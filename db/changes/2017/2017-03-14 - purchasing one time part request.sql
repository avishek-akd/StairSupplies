CREATE TABLE TblPurchaseOneTimePartRequest (
	RequestID INT UNSIGNED NOT NULL AUTO_INCREMENT,
	EmployeeID INT NOT NULL,
	Description VARCHAR(500) NULL DEFAULT NULL,
	RequestedQuantity INT NULL DEFAULT NULL,
	PurchasePrice DECIMAL(19,4) NULL DEFAULT NULL,
	RecordCreated DATETIME NOT NULL,
	PRIMARY KEY (`RequestID`),
	INDEX `idxEmployee` (`EmployeeID`),
	CONSTRAINT `FK_TblPurchaseOneTimePartRequest_Employees` FOREIGN KEY (`EmployeeID`) REFERENCES `Employees` (`EmployeeID`)
) ENGINE=InnoDB;