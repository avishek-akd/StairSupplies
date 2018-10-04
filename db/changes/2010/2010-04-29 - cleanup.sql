DELETE
FROM TblOrdersBOM_Items
WHERE orderID is null;

ALTER TABLE `TblOrdersBOM_Items`
	CHANGE COLUMN `OrderID` `OrderID` INT(10) NOT NULL AFTER `OrderItemsID`;

ALTER TABLE `TblOrdersBOM_Items`
	CHANGE COLUMN `Outsource` `z_unused_Outsource` TINYINT(4) NULL DEFAULT NULL AFTER `ExceptionClosed`,
	CHANGE COLUMN `OutsourceDate` `z_unused_OutsourceDate` DATETIME NULL DEFAULT NULL AFTER `z_unused_Outsource`,
	CHANGE COLUMN `OutsourceInitials` `z_unused_OutsourceInitials` LONGTEXT NULL AFTER `z_unused_OutsourceDate`,
	CHANGE COLUMN `outsource_EmployeeID` `z_unused_outsource_EmployeeID` BIGINT(19) NULL DEFAULT NULL AFTER `ExceptionClosed_EmployeeID`;

ALTER TABLE `TblOrdersBOM_Items`
	CHANGE COLUMN `ExceptionId` `ExceptionId` BIGINT(19) NULL DEFAULT NULL AFTER `Prefinishing_Complete_EmployeeID`,
	CHANGE COLUMN `exceptionOpened_EmployeeID` `ExceptionOpened_EmployeeID` BIGINT(19) NULL DEFAULT NULL AFTER `ExceptionClosed`,
	CHANGE COLUMN `ExceptionClosed_EmployeeID` `ExceptionClosed_EmployeeID` BIGINT(19) NULL DEFAULT NULL AFTER `ExceptionOpened_EmployeeID`;

ALTER TABLE `TblOrdersBOM_Items`
	CHANGE COLUMN `ReadytoShip` `z_unused_ReadytoShip` TINYINT(4) NULL DEFAULT '0' AFTER `UnitWeight`,
	CHANGE COLUMN `PRC_Initials` `PRC_Initials` LONGTEXT NULL AFTER `PRC`,
	CHANGE COLUMN `PRC_Date` `PRC_Date` DATETIME NULL DEFAULT NULL AFTER `PRC_Initials`,
	CHANGE COLUMN `PRC_EmployeeID` `PRC_EmployeeID` BIGINT(19) NULL DEFAULT NULL AFTER `PRC_Date`,
	CHANGE COLUMN `Final_Initials` `Final_Initials` LONGTEXT NULL AFTER `Final`,
	CHANGE COLUMN `Final_Date` `Final_Date` DATETIME NULL DEFAULT NULL AFTER `Final_Initials`,
	CHANGE COLUMN `Final_EmployeeID` `Final_EmployeeID` BIGINT(19) NULL DEFAULT NULL AFTER `Final_Date`;

ALTER TABLE `TblOrdersBOM_Items`
	CHANGE COLUMN `Status` `z_unused_Status` VARCHAR(50) NULL DEFAULT NULL AFTER `Discount`;
