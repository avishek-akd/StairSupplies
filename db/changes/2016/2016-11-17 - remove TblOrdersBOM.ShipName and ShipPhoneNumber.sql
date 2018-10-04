-- Field are not used and are 99.99% NULL
ALTER TABLE `TblOrdersBOM`
	CHANGE COLUMN `ShipName` `_unused_ShipName` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `OrderWeight`,
	CHANGE COLUMN `ShipPhoneNumber` `_unused_ShipPhoneNumber` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `ShipPostalCode`;
