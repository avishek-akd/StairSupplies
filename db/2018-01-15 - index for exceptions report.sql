ALTER TABLE `TblOrdersBOM_Items`
	DROP INDEX `ExceptionOpened`,
	ADD INDEX `idxExceptionOpened_Closed_Date` (`ExceptionOpened`, `ExceptionClosed`, `ExceptionOpened_Date`)
;