ALTER TABLE `Products`
	CHANGE COLUMN `PUnitPrice` `UnitPrice` DECIMAL(19,4) NOT NULL DEFAULT '0.0000' COMMENT 'Standard selling price, per unit' AFTER `ProductDescription`,
	ADD COLUMN `UnitPriceViewrail` DECIMAL(19,4) NULL DEFAULT '0.0000' COMMENT 'Price that is used only when adding products to Viewrail orders' AFTER `UnitPrice`;


UPDATE Products
SET UnitPriceViewRail = NULL;


UPDATE Products
SET
	UnitPriceViewrail = UnitPrice
WHERE productID in (SELECT productID FROM TblOrdersBOM_Items INNER JOIN TblOrdersBOM ON TblOrdersBOM.orderID = TblOrdersBOM_Items.orderID WHERE TblOrdersBOM.CompanyID = 4);


DELIMITER $$


CREATE FUNCTION `fGetProductUnitPrice`(`companyID` INT, `unitPrice` DECIMAL(19,4), `unitPriceViewrail` decimal(19,4))
	RETURNS DECIMAL(19,4)
	LANGUAGE SQL
	DETERMINISTIC
	CONTAINS SQL
	SQL SECURITY DEFINER
	COMMENT ''
BEGIN
	IF ( companyID = 4 ) THEN
		RETURN unitPriceViewrail;
	ELSE
		RETURN unitPrice;
	END IF;
END
$$



CREATE PROCEDURE `spPricePerCategory`(IN `orderID` INTEGER(11))
	LANGUAGE SQL
	NOT DETERMINISTIC
	CONTAINS SQL
	SQL SECURITY INVOKER
	COMMENT ''
BEGIN

SELECT TblProductTypeType.title, Coalesce(Sum( fItemPriceWithDiscount(TblOrdersBOM_Items.unitPrice, discountPercent, quantity) ), 0) as total
FROM TblProductType
	INNER JOIN TblProductTypeType ON TblProductTypeType.id = TblProductType.type_id
	LEFT JOIN Products            ON Products.ProductType_id = TblProductType.ProductType_id
	LEFT JOIN TblOrdersBOM_Items  ON (TblOrdersBOM_Items.ProductID = Products.ProductId
										AND TblOrdersBOM_Items.OrderId = orderID)
GROUP BY TblProductType.type_id
ORDER BY TblProductType.type_id ASC;

END
$$

DELIMITER ;