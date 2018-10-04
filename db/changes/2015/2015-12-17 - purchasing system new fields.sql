ALTER TABLE `Products`
	ADD COLUMN `PurchasingAccountCode` VARCHAR(255) NULL DEFAULT NULL AFTER `InventoryNote`,
	ADD COLUMN `PurchasingVendorPartNumber` VARCHAR(255) NULL DEFAULT NULL AFTER `PurchasingAccountCode`,
	ADD COLUMN `PurchasingReorderQuantity` INT NULL DEFAULT NULL AFTER `PurchasingVendorPartNumber`;
	

UPDATE Products
SET
	PurchasingAccountCode = Production_Instructions
WHERE Production_Instructions IS NOT NULL
	AND Production_Instructions <> ''
	AND Vendor_id <> 6072;

	
UPDATE Products
SET
	PurchasingVendorPartNumber = WebsitePartName
WHERE WebsitePartName IS NOT NULL
	AND WebsitePartName <> ''
	AND Vendor_id <> 6072;