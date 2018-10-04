ALTER TABLE TblEmployee
	ADD COLUMN `DefaultCustomerServiceEmployeeID` INT NULL DEFAULT NULL
			COMMENT 'Setting the sales person to this employee automatically sets the customer service and sales support persons. Kind of like a team.' AFTER `EmailSignatureViewrail`,
	ADD COLUMN `DefaultSalesSupportEmployeeID` INT  NULL DEFAULT NULL
			COMMENT 'Setting the sales person to this employee automatically sets the customer service and sales support persons. Kind of like a team.' AFTER `DefaultCustomerServiceEmployeeID`,

	ADD INDEX `idxFK_DefaultCustomerServiceEmployeeID`(`DefaultCustomerServiceEmployeeID`),
	ADD INDEX `idxFK_DefaultSalesSupportEmployeeID`(`DefaultSalesSupportEmployeeID`),

	ADD CONSTRAINT `FK_TblEmployee_DefaultCustomerServiceEmployeeID` FOREIGN KEY (`DefaultCustomerServiceEmployeeID`) REFERENCES `TblEmployee` (`EmployeeID`) ON UPDATE NO ACTION ON DELETE NO ACTION,
	ADD CONSTRAINT `FK_TblEmployee_DefaultSalesSupportEmployeeID` FOREIGN KEY (`DefaultSalesSupportEmployeeID`) REFERENCES `TblEmployee` (`EmployeeID`) ON UPDATE NO ACTION ON DELETE NO ACTION
;
