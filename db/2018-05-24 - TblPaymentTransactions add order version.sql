ALTER TABLE `TblPaymentTransactions`
	ADD COLUMN `OrderVersionID` INT(10) UNSIGNED NULL DEFAULT NULL AFTER `OrderID`,
	ADD CONSTRAINT `FK_TblPaymentTransactions_OrderVersionID` FOREIGN KEY (`OrderVersionID`) REFERENCES `TblOrdersBOM_Version` (`OrderVersionID`) ON UPDATE NO ACTION ON DELETE NO ACTION
;