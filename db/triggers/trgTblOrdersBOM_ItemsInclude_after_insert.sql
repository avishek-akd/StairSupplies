DELIMITER $$


DROP TRIGGER IF EXISTS `trgTblOrdersBOM_ItemsInclude_after_insert`
$$
CREATE TRIGGER `trgTblOrdersBOM_ItemsInclude_after_insert` AFTER INSERT ON `TblOrdersBOM_ItemsInclude` FOR EACH ROW BEGIN
	DECLARE newPurchasePrice DECIMAL(19,2) DEFAULT (SELECT Purchase_Price FROM TblProducts WHERE ProductID = NEW.BundledProductID);

	
	UPDATE TblOrdersBOM_Items
	SET	costPurchaseIncludedProducts = Coalesce(costPurchaseIncludedProducts, 0)
	                                        + (newPurchasePrice * NEW.BundledQuantity)
	WHERE OrderItemsID = NEW.OrderItemsID;
END
$$


DELIMITER ;