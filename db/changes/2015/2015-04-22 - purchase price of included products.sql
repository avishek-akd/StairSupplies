ALTER TABLE `Products`
	COMMENT='Purchase_price can have the following values:\r\n- NULL - this means we ignore it and use PurchasePriceOfIncludedProducts as the purchase price.\r\n	Note: if the Product doesn\'t include other products then the Purchase_price cannot be NULL.\r\n- any other value including zero - we use it as the purchase price.',
	CHANGE COLUMN `Purchase_Price` `Purchase_Price` DECIMAL(19,4) NULL DEFAULT '0.0000' AFTER `UnitPriceNAC`,
	ADD COLUMN `PurchasePriceOfIncludedProducts` DECIMAL(19,4) NULL COMMENT 'Calculated value of the included products prices' AFTER `Purchase_Price`;




DELIMITER $$



DROP TRIGGER IF EXISTS ProductsInclude_after_ins_tr1
$$
CREATE TRIGGER `ProductsInclude_after_ins_tr1` AFTER INSERT ON `ProductsInclude`
  FOR EACH ROW
BEGIN
	DECLARE newPurchasePrice INT DEFAULT (SELECT Purchase_Price FROM Products WHERE ProductID = NEW.IncludedProductID);

	
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
	DECLARE newPurchasePrice INT DEFAULT (SELECT Purchase_Price FROM Products WHERE ProductID = NEW.IncludedProductID);

	
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
	DECLARE newPurchasePrice INT DEFAULT (SELECT Purchase_Price FROM Products WHERE ProductID = OLD.IncludedProductID);
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