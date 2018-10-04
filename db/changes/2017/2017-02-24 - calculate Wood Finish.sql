DELIMITER $$


DROP PROCEDURE IF EXISTS spPricePerAccountingType
$$
CREATE PROCEDURE `spPricePerAccountingType`(IN `orderID` INTEGER(11)
    )
	LANGUAGE SQL
	DETERMINISTIC
	CONTAINS SQL
	SQL SECURITY INVOKER
	COMMENT 'For a given order return the sum of prices in each accounting type (LED, Stock, etc)'
BEGIN
	DECLARE woodFinishPrice DECIMAL(19,2);
	DECLARE cableRailFinish DECIMAL(19,2);


	--  We need to calculate Wood Finish without actually adding it as an Accounting type
	--  (each Product Type can have only one associated accounting type) so we calculate it separately and use a fakeID of 2.5
	--  to insert it after Production Accounting type.
	SELECT Coalesce(Sum( (Products.FinishPrice * FinishPriceMultiplier) * (1 - OBOMI.DiscountPercent) * OBOMI.quantityOrdered ), 0) INTO woodFinishPrice
	FROM TblOrdersBOM_Items AS OBOMI
		INNER JOIN Products       ON OBOMI.ProductID = Products.productID
		INNER JOIN TblProductType ON TblProductType.ProductType_id = Products.ProductType_id
		LEFT JOIN TblFinishOption ON TblFinishOption.id = OBOMI.FinishOptionID
	WHERE OBOMI.OrderId = orderID
		--  only 'Wood Production' production type items
		AND ProductionTypeID = 2;


	SELECT Coalesce(Sum( (Products.FinishPrice * FinishPriceMultiplier) * (1 - OBOMI.DiscountPercent) * OBOMI.quantityOrdered ), 0) INTO cableRailFinish
	FROM TblOrdersBOM_Items AS OBOMI
		INNER JOIN Products       ON OBOMI.ProductID = Products.productID
		INNER JOIN TblProductType ON TblProductType.ProductType_id = Products.ProductType_id
		LEFT JOIN TblFinishOption ON TblFinishOption.id = OBOMI.FinishOptionID
	WHERE OBOMI.OrderId = orderID
		--  only 'Cable Production' production type items
		AND ProductionTypeID = 3;


	(
		--  Production includes "Wood Finish" so we need to cut it out
		--  The same for "Cable Rail - Production" (it includes cableRailFinish)
		SELECT TblProductTypeAccountingType.id as fakeID, title, Coalesce(total - IF(id = 2, woodFinishPrice, 0) - IF(id = 5, cableRailFinish, 0), 0) AS total
		FROM TblProductTypeAccountingType
			LEFT JOIN (
						SELECT AccountingTypeID, Sum( vOrderItemPrice.unitPriceDiscounted * OBOMI.quantityOrdered ) AS total
						FROM TblOrdersBOM_Items AS OBOMI
							INNER JOIN Products        ON OBOMI.ProductID = Products.productID
							INNER JOIN TblProductType  ON TblProductType.ProductType_id = Products.ProductType_id
							INNER JOIN vOrderItemPrice ON vOrderItemPrice.OrderItemsID = OBOMI.OrderItemsID
						WHERE OBOMI.OrderId = orderID
						GROUP BY TblProductType.AccountingTypeID
						) AS ExistingItemsTypes ON ExistingItemsTypes.AccountingTypeID = TblProductTypeAccountingType.id
	)
	UNION
	(
		SELECT 2.5 AS fakeID, 'Wood Finish' as title, woodFinishPrice
	)
	UNION
	(
		SELECT 5.5 AS fakeID, 'Cable Rail - Finish' as title, cableRailFinish
	)
	ORDER BY fakeID ASC;

END
$$


DELIMITER ;