ALTER TABLE `Products` 
	ADD COLUMN `BoardFootage_date` DATETIME NULL DEFAULT NULL AFTER `BoardFootage`, 
	ADD COLUMN `BoardFootage_EmployeeID` INT NULL DEFAULT NULL AFTER `BoardFootage_date`;

ALTER TABLE `Products`  
	ADD INDEX `idx_BoardFootageEmployee` (`BoardFootage_EmployeeID`),
	ADD CONSTRAINT `FK_Products_Employees` FOREIGN KEY (`BoardFootage_EmployeeID`) REFERENCES `Employees` (`EmployeeID`) ON UPDATE NO ACTION ON DELETE NO ACTION;
