ALTER TABLE `TblOrdersBOM`
	CHANGE COLUMN `DateCreated` `DateCreated` DATETIME NULL DEFAULT NULL AFTER `hiddenInLateOrderRport`,
	CHANGE COLUMN `DateUpdated` `DateUpdated` DATETIME NULL DEFAULT NULL AFTER `DateCreated`;

ALTER TABLE `Products`
	CHANGE COLUMN `archived` `Archived` TINYINT(4) NULL DEFAULT '0' AFTER `InventoryNote`,
	CHANGE COLUMN `_unused_EmployeeRateFinal` `_unused_EmployeeRateFinal` DECIMAL(10,2) NOT NULL DEFAULT '0.00' AFTER `DateUpdated`,
	CHANGE COLUMN `_unused_Bin` `_unused_Bin` VARCHAR(50) NULL DEFAULT NULL AFTER `_unused_EmployeeRateFinal`,
	CHANGE COLUMN `_unused_inboundFreightCost` `_unused_inboundFreightCost` DECIMAL(10,2) NOT NULL DEFAULT '0.00' COMMENT 'shipping cost associated with receiving an inbound item ($/item)' AFTER `_unused_Bin`;

ALTER TABLE `Customers`
	CHANGE COLUMN `BillCountryId` `BillCountryID` INT(10) NULL DEFAULT NULL AFTER `BillPostalCode`,
	CHANGE COLUMN `ShipCountryId` `ShipCountryID` INT(10) NULL DEFAULT NULL AFTER `ShipPostalCode`;

ALTER TABLE `TblOrdersBOM_Exceptions`
	CHANGE COLUMN `exceptionname` `ExceptionName` VARCHAR(500) NULL DEFAULT NULL AFTER `id`;

ALTER TABLE `TblOrdersBOM_Items`
	CHANGE COLUMN `RecordCreated` `_unused_RecordCreated` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP AFTER `so_programming_complete_employeeID`,
	CHANGE COLUMN `FinishOptionID` `FinishOptionID` INT(10) UNSIGNED NULL DEFAULT NULL AFTER `ShippedDate`,

	CHANGE COLUMN `In_House_Notes` `In_House_Notes` VARCHAR(2000) NULL COLLATE 'utf8_unicode_ci' AFTER `Special_Instructions`,
	CHANGE COLUMN `Customer_Notes` `Customer_Notes` VARCHAR(2000) NULL COLLATE 'utf8_unicode_ci' AFTER `In_House_Notes`,
	CHANGE COLUMN `PRC_Initials` `PRC_Initials` VARCHAR(15) NULL COLLATE 'utf8_unicode_ci' AFTER `PRC`,
	CHANGE COLUMN `Final_Initials` `Final_Initials` VARCHAR(15) NULL COLLATE 'utf8_unicode_ci' AFTER `Final`,
	CHANGE COLUMN `Prefinishing_Complete_Initials` `Prefinishing_Complete_Initials` VARCHAR(15) NULL COLLATE 'utf8_unicode_ci' AFTER `Prefinishing_Complete`;
