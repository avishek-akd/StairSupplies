ALTER TABLE `ProductsInclude`
	ADD COLUMN `Quantity` INT UNSIGNED NOT NULL DEFAULT '1' COMMENT 'How many pieces of this product are included in the parent product' AFTER `IncludedProductID`;
