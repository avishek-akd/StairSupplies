DELIMITER $$



RENAME TABLE `FinishOption` TO `TblFinishOption`
$$


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
			+ Coalesce(Products.PreFinishCost * TblFinishOption.FinishPriceMultiplier, 0)
			+ Coalesce(tbl_wood_type_lumber_type.d_lumber_rate * Products.boardFootage, 0)
			) AS costPerUnit
FROM TblOrdersBOM_Items AS OBOMI
	INNER JOIN Products                 ON Products.productID = OBOMI.productID
	LEFT JOIN TblFinishOption           ON TblFinishOption.id = OBOMI.FinishOptionID
	LEFT JOIN tbl_wood_type             ON tbl_wood_type.id = Products.WoodTypeID
	LEFT JOIN tbl_wood_type_lumber_type ON (tbl_wood_type_lumber_type.d_wood_type_id = Products.WoodTypeID
											AND tbl_wood_type_lumber_type.d_lumber_type_id = Products.LumberTypeID)
$$



DROP VIEW IF EXISTS vOrderItems
$$
CREATE ALGORITHM=UNDEFINED SQL SECURITY INVOKER VIEW `vOrderItems` AS 
select `TblOrdersBOM_Items`.`OrderItemsID` AS `orderItemsID`,
       `TblOrdersBOM_Items`.`OrderID` AS `orderID`,
       `TblOrdersBOM_Items`.`GroupID` AS `GroupID`,
       `TblOrdersBOM_Items`.`UnitPrice` AS `unitPrice`,
       `TblOrdersBOM_Items`.`ProductName` AS `ProductName`,
       `TblOrdersBOM_Items`.`ProductDescription` AS `ProductDescription`,
       `TblOrdersBOM_Items`.`In_House_Notes` AS `in_house_notes`,
       `TblOrdersBOM_Items`.`QuantityOrdered` AS `QuantityOrdered`,
       `TblOrdersBOM_Items`.`UnitWeight` AS `unitWeight`,
       `TblOrdersBOM_Items`.`QuantityShipped` AS `quantityShipped`,
       `TblOrdersBOM_Items`.`Customer_Notes` AS `Customer_Notes`,
       `TblOrdersBOM_Items`.`DiscountPercent` AS `discountPercent`,
       `TblOrdersBOM_Items`.`Shipped` AS `shipped`,
       `TblOrdersBOM_Items`.`GroupSortField` AS `GroupSortField`,
       `TblOrdersBOM_Items`.`Special_Instructions` AS `Special_Instructions`,
       vOrderItemPrice.unitPriceDiscounted AS `discountedUnitPrice`,
       vOrderItemPrice.unitPriceDiscounted * QuantityOrdered AS itemPrice,
       `TblOrdersBOM_Items`.`FinishOptionID` AS `FinishOptionID`,
       `Products`.`WoodTypeID` AS `WoodTypeID`,
       `tbl_wood_type`.`d_name` AS `woodTypeName`,
       `tbl_wood_type`.`d_finish_image_unfinished` AS
        `d_finish_image_unfinished`,
       `tbl_wood_type`.`d_finish_image_standard` AS `d_finish_image_standard`,
       `TblFinishOption`.`FinishImage` AS `FinishImage`,
       `TblFinishOption`.`title` AS `finishOptionTitle`,
       `Products`.`Unit_of_Measure` AS `Unit_of_Measure`,
       `Products`.`ProductType_id` AS `ProductType_Id`,
       `Products`.`ProductID` AS `ProductID`
from `TblOrdersBOM_Items`
	INNER JOIN vOrderItemPrice ON vOrderItemPrice.OrderItemsID = TblOrdersBOM_Items.OrderItemsID
     left join `Products`      on `Products`.`ProductID` = `TblOrdersBOM_Items`.`ProductID`
     left join `tbl_wood_type` on `tbl_wood_type`.`id` = `Products`.`WoodTypeID`
     left join `TblFinishOption`  on `TblFinishOption`.`id` = `TblOrdersBOM_Items`.`FinishOptionID`
order by `TblOrdersBOM_Items`.`OrderItemsID`
$$




DELIMITER ;