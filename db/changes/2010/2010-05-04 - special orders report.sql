-- Apeters appears three times in the Employees table. Remove the 2 entries that don't have an Employee code associated
DELETE FROM `Employees` WHERE (`EmployeeID`=166) LIMIT 1;
DELETE FROM `Employees` WHERE (`EmployeeID`=171) LIMIT 1;


ALTER TABLE `TblOrdersBOM_Items`
	ADD COLUMN `so_dimensions` TINYINT(4) NOT NULL DEFAULT '0',
	ADD COLUMN `so_dimensions_date` DATETIME NULL DEFAULT NULL,
	ADD COLUMN `so_dimensions_employeeID` INT NULL DEFAULT NULL,

	ADD COLUMN `so_email_sent` TINYINT(4) NOT NULL DEFAULT '0',
	ADD COLUMN `so_email_sent_date` DATETIME NULL DEFAULT NULL,
	ADD COLUMN `so_email_sent_employeeID` INT NULL DEFAULT NULL,
	
	ADD COLUMN `so_customer_approved` TINYINT(4) NOT NULL DEFAULT '0',
	ADD COLUMN `so_customer_approved_date` DATETIME NULL DEFAULT NULL,
	ADD COLUMN `so_customer_approved_employeeID` INT NULL DEFAULT NULL,
	
	ADD COLUMN `so_programming_complete` TINYINT(4) NOT NULL DEFAULT '0',
	ADD COLUMN `so_programming_complete_date` DATETIME NULL DEFAULT NULL,
	ADD COLUMN `so_programming_complete_employeeID` INT NULL DEFAULT NULL;


ALTER TABLE `TblOrdersBOM_Items`
	ADD CONSTRAINT `FK_TblOrdersBOM_Items_Employees1` FOREIGN KEY (`so_dimensions_employeeID`)
			REFERENCES `Employees` (`EmployeeID`) ON UPDATE NO ACTION ON DELETE NO ACTION,
	ADD CONSTRAINT `FK_TblOrdersBOM_Items_Employees2` FOREIGN KEY (`so_email_sent_employeeID`)
			REFERENCES `Employees` (`EmployeeID`) ON UPDATE NO ACTION ON DELETE NO ACTION,
	ADD CONSTRAINT `FK_TblOrdersBOM_Items_Employees3` FOREIGN KEY (`so_customer_approved_employeeID`)
			REFERENCES `Employees` (`EmployeeID`) ON UPDATE NO ACTION ON DELETE NO ACTION,
	ADD CONSTRAINT `FK_TblOrdersBOM_Items_Employees4` FOREIGN KEY (`so_programming_complete_employeeID`)
			REFERENCES `Employees` (`EmployeeID`) ON UPDATE NO ACTION ON DELETE NO ACTION;

	
UPDATE TblOrdersBOM_Items AS target
	INNER JOIN Tbl_SpecialOrder_new AS source ON target.orderItemsID = source.specialOrderID
SET 
	target.so_dimensions = Coalesce(source.dimensions, 0),
	target.so_dimensions_date = source.dim_date,
	target.so_dimensions_employeeID = (SELECT EmployeeID FROM Employees WHERE Employees.username = source.dim_username),

	target.so_email_sent = Coalesce(source.email_sent, 0),
	target.so_email_sent_date = source.email_date,
	target.so_email_sent_employeeID = (SELECT EmployeeID FROM Employees WHERE Employees.username = source.email_username),

	target.so_customer_approved = Coalesce(source.customer_approval, 0),
	target.so_customer_approved_date = source.customer_date,
	target.so_customer_approved_employeeID = (SELECT EmployeeID FROM Employees WHERE Employees.username = source.customer_username),

	target.so_programming_complete = Coalesce(source.programming_complete, 0),
	target.so_programming_complete_date = source.pcomplete_date,
	target.so_programming_complete_employeeID = (SELECT EmployeeID FROM Employees WHERE Employees.username = source.pcomplete_username)
;


RENAME TABLE `Tbl_SpecialOrder_new` TO `z_unused_Tbl_SpecialOrder_new`;