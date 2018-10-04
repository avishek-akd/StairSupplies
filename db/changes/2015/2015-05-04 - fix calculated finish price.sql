DELIMITER $$


DROP TRIGGER IF EXISTS ProductsInclude_after_ins_tr1
$$
CREATE TRIGGER `ProductsInclude_after_ins_tr1` AFTER INSERT ON `ProductsInclude`
  FOR EACH ROW
BEGIN
	DECLARE newPurchasePrice DECIMAL(19,4) DEFAULT (SELECT Purchase_Price FROM Products WHERE ProductID = NEW.IncludedProductID);

	
	UPDATE Products
	SET	PurchasePriceOfIncludedProducts = Coalesce(PurchasePriceOfIncludedProducts, 0)
	                                        + (newPurchasePrice * NEW.Quantity)
	WHERE ProductID = NEW.ParentProductID;

END
$$


DROP TRIGGER IF EXISTS ProductsInclude_after_upd_tr1
$$
CREATE TRIGGER `ProductsInclude_after_upd_tr1` AFTER UPDATE ON `ProductsInclude`
  FOR EACH ROW
BEGIN
	DECLARE newPurchasePrice DECIMAL(19,4) DEFAULT (SELECT Purchase_Price FROM Products WHERE ProductID = NEW.IncludedProductID);

	
	UPDATE Products
	SET	PurchasePriceOfIncludedProducts = PurchasePriceOfIncludedProducts
											- (newPurchasePrice * OLD.Quantity)
	                                        + (newPurchasePrice * NEW.Quantity)
	WHERE ProductID = NEW.ParentProductID;

END
$$


DROP TRIGGER IF EXISTS ProductsInclude_after_del_tr1
$$
CREATE TRIGGER `ProductsInclude_after_del_tr1` AFTER DELETE ON `ProductsInclude`
  FOR EACH ROW
BEGIN
	DECLARE newPurchasePrice DECIMAL(19,4) DEFAULT (SELECT Purchase_Price FROM Products WHERE ProductID = OLD.IncludedProductID);
	DECLARE remainingIncludedProducts INT DEFAULT (SELECT Count(*) FROM ProductsInclude WHERE ParentProductID = OLD.ParentProductID);
	

	IF remainingIncludedProducts = 0 THEN
		UPDATE Products
		SET	PurchasePriceOfIncludedProducts = NULL,
			Purchase_Price = IF(Purchase_Price IS NULL, 0, Purchase_Price)
		WHERE ProductID = OLD.ParentProductID;
	ELSE
		UPDATE Products
		SET	PurchasePriceOfIncludedProducts = PurchasePriceOfIncludedProducts
												- (newPurchasePrice * OLD.Quantity)
		WHERE ProductID = OLD.ParentProductID;
	END IF;
END
$$


DELIMITER ;