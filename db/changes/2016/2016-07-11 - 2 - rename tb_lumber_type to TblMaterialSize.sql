RENAME TABLE `tbl_lumber_type` TO `TblMaterialSize`;
ALTER TABLE `TblMaterialSize`
	COMMENT='';



RENAME TABLE `TblMaterialLumberType` TO `TblMaterialSizeLink`;
ALTER TABLE `TblMaterialSizeLink`
	ALTER `d_lumber_type_id` DROP DEFAULT,
	CHANGE COLUMN `d_lumber_type_id` `d_material_size_id` INT(10) UNSIGNED NOT NULL AFTER `d_material_id`,
	COMMENT='n:m relationship table between materials and sizes';



ALTER TABLE `Products`
	CHANGE COLUMN `LumberTypeID` `MaterialSizeID` INT(10) UNSIGNED NULL DEFAULT NULL AFTER `MaterialID`;
ALTER TABLE `Products`
	DROP INDEX `LumberTypeID`,
	ADD INDEX `idxMaterialSizeID` (`MaterialSizeID`);




DELIMITER $$



DROP VIEW IF EXISTS vOrderItemCosts
$$
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
			TblFinishOption.FinishPriceMultiplier
			) AS costFinishOptionMultiplier,
		IF(costsAreFrozen = 1,
			IF(OBOMI.FinishOptionID IS NULL, 0, Coalesce(OBOMI.costPreFinish * OBOMI.costFinishOptionMultiplier, 0)),
			IF(OBOMI.FinishOptionID IS NULL, 0, Coalesce(Products.PreFinishCost * TblFinishOption.FinishPriceMultiplier, 0))
			) AS costOfPreFinish,
		IF(costsAreFrozen = 1,
			OBOMI.costLumberRate,
			TblMaterialSizeLink.d_lumber_rate
			) AS costLumberRate,
		IF(costsAreFrozen = 1,
			OBOMI.costBoardFootage,
			Products.boardFootage
			) AS costBoardFootage,
		IF(costsAreFrozen = 1,
			Coalesce(OBOMI.costLumberRate * OBOMI.costBoardFootage, 0),
			Coalesce(TblMaterialSizeLink.d_lumber_rate * Products.boardFootage, 0)
			) AS costOfBoardFootage,
		IF(costsAreFrozen = 1,
			IF(OBOMI.costPurchase IS NULL, OBOMI.costPurchaseIncludedProducts, OBOMI.costPurchase)
			+ OBOMI.costOfLabor
			+ Coalesce(OBOMI.costPreFinish * OBOMI.costFinishOptionMultiplier, 0)
			+ Coalesce(OBOMI.costLumberRate * OBOMI.costBoardFootage, 0)
			,
			IF(Products.Purchase_price IS NULL, Products.PurchasePriceOfIncludedProducts, Products.Purchase_price)
			+ Products.LaborCost
			+ Coalesce(Products.PreFinishCost * TblFinishOption.FinishPriceMultiplier, 0)
			+ Coalesce(TblMaterialSizeLink.d_lumber_rate * Products.boardFootage, 0)
			) AS costPerUnit
FROM TblOrdersBOM_Items AS OBOMI
	INNER JOIN Products           ON Products.productID = OBOMI.productID
	LEFT JOIN TblFinishOption     ON TblFinishOption.id = OBOMI.FinishOptionID
	LEFT JOIN TblMaterial         ON TblMaterial.id = Products.MaterialID
	LEFT JOIN TblMaterialSizeLink ON (TblMaterialSizeLink.d_material_id = Products.MaterialID
											AND TblMaterialSizeLink.d_material_size_id = Products.MaterialSizeID)
$$



DELIMITER ;

