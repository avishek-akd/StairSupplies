DROP TABLE `z_unused_TblProductVendors`;


ALTER TABLE `Customers`
	DROP INDEX `Customers_idx8`,
	DROP INDEX `IX_Customers`,
	DROP INDEX `Customers_idx3`,
	DROP FOREIGN KEY `Customers_fk4`,
	DROP FOREIGN KEY `Customers_fk5`;
ALTER TABLE `Customers`
	DROP COLUMN `old_Email`,
	DROP COLUMN `old_Password`,
	DROP COLUMN `old_CanLogin`,
	DROP COLUMN `old_BillingEmails`,
	DROP COLUMN `old_iPhoneToken`;
ALTER TABLE `Customers`
	DROP COLUMN `old_ContactCompanyName`,
	DROP COLUMN `old_ContactTitle`,
	DROP COLUMN `old_ContactFirstName`,
	DROP COLUMN `old_ContactLastName`,
	DROP COLUMN `old_ContactAddress1`,
	DROP COLUMN `old_ContactAddress2`,
	DROP COLUMN `old_ContactAddress3`,
	DROP COLUMN `old_ContactAddress4`,
	DROP COLUMN `old_ContactCity`,
	DROP COLUMN `old_ContactState`,
	DROP COLUMN `old_ContactStateOther`,
	DROP COLUMN `old_ContactPostalCode`,
	DROP COLUMN `old_ContactCountryId`,
	DROP COLUMN `old_ContactPhoneNumber`,
	DROP COLUMN `old_ContactFaxNumber`,
	DROP COLUMN `old_ContactCellPhone`;



ALTER TABLE `TblOrdersBOM`
	DROP INDEX `IX_CustomerID`,
	DROP FOREIGN KEY `FK_TblOrdersBOM_Customers`,
	DROP COLUMN `old_CustomerID`;



ALTER TABLE `TblOrdersBOM_Items`
	DROP INDEX `TblOrdersBOM_Items19`,
	ADD INDEX `TblOrdersBOM_Items19` (`OrderID`, `Quantity`, `QuantityShipped`, `Unit_of_Measure`, `Special_Instructions`, `ProductName`, `ProductDescription`(255)),
	DROP INDEX `TblOrdersBOM_Items49`,
	ADD INDEX `TblOrdersBOM_Items49` (`OrderID`, `Quantity`);



ALTER DATABASE `XXXXXXXXXXXXXXXXXXXXX REPLACE WITH ACTUAL DB NAME` CHARACTER SET utf8 COLLATE 'utf8_unicode_ci';



ALTER TABLE `TblOrdersBOM_ShipmentsItems`
	COLLATE='utf8_unicode_ci';
ALTER TABLE `TblOrdersBOM_ShipmentsItems`
	CHANGE COLUMN `BoxSkidNumber` `BoxSkidNumber` VARCHAR(10) NULL DEFAULT NULL AFTER `QuantityShipped`;



ALTER TABLE `TblFile`
	COLLATE='utf8_unicode_ci';
ALTER TABLE `TblFile`
	CHANGE COLUMN `file_name` `file_name` VARCHAR(100) NOT NULL AFTER `customerContactID`,
	CHANGE COLUMN `thumbnail` `thumbnail` VARCHAR(100) NULL DEFAULT NULL AFTER `file_name`;



ALTER TABLE `TblOrdersBOM_Shipments_Signature`
	COLLATE='utf8_unicode_ci';
ALTER TABLE `TblOrdersBOM_Shipments_Signature`
	CHANGE COLUMN `signature_file` `signature_file` VARCHAR(100) NOT NULL AFTER `shipmentID`,
	CHANGE COLUMN `initials` `initials` VARCHAR(100) NOT NULL AFTER `signature_file`,
	CHANGE COLUMN `request_ip` `request_ip` VARCHAR(15) NOT NULL AFTER `initials`;



ALTER TABLE `TblOrdersBOM_Signature`
	COLLATE='utf8_unicode_ci';
ALTER TABLE `TblOrdersBOM_Signature`
	CHANGE COLUMN `signature_file` `signature_file` VARCHAR(100) NOT NULL AFTER `orderID`,
	CHANGE COLUMN `initials` `initials` VARCHAR(100) NOT NULL AFTER `signature_file`,
	CHANGE COLUMN `request_ip` `request_ip` VARCHAR(15) NOT NULL AFTER `initials`;
