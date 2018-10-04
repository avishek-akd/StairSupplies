ALTER TABLE `TblOrdersBOM_Items`
	CHANGE COLUMN `PRC_EmployeeID` `PRC_EmployeeID` INT NULL DEFAULT NULL AFTER `PRC_Date`,
	CHANGE COLUMN `Final_EmployeeID` `Final_EmployeeID` INT NULL DEFAULT NULL AFTER `Final_Date`,
	CHANGE COLUMN `Prefinishing_Complete_EmployeeID` `Prefinishing_Complete_EmployeeID` INT NULL DEFAULT NULL AFTER `Prefinishing_Complete_Date`,
	CHANGE COLUMN `ExceptionId` `ExceptionId` INT NULL DEFAULT NULL AFTER `Prefinishing_Complete_EmployeeID`,
	CHANGE COLUMN `ExceptionOpened_EmployeeID` `ExceptionOpened_EmployeeID` INT NULL DEFAULT NULL AFTER `ExceptionClosed`,
	CHANGE COLUMN `ExceptionClosed_EmployeeID` `ExceptionClosed_EmployeeID` INT NULL DEFAULT NULL AFTER `ExceptionOpened_EmployeeID`;


UPDATE TblOrdersBOM_Items SET PRC_EmployeeID = NULL WHERE PRC_EmployeeID NOT IN (SELECT employeeID FROM Employees);
ALTER TABLE `TblOrdersBOM_Items`
	ADD CONSTRAINT `FK_TblOrdersBOM_Items_Employees_1` FOREIGN KEY (`PRC_EmployeeID`) REFERENCES `Employees` (`EmployeeID`) ON UPDATE NO ACTION ON DELETE NO ACTION;

UPDATE TblOrdersBOM_Items SET Final_EmployeeID = NULL WHERE Final_EmployeeID NOT IN (SELECT employeeID FROM Employees);
ALTER TABLE `TblOrdersBOM_Items`
	ADD CONSTRAINT `FK_TblOrdersBOM_Items_Employees_2` FOREIGN KEY (`Final_EmployeeID`) REFERENCES `Employees` (`EmployeeID`);

UPDATE TblOrdersBOM_Items SET Prefinishing_Complete_EmployeeID = NULL WHERE Prefinishing_Complete_EmployeeID NOT IN (SELECT employeeID FROM Employees);
ALTER TABLE `TblOrdersBOM_Items`
	ADD CONSTRAINT `FK_TblOrdersBOM_Items_Employees_3` FOREIGN KEY (`Prefinishing_Complete_EmployeeID`) REFERENCES `Employees` (`EmployeeID`);
	
UPDATE TblOrdersBOM_Items SET ExceptionOpened_EmployeeID = NULL WHERE ExceptionOpened_EmployeeID NOT IN (SELECT employeeID FROM Employees);
ALTER TABLE `TblOrdersBOM_Items`
	ADD CONSTRAINT `FK_TblOrdersBOM_Items_Employees_4` FOREIGN KEY (`ExceptionOpened_EmployeeID`) REFERENCES `Employees` (`EmployeeID`);
	
UPDATE TblOrdersBOM_Items SET ExceptionClosed_EmployeeID = NULL WHERE ExceptionClosed_EmployeeID NOT IN (SELECT employeeID FROM Employees);
ALTER TABLE `TblOrdersBOM_Items`
	ADD CONSTRAINT `FK_TblOrdersBOM_Items_Employees_5` FOREIGN KEY (`ExceptionClosed_EmployeeID`) REFERENCES `Employees` (`EmployeeID`);


ALTER TABLE `TblOrdersBOM_Items`
	ADD CONSTRAINT `FK_TblOrdersBOM_Items_TblOrdersBOM_Exceptions` FOREIGN KEY (`ExceptionId`) REFERENCES `TblOrdersBOM_Exceptions` (`id`);

	
ALTER TABLE `tblRGARequest`
	ADD UNIQUE INDEX `d_rga_number` (`d_rga_number`);
