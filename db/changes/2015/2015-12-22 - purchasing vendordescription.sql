ALTER TABLE `Products`
	ADD COLUMN `PurchasingDescription` VARCHAR(500) NULL DEFAULT NULL AFTER `InventoryNote`;

	
UPDATE Products
SET
	PurchasingDescription = ProductDescription
WHERE ProductDescription IS NOT NULL
	AND ProductDescription <> ''
	AND Vendor_id <> 6072;