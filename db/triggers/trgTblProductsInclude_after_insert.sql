DELIMITER $$


DROP TRIGGER IF EXISTS `trgTblProductsInclude_after_insert`
$$
CREATE TRIGGER `trgTblProductsInclude_after_insert` AFTER INSERT ON `TblProductsInclude` FOR EACH ROW BEGIN
	DECLARE newPurchasePrice DECIMAL(19,2) DEFAULT (SELECT Purchase_Price FROM TblProducts WHERE ProductID = NEW.IncludedProductID);

	
	UPDATE TblProducts
	SET	PurchasePriceOfIncludedProducts = Coalesce(PurchasePriceOfIncludedProducts, 0)
	                                        + (newPurchasePrice * NEW.Quantity)
	WHERE ProductID = NEW.ParentProductID;

END
$$


DELIMITER ;