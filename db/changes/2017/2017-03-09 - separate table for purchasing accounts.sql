CREATE TABLE TblPurchaseAccount (
	PurchaseAccountID INT UNSIGNED NOT NULL AUTO_INCREMENT,
	AccountTitle VARCHAR(50) NOT NULL,
	isHidden TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '=1 if this account is an internal account that cannot be assigned to products (is hidden)',
	Active TINYINT(1) UNSIGNED NOT NULL DEFAULT 1,
	RecordCreated DATETIME NOT NULL,
	RecordUpdated DATETIME NULL DEFAULT NULL,
	PRIMARY KEY (PurchaseAccountID)
) Engine=INNODB;


ALTER TABLE Products
	CHANGE COLUMN `PurchasingAccountCode` `_unused_PurchasingAccountCode` VARCHAR(255) NULL DEFAULT NULL,
	ADD COLUMN PurchasingAccountID INT UNSIGNED NULL DEFAULT NULL AFTER `_unused_PurchasingAccountCode`,
	ADD CONSTRAINT `FK_Products_TblPurchaseAccount` FOREIGN KEY (PurchasingAccountID) REFERENCES TblPurchaseAccount(PurchaseAccountID) ON UPDATE NO ACTION ON DELETE NO ACTION
;


--  Fill with valid account codes
INSERT INTO TblPurchaseAccount
	(AccountTitle, isHidden, RecordCreated)
VALUES
	('6661 Inbound Shipping', 1, Now()),
	('6755 Taxes Paid to Vendors', 1, Now());
INSERT INTO TblPurchaseAccount
	(AccountTitle, RecordCreated)
SELECT DISTINCT _unused_PurchasingAccountCode, Now()
FROM Products
WHERE _unused_PurchasingAccountCode IS NOT NULL
	AND _unused_PurchasingAccountCode <> ''
	AND length(_unused_PurchasingAccountCode) = 4
	AND _unused_PurchasingAccountCode REGEXP '^[0-9]+$'
ORDER BY _unused_PurchasingAccountCode ASC;



--  Fill in ID's
UPDATE Products
SET PurchasingAccountID = (SELECT PurchaseAccountID FROM TblPurchaseAccount WHERE AccountTitle = _unused_PurchasingAccountCode)
WHERE 1 = 1;


--  Strange, non numeric codes get copied into PurchasingInHouseNotes
UPDATE Products
SET PurchasingInHouseNotes = _unused_PurchasingAccountCode
WHERE PurchasingAccountID IS NULL
	AND _unused_PurchasingAccountCode is not null
	AND _unused_PurchasingAccountCode <> ''
;


ALTER TABLE TblPurchaseOrder
	ADD COLUMN Status ENUM('open', 'closed', 'deleted') NOT NULL DEFAULT 'open' COMMENT 'A PO starts as open and when all the items are received it changes to closed.' AFTER `vendorEstimatedShippingDate`,
	ADD COLUMN ClosedReason ENUM('short', 'exact', 'high') NULL DEFAULT NULL COMMENT '3 ways to close a PO: all items are received exactly as ordered, under-shipped or over-shiped. Exact and high are handled automatically, short must be set manually by the user.' AFTER `Status`,
	CHANGE COLUMN `Deleted` `_unused_Deleted` TINYINT(1) NOT NULL DEFAULT '0' AFTER `ClosedReason`
;
UPDATE TblPurchaseOrder
SET Status = 'open',
	ClosedReason = NULL
;
UPDATE TblPurchaseOrder
SET Status = 'deleted',
	ClosedReason = NULL
WHERE _unused_Deleted = 1
;
--  Received completely
UPDATE TblPurchaseOrder
SET Status = 'closed', ClosedReason = 'exact'
WHERE _unused_Deleted = 0
	--  At least 1 ordered product
	AND EXISTS (
				SELECT 1
				FROM TblPurchaseOrderItem
				WHERE PurchaseOrderID = TblPurchaseOrder.id)
	--  At least 1 received product
	AND EXISTS (
				SELECT 1
				FROM TblPurchaseOrderItem
					INNER JOIN TblPurchaseOrderReceiveItem ON TblPurchaseOrderReceiveItem.PurchaseOrderItemID = TblPurchaseOrderItem.id
				WHERE PurchaseOrderID = TblPurchaseOrder.id)
	--  All products are fully received
	AND 1 = ALL (
				SELECT IF(Min(QuantityRequested) = Coalesce(Sum(QuantityReceived), 0), 1, 0)
				FROM TblPurchaseOrderItem
					LEFT JOIN TblPurchaseOrderReceiveItem ON TblPurchaseOrderReceiveItem.PurchaseOrderItemID = TblPurchaseOrderItem.id
				WHERE PurchaseOrderID = TblPurchaseOrder.id
				GROUP BY TblPurchaseOrderItem.id
				)
;
--  Received more than ordered for each product
UPDATE TblPurchaseOrder
SET Status = 'closed', ClosedReason = 'high'
WHERE _unused_Deleted = 0
	--  At least 1 ordered product
	AND EXISTS (
				SELECT 1
				FROM TblPurchaseOrderItem
				WHERE PurchaseOrderID = TblPurchaseOrder.id)
	--  At least 1 received product
	AND EXISTS (
				SELECT 1
				FROM TblPurchaseOrderItem
					INNER JOIN TblPurchaseOrderReceiveItem ON TblPurchaseOrderReceiveItem.PurchaseOrderItemID = TblPurchaseOrderItem.id
				WHERE PurchaseOrderID = TblPurchaseOrder.id)
	--  All products are fully received
	AND 1 = ALL (
				SELECT IF(Min(QuantityRequested) <= Coalesce(Sum(QuantityReceived), 0), 1, 0)
				FROM TblPurchaseOrderItem
					LEFT JOIN TblPurchaseOrderReceiveItem ON TblPurchaseOrderReceiveItem.PurchaseOrderItemID = TblPurchaseOrderItem.id
				WHERE PurchaseOrderID = TblPurchaseOrder.id
				GROUP BY TblPurchaseOrderItem.id
				)
	--  But we have at least 1 product that was over-shipped
	AND EXISTS (
				SELECT 1
				FROM TblPurchaseOrderItem
					LEFT JOIN TblPurchaseOrderReceiveItem ON TblPurchaseOrderReceiveItem.PurchaseOrderItemID = TblPurchaseOrderItem.id
				WHERE PurchaseOrderID = TblPurchaseOrder.id
				GROUP BY TblPurchaseOrderItem.id
				HAVING Min(QuantityRequested) < Sum(QuantityReceived)
				)
;




ALTER TABLE `TblPurchaseOrderReceiveItem`
	DROP FOREIGN KEY `FK_TblPurchaseOrderReceiveItem_TblPurchaseOrderReceive`;
ALTER TABLE `TblPurchaseOrderReceiveItem`
	ADD CONSTRAINT `FK_TblPurchaseOrderReceiveItem_TblPurchaseOrderReceive` FOREIGN KEY (`PurchaseOrderReceiveID`) REFERENCES `TblPurchaseOrderReceive` (`id`) ON DELETE CASCADE;
