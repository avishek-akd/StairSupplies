ALTER TABLE TblPurchaseOrderItem
	ADD COLUMN `AccountID` INT UNSIGNED NULL DEFAULT NULL AFTER `ProductID`,
	ADD CONSTRAINT `FK_TblPurchaseOrderItem_AccountID` FOREIGN KEY(`AccountID`) REFERENCES TblPurchaseAccount(PurchaseAccountID) ON UPDATE NO ACTION ON DELETE NO ACTION
;
UPDATE TblPurchaseOrderItem
SET AccountID = (SELECT PurchasingAccountID FROM Products WHERE TblPurchaseOrderItem.ProductID = Products.ProductID)
;