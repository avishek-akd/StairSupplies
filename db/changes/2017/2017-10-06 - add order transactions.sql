CREATE TABLE `TblOrdersBOM_Transactions` (
  `OrderTransactionID` int(11) NOT NULL AUTO_INCREMENT,
  `OrderID` int(10) NOT NULL,
  `Amount` decimal(19,2) NOT NULL,
  `Sale` bit(1) NOT NULL,
  `Charge` bit(1) NOT NULL,
  `TransactionDate` datetime NOT NULL,
  `SalesEmployeeID` int(11) NOT NULL,
  `EntryDate` datetime NOT NULL,
  `QuickBooksExportedDate` datetime NULL,
  `QuickBooksEmployeeID` int(11) NULL,
  `Deleted` bit(1) NOT NULL,
  PRIMARY KEY (`OrderTransactionID`),
  KEY `FK_TblOrdersBOM_Transactions_OrderID_idx` (`OrderID`),
  CONSTRAINT `FK_TblOrdersBOM_Transactions_OrderID` FOREIGN KEY (`OrderID`) REFERENCES `TblOrdersBOM` (`OrderID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;


CREATE TABLE `TblOrdersBOM_Transactions_Accounting` (
  `OrderTransactionAccountingID` int(11) NOT NULL AUTO_INCREMENT,
  `OrderTransactionID` int(11) NOT NULL,
  `ProductTypeAccountingTypeID` int(11) NOT NULL,
  `Amount` decimal(19,2) NOT NULL,
  PRIMARY KEY (`OrderTransactionAccountingID`),
  KEY `FK_OrdersTransaction_TransactionAccounting_ID_idx` (`OrderTransactionID`),
  CONSTRAINT `FK_OrdersTransaction_TransactionAccounting_ID` FOREIGN KEY (`OrderTransactionID`) REFERENCES `TblOrdersBOM_Transactions` (`OrderTransactionID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `Settings` (
  `SettingID` INT NOT NULL AUTO_INCREMENT,
  `Setting` VARCHAR(50) NOT NULL,
  `Value` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`SettingID`));
