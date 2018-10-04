ALTER TABLE `TblSalesFile`
	CHANGE COLUMN `id` `SalesFileID` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
	CHANGE COLUMN `name` `FileHeadline` VARCHAR(100) NOT NULL,
	ADD COLUMN `FileDescription` VARCHAR(200) NULL DEFAULT NULL AFTER `FileHeadline`
;
ALTER TABLE `TblSalesFileGroup`
	ALTER `name` DROP DEFAULT
;
ALTER TABLE `TblSalesFileGroup`
	CHANGE COLUMN `id` `GroupID` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT FIRST,
	CHANGE COLUMN `name` `SalesGroupName` VARCHAR(50) NOT NULL COLLATE 'utf8_unicode_ci' AFTER `GroupID`
;

CREATE TABLE `TblSalesFolder` (
	`SalesFolderID` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
	`GroupID` INT(10) UNSIGNED NOT NULL,
	`FolderName` VARCHAR(100) NOT NULL,
	`RecordCreated` DATETIME NOT NULL,
	`RecordUpdated` DATETIME NULL DEFAULT NULL,
	PRIMARY KEY (`SalesFolderID`)
) ENGINE=InnoDB
;
INSERT INTO `TblSalesFolder` (FolderName, GroupID, RecordCreated)
VALUES
	('Default', 1, Now()),
	('Default', 2, Now())
;


CREATE TABLE `TblSalesFileFolder` (
	`SalesFolderID` INT(10) UNSIGNED NOT NULL,
	`SalesFileID` INT(10) UNSIGNED NOT NULL,
	PRIMARY KEY(`SalesFolderID`, `SalesFileID`),
	INDEX `idxFK_SalesFileID` (`SalesFileID`),
	CONSTRAINT `FK_TblSalesFileFolder_SalesFolderID` FOREIGN KEY (`SalesFolderID`) REFERENCES `TblSalesFolder` (`SalesFolderID`),
	CONSTRAINT `FK_TblSalesFileFolder_SalesFileID` FOREIGN KEY (`SalesFileID`) REFERENCES `TblSalesFile` (`SalesFileID`)
) ENGINE=InnoDB
;
INSERT INTO `TblSalesFileFolder` (SalesFolderID, SalesFileID)
SELECT 1, SalesFileID
FROM TblSalesFile
WHERE GroupID = 1
;
INSERT INTO `TblSalesFileFolder` (SalesFolderID, SalesFileID)
SELECT 2, SalesFileID
FROM TblSalesFile
WHERE GroupID = 2
;



ALTER TABLE `tbl_settings_per_company`
	ADD COLUMN `DefaultSalesImages` VARCHAR(20) NOT NULL DEFAULT '' COMMENT 'List of image ID\'s from TblSalesFile that are used when no files are selected by the user.' AFTER `SalePriceEnabled`
;
ALTER TABLE `tbl_settings_global`
	ADD COLUMN `SalesFilesProjectLayoutHeadline` VARCHAR(100) NULL AFTER `VictorImportEnabled`,
	ADD COLUMN `SalesFilesProjectLayoutDescription` VARCHAR(200) NULL AFTER `SalesFilesProjectLayoutHeadline`
;
UPDATE tbl_settings_global
SET
	SalesFilesProjectLayoutHeadline = 'Project Information',
	SalesFilesProjectLayoutDescription = 'View your project layout, blueprints and download installation information.'
;



ALTER TABLE `TblOrdersBOM_SalesFile`
	ADD COLUMN `SortOrder` INT NULL DEFAULT NULL
;