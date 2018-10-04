ALTER TABLE `TblOrdersBOM_Items`
	CHANGE COLUMN `ProductName` `ProductName` VARCHAR(100) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `ProductID`,
	CHANGE COLUMN `ProductDescription` `ProductDescription` VARCHAR(500) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `ProductName`;
