DELIMITER $$


DROP TRIGGER IF EXISTS `trgTblOrdersBOM_ItemsInclude_after_delete`
$$
CREATE TRIGGER `trgTblOrdersBOM_ItemsInclude_after_delete` AFTER DELETE ON `TblOrdersBOM_ItemsInclude` FOR EACH ROW BEGIN
	DECLARE newPurchasePrice DECIMAL(19,2) DEFAULT (SELECT Purchase_Price FROM TblProducts WHERE ProductID = OLD.BundledProductID);
	DECLARE remainingIncludedProducts INT  DEFAULT (SELECT Count(*) FROM TblOrdersBOM_ItemsInclude WHERE OrderItemsID = OLD.OrderItemsID);
	

	IF remainingIncludedProducts = 0 THEN
		UPDATE TblOrdersBOM_Items
		SET	costPurchaseIncludedProducts = NULL,
			costPurchase                 = IF(costPurchase IS NULL, 0, costPurchase)
		WHERE OrderItemsID = OLD.OrderItemsID;
	ELSE
		UPDATE TblOrdersBOM_Items
		SET	costPurchaseIncludedProducts = costPurchaseIncludedProducts
												- (newPurchasePrice * OLD.BundledQuantity)
		WHERE OrderItemsID = OLD.OrderItemsID;
	END IF;
END
$$


DELIMITER ;