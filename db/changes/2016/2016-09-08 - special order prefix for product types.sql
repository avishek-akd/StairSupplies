ALTER TABLE `TblProductType`
	ADD COLUMN `SpecialOrderPrefix` VARCHAR(50) NULL COMMENT 'Prefix that will be used when creating special orders' AFTER `description`;
