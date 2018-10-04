CREATE TABLE `TblProductTypeProductionType` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`Name` VARCHAR(50) NOT NULL,
	PRIMARY KEY (`id`)
)
COLLATE='utf8mb4_unicode_ci'
ENGINE=InnoDB
;
INSERT INTO TblProductTypeProductionType(Name)
VALUES ('Order Notes & Directions'), ('Wood Production'), ('Cable Production'), ('Wood Stock'), ('Cable Stock');


ALTER TABLE `TblProductType`
	ADD COLUMN `ProductionTypeID` INT(10) NULL AFTER `AccountingTypeID`,
	ADD CONSTRAINT `FK_TblProductType_TblProductTypeProductionType` FOREIGN KEY (`ProductionTypeID`) REFERENCES `TblProductTypeProductionType` (`id`);
