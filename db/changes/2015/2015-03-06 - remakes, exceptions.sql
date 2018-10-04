ALTER TABLE `TblOrdersBOM`
	ADD COLUMN `RemakeNoteID` INT UNSIGNED NULL DEFAULT NULL COMMENT 'If this order needs to be remade this is the reason (this or remakeNotes need to be filled in)' AFTER `Remake_userId`,
	ADD COLUMN `RemakeFaultID` INT UNSIGNED NULL DEFAULT NULL COMMENT 'Why did we have to remake (XOR RemakeFaultEmployeeID)' AFTER `RemakeNoteID`,
	ADD COLUMN `RemakeFaultEmployeeID` INT NULL DEFAULT NULL COMMENT 'Who\'s to blame for the remake (XOR RemakeFaultID)' AFTER `RemakeFaultID`,
	ADD COLUMN `RemakeCostEstimate` DECIMAL(10,2) NULL DEFAULT NULL COMMENT 'How much does the remake cost ?' AFTER `RemakeFaultEmployeeID`,
	ADD CONSTRAINT `FK_TblOrdersBOM_TblOrdersBOM_Remakes` FOREIGN KEY (`RemakeNoteID`) REFERENCES `TblOrdersBOM_Remakes` (`id`),
	ADD CONSTRAINT `FK_TblOrdersBOM_TblOrdersBOM_Faults` FOREIGN KEY (`RemakeFaultID`) REFERENCES `TblOrdersBOM_Faults` (`id`),
	ADD CONSTRAINT `FK_TblOrdersBOM_Employees_11` FOREIGN KEY (`RemakeFaultEmployeeID`) REFERENCES `Employees` (`EmployeeID`);



ALTER TABLE `TblOrdersBOM_Items`
	ADD COLUMN `ExceptionFaultId` INT UNSIGNED NULL DEFAULT NULL AFTER `ExceptionClosed_EmployeeID`,
	ADD COLUMN `ExceptionFaultEmployeeId` INT NULL DEFAULT NULL AFTER `ExceptionFaultId`,
	ADD COLUMN `ExceptionCostEstimate` DECIMAL(10,2) NULL DEFAULT NULL AFTER `ExceptionFaultEmployeeId`,
	ADD CONSTRAINT `FK_TblOrdersBOM_Items_TblOrdersBOM_Faults` FOREIGN KEY (`ExceptionFaultId`) REFERENCES `TblOrdersBOM_Faults` (`id`),
	ADD CONSTRAINT `FK_TblOrdersBOM_Items_Employees` FOREIGN KEY (`ExceptionFaultEmployeeId`) REFERENCES `Employees` (`EmployeeID`);
