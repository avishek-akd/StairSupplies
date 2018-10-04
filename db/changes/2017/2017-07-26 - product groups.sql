CREATE TABLE TblPostSystemType (
	`PostSystemTypeID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`Name` VARCHAR(50) NOT NULL,
	PRIMARY KEY (`PostSystemTypeID`),
	UNIQUE INDEX `unqName`(`Name`)
) ENGINE=InnoDB
;
INSERT INTO TblPostSystemType(Name)
VALUES
	('Cable'), ('Glass'), ('Rod')
;



CREATE TABLE TblPostMountingStyle (
	`PostMountingStyleID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`Name` VARCHAR(50) NOT NULL,
	PRIMARY KEY (`PostMountingStyleID`),
	UNIQUE INDEX `unqName`(`Name`)
) ENGINE=InnoDB
;
INSERT INTO TblPostMountingStyle(Name)
VALUES
	('Core Drill'), ('Side Mount'), ('Slim Side Mount'), ('Slim Side Mount Bump Out'),
	('Surface Mount'), ('Special Application')
;



CREATE TABLE TblPostTopStyle2 (
	`PostTopStyleID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`Name` VARCHAR(50) NOT NULL,
	PRIMARY KEY (`PostTopStyleID`),
	UNIQUE INDEX `unqName`(`Name`)
) ENGINE=InnoDB COMMENT='Simplified top styles, used in TblProductType'
;
INSERT INTO TblPostTopStyle2(Name)
VALUES
	('Flat Top'), ('Universal Top')
;



CREATE TABLE TblProductTypeGroup (
	`ProductTypeGroupID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`ParentGroupID` INT UNSIGNED NULL DEFAULT NULL COMMENT 'self-referencing ID for parent (if it\'s a secondary group)',
	`Title` VARCHAR(100) NOT NULL,
	`ShowInLateOrderReports` ENUM('neither', 'both', 'wood', 'cable') NOT NULL DEFAULT 'neither' COMMENT 'Show this product type in the Production: Late Order reports.',
	`Archived` TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
	`RecordCreated` DATETIME NOT NULL,
	`RecordUpdated` DATETIME NULL DEFAULT NULL,
	PRIMARY KEY(`ProductTypeGroupID`),
	UNIQUE INDEX `unqTitle`(`Title`),
	CONSTRAINT `FK_TblProductTypeGroup_parent` FOREIGN KEY (`ParentGroupID`) REFERENCES `TblProductTypeGroup` (`ProductTypeGroupID`) ON UPDATE NO ACTION ON DELETE NO ACTION
) Engine=INNODB
;
INSERT INTO TblProductTypeGroup(ParentGroupID, Title, ShowInLateOrderReports, RecordCreated)
VALUES
	(NULL, 'Cable Production', 'cable', Now()),
	(NULL, 'Wood Production', 'wood', Now()),
	(1, 'Cable railing Posts', 'cable', Now())
;



ALTER TABLE TblProductType
	ADD COLUMN `ShowOnAddOrderItem2` TINYINT(1) NOT NULL DEFAULT 1 COMMENT 'Controls if the products of this type of displayed when adding products to order. =1 Always show; =2  Use material filter; =3 Always hide',
	ADD COLUMN `isPost2` TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
	ADD COLUMN `isHandrail2` TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,

	ADD COLUMN `TypeGroupID` INT UNSIGNED NULL DEFAULT NULL AFTER `ProductType_id`,
	ADD COLUMN `AdditionalTypeGroupID` INT UNSIGNED NULL DEFAULT NULL AFTER `TypeGroupID`,
	ADD COLUMN `ShowOnInventory` TINYINT UNSIGNED NOT NULL DEFAULT 0 AFTER `ShowInLateOrderReports`,
	ADD COLUMN `PostSystemTypeID` INT UNSIGNED NULL DEFAULT NULL AFTER `isPost`,
	ADD COLUMN `PostMountingStyleID` INT UNSIGNED NULL DEFAULT NULL AFTER `PostSystemTypeID`,
	ADD COLUMN `PostTopStyleID` INT UNSIGNED NULL DEFAULT NULL AFTER `PostMountingStyleID`,
	ADD CONSTRAINT `FK_TblProductType_TblProductTypeGroup` FOREIGN KEY (`TypeGroupID`) REFERENCES `TblProductTypeGroup` (`ProductTypeGroupID`)
			ON UPDATE NO ACTION ON DELETE NO ACTION,
	ADD CONSTRAINT `FK_TblProductType_TblProductTypeGroupAdditional` FOREIGN KEY (`AdditionalTypeGroupID`) REFERENCES `TblProductTypeGroup` (`ProductTypeGroupID`)
			ON UPDATE NO ACTION ON DELETE NO ACTION,
	ADD CONSTRAINT `FK_TblProductType_TblPostSystemType` FOREIGN KEY (`PostSystemTypeID`) REFERENCES `TblPostSystemType` (`PostSystemTypeID`)
			ON UPDATE NO ACTION ON DELETE NO ACTION,
	ADD CONSTRAINT `FK_TblProductType_TblPostMountingStyle` FOREIGN KEY (`PostMountingStyleID`) REFERENCES `TblPostMountingStyle` (`PostMountingStyleID`)
			ON UPDATE NO ACTION ON DELETE NO ACTION,
	ADD CONSTRAINT `FK_TblProductType_TblPostTopStyle2` FOREIGN KEY (`PostTopStyleID`) REFERENCES `TblPostTopStyle2` (`PostTopStyleID`)
			ON UPDATE NO ACTION ON DELETE NO ACTION
;
UPDATE TblProductType SET TypeGroupID = 3
;
UPDATE TblProductType SET ShowOnAddOrderItem2 = ShowOnAddOrderItem, isPost2 = isPost, isHandrail2 = isHandrail
;
ALTER TABLE TblProductType
	CHANGE COLUMN `TypeGroupID` `TypeGroupID` INT UNSIGNED NOT NULL
;
