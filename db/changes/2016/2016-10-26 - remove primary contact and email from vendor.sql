ALTER TABLE `TblVendor`
	CHANGE COLUMN `primaryContact` `_unused_primaryContact` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `Terms`,
	CHANGE COLUMN `primaryEmail` `_unused_primaryEmail` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `_unused_primaryContact`;
