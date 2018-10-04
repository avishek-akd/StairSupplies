
ALTER TABLE `TblOrdersBOM_Items`
	DROP INDEX `idx_TblOrdersBOM_Items_ProductID`,
	ADD INDEX `idx_ProductID` (`ProductID`),
	DROP INDEX `IX_OrderID`,
	ADD INDEX `idx_OrderID` (`OrderID`),
	DROP INDEX `TblOrdersBOM_Items_idx`,
	ADD INDEX `idx_ExceptionId` (`ExceptionId`),
	DROP INDEX `TblOrdersBOM_Items_idx2`,
	ADD INDEX `idx_PRC_EmployeeID` (`PRC_EmployeeID`),
	DROP INDEX `TblOrdersBOM_Items_idx3`,
	ADD INDEX `idx_Final_EmployeeID` (`Final_EmployeeID`),
	DROP INDEX `TblOrdersBOM_Items_idx4`,
	ADD INDEX `idx_Prefinishing_Complete_EmployeeID` (`Prefinishing_Complete_EmployeeID`),
	DROP INDEX `TblOrdersBOM_Items_idx5`,
	ADD INDEX `idx_ExceptionOpened_EmployeeID` (`ExceptionOpened_EmployeeID`),
	DROP INDEX `TblOrdersBOM_Items_idx6`,
	ADD INDEX `idx_ExceptionClosed_EmployeeID` (`ExceptionClosed_EmployeeID`),
	DROP INDEX `Index 18`,
	ADD INDEX `idx_OrderID_ProductID` (`OrderID`, `ProductID`),
	DROP INDEX `GroupID`,
	ADD INDEX `idx_GroupID` (`GroupID`)
;
