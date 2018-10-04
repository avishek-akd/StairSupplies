ALTER TABLE `Customers`
	CHANGE COLUMN `BillAddress4` `_unused_BillAddress4` VARCHAR(100) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `BillAddress3`,
	CHANGE COLUMN `ShipAddress4` `_unused_ShipAddress4` VARCHAR(100) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `ShipAddress3`,
	CHANGE COLUMN `defaultShippingMethodID` `_unused_defaultShippingMethodID` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT 'Default shipping method for new orders' AFTER `defaultDiscountPercent`;
ALTER TABLE `CustomerContact`
	CHANGE COLUMN `ContactAddress4` `_unused_ContactAddress4` VARCHAR(255) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `ContactAddress3`;
ALTER TABLE `TblOrdersBOM`
	CHANGE COLUMN `ShipAddress4` `_unused_ShipAddress4` VARCHAR(100) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `ShipAddress3`,
	CHANGE COLUMN `BillAddress4` `_unused_BillAddress4` VARCHAR(100) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `BillAddress3`;
