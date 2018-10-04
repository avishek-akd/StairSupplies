--  Rounding needs to happen at display time, not when we get the items from the database

DROP VIEW IF EXISTS vOrderItemPrice
;
CREATE SQL SECURITY INVOKER VIEW `vOrderItemPrice` AS 
  select 
    `TblOrdersBOM_Items`.`OrderItemsID` AS `orderItemsId`,
    (`TblOrdersBOM_Items`.`UnitPrice` * (1 - `TblOrdersBOM_Items`.`DiscountPercent`)) AS `unitPriceDiscounted`,
    (`TblOrdersBOM_Items`.`UnitPrice` * `TblOrdersBOM_Items`.`DiscountPercent`) AS `unitDiscountAmount` 
  from 
    `TblOrdersBOM_Items`
;



DROP VIEW IF EXISTS vOrderItemCosts
;
CREATE SQL SECURITY INVOKER VIEW vOrderItemCosts AS
SELECT orderItemsId,
		IF(costsAreFrozen = 1,
			OBOMI.costPurchase,
			Products.Purchase_price
			) AS costPurchase,
		IF(costsAreFrozen = 1,
			OBOMI.costPurchaseIncludedProducts,
			Products.PurchasePriceOfIncludedProducts
			) AS costPurchaseIncludedProducts,
		IF(costsAreFrozen = 1,
			IF(OBOMI.costPurchase IS NULL, OBOMI.costPurchaseIncludedProducts, OBOMI.costPurchase),
			IF(Products.Purchase_price IS NULL, Products.PurchasePriceOfIncludedProducts, Products.Purchase_price)
			) AS costOfPurchase,
		IF(costsAreFrozen = 1,
			OBOMI.costOfLabor,
			Products.LaborCost
			) AS costOfLabor,
		IF(costsAreFrozen = 1,
			OBOMI.costPreFinish,
			Products.PreFinishCost
			) AS costPreFinish,
		IF(costsAreFrozen = 1,
			OBOMI.costFinishOptionMultiplier,
			FinishOption.FinishPriceMultiplier
			) AS costFinishOptionMultiplier,
		IF(costsAreFrozen = 1,
			IF(OBOMI.FinishOptionID IS NULL, 0, Coalesce(OBOMI.costPreFinish * OBOMI.costFinishOptionMultiplier, 0)),
			IF(OBOMI.FinishOptionID IS NULL, 0, Coalesce(Products.PreFinishCost * FinishOption.FinishPriceMultiplier, 0))
			) AS costOfPreFinish,
		IF(costsAreFrozen = 1,
			OBOMI.costLumberRate,
			tbl_wood_type_lumber_type.d_lumber_rate
			) AS costLumberRate,
		IF(costsAreFrozen = 1,
			OBOMI.costBoardFootage,
			Products.boardFootage
			) AS costBoardFootage,
		IF(costsAreFrozen = 1,
			Coalesce(OBOMI.costLumberRate * OBOMI.costBoardFootage, 0),
			Coalesce(tbl_wood_type_lumber_type.d_lumber_rate * Products.boardFootage, 0)
			) AS costOfBoardFootage,
		IF(costsAreFrozen = 1,
			IF(OBOMI.costPurchase IS NULL, OBOMI.costPurchaseIncludedProducts, OBOMI.costPurchase)
			+ OBOMI.costOfLabor
			+ Coalesce(OBOMI.costPreFinish * OBOMI.costFinishOptionMultiplier, 0)
			+ Coalesce(OBOMI.costLumberRate * OBOMI.costBoardFootage, 0)
			,
			IF(Products.Purchase_price IS NULL, Products.PurchasePriceOfIncludedProducts, Products.Purchase_price)
			+ Products.LaborCost
			+ Coalesce(Products.PreFinishCost * FinishOption.FinishPriceMultiplier, 0)
			+ Coalesce(tbl_wood_type_lumber_type.d_lumber_rate * Products.boardFootage, 0)
			) AS costPerUnit
FROM TblOrdersBOM_Items AS OBOMI
	INNER JOIN Products                 ON Products.productID = OBOMI.productID
	LEFT JOIN FinishOption              ON FinishOption.id = OBOMI.FinishOptionID
	LEFT JOIN tbl_wood_type             ON tbl_wood_type.id = Products.WoodTypeID
	LEFT JOIN tbl_wood_type_lumber_type ON (tbl_wood_type_lumber_type.d_wood_type_id = Products.WoodTypeID
											AND tbl_wood_type_lumber_type.d_lumber_type_id = Products.LumberTypeID)
;