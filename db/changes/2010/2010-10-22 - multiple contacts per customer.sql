CREATE TABLE `CustomerContact` (
	`CustomerContactID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`CustomerID` INT NOT NULL,
	`ContactCompanyName` VARCHAR(50) NULL DEFAULT NULL,
	`ContactTitle` VARCHAR(50) NULL DEFAULT NULL,
	`ContactFirstName` VARCHAR(50) NULL DEFAULT NULL,
	`ContactLastName` VARCHAR(50) NULL DEFAULT NULL,
	`ContactAddress1` VARCHAR(255) NULL DEFAULT NULL,
	`ContactAddress2` VARCHAR(255) NULL DEFAULT NULL,
	`ContactAddress3` VARCHAR(255) NULL DEFAULT NULL,
	`ContactAddress4` VARCHAR(255) NULL DEFAULT NULL,
	`ContactCity` VARCHAR(50) NULL DEFAULT NULL,
	`ContactState` VARCHAR(2) NULL DEFAULT NULL COMMENT 'If the country is USA or Canada then ContactState is a foreign key into the tblState table. Otherwise the ContactStateOther field must be filled in.',
	`ContactStateOther` VARCHAR(100) NULL DEFAULT NULL,
	`ContactPostalCode` VARCHAR(20) NULL DEFAULT NULL,
	`ContactCountryId` INT(10) NULL DEFAULT NULL,
	`ContactPhoneNumber` VARCHAR(50) NULL DEFAULT NULL,
	`ContactFaxNumber` VARCHAR(50) NULL DEFAULT NULL,
	`ContactCellPhone` VARCHAR(50) NULL DEFAULT NULL,
	`Email` VARCHAR(50) NULL DEFAULT NULL,
	`Password` VARCHAR(20) NULL DEFAULT NULL,
	`CanLogin` TINYINT(4) NULL DEFAULT '1',
	`BillingEmails` VARCHAR(255) NULL DEFAULT NULL COMMENT 'The invoice from the invoicing module is sent to these emails.',
	`iPhoneToken` CHAR(64) NULL DEFAULT NULL COMMENT 'Device token ID used by the customer when he last signed in.',
	`PosibleDuplicates` INT(10) UNSIGNED NULL DEFAULT NULL,
	`DateUpdated` DATETIME NULL DEFAULT NULL,
	`DateEntered` DATETIME NULL DEFAULT NULL,
	PRIMARY KEY (`CustomerContactID`),
	INDEX `CustomerContact_idxCustomer` (`CustomerID`),
	INDEX `CustomerContact_idxState` (`ContactState`),
	INDEX `CustomerContact_idxCountry` (`ContactCountryId`),
	CONSTRAINT `CustomerContact_fk1` FOREIGN KEY (`CustomerID`) REFERENCES `Customers` (`CustomerID`) ON UPDATE NO ACTION ON DELETE CASCADE,
	CONSTRAINT `CustomerContact_fk2` FOREIGN KEY (`ContactState`) REFERENCES `TblState` (`State`) ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT `CustomerContact_fk3` FOREIGN KEY (`ContactCountryId`) REFERENCES `Country` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION
)
COLLATE='utf8_general_ci' ENGINE=InnoDB;


ALTER TABLE `Customers`
	DROP FOREIGN KEY `Customers_fk4`,
	DROP FOREIGN KEY `Customers_fk5`;
ALTER TABLE `Customers` 
	CHANGE COLUMN `ContactCompanyName` `old_ContactCompanyName` VARCHAR(50) NULL DEFAULT NULL AFTER `CustomerID`,  
	CHANGE COLUMN `ContactTitle` `old_ContactTitle` VARCHAR(50) NULL DEFAULT NULL AFTER `old_ContactCompanyName`, 
	CHANGE COLUMN `ContactFirstName` `old_ContactFirstName` VARCHAR(50) NULL DEFAULT NULL AFTER `old_ContactTitle`, 
	CHANGE COLUMN `ContactLastName` `old_ContactLastName` VARCHAR(50) NULL DEFAULT NULL AFTER `old_ContactFirstName`,
	CHANGE COLUMN `ContactAddress1` `old_ContactAddress1` VARCHAR(255) NULL DEFAULT NULL AFTER `old_ContactLastName`, 
	CHANGE COLUMN `ContactAddress2` `old_ContactAddress2` VARCHAR(255) NULL DEFAULT NULL AFTER `old_ContactAddress1`, 
	CHANGE COLUMN `ContactAddress3` `old_ContactAddress3` VARCHAR(255) NULL DEFAULT NULL AFTER `old_ContactAddress2`, 
	CHANGE COLUMN `ContactAddress4` `old_ContactAddress4` VARCHAR(255) NULL DEFAULT NULL AFTER `old_ContactAddress3`, 
	CHANGE COLUMN `ContactCity` `old_ContactCity` VARCHAR(50) NULL DEFAULT NULL AFTER `old_ContactAddress4`, 
	CHANGE COLUMN `ContactState` `old_ContactState` VARCHAR(2) NULL DEFAULT NULL COMMENT 'If the country is USA or Canada then ContactState is a foreign key into the tblState table. Otherwise the ContactStateOther field must be filled in.' AFTER `old_ContactCity`,  
	CHANGE COLUMN `ContactStateOther` `old_ContactStateOther` VARCHAR(100) NULL DEFAULT NULL AFTER `old_ContactState`, 
	CHANGE COLUMN `ContactPostalCode` `old_ContactPostalCode` VARCHAR(20) NULL DEFAULT NULL AFTER `old_ContactStateOther`,
	CHANGE COLUMN `ContactCountryId` `old_ContactCountryId` INT(10) NULL DEFAULT NULL AFTER `old_ContactPostalCode`, 
	CHANGE COLUMN `ContactPhoneNumber` `old_ContactPhoneNumber` VARCHAR(50) NULL DEFAULT NULL AFTER `old_ContactCountryId`, 
	CHANGE COLUMN `ContactFaxNumber` `old_ContactFaxNumber` VARCHAR(50) NULL DEFAULT NULL AFTER `old_ContactPhoneNumber`, 
	CHANGE COLUMN `ContactCellPhone` `old_ContactCellPhone` VARCHAR(50) NULL DEFAULT NULL AFTER `old_ContactFaxNumber`,
	CHANGE COLUMN `Email` `old_Email` VARCHAR(50) NULL DEFAULT NULL,
	CHANGE COLUMN `Password` `old_Password` VARCHAR(20) NULL DEFAULT NULL,
	CHANGE COLUMN `CanLogin` `old_CanLogin` TINYINT(4) NULL DEFAULT NULL,
	CHANGE COLUMN `iPhoneToken` `old_iPhoneToken` CHAR(64) NULL DEFAULT NULL,
	CHANGE COLUMN `BillingEmails` `old_BillingEmails` VARCHAR(255) NULL DEFAULT NULL;
ALTER TABLE `Customers`  
	ADD CONSTRAINT `Customers_fk4` FOREIGN KEY (`old_ContactCountryId`) REFERENCES `Country` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION,
	ADD CONSTRAINT `Customers_fk5` FOREIGN KEY (`old_ContactState`) REFERENCES `TblState` (`State`) ON UPDATE NO ACTION ON DELETE NO ACTION;


INSERT INTO CustomerContact
	(CustomerID, ContactCompanyName, ContactTitle, ContactFirstName, ContactLastName, ContactAddress1, ContactAddress2, ContactAddress3, ContactAddress4,
	ContactCity, ContactState, ContactStateOther, ContactPostalCode, ContactCountryId, ContactPhoneNumber, ContactFaxNumber, ContactCellPhone,
	Email, Password, CanLogin, BillingEmails, iPhoneToken, PosibleDuplicates, DateEntered, DateUpdated)
SELECT CustomerID, old_ContactCompanyName, old_ContactTitle, old_ContactFirstName, old_ContactLastName, old_ContactAddress1, old_ContactAddress2, old_ContactAddress3, old_ContactAddress4,
		old_ContactCity, old_ContactState, old_ContactStateOther, old_ContactPostalCode, old_ContactCountryId, old_ContactPhoneNumber, old_ContactFaxNumber, old_ContactCellPhone,
		old_Email, old_Password, old_CanLogin, old_BillingEmails, old_iPhoneToken, 0, Customers.DateEntered, Customers.DateUpdated
FROM Customers;


--
--  TblOrdersBOM
--
ALTER TABLE `TblOrdersBOM` 
	DROP FOREIGN KEY `FK_TblOrdersBOM_Customers`;
ALTER TABLE `TblOrdersBOM` 
	CHANGE COLUMN `CustomerID` `old_CustomerID` INT(10) NULL AFTER `OrderID`, 
	ADD CONSTRAINT `FK_TblOrdersBOM_Customers` FOREIGN KEY (`old_CustomerID`) REFERENCES `Customers` (`CustomerID`) ON UPDATE NO ACTION ON DELETE NO ACTION,
	ADD COLUMN `CustomerContactID` INT(10) UNSIGNED NULL AFTER `old_CustomerID`,
	ADD CONSTRAINT `TblOrdersBOM_fk6` FOREIGN KEY (`CustomerContactID`) REFERENCES `CustomerContact` (`CustomerContactID`) ON UPDATE NO ACTION ON DELETE NO ACTION;
UPDATE TblOrdersBOM SET CustomerContactID = (SELECT CustomerContactID FROM CustomerContact WHERE CustomerContact.CustomerID = TblOrdersBOM.old_CustomerID);
ALTER TABLE `TblOrdersBOM`
	CHANGE COLUMN `CustomerContactID` `CustomerContactID` INT(10) UNSIGNED NOT NULL AFTER `old_CustomerID`;

	
--
--  TblFile
--
ALTER TABLE `TblFile`  
	ADD COLUMN `customerContactID` INT(10) UNSIGNED NULL DEFAULT NULL AFTER `customerID`,
	ADD CONSTRAINT `FK_TblFile_CustomerContact` FOREIGN KEY (`customerContactID`) REFERENCES `CustomerContact` (`CustomerContactID`) ON UPDATE NO ACTION ON DELETE NO ACTION;


--
--  CustomerLogins 
--
ALTER TABLE `CustomerLogins`
	DROP FOREIGN KEY `CustomerLogins_fk`,
	CHANGE COLUMN `customerID` `old_customerID` INT(10) NOT NULL AFTER `id`, 
	ADD COLUMN `customerContactID` INT(10) UNSIGNED NULL AFTER `old_customerID`,  
	ADD INDEX `CustomerLogins_idx3` (`customerContactID`), 
	ADD CONSTRAINT `FK_CustomerLogins_CustomerContact` FOREIGN KEY (`customerContactID`) REFERENCES `CustomerContact` (`CustomerContactID`) ON UPDATE RESTRICT ON DELETE CASCADE,
	ADD CONSTRAINT `CustomerLogins_fk` FOREIGN KEY (`old_customerID`) REFERENCES `Customers` (`CustomerID`) ON UPDATE NO ACTION ON DELETE CASCADE;

UPDATE CustomerLogins SET CustomerContactID = (SELECT CustomerContactID FROM CustomerContact WHERE CustomerContact.CustomerID = CustomerLogins.old_CustomerID);