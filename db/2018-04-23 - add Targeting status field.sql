ALTER TABLE TblOrdersBOM
	ADD COLUMN Targeting TINYINT NOT NULL DEFAULT 0 AFTER HighProbability,
	ADD COLUMN Targeting_date DATETIME NULL DEFAULT NULL AFTER HighProbability_userId,
	ADD COLUMN Targeting_userId INT NULL DEFAULT NULL AFTER Targeting_date,
	ADD CONSTRAINT `FK_TblOrdersBOM_Targeting_userId` FOREIGN KEY (`Targeting_userId`) REFERENCES `TblEmployee` (`EmployeeID`)
;