ALTER TABLE `Products`
	ADD COLUMN `PurchasingPrice` DECIMAL(19,4) NULL DEFAULT NULL AFTER `PurchasingDepartmentID`,
	ADD COLUMN `PurchasingInHouseNotes` VARCHAR(500) NULL DEFAULT NULL AFTER `PurchasingDescription`;

	

ALTER TABLE `TblPurchaseOrderItem`
	ALTER `PurchasePrice` DROP DEFAULT;
ALTER TABLE `TblPurchaseOrderItem`
	CHANGE COLUMN `PurchasePrice` `PurchasePrice` DECIMAL(19,4) NOT NULL AFTER `ProductName`;
UPDATE Products
SET PurchasingPrice = Purchase_Price;