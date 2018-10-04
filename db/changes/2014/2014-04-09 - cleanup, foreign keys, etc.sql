ALTER TABLE `TblProductTypeInclude`
	ADD CONSTRAINT `FK_TblProductTypeInclude_TblProductType` FOREIGN KEY (`parentTypeId`) REFERENCES `TblProductType` (`ProductType_id`),
	ADD CONSTRAINT `FK_TblProductTypeInclude_TblProductType_2` FOREIGN KEY (`childTypeId`) REFERENCES `TblProductType` (`ProductType_id`);


-- Not NULL
ALTER TABLE `Country`
	ALTER `Name` DROP DEFAULT,
	ALTER `Code2` DROP DEFAULT,
	ALTER `SortOrder` DROP DEFAULT;
ALTER TABLE `Country`
	CHANGE COLUMN `Name` `Name` VARCHAR(100) NOT NULL COLLATE 'utf8_unicode_ci' AFTER `id`,
	CHANGE COLUMN `Code2` `Code2` VARCHAR(2) NOT NULL COLLATE 'utf8_unicode_ci' AFTER `Name`,
	CHANGE COLUMN `SortOrder` `SortOrder` TINYINT(3) NOT NULL AFTER `Code2`;


--  Consistent Foreign key names
ALTER TABLE `CustomerContact`
	DROP FOREIGN KEY `CustomerContact_fk1`,
	DROP FOREIGN KEY `CustomerContact_fk3`;
ALTER TABLE `CustomerContact`
	ADD CONSTRAINT `FK_CustomerContact_Customers` FOREIGN KEY (`CustomerID`) REFERENCES `Customers` (`CustomerID`) ON UPDATE NO ACTION ON DELETE CASCADE,
	ADD CONSTRAINT `FK_CustomerContact_Country` FOREIGN KEY (`ContactCountryId`) REFERENCES `Country` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION;


--  Column order, Forecast not Forcast 
ALTER TABLE `Customers`
	CHANGE COLUMN `Annual_Sales_Forcast` `Annual_Sales_Forecast` DECIMAL(19,4) NULL DEFAULT '0.0000' AFTER `CustomerType`,
	CHANGE COLUMN `DateEntered` `DateEntered` DATETIME NULL DEFAULT NULL AFTER `SalesPersonCommission`;

	
	
--  Column order	
ALTER TABLE `Employees`
	CHANGE COLUMN `EmployeeCode` `EmployeeCode` CHAR(4) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `EmployeeID`,
	CHANGE COLUMN `Address` `Address` VARCHAR(100) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `Title`,
	CHANGE COLUMN `City` `City` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `Address`,
	CHANGE COLUMN `State` `State` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `City`,
	CHANGE COLUMN `Zip` `Zip` VARCHAR(10) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `State`,
	CHANGE COLUMN `WorkPhone` `WorkPhone` VARCHAR(30) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `Zip`,
	CHANGE COLUMN `CellPhone` `CellPhone` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `Extension`,
	CHANGE COLUMN `HomePhone` `HomePhone` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `CellPhone`,
	CHANGE COLUMN `EmergencyContactName` `EmergencyContactName` VARCHAR(100) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `HomePhone`,
	CHANGE COLUMN `EmergencyContactNumber` `EmergencyContactNumber` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `EmergencyContactName`;
	
ALTER TABLE `Employees`
	CHANGE COLUMN `email` `email` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `HomePhone`,
	CHANGE COLUMN `EmployeeCode` `EmployeeCode` CHAR(4) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `EmergencyContactNumber`,
	CHANGE COLUMN `Password` `Password` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `EmployeeCode`;

	
ALTER TABLE `Shipping_Methods`
	CHANGE COLUMN `active` `active` TINYINT(4) NULL DEFAULT '1' AFTER `byTruck`;
