--  Increase the size from 500 to 600 chars
ALTER TABLE `Products`
	CHANGE COLUMN `In_House_Notes` `In_House_Notes` VARCHAR(600) NULL DEFAULT NULL,
	CHANGE COLUMN `Customer_Notes` `Customer_Notes` VARCHAR(600) NULL DEFAULT NULL;
