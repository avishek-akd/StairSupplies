DELIMITER $$


DROP TRIGGER IF EXISTS `trgTblProductsInclude_after_update`
$$
CREATE TRIGGER `trgTblProductsInclude_after_update` AFTER UPDATE ON `TblProductsInclude` FOR EACH ROW BEGIN
	DECLARE newPurchasePrice DECIMAL(19,2) DEFAULT (SELECT Purchase_Price FROM TblProducts WHERE ProductID = NEW.IncludedProductID);

	
	UPDATE TblProducts
	SET	PurchasePriceOfIncludedProducts = PurchasePriceOfIncludedProducts
											- (newPurchasePrice * OLD.Quantity)
	                                        + (newPurchasePrice * NEW.Quantity)
	WHERE ProductID = NEW.ParentProductID;

END
$$


DELIMITER ;