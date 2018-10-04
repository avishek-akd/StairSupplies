ALTER TABLE `CustomerContact`
	CHANGE COLUMN `ContactCompanyName` `ContactCompanyName` VARCHAR(100) NULL DEFAULT NULL AFTER `CustomerID`;
