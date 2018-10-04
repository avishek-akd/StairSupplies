DELIMITER $$


DROP TRIGGER IF EXISTS `trgTblOrdersBOM_ItemsInclude_after_update`
$$
CREATE TRIGGER `TblOrdersBOM_ItemsInclude_after_upd_tr1` AFTER UPDATE ON `TblOrdersBOM_ItemsInclude` FOR EACH ROW BEGIN
	DECLARE newPurchasePrice DECIMAL(19,2) DEFAULT (SELECT Purchase_Price FROM TblProducts WHERE ProductID = NEW.BundledProductID);

	
	UPDATE TblOrdersBOM_Items
	SET	costPurchaseIncludedProducts = costPurchaseIncludedProducts
											- (newPurchasePrice * OLD.BundledQuantity)
	                                        + (newPurchasePrice * NEW.BundledQuantity)
	WHERE OrderItemsID = NEW.OrderItemsID;
END
$$


DELIMITER ;