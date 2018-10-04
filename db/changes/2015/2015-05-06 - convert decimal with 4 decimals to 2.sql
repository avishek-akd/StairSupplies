--  Convert fields to 2 decimals where they're not needed
ALTER TABLE `Customers`
	CHANGE COLUMN `Annual_Sales_Forecast` `Annual_Sales_Forecast` INT NULL DEFAULT '0' AFTER `_unused_CustomerType`;
--  Fix comment ("< 0" should be "< 1")
ALTER TABLE `Customers`
	CHANGE COLUMN `SalesPersonCommission` `SalesPersonCommission` DECIMAL(10,4) NULL DEFAULT '0.0000' COMMENT 'Commision paid to the sales person when a customer pays a bill. For example 0.055 for 5.5%. This should always be < 1.' AFTER `_unused_defaultShippingMethodID`;

	

update Products set unitPrice = round(unitPrice, 2) where unitPrice <> truncate(unitPrice, 2);
update Products set UnitPriceViewrail = round(UnitPriceViewrail, 2) where UnitPriceViewrail <> truncate(UnitPriceViewrail, 2);
update Products set UnitPriceNAC = round(UnitPriceNAC, 2) where UnitPriceNAC <> truncate(UnitPriceNAC, 2);
update Products set Purchase_Price = round(Purchase_Price, 2) where Purchase_Price <> truncate(Purchase_Price, 2);
update Products set PurchasePriceOfIncludedProducts = round(PurchasePriceOfIncludedProducts, 2) where PurchasePriceOfIncludedProducts <> truncate(PurchasePriceOfIncludedProducts, 2);
ALTER TABLE `Products`
	CHANGE COLUMN `UnitPrice` `UnitPrice` DECIMAL(19,2) NOT NULL DEFAULT '0.00' COMMENT 'Standard selling price, per unit' AFTER `ProductDescription`,
	CHANGE COLUMN `UnitPriceViewrail` `UnitPriceViewrail` DECIMAL(19,2) NULL DEFAULT '0.00' COMMENT 'Price that is used only when adding products to Viewrail orders' AFTER `UnitPrice`,
	CHANGE COLUMN `UnitPriceNAC` `UnitPriceNAC` DECIMAL(19,2) NULL DEFAULT '0.00' COMMENT 'Price that is used for North Atlantic Corp customers' AFTER `VR_Part`,
	CHANGE COLUMN `Purchase_Price` `Purchase_Price` DECIMAL(19,2) NULL DEFAULT '0.00' AFTER `UnitPriceNAC`,
	CHANGE COLUMN `PurchasePriceOfIncludedProducts` `PurchasePriceOfIncludedProducts` DECIMAL(19,2) NULL DEFAULT NULL COMMENT 'Calculated value of the included products prices' AFTER `Purchase_Price`;



ALTER TABLE `TblOrdersBOM`
	CHANGE COLUMN `OrderTotal` `OrderTotal` DECIMAL(19,2) NOT NULL DEFAULT '0.0000' AFTER `Canonical_Job_Name`;




DELIMITER $$


DROP TRIGGER IF EXISTS ProductsInclude_after_ins_tr1
$$
CREATE TRIGGER `ProductsInclude_after_ins_tr1` AFTER INSERT ON `ProductsInclude`
  FOR EACH ROW
BEGIN
	DECLARE newPurchasePrice DECIMAL(19,2) DEFAULT (SELECT Purchase_Price FROM Products WHERE ProductID = NEW.IncludedProductID);

	
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
	DECLARE newPurchasePrice DECIMAL(19,2) DEFAULT (SELECT Purchase_Price FROM Products WHERE ProductID = NEW.IncludedProductID);

	
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
	DECLARE newPurchasePrice DECIMAL(19,2) DEFAULT (SELECT Purchase_Price FROM Products WHERE ProductID = OLD.IncludedProductID);
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


DROP FUNCTION IF EXISTS fGetProductUnitPrice
$$
CREATE FUNCTION `fGetProductUnitPrice`(
        `companyID` INTEGER,
        `CustomerTypeID` INTEGER,
        `unitPrice` DECIMAL(19,2),
        `unitPriceViewrail` DECIMAL(19,2),
        `unitPriceNAC` DECIMAL(19,2)
    )
    RETURNS decimal(19,2)
    DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY DEFINER
    COMMENT ''
BEGIN
	IF ( CustomerTypeID = 14 ) THEN
		RETURN unitPriceNAC;
	ELSE
		BEGIN
			IF ( companyID = 4 ) THEN
				RETURN unitPriceViewrail;
			ELSE
				RETURN unitPrice;
			END IF;
		END;
	END IF;
END
$$


DROP FUNCTION IF EXISTS fItemPriceWithDiscount
$$
CREATE FUNCTION `fItemPriceWithDiscount`(
        `unitPrice` DECIMAL(19,4),
        `discountPercent` DECIMAL(10,4),
        quantity DECIMAL(10,2)
    )
    RETURNS decimal(19,4)
    DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY DEFINER
    COMMENT ''
RETURN Round(unitPrice * (1 - discountPercent), 2) * quantity
$$


DROP FUNCTION IF EXISTS fUnitCost
$$
CREATE FUNCTION `fUnitCost`(
        Purchase_price DECIMAL(19,2),
        LaborCost DECIMAL(10,2),
        PreFinishCost DECIMAL(10,2),
        lumber_rate DECIMAL(10,2),
        boardFootage DECIMAL(7,2)
    )
    RETURNS decimal(19,2)
    DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY DEFINER
    COMMENT ''
BEGIN
	RETURN Purchase_price + LaborCost + PreFinishCost + Coalesce(lumber_rate * boardFootage, 0);
END
$$


DELIMITER ;
	
	
	
	
/*	
select unitPrice, round(unitPrice, 2), Products.* from Products where unitPrice <> truncate(unitPrice, 2);
select UnitPriceViewrail, round(UnitPriceViewrail, 2), Products.* from Products where UnitPriceViewrail <> truncate(UnitPriceViewrail, 2);
select UnitPriceNAC, round(UnitPriceNAC, 2), Products.* from Products where UnitPriceNAC <> truncate(UnitPriceNAC, 2);
select Purchase_Price, round(Purchase_Price, 2), Products.* from Products where Purchase_Price <> truncate(Purchase_Price, 2);
select PurchasePriceOfIncludedProducts, round(PurchasePriceOfIncludedProducts, 2), Products.* from Products where PurchasePriceOfIncludedProducts <> truncate(PurchasePriceOfIncludedProducts, 2);
*/
