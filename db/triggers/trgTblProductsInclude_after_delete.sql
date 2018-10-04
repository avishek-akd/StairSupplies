DELIMITER $$


DROP TRIGGER IF EXISTS `trgTblProductsInclude_after_delete`
$$
CREATE TRIGGER `trgTblProductsInclude_after_delete` AFTER DELETE ON `TblProductsInclude` FOR EACH ROW BEGIN
	DECLARE newPurchasePrice DECIMAL(19,2) DEFAULT (SELECT Purchase_Price FROM TblProducts WHERE ProductID = OLD.IncludedProductID);
	DECLARE remainingIncludedProducts INT DEFAULT (SELECT Count(*) FROM TblProductsInclude WHERE ParentProductID = OLD.ParentProductID);
	

	IF remainingIncludedProducts = 0 THEN
		UPDATE TblProducts
		SET	PurchasePriceOfIncludedProducts = NULL,
			Purchase_Price = IF(Purchase_Price IS NULL, 0, Purchase_Price)
		WHERE ProductID = OLD.ParentProductID;
	ELSE
		UPDATE TblProducts
		SET	PurchasePriceOfIncludedProducts = PurchasePriceOfIncludedProducts
												- (newPurchasePrice * OLD.Quantity)
		WHERE ProductID = OLD.ParentProductID;
	END IF;
END
$$


DELIMITER ;