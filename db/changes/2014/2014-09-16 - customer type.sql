CREATE TABLE `CustomerType` (
	`id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`TypeName` VARCHAR(100) NOT NULL,
	PRIMARY KEY (`id`)
)
COLLATE='utf8_unicode_ci'
ENGINE=InnoDB;


INSERT INTO `CustomerType` (`TypeName`) VALUES ('Contractor');
INSERT INTO `CustomerType` (`TypeName`) VALUES ('Distributor');
INSERT INTO `CustomerType` (`TypeName`) VALUES ('Do Not Call');
INSERT INTO `CustomerType` (`TypeName`) VALUES ('Home Owner');
INSERT INTO `CustomerType` (`TypeName`) VALUES ('Iron Sample');
INSERT INTO `CustomerType` (`TypeName`) VALUES ('Level 1');
INSERT INTO `CustomerType` (`TypeName`) VALUES ('Level 2');
INSERT INTO `CustomerType` (`TypeName`) VALUES ('MailOnly');
INSERT INTO `CustomerType` (`TypeName`) VALUES ('Phonebook');
INSERT INTO `CustomerType` (`TypeName`) VALUES ('Phonebook Maybe');
INSERT INTO `CustomerType` (`TypeName`) VALUES ('Phonebook Yes');
INSERT INTO `CustomerType` (`TypeName`) VALUES ('Website');
INSERT INTO `CustomerType` (`TypeName`) VALUES ('Wood Sample Pack');
INSERT INTO `CustomerType` (`TypeName`) VALUES ('North Atlantic Corp.');


ALTER TABLE `Customers`
	ADD COLUMN `CustomerTypeID` INT UNSIGNED DEFAULT NULL AFTER `TaxExempt`,
	CHANGE COLUMN `CustomerType` `_unused_CustomerType` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `CustomerTypeID`;
	

UPDATE Customers
SET CustomerTypeID = (SELECT id FROM CustomerType WHERE TypeName = _unused_CustomerType);
