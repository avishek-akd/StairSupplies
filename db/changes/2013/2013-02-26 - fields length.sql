ALTER TABLE `Products`
	CHANGE COLUMN `Customer_Notes` `Customer_Notes` VARCHAR(500) NULL AFTER `In_House_Notes`;
ALTER TABLE `Products`
	CHANGE COLUMN `In_House_Notes` `In_House_Notes` VARCHAR(500) NULL AFTER `Unit_of_Measure`;
ALTER TABLE `Products`
	CHANGE COLUMN `In_House_Notes` `In_House_Notes` VARCHAR(500) NULL DEFAULT NULL AFTER `Unit_of_Measure`;
