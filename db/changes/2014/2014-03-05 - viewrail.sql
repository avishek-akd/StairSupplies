INSERT INTO `Company`
	(`CompanyName`, `Address`, `City`, `StateOrProvince`,
	`PostalCode`, `Country`, `PhoneNumber`, `FaxNumber`, `FileSuffix`, `webAddress`)
VALUES
	('Viewrail', '1722 Eisenhower Drive North', 'Goshen', 'IN',
	'46526', 'USA', '574-742-1030', NULL, 'viewrail', 'http://www.viewrailsystems.com');

	
ALTER TABLE `Company`
	ADD COLUMN `isActive` TINYINT(1) UNSIGNED NOT NULL DEFAULT '1' AFTER `webAddress`;
	
UPDATE `Company` SET `isActive`=0 WHERE  `CompanyID`=2;