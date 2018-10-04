ALTER TABLE `Customers`
	ADD CONSTRAINT `FK_Customers_CustomerType` FOREIGN KEY (`CustomerTypeID`) REFERENCES `CustomerType` (`id`);




ALTER TABLE `CustomerContact`
	ADD COLUMN `Archived` TINYINT(1) NOT NULL DEFAULT '0' AFTER `iContactID`;

	
ALTER TABLE `Customers`
	CHANGE COLUMN `BillCompanyName` `_unused_BillCompanyName` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci',
	CHANGE COLUMN `BillFirstName` `_unused_BillFirstName` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci',
	CHANGE COLUMN `BillLastName` `_unused_BillLastName` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci',
	CHANGE COLUMN `BillAddress1` `_unused_BillAddress1` VARCHAR(100) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci',
	CHANGE COLUMN `BillAddress2` `_unused_BillAddress2` VARCHAR(100) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci',
	CHANGE COLUMN `BillAddress3` `_unused_BillAddress3` VARCHAR(100) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci',
	CHANGE COLUMN `BillCity` `_unused_BillCity` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci',
	CHANGE COLUMN `BillState` `_unused_BillState` VARCHAR(2) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci',
	CHANGE COLUMN `BillStateOther` `_unused_BillStateOther` VARCHAR(100) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci',
	CHANGE COLUMN `BillPostalCode` `_unused_BillPostalCode` VARCHAR(20) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci',
	CHANGE COLUMN `BillCountryID` `_unused_BillCountryID` INT(10) NULL DEFAULT NULL,
	
	CHANGE COLUMN `ShipCompanyName` `_unused_ShipCompanyName` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci',
	CHANGE COLUMN `ShipFirstName` `_unused_ShipFirstName` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci',
	CHANGE COLUMN `ShipLastName` `_unused_ShipLastName` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci',
	CHANGE COLUMN `ShipAddress1` `_unused_ShipAddress1` VARCHAR(100) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci',
	CHANGE COLUMN `ShipAddress2` `_unused_ShipAddress2` VARCHAR(100) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci',
	CHANGE COLUMN `ShipAddress3` `_unused_ShipAddress3` VARCHAR(100) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci',
	CHANGE COLUMN `ShipCity` `_unused_ShipCity` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci',
	CHANGE COLUMN `ShipState` `_unused_ShipState` VARCHAR(2) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci',
	CHANGE COLUMN `ShipStateOther` `_unused_ShipStateOther` VARCHAR(100) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci',
	CHANGE COLUMN `ShipPostalCode` `_unused_ShipPostalCode` VARCHAR(20) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci',
	CHANGE COLUMN `ShipCountryID` `_unused_ShipCountryID` INT(10) NULL DEFAULT NULL
;
	
DELETE FROM `stairs5_intranet`.`Customers` WHERE  `CustomerID`=46921;
DELETE FROM `stairs5_intranet`.`Customers` WHERE  `CustomerID`=47187;
DELETE FROM `stairs5_intranet`.`Customers` WHERE  `CustomerID`=47346;
DELETE FROM `stairs5_intranet`.`Customers` WHERE  `CustomerID`=47940;
DELETE FROM `stairs5_intranet`.`Customers` WHERE  `CustomerID`=48584;
DELETE FROM `stairs5_intranet`.`Customers` WHERE  `CustomerID`=48881;
DELETE FROM `stairs5_intranet`.`Customers` WHERE  `CustomerID`=49091;
DELETE FROM `stairs5_intranet`.`Customers` WHERE  `CustomerID`=49092;
DELETE FROM `stairs5_intranet`.`Customers` WHERE  `CustomerID`=49213;
DELETE FROM `stairs5_intranet`.`Customers` WHERE  `CustomerID`=49653;
DELETE FROM `stairs5_intranet`.`Customers` WHERE  `CustomerID`=50073;
DELETE FROM `stairs5_intranet`.`Customers` WHERE  `CustomerID`=50744;
DELETE FROM `stairs5_intranet`.`Customers` WHERE  `CustomerID`=51416;
DELETE FROM `stairs5_intranet`.`Customers` WHERE  `CustomerID`=51616;
DELETE FROM `stairs5_intranet`.`Customers` WHERE  `CustomerID`=51866;
DELETE FROM `stairs5_intranet`.`Customers` WHERE  `CustomerID`=51988;
DELETE FROM `stairs5_intranet`.`Customers` WHERE  `CustomerID`=52178;
DELETE FROM `stairs5_intranet`.`Customers` WHERE  `CustomerID`=52194;
DELETE FROM `stairs5_intranet`.`Customers` WHERE  `CustomerID`=52201;
DELETE FROM `stairs5_intranet`.`Customers` WHERE  `CustomerID`=52480;
DELETE FROM `stairs5_intranet`.`Customers` WHERE  `CustomerID`=52853;
DELETE FROM `stairs5_intranet`.`Customers` WHERE  `CustomerID`=53748;
DELETE FROM `stairs5_intranet`.`Customers` WHERE  `CustomerID`=53953;
DELETE FROM `stairs5_intranet`.`Customers` WHERE  `CustomerID`=54280;	


ALTER TABLE `Customers`
	ADD COLUMN `defaultBillingContactID` INT UNSIGNED NULL DEFAULT NULL AFTER `defaultCompanyID`,
	ADD COLUMN `defaultShippingContactID` INT UNSIGNED NULL DEFAULT NULL AFTER `defaultBillingContactID`,
	ADD CONSTRAINT `FK_Customers_CustomerContact` FOREIGN KEY (`defaultBillingContactID`) REFERENCES `CustomerContact` (`CustomerContactID`),
	ADD CONSTRAINT `FK_Customers_CustomerContact_2` FOREIGN KEY (`defaultShippingContactID`) REFERENCES `CustomerContact` (`CustomerContactID`)
;
UPDATE Customers
SET
	defaultBillingContactID  = (SELECT customerContactID FROM CustomerContact WHERE CustomerID = Customers.CustomerID LIMIT 0,1),
	defaultShippingContactID = (SELECT customerContactID FROM CustomerContact WHERE CustomerID = Customers.CustomerID LIMIT 0,1)
;
	