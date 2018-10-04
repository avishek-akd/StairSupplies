
ALTER TABLE TblOrdersBOM
	ADD COLUMN InitialContactMade TINYINT NOT NULL DEFAULT 0 AFTER NeedToQuote,
	ADD COLUMN InitialContactMade_date DATETIME NULL DEFAULT NULL AFTER NeedToQuote_userId,
	ADD COLUMN InitialContactMade_userId INT NULL DEFAULT NULL AFTER InitialContactMade_date,
	ADD CONSTRAINT `FK_TblOrdersBOM_Employees_InitialContactMade` FOREIGN KEY (`InitialContactMade_userId`) REFERENCES `Employees` (`EmployeeID`);