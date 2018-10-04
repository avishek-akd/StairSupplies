ALTER TABLE `TblOrdersBOM_InHouseNotes`
	ALTER `InHouseNote` DROP DEFAULT;
ALTER TABLE `TblOrdersBOM_InHouseNotes`
	CHANGE COLUMN `OrderInHouseNotesID` `OrderNoteID` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT FIRST,
	CHANGE COLUMN `InHouseNote` `NoteInHouse` VARCHAR(4000) NULL COLLATE 'utf8_unicode_ci' AFTER `EmployeeID`,
	ADD COLUMN `NoteFromCustomer` VARCHAR(4000) NULL AFTER `NoteInHouse`,
	ADD COLUMN `NoteProjectTimeFrame` VARCHAR(4000) NULL AFTER `NoteFromCustomer`,
	ADD COLUMN `NoteReasonForLoss` VARCHAR(4000) NULL AFTER `NoteProjectTimeFrame`,
	ADD COLUMN `NoteReasonForWin` VARCHAR(4000) NULL AFTER `NoteReasonForLoss`;
RENAME TABLE `TblOrdersBOM_InHouseNotes` TO `TblOrdersBOM_Note`;


ALTER TABLE `TblOrdersBOM`
	CHANGE COLUMN `Notes_From_Customer` `_unused_Notes_From_Customer` VARCHAR(4000) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `_unused_In_House_Notes_bk`;
INSERT INTO TblOrdersBOM_Note (OrderID, NoteFromCustomer, RecordCreated)
	SELECT OrderID, _unused_Notes_From_Customer, Now()
	FROM TblOrdersBOM
	WHERE _unused_Notes_From_Customer IS NOT NULL
		AND _unused_Notes_From_Customer <> '';




CREATE TABLE `TblReasonLoss` (
	`ReasonLossID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`Title` VARCHAR(100) NOT NULL,
	`RecordCreated` DATETIME NOT NULL,
	PRIMARY KEY (`ReasonLossID`)
);
INSERT INTO TblReasonLoss (Title, RecordCreated)
		VALUES
		('Price', Now()),
		('Lead Time', Now()),
		('Quote Speed', Now()),
		('Local', Now()),
		('Product Offering', Now());


CREATE TABLE `TblReasonWin` (
	`ReasonWinID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`Title` VARCHAR(100) NOT NULL,
	`RecordCreated` DATETIME NOT NULL,
	PRIMARY KEY (`ReasonWinID`)
);
INSERT INTO TblReasonWin (Title, RecordCreated)
		VALUES
		('Product Offering', Now()),
		('Price', Now()),
		('Service', Now()),
		('Lead Time', Now());



ALTER TABLE TblOrdersBOM
	ADD COLUMN `ReasonLossID` INT UNSIGNED NULL AFTER `_unused_Notes_From_Customer`,
	ADD COLUMN `ReasonWinID` INT UNSIGNED NULL AFTER `ReasonLossID`,
	ADD CONSTRAINT `TblOrdersBOM_ReasonLossID` FOREIGN KEY (`ReasonLossID`) REFERENCES `TblReasonLoss`(`ReasonLossID`),
	ADD CONSTRAINT `TblOrdersBOM_ReasonWinID` FOREIGN KEY (`ReasonWinID`) REFERENCES `TblReasonWin`(`ReasonWinID`),

	ADD COLUMN Status1stFollowUp TINYINT NOT NULL DEFAULT 0 AFTER Estimate,
	ADD COLUMN Status2ndFollowUp TINYINT NOT NULL DEFAULT 0 AFTER Status1stFollowUp,
	ADD COLUMN HighProbability TINYINT NOT NULL DEFAULT 0 AFTER Status2ndFollowUp,
	ADD COLUMN FinalFollowUp TINYINT NOT NULL DEFAULT 0 AFTER HighProbability,

	ADD COLUMN Status1stFollowUp_date DATETIME NULL DEFAULT NULL AFTER estimate_userId,
	ADD COLUMN Status1stFollowUp_userId INT NULL DEFAULT NULL AFTER Status1stFollowUp_date,
	ADD CONSTRAINT `FK_TblOrdersBOM_Employees_Status1stFollowUp` FOREIGN KEY (`Status1stFollowUp_userId`) REFERENCES `Employees` (`EmployeeID`),

	ADD COLUMN Status2ndFollowUp_date DATETIME NULL DEFAULT NULL AFTER Status1stFollowUp_userId,
	ADD COLUMN Status2ndFollowUp_userId INT NULL DEFAULT NULL AFTER Status2ndFollowUp_date,
	ADD CONSTRAINT `FK_TblOrdersBOM_Employees_Status2ndFollowUp` FOREIGN KEY (`Status2ndFollowUp_userId`) REFERENCES `Employees` (`EmployeeID`),

	ADD COLUMN HighProbability_date DATETIME NULL DEFAULT NULL AFTER Status2ndFollowUp_userId,
	ADD COLUMN HighProbability_userId INT NULL DEFAULT NULL AFTER HighProbability_date,
	ADD CONSTRAINT `FK_TblOrdersBOM_Employees_HighProbability` FOREIGN KEY (`HighProbability_userId`) REFERENCES `Employees` (`EmployeeID`),

	ADD COLUMN FinalFollowUp_date DATETIME NULL DEFAULT NULL AFTER HighProbability_userId,
	ADD COLUMN FinalFollowUp_userId INT NULL DEFAULT NULL AFTER FinalFollowUp_date,
	ADD CONSTRAINT `FK_TblOrdersBOM_Employees_FinalFollowUp` FOREIGN KEY (`FinalFollowUp_userId`) REFERENCES `Employees` (`EmployeeID`);
