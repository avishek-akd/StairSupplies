ALTER TABLE TblProductTypeAccountingType
	ADD COLUMN `SortOrder` TINYINT NOT NULL DEFAULT 0
;

UPDATE `TblProductTypeAccountingType` SET `SortOrder`='1' WHERE  `id`=1;
UPDATE `TblProductTypeAccountingType` SET `SortOrder`='2' WHERE  `id`=2;
UPDATE `TblProductTypeAccountingType` SET `SortOrder`='4' WHERE  `id`=3;
UPDATE `TblProductTypeAccountingType` SET `SortOrder`='5' WHERE  `id`=4;
UPDATE `TblProductTypeAccountingType` SET `SortOrder`='6' WHERE  `id`=5;
UPDATE `TblProductTypeAccountingType` SET `SortOrder`='8' WHERE  `id`=6;


INSERT INTO TblProductTypeAccountingType
	(id, title, SortOrder)
VALUES
	(7, 'Wood Finish', 3),
	(8, 'Cable Rail - Finish', 6),
	(9, 'Sales Tax', 9),
	(10, 'Freightcharge', 10)
;




/*
      CASE
        WHEN (TblOrdersBOM_Transactions_Accounting.ProductTypeAccountingTypeID = -4) THEN
          'Cable Rail - Finish'
        WHEN (TblOrdersBOM_Transactions_Accounting.ProductTypeAccountingTypeID = -3) THEN
          'Wood Finish'
        WHEN (TblOrdersBOM_Transactions_Accounting.ProductTypeAccountingTypeID = -2) THEN
          'Freightcharge'
        WHEN (TblOrdersBOM_Transactions_Accounting.ProductTypeAccountingTypeID = -1) THEN
          'Sales Tax'
        ELSE
          TblProductTypeAccountingType.title
      END AS title
*/
UPDATE TblOrdersBOM_Transactions_Accounting SET ProductTypeAccountingTypeID = 8  WHERE ProductTypeAccountingTypeID = -4;
UPDATE TblOrdersBOM_Transactions_Accounting SET ProductTypeAccountingTypeID = 7  WHERE ProductTypeAccountingTypeID = -3;
UPDATE TblOrdersBOM_Transactions_Accounting SET ProductTypeAccountingTypeID = 10 WHERE ProductTypeAccountingTypeID = -2;
UPDATE TblOrdersBOM_Transactions_Accounting SET ProductTypeAccountingTypeID = 9  WHERE ProductTypeAccountingTypeID = -1;




ALTER TABLE `TblOrdersBOM_Transactions_Accounting`
	ALTER `ProductTypeAccountingTypeID` DROP DEFAULT;
ALTER TABLE `TblOrdersBOM_Transactions_Accounting`
	CHANGE COLUMN `ProductTypeAccountingTypeID` `ProductTypeAccountingTypeID` INT(11) UNSIGNED NOT NULL AFTER `OrderTransactionID`;
ALTER TABLE `TblOrdersBOM_Transactions_Accounting`
	ADD CONSTRAINT `FK_TblOrdersBOM_Transactions_Accounting_Type` FOREIGN KEY (`ProductTypeAccountingTypeID`) REFERENCES `TblProductTypeAccountingType` (`id`)
;
