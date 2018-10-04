
ALTER TABLE TblOrdersBOM_Items
	ADD COLUMN `costGeneral` DECIMAL(7,2) NULL DEFAULT NULL COMMENT 'A general cost field that is editable only on some product types' AFTER `costBoardFootage`
;

ALTER TABLE TblProductType
	ADD COLUMN `canEditCostGeneral` TINYINT(4) NOT NULL DEFAULT 0 COMMENT '=1 if the item general cost field can be edited' AFTER `canEditListPrice`
;



CREATE OR REPLACE SQL SECURITY INVOKER VIEW `vOrderItemCosts` AS
SELECT orderItemsId,
		IF(costsAreFrozen = 1,
			OBOMI.costPurchase,
			TblProducts.Purchase_price
			) AS costPurchase,
		IF(costsAreFrozen = 1,
			OBOMI.costPurchaseIncludedProducts,
			TblProducts.PurchasePriceOfIncludedProducts
			) AS costPurchaseIncludedProducts,
		IF(costsAreFrozen = 1,
			IF(OBOMI.costPurchase IS NULL, OBOMI.costPurchaseIncludedProducts, OBOMI.costPurchase),
			IF(TblProducts.Purchase_price IS NULL, TblProducts.PurchasePriceOfIncludedProducts, TblProducts.Purchase_price)
			) AS costOfPurchase,
		IF(costsAreFrozen = 1,
			OBOMI.costOfLabor,
			TblProducts.LaborCost
			) AS costOfLabor,
		IF(costsAreFrozen = 1,
			OBOMI.costPreFinish,
			TblProducts.PreFinishCost
			) AS costPreFinish,
		IF(costsAreFrozen = 1,
			OBOMI.costFinishOptionMultiplier,
			TblFinishOption.FinishPriceMultiplier
			) AS costFinishOptionMultiplier,
		IF(costsAreFrozen = 1,
			IF(OBOMI.FinishOptionID IS NULL, 0, Coalesce(OBOMI.costPreFinish * OBOMI.costFinishOptionMultiplier, 0)),
			IF(OBOMI.FinishOptionID IS NULL, 0, Coalesce(TblProducts.PreFinishCost * TblFinishOption.FinishPriceMultiplier, 0))
			) AS costOfPreFinish,
		IF(costsAreFrozen = 1,
			OBOMI.costLumberRate,
			TblMaterialSizeLink.d_lumber_rate
			) AS costLumberRate,
		IF(costsAreFrozen = 1,
			OBOMI.costBoardFootage,
			Coalesce(TblProducts.boardFootage, 0)
			) AS costBoardFootage,
		IF(costsAreFrozen = 1,
			Coalesce(OBOMI.costLumberRate * OBOMI.costBoardFootage, 0),
			Coalesce(TblMaterialSizeLink.d_lumber_rate * Coalesce(TblProducts.boardFootage, 0), 0)
			) AS costOfBoardFootage,
	    OBOMI.OrderItemPricePerUnit * (1 - OBOMI.DiscountPercent) * Coalesce(TblEmployee.SalesCommission, 0) AS costOfSalesCommision,
	    Coalesce(costGeneral, 0) AS costGeneral,

		IF(costsAreFrozen = 1,
			IF(OBOMI.costPurchase IS NULL, OBOMI.costPurchaseIncludedProducts, OBOMI.costPurchase)
			+ OBOMI.costOfLabor
			+ Coalesce(OBOMI.costPreFinish * OBOMI.costFinishOptionMultiplier, 0)
			+ Coalesce(OBOMI.costLumberRate * OBOMI.costBoardFootage, 0)
			,
			IF(TblProducts.Purchase_price IS NULL, TblProducts.PurchasePriceOfIncludedProducts, TblProducts.Purchase_price)
			+ TblProducts.LaborCost
			+ Coalesce(TblProducts.PreFinishCost * TblFinishOption.FinishPriceMultiplier, 0)
			+ Coalesce(TblMaterialSizeLink.d_lumber_rate * Coalesce(TblProducts.boardFootage, 0), 0)
			)
		+ OBOMI.OrderItemPricePerUnit * (1 - OBOMI.DiscountPercent) * Coalesce(TblEmployee.SalesCommission, 0)
		+ Coalesce(costGeneral, 0)
		AS costPerUnit
FROM TblOrdersBOM_Items AS OBOMI
	INNER JOIN TblOrdersBOM       ON TblOrdersBOM.OrderID = OBOMI.OrderID
	LEFT JOIN TblEmployee         ON TblEmployee.EmployeeID = TblOrdersBOM.SalesmanEmployeeID
	INNER JOIN TblProducts        ON TblProducts.productID = OBOMI.productID
	LEFT JOIN TblFinishOption     ON TblFinishOption.id = OBOMI.FinishOptionID
	LEFT JOIN TblMaterial         ON TblMaterial.id = TblProducts.MaterialID
	LEFT JOIN TblMaterialSizeLink ON (TblMaterialSizeLink.d_material_id = TblProducts.MaterialID
											AND TblMaterialSizeLink.d_material_size_id = TblProducts.MaterialSizeID)
;