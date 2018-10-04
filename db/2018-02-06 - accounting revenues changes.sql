DELIMITER $$



DROP PROCEDURE IF EXISTS `spPricePerAccountingType`
$$
CREATE PROCEDURE `spPricePerAccountingType`(
	IN `orderID` INTEGER(11)
	)
	DETERMINISTIC
	READS SQL DATA
	SQL SECURITY INVOKER
	COMMENT 'For a given order return the sum of prices in each accounting type (LED, Stock, etc)'
BEGIN
	DECLARE woodFinishPrice DECIMAL(19,2);
	DECLARE cableRailFinish DECIMAL(19,2);


	--  Calculate Wood Finish and Cable Rail Finish separately because it makes the final query easier to understand
	SELECT Coalesce(Sum( (TblProducts.FinishPrice * FinishPriceMultiplier) * (1 - OBOMI.DiscountPercent) * OBOMI.quantityOrdered ), 0) INTO woodFinishPrice
	FROM TblOrdersBOM_Items AS OBOMI
		INNER JOIN TblProducts    ON OBOMI.ProductID = TblProducts.productID
		INNER JOIN TblProductType ON TblProductType.ProductType_id = TblProducts.ProductType_id
		LEFT JOIN TblFinishOption ON TblFinishOption.id = OBOMI.FinishOptionID
	WHERE OBOMI.OrderId = orderID
		--  only 'Wood Production' production type items
		AND ProductionTypeID = 2;


	SELECT Coalesce(Sum( (TblProducts.FinishPrice * FinishPriceMultiplier) * (1 - OBOMI.DiscountPercent) * OBOMI.quantityOrdered ), 0) INTO cableRailFinish
	FROM TblOrdersBOM_Items AS OBOMI
		INNER JOIN TblProducts    ON OBOMI.ProductID = TblProducts.productID
		INNER JOIN TblProductType ON TblProductType.ProductType_id = TblProducts.ProductType_id
		LEFT JOIN TblFinishOption ON TblFinishOption.id = OBOMI.FinishOptionID
	WHERE OBOMI.OrderId = orderID
		--  only 'Cable Production' production type items
		AND ProductionTypeID = 3;


	--  Production includes "Wood Finish" so we need to cut it out
	--  The same for "Cable Rail - Production" (it includes cableRailFinish)
	SELECT TblProductTypeAccountingType.id, title,
		CASE
			WHEN id = 2  THEN Coalesce(perAccountingTypeSubtotal - woodFinishPrice, 0)
			WHEN id = 5  THEN Coalesce(perAccountingTypeSubtotal - cableRailFinish, 0)
			WHEN id = 7  THEN Coalesce(woodFinishPrice, 0)
			WHEN id = 8  THEN Coalesce(cableRailFinish, 0)
			WHEN id = 9  THEN Coalesce((perAccountingTypeSubtotal + (SELECT FreightCharge FROM TblOrdersBOM WHERE TblOrdersBOM.OrderID = orderID)) * (SELECT SalesTaxRate FROM TblOrdersBOM WHERE TblOrdersBOM.OrderID = orderID), 0)
			WHEN id = 10 THEN Coalesce(perAccountingTypeSubtotal + (SELECT FreightCharge FROM TblOrdersBOM WHERE TblOrdersBOM.OrderID = orderID), 0)
			ELSE Coalesce(perAccountingTypeSubtotal, 0)
		END AS total
	FROM TblProductTypeAccountingType
		LEFT JOIN (
						SELECT AccountingTypeID,
							Sum( vOrderItemPrice.unitPriceDiscounted * OBOMI.quantityOrdered ) AS perAccountingTypeSubtotal
						FROM TblOrdersBOM_Items AS OBOMI
							INNER JOIN TblProducts     ON OBOMI.ProductID = TblProducts.productID
							INNER JOIN TblProductType  ON TblProductType.ProductType_id = TblProducts.ProductType_id
							INNER JOIN vOrderItemPrice ON vOrderItemPrice.OrderItemsID = OBOMI.OrderItemsID
						WHERE OBOMI.OrderId = orderID
						GROUP BY TblProductType.AccountingTypeID

					UNION
						--  We need a separate sum for "Sales tax" because it applies to all products
						SELECT 9 AS AccountingTypeID,
							Sum( vOrderItemPrice.unitPriceDiscounted * OBOMI.quantityOrdered ) AS perAccountingTypeSubtotal
						FROM TblOrdersBOM_Items AS OBOMI
							INNER JOIN vOrderItemPrice ON vOrderItemPrice.OrderItemsID = OBOMI.OrderItemsID
						WHERE OBOMI.OrderId = orderID

					) AS ExistingItemsTypes ON ExistingItemsTypes.AccountingTypeID = TblProductTypeAccountingType.id
	ORDER BY SortOrder ASC;

END
$$


DELIMITER ;