ALTER TABLE `TblCompany`
	ADD COLUMN `purchasingUrlPrefix` VARCHAR(100) NULL AFTER `salesUrlPrefix`;
UPDATE `TblCompany`
SET `purchasingUrlPrefix`='http://office.stairsupplies.com/purchasing'
WHERE  `CompanyID` = 1;


ALTER TABLE `TblPurchaseOrder`
	ADD COLUMN `vendorAcknowledged` TINYINT(1) NULL DEFAULT NULL COMMENT '=1 if Vendor acknowledged this order' AFTER `RequestedDueDate`,
	ADD COLUMN `vendorAcknowledgementDate` DATETIME NULL DEFAULT NULL AFTER `vendorAcknowledged`,
	ADD COLUMN `vendorShippingAmount` DECIMAL(10,2) NULL DEFAULT NULL COMMENT 'Vendor entered shipping amount' AFTER `vendorAcknowledgementDate`,
	ADD COLUMN `vendorNotes` VARCHAR(500) NULL DEFAULT NULL AFTER `vendorShippingAmount`;
ALTER TABLE `TblPurchaseOrderItem`
	ADD COLUMN `vendorShipDate` DATE NULL DEFAULT NULL COMMENT 'Vendor can enter a shipping date' AFTER `QuantityReceived`,
	ADD COLUMN `vendorPrice` DECIMAL(19,2) NULL DEFAULT NULL COMMENT 'VendorPrice, if different from Purchase price' AFTER `vendorShipDate`;
