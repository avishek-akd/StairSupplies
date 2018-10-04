ALTER TABLE `TblOrdersBOM`
	CHANGE COLUMN `BillCompanyName` `BillCompanyName` VARCHAR(100) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `OrderWeight`,
	CHANGE COLUMN `BillContactFirstName` `BillContactFirstName` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `BillCompanyName`,
	CHANGE COLUMN `BillContactLastName` `BillContactLastName` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `BillContactFirstName`,
	CHANGE COLUMN `BillAddress1` `BillAddress1` VARCHAR(200) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `BillContactLastName`,
	CHANGE COLUMN `BillAddress2` `BillAddress2` VARCHAR(200) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `BillAddress1`,
	CHANGE COLUMN `BillAddress3` `BillAddress3` VARCHAR(200) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `BillAddress2`,
	CHANGE COLUMN `BillCity` `BillCity` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `BillAddress3`,
	CHANGE COLUMN `BillState` `BillState` VARCHAR(2) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `BillCity`,
	CHANGE COLUMN `BillStateOther` `BillStateOther` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `BillState`,
	CHANGE COLUMN `BillPostalCode` `BillPostalCode` VARCHAR(20) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `BillStateOther`,
	CHANGE COLUMN `BillCountryId` `BillCountryId` INT(11) NULL DEFAULT NULL AFTER `BillPostalCode`,
	CHANGE COLUMN `PhoneNumber` `PhoneNumber` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `BillCountryId`,
	CHANGE COLUMN `FaxNumber` `FaxNumber` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `PhoneNumber`,
	CHANGE COLUMN `CellPhone` `CellPhone` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `FaxNumber`,
	CHANGE COLUMN `Email` `Email` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `CellPhone`,
	CHANGE COLUMN `_unused_ShipName` `_unused_ShipName` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `ShipCountryId`;

ALTER TABLE `TblOrdersBOM`
	CHANGE COLUMN `PhoneNumber` `BillPhoneNumber` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `BillCountryId`,
	CHANGE COLUMN `FaxNumber` `BillFaxNumber` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `BillPhoneNumber`,
	CHANGE COLUMN `CellPhone` `BillCellPhone` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `BillFaxNumber`,
	CHANGE COLUMN `Email` `BillEmail` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `BillCellPhone`,
	ADD COLUMN `ShipPhoneNumber` VARCHAR(50) NULL DEFAULT NULL AFTER `ShipCountryId`,
	ADD COLUMN `ShipFaxNumber` VARCHAR(50) NULL DEFAULT NULL AFTER `ShipPhoneNumber`,
	ADD COLUMN `ShipCellPhone` VARCHAR(50) NULL DEFAULT NULL AFTER `ShipFaxNumber`,
	ADD COLUMN `ShipEmail` VARCHAR(50) NULL DEFAULT NULL AFTER `ShipCellPhone`;

UPDATE TblOrdersBOM
SET
	ShipPhoneNumber = BillPhoneNumber,
	ShipFaxNumber = BillFaxNumber,
	ShipCellPhone = BillCellPhone,
	ShipEmail = BillEmail
;