ALTER TABLE `tbl_settings_global`
	ALTER `conversion_factor_machine1` DROP DEFAULT,
	ALTER `conversion_factor_machine2` DROP DEFAULT;
ALTER TABLE `tbl_settings_global`
	CHANGE COLUMN `conversion_factor_machine1` `_unused_conversion_factor_machine1` DECIMAL(5,2) NOT NULL AFTER `id`,
	CHANGE COLUMN `conversion_factor_machine2` `_unused_conversion_factor_machine2` DECIMAL(5,2) NOT NULL AFTER `_unused_conversion_factor_machine1`;

	
	
ALTER TABLE `Products`
	CHANGE COLUMN `PoundsOfPolyurethane` `_unused_PoundsOfPolyurethane` DECIMAL(4,2) NULL DEFAULT NULL COMMENT 'Pounds of polyurethane that is needed for the mold on the Urethane machines.' AFTER `DefaultFinishOptionID`,
	CHANGE COLUMN `WebsitePartNumber` `_unused_WebsitePartNumber` VARCHAR(50) NULL DEFAULT NULL COMMENT 'Stairsupplies.net part number' COLLATE 'utf8_unicode_ci' AFTER `WebsitePartName`,
	ADD COLUMN `VR_Part` VARCHAR(50) NULL AFTER `UnitPriceViewrail`,
	ADD COLUMN `StairMargin` DECIMAL(10,2) NULL COMMENT 'StairSupplies margin percent 40=40%, 100=100%' AFTER `PreFinishCost`;
