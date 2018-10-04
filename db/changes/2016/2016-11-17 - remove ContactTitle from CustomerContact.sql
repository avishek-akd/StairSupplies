ALTER TABLE `CustomerContact`
	CHANGE COLUMN `ContactTitle` `_unused_ContactTitle` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `ContactCompanyName`;
