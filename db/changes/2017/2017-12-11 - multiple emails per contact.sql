CREATE TABLE `TblCustomerContactEmail` (
	`CustomerContactEmailID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`CustomerContactID` INT UNSIGNED NOT NULL,
	`Email` VARCHAR(50) NOT NULL,
	`RecordCreated` DATETIME NOT NULL,
	PRIMARY KEY (`CustomerContactEmailID`),
	INDEX `idxCustomerContactID` (`CustomerContactID`),
	CONSTRAINT `FK_TblCustomerContactEmail_CustomerContact` FOREIGN KEY (`CustomerContactID`) REFERENCES `TblCustomerContact` (`CustomerContactID`) ON UPDATE NO ACTION ON DELETE CASCADE
)
;


ALTER TABLE `TblOrdersBOM`
	CHANGE COLUMN `BillEmail` `BillEmails` VARCHAR(50) NULL DEFAULT NULL AFTER `BillCellPhone`,
	CHANGE COLUMN `ShipEmail` `ShipEmails` VARCHAR(50) NULL DEFAULT NULL AFTER `ShipCellPhone`
;
