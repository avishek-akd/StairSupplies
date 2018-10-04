--  Emails field is too small
ALTER TABLE `TblOrdersBOM`
	CHANGE COLUMN `BillEmails` `BillEmails` VARCHAR(500) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `BillCellPhone`,
	CHANGE COLUMN `ShipEmails` `ShipEmails` VARCHAR(500) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `ShipCellPhone`,
	DROP INDEX `idxShippingAddress`,
	ADD INDEX `idxShippingAddress` (`ShipCompanyName`, `ShipContactFirstName`, `ShipAddress1`, `ShipAddress2`, `ShipAddress3`, `ShipCity`, `ShipState`, `ShipPostalCode`, `BillPhoneNumber`, `BillFaxNumber`)
;
