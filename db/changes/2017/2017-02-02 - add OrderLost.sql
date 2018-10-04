ALTER TABLE TblOrdersBOM
	ADD COLUMN OrderLost TINYINT NOT NULL DEFAULT 0 AFTER HighProbability,
	ADD COLUMN OrderLost_date DATETIME NULL DEFAULT NULL AFTER HighProbability_userId,
	ADD COLUMN OrderLost_userId INT NULL DEFAULT NULL AFTER OrderLost_date,
	ADD CONSTRAINT `FK_TblOrdersBOM_Employees_OrderLost` FOREIGN KEY (`OrderLost_userId`) REFERENCES `Employees` (`EmployeeID`);