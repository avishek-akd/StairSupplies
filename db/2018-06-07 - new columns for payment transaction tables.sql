ALTER TABLE `TblPaymentTransactions` 
	ADD COLUMN `EmployeeID` INT(10) NULL DEFAULT NULL AFTER `OrderVersionID`,
	ADD CONSTRAINT `FK_TblPaymentTransactions_EmployeeID` FOREIGN KEY (`EmployeeID`) REFERENCES `TblEmployee` (`EmployeeID`) ON UPDATE NO ACTION ON DELETE NO ACTION;
	
ALTER TABLE `TblPaymentTransactions_Payeezy` 
	ADD COLUMN `PaymentTransaction_Payeezy_ReferenceID` INT(11) NULL DEFAULT NULL AFTER `PaymentTransactionID`;