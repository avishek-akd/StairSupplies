ALTER TABLE `TblOrdersBOM`
	ADD COLUMN `PaidPartially` TINYINT(4) NOT NULL DEFAULT '0' AFTER `Cancelled`,
	ADD COLUMN `PaidPartially_date` DATETIME NULL DEFAULT NULL AFTER `DueDate_userid`,
	ADD COLUMN `PaidPartially_userId` INT(10) NULL DEFAULT NULL AFTER `PaidPartially_date`,
	ADD CONSTRAINT `FK_TblOrdersBOM_Employees_15` FOREIGN KEY (`PaidPartially_userId`) REFERENCES `Employees` (`EmployeeID`);
