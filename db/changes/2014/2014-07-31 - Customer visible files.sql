ALTER TABLE `TblFile`
	ADD COLUMN `orderCustomerVisibleID` INT NULL DEFAULT NULL COMMENT 'This field is a foreign key into the orders table but it\'s for Customer visible files (files that the customer can see in the /sales/ area)' AFTER `rgaRequestStatusID`,
	ADD CONSTRAINT `FK_TblFile_TblOrdersBOM_2` FOREIGN KEY (`orderCustomerVisibleID`) REFERENCES `TblOrdersBOM` (`OrderID`) ON UPDATE NO ACTION ON DELETE NO ACTION,

	DROP INDEX `Index 8`,
	ADD INDEX `idxRequestStatus` (`rgaRequestStatusID`);

ALTER TABLE `TblFile`
	DROP INDEX `FK_TblFile_TblOrdersBOM_2`,
	ADD INDEX `idxOrderCustomerVisible` (`orderCustomerVisibleID`);
