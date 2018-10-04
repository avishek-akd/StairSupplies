DELIMITER $$



RENAME TABLE `TblPurchaseOneTimePartRequest` TO `TblPurchaseRequestOneTimePart`
$$
RENAME TABLE `TblPurchaseOrderRequestProduct` TO `TblPurchaseRequestPart`
$$


ALTER TABLE `TblPurchaseRequestPart`
	CHANGE COLUMN `RecordUpdated` `_unused_RecordUpdated` DATETIME NULL DEFAULT NULL AFTER `RecordCreated`
$$
ALTER TABLE `TblPurchaseOrderItem`
	ALTER `ProductName` DROP DEFAULT
$$
ALTER TABLE `TblPurchaseOrderItem`
	CHANGE COLUMN `ProductName` `PartName` VARCHAR(100) NOT NULL COLLATE 'utf8_unicode_ci' AFTER `AccountID`
$$
ALTER TABLE `TblPurchaseOrder`
	CHANGE COLUMN `ProductsTotalAmount` `_unused_PartsTotalAmount` DECIMAL(10,2) NOT NULL DEFAULT '0.00' COMMENT 'Subtotal for products, in dollars. This is updated automatically via triggers' AFTER `RequestedByEmployeeID`,
	CHANGE COLUMN `TotalAmount` `_unused_TotalAmount` DECIMAL(10,2) NOT NULL DEFAULT 0 AFTER `ShippingAmount`
$$


/*  Use views instead of triggers to calculate totals  */
DROP TRIGGER TblPurchaseOrderItem_after_del_tr1
$$
DROP TRIGGER TblPurchaseOrderItem_after_ins_tr1
$$
DROP TRIGGER TblPurchaseOrderItem_after_upd_tr1
$$



DROP VIEW IF EXISTS vPurchaseOrderTotals
$$
CREATE VIEW `vPurchaseOrderTotals`
AS
SELECT TblPurchaseOrder.id AS PurchaseOrderID,
	Sum(PurchasePrice * QuantityRequested) AS PartsTotalAmount,
	(Sum(PurchasePrice * QuantityRequested) + Sum(PurchasePrice * QuantityRequested) * TaxPercent + ShippingAmount) AS TotalAmount
FROM TblPurchaseOrder
	INNER JOIN TblPurchaseOrderItem ON TblPurchaseOrderItem.PurchaseOrderID = TblPurchaseOrder.id
GROUP BY TblPurchaseOrder.id, TaxPercent, ShippingAmount
$$



DELIMITER ;