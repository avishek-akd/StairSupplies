ALTER TABLE TblOrdersBOM
	ADD COLUMN `Scrubbed` TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 AFTER `Ordered`,
	ADD COLUMN `Scrubbed_date` DATETIME NULL DEFAULT NULL AFTER `ordered_userid`,
	ADD COLUMN `Scrubbed_userid` INT(10) NULL DEFAULT NULL AFTER `Scrubbed_date`,
	ADD CONSTRAINT `FK_TblOrdersBOM_Employees_Scrubbed` FOREIGN KEY (`Scrubbed_userid`) REFERENCES `Employees` (`EmployeeID`)
;