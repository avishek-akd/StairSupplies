CREATE TABLE `CustomerInitialContact` (
	`InitialContactID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`Title` VARCHAR(200) NOT NULL,
	`RecordCreated` DATETIME NOT NULL,
	`RecordUpdated` DATETIME NULL,
	PRIMARY KEY (`InitialContactID`)
) ENGINE=InnoDB;
INSERT INTO CustomerInitialContact
	(Title, RecordCreated)
VALUES
	('Website', Now()),
	('Phone Call', Now()),
	('Email', Now()),
	('Victor Drawing', Now()),
	('Contact Form - Basic', Now()),
	('Contact Form - Help me build', Now()),
	('Design Help - Wood', Now()),
	('Design Help - Metal Cable', Now()),
	('Design Help - Wood Cable', Now()),
	('Stair Artist', Now()),
	('Saved Cart - Shipping', Now()),
	('Saved Cart - Design', Now()),
	('Saved Cart - Design & Shipping', Now()),
	('Trade Show - IBS', Now()),
	('Trade Show - RDJ', Now()),
	('Phil Pudewell', Now()),
	('Unknown', Now())
;
ALTER TABLE Customers
	ADD COLUMN `InitialContactID` INT UNSIGNED NULL DEFAULT NULL AFTER `CustomerTypeID`,
	ADD CONSTRAINT `FK_Customers_CustomerInitialContact` FOREIGN KEY (`InitialContactID`) REFERENCES `CustomerInitialContact`(`InitialContactID`)
;
--  Customer type Website maps to Initial contact Website
UPDATE Customers
SET InitialContactID = 1
WHERE CustomerTypeID IS NOT NULL
	AND CustomerTypeID = 12;




UPDATE CustomerType
SET TypeName = 'Unknown'
WHERE id = 3;


UPDATE Customers
SET CustomerTypeID = 3
WHERE CustomerTypeID IS NOT NULL
	AND CustomerTypeID NOT IN (1,2,3,4,14);

DELETE
FROM CustomerType
WHERE id NOT IN (1,2,3,4,14);