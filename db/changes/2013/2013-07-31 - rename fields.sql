ALTER TABLE `tbl_settings_global`
	ALTER `stain_costs_multiplier` DROP DEFAULT;
ALTER TABLE `tbl_settings_global`
	CHANGE COLUMN `stain_costs_multiplier` `stain_price_multiplier` DECIMAL(5,2) NOT NULL COMMENT '1.2 for 120%, 0.9 for 90% (lower than 1 means smaller stain cost than finish cost)' AFTER `conversion_factor_machine2`;



ALTER TABLE `Products`
	CHANGE COLUMN `Bin` `_unused_Bin` VARCHAR(50) NULL DEFAULT NULL AFTER `Customer_Notes`,
	CHANGE COLUMN `EmployeeRateFinal` `_unused_EmployeeRateFinal` DECIMAL(10,2) NOT NULL DEFAULT '0.00' AFTER `EmployeeRatePRC`,
	CHANGE COLUMN `inboundFreightCost` `_unused_inboundFreightCost` DECIMAL(10,2) NOT NULL DEFAULT '0.00' COMMENT 'shipping cost associated with receiving an inbound item ($/item)' AFTER `EmployeeRatePreFinish`;



ALTER TABLE `Products`
	CHANGE COLUMN `FinishCost` `FinishPrice` DECIMAL(10,2) NOT NULL DEFAULT '0.00' COMMENT 'The price that is added to a product if the customer wants finish' AFTER `_unused_inboundFreightCost`,
	CHANGE COLUMN `EmployeeRatePRC` `LaborCost` DECIMAL(10,2) NOT NULL DEFAULT '0.00' AFTER `Production_Instructions`,
	CHANGE COLUMN `EmployeeRatePreFinish` `PreFinishCost` DECIMAL(10,2) NOT NULL DEFAULT '0.00' AFTER `LaborCost`,
	CHANGE COLUMN `CompetitorEquivalent` `WebsitePartName` VARCHAR(255) NULL DEFAULT NULL AFTER `FinishPrice`,
	CHANGE COLUMN `WebsitePart` `WebsitePartNumber` VARCHAR(50) NULL DEFAULT NULL COMMENT 'Stairsupplies.net part number' AFTER `WebsitePartName`,
	CHANGE COLUMN `WebsiteID` `WebsiteURL` VARCHAR(255) NULL DEFAULT NULL COMMENT 'Stairsupplies.net address of the product' AFTER `WebsitePartNumber`;