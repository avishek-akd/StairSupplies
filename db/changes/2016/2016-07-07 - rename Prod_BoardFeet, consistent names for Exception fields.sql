-- The field is actually used as In Process so rename it
ALTER TABLE `TblOrdersBOM_Items`
	CHANGE COLUMN `Prod_BoardFeet` `QuantityInProcess` INT NULL DEFAULT '0' AFTER `UnitWeight`;


--  Field order should be consistent with the other flag fields (PRC, Final, etc)
ALTER TABLE `TblOrdersBOM_Items`
	CHANGE COLUMN `ExceptionOpened_EmployeeID` `ExceptionOpened_EmployeeID` INT(11) NULL DEFAULT NULL AFTER `ExceptionOpened`,
	CHANGE COLUMN `ExceptionClosed` `ExceptionClosed` TINYINT(4) NULL DEFAULT '0' AFTER `ExceptionDateCreated`,
	CHANGE COLUMN `ExceptionClosed_EmployeeID` `ExceptionClosed_EmployeeID` INT(11) NULL DEFAULT NULL AFTER `ExceptionClosed`;
--  Consistent field name for dates
ALTER TABLE `TblOrdersBOM_Items`
	CHANGE COLUMN `ExceptionDateCreated` `ExceptionOpened_Date` DATETIME NULL DEFAULT NULL AFTER `ExceptionOpened_EmployeeID`,
	CHANGE COLUMN `ExceptionDateClosed` `ExceptionClosed_Date` DATETIME NULL DEFAULT NULL AFTER `ExceptionClosed_EmployeeID`;


