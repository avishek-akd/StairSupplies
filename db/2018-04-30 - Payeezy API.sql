CREATE TABLE `TblPaymentTransactions` (
  `PaymentTransactionID` int(11) NOT NULL AUTO_INCREMENT,
  `OrderID` int(11) NOT NULL,
  `ProcessedDate` datetime NOT NULL,
  `Transaction_Approved` bit(1) NOT NULL DEFAULT b'0',
  `Transaction_Error` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`PaymentTransactionID`)
) ENGINE=InnoDB;

CREATE TABLE `TblPaymentTransactions_Payeezy` (
  `PaymentTransaction_PayeezyID` int(11) NOT NULL AUTO_INCREMENT,
  `PaymentTransactionID` int(11) NOT NULL,
  `ExactID` varchar(50) DEFAULT NULL,
  `DollarAmount` varchar(50) DEFAULT NULL,
  `Transaction_Tag` varchar(50) DEFAULT NULL,
  `Authorization_Num` varchar(50) DEFAULT NULL,
  `CardHoldersName` varchar(100) DEFAULT NULL,
  `Exact_Response_Code` varchar(10) DEFAULT NULL,
  `Exact_Message` varchar(100) DEFAULT NULL,
  `Bank_Response_Code` varchar(10) DEFAULT NULL,
  `Bank_Message` varchar(50) DEFAULT NULL,
  `Sequence_No` varchar(50) DEFAULT NULL,
  `Retrieval_Ref_No` varchar(50) DEFAULT NULL,
  `CardType` varchar(50) DEFAULT NULL,
  `TransactionType` varchar(50) NOT NULL,
  `Expiry_Date` varchar(4) DEFAULT NULL,
  `TransarmorToken` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`PaymentTransaction_PayeezyID`)
) ENGINE=InnoDB;

ALTER TABLE `TblPaymentTransactions_Payeezy`
	ADD CONSTRAINT `FK_TblPaymentTransactions_Payeezy_PaymentTransactionID` FOREIGN KEY (`PaymentTransactionID`) REFERENCES `TblPaymentTransactions` (`PaymentTransactionID`) ON UPDATE NO ACTION ON DELETE NO ACTION;
	
ALTER TABLE `TblPaymentTransactions`
	ADD CONSTRAINT `FK_TblOrdersBOM_OrderID` FOREIGN KEY (`OrderID`) REFERENCES `TblOrdersBOM` (`OrderID`) ON UPDATE NO ACTION ON DELETE NO ACTION;