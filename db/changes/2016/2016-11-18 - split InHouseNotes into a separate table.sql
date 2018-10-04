CREATE TABLE `TblOrdersBOM_InHouseNotes` (
	`OrderInHouseNotesID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`OrderID` INT NOT NULL,
	`EmployeeID` INT NULL DEFAULT NULL,
	`InHouseNote` VARCHAR(4000) NOT NULL,
	`RecordCreated` DATETIME NULL DEFAULT NULL,
	PRIMARY KEY (`OrderInHouseNotesID`)
);
ALTER TABLE `TblOrdersBOM_InHouseNotes`
	ADD CONSTRAINT `FK_TblOrdersBOM_InHouseNotes_TblOrdersBOM` FOREIGN KEY (`OrderID`) REFERENCES `TblOrdersBOM` (`OrderID`),
	ADD CONSTRAINT `FK_TblOrdersBOM_InHouseNotes_Employees` FOREIGN KEY (`EmployeeID`) REFERENCES `Employees` (`EmployeeID`);



--  Add a backup field to keep the notes because we will actually NULL _unused_In_House_Notes when we migrate that info to TblOrdersBOM_InHouseNotes
ALTER TABLE `TblOrdersBOM`
	CHANGE COLUMN `In_House_Notes` `_unused_In_House_Notes` LONGTEXT NULL COLLATE 'utf8_unicode_ci' AFTER `FreightChargeTaxRate`,
	ADD COLUMN `_unused_In_House_Notes_bk` LONGTEXT NULL AFTER `_unused_In_House_Notes`;
UPDATE TblOrdersBOM SET _unused_In_House_Notes_bk = _unused_In_House_Notes;
