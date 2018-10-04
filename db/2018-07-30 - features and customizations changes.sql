ALTER TABLE `TblOrdersBOM_Items`
	ADD COLUMN `_bk_OrderItemPricePerUnit` DECIMAL(19,4) NOT NULL DEFAULT -1 AFTER `OrderItemPricePerUnit`
;
UPDATE `TblOrdersBOM_Items`
SET _bk_OrderItemPricePerUnit = OrderItemPricePerUnit
;
ALTER TABLE `TblOrdersBOM_Items`
	DROP COLUMN `OrderItemPricePerUnit`
;



ALTER TABLE TblOrdersBOM_Items
	CHANGE COLUMN `OrderItemFeaturesAndCustomizationsPrice` `_unused_OrderItemFeaturesAndCustomizationsPrice` DECIMAL(19,4) NOT NULL DEFAULT 0
			COMMENT 'Sum of features and customizations price per unit, excluding discount',
	CHANGE COLUMN `OrderItemBasePrice` `OrderItemPricePerUnit` DECIMAL(19,4) NOT NULL DEFAULT 0 COMMENT 'Unit price excluding features and customizations, excluding discount'
;


UPDATE TblOrdersBOM_Items
SET OrderItemPricePerUnit = OrderItemPricePerUnit + _unused_OrderItemFeaturesAndCustomizationsPrice
WHERE _unused_OrderItemFeaturesAndCustomizationsPrice <> 0
;






DELIMITER $$



DROP PROCEDURE IF EXISTS `spUpdateOrderItemFeaturesAndCustomizations`
$$
/*
	Stored procedure used in when a feature or customization is added/removed from an order item.
	The SP is called from triggers on TblOrdersBOM_ItemsFeature and TblOrdersBOM_ItemsCustomization.
*/
CREATE PROCEDURE `spUpdateOrderItemFeaturesAndCustomizations`(
	IN `vOrderItemID` INTEGER(11)
	)
	DETERMINISTIC
	READS SQL DATA
	SQL SECURITY INVOKER
	COMMENT ''
BEGIN
	UPDATE TblOrdersBOM_Items
	SET
		OrderItemNameSuffix        = Coalesce((SELECT Group_concat(NameSuffix SEPARATOR ' - ')
												FROM (SELECT NameSuffix FROM TblOrdersBOM_ItemsFeature WHERE OrderItemsID = vOrderItemID
														UNION
														SELECT NameSuffix FROM TblOrdersBOM_ItemsCustomization WHERE OrderItemsID = vOrderItemID) AS dummy), ''),
		OrderItemDescriptionPrefix = Coalesce((SELECT Group_concat(DescriptionPrefix SEPARATOR ' - ')
												FROM (SELECT DescriptionPrefix FROM TblOrdersBOM_ItemsFeature WHERE OrderItemsID = vOrderItemID
													UNION
													SELECT DescriptionPrefix FROM TblOrdersBOM_ItemsCustomization WHERE OrderItemsID = vOrderItemID) AS dummy), ''),
		costOfFeaturesAndCustomizations         = Coalesce((SELECT Sum(AdditionalLaborCost) FROM TblOrdersBOM_ItemsFeature WHERE OrderItemsID = vOrderItemID), 0)
													+ Coalesce((SELECT Sum(AdditionalLaborCost) FROM TblOrdersBOM_ItemsCustomization WHERE OrderItemsID = vOrderItemID), 0)
	WHERE OrderItemsID = vOrderItemID;
END
$$


DELIMITER ;
DELIMITER $$



DROP PROCEDURE IF EXISTS `spOrderRevenuePerAccountingType`
$$
CREATE PROCEDURE `spOrderRevenuePerAccountingType`(
	IN `argOrderID` INTEGER(11)
	)
	DETERMINISTIC
	READS SQL DATA
	SQL SECURITY INVOKER
	COMMENT 'For a given order return the sum of prices in each accounting type (LED, Stock, etc)'
BEGIN
	DECLARE localWoodFinishPrice DECIMAL(19,2);
	DECLARE localCableRailFinish DECIMAL(19,2);
	DECLARE localFreightCharge DECIMAL(19,2);
	DECLARE localSalesTaxRate DECIMAL(19,4);


	SELECT FreightCharge, SalesTaxRate
	INTO localFreightCharge, localSalesTaxRate
	FROM TblOrdersBOM_ActiveVersion
		INNER JOIN TblOrdersBOM ON TblOrdersBOM.OrderID = TblOrdersBOM_ActiveVersion.OrderID
	WHERE TblOrdersBOM_ActiveVersion.OrderID = argOrderID;


	--  Calculate Wood Finish and Cable Rail Finish separately because it makes the final query easier to understand
	SELECT Coalesce(Sum( (TblProducts.FinishPrice * FinishPriceMultiplier) * (1 - TblOrdersBOM_Items.DiscountPercent) * TblOrdersBOM_Items.quantityOrdered ), 0) INTO localWoodFinishPrice
	FROM TblOrdersBOM_Items
		INNER JOIN TblOrdersBOM_ActiveVersion ON TblOrdersBOM_ActiveVersion.OrderVersionID = TblOrdersBOM_Items.OrderVersionID
		INNER JOIN TblProducts                ON TblOrdersBOM_Items.ProductID = TblProducts.productID
		INNER JOIN TblProductType             ON TblProductType.ProductType_id = TblProducts.ProductType_id
		LEFT JOIN TblFinishOption             ON TblFinishOption.id = TblOrdersBOM_Items.FinishOptionID
	WHERE TblOrdersBOM_ActiveVersion.OrderID = argOrderID
		--  only 'Wood Production' production type items
		AND ProductionTypeID = 2;


	SELECT Coalesce(Sum( (TblProducts.FinishPrice * FinishPriceMultiplier) * (1 - TblOrdersBOM_Items.DiscountPercent) * TblOrdersBOM_Items.quantityOrdered ), 0) INTO localCableRailFinish
	FROM TblOrdersBOM_Items
		INNER JOIN TblOrdersBOM_ActiveVersion ON TblOrdersBOM_ActiveVersion.OrderVersionID = TblOrdersBOM_Items.OrderVersionID
		INNER JOIN TblProducts                ON TblOrdersBOM_Items.ProductID = TblProducts.productID
		INNER JOIN TblProductType             ON TblProductType.ProductType_id = TblProducts.ProductType_id
		LEFT JOIN TblFinishOption             ON TblFinishOption.id = TblOrdersBOM_Items.FinishOptionID
	WHERE TblOrdersBOM_ActiveVersion.OrderID = argOrderID
		--  only 'Cable Production' production type items
		AND ProductionTypeID = 3;


	--  Production includes "Wood Finish" so we need to cut it out
	--  The same for "Cable Rail - Production" (it includes localCableRailFinish)
	SELECT TblProductTypeAccountingType.id, title, SortOrder,
		CASE
			WHEN id = 2  THEN Coalesce(Coalesce(perAccountingTypeSubtotal, 0) - localWoodFinishPrice, 0)
			WHEN id = 5  THEN Coalesce(Coalesce(perAccountingTypeSubtotal, 0) - localCableRailFinish, 0)
			WHEN id = 7  THEN Coalesce(localWoodFinishPrice, 0)
			WHEN id = 8  THEN Coalesce(localCableRailFinish, 0)
			WHEN id = 9  THEN Coalesce((Coalesce(perAccountingTypeSubtotal, 0) + localFreightCharge) * localSalesTaxRate, 0)
			WHEN id = 10 THEN Coalesce(Coalesce(perAccountingTypeSubtotal, 0) + localFreightCharge, 0)
			ELSE Coalesce(perAccountingTypeSubtotal, 0)
		END AS amount
	FROM TblProductTypeAccountingType
		LEFT JOIN (
					SELECT AccountingTypeID, Sum(perAccountingTypeSubtotal) AS perAccountingTypeSubtotal
					FROM (
							--  From the item price we need to subtract features and customizations because those might be
							-- assigned to a different accounting types.
							SELECT AccountingTypeID,
								Sum( OrderItemPricePerUnit * (1 - DiscountPercent) * TblOrdersBOM_Items.quantityOrdered )
								- Sum((
									SELECT Sum(TblOrdersBOM_ItemsFeature.AdditionalUnitPrice * (1 - DiscountPercent) * QuantityOrdered)
									FROM TblOrdersBOM_ItemsFeature
									WHERE TblOrdersBOM_ItemsFeature.OrderItemsID = TblOrdersBOM_Items.OrderItemsID
									GROUP BY TblOrdersBOM_Items.OrderItemsID
								))
								- Sum(Coalesce((
									SELECT Sum(TblOrdersBOM_ItemsCustomization.AdditionalUnitPrice * (1 - DiscountPercent) * QuantityOrdered)
									FROM TblOrdersBOM_ItemsCustomization
									WHERE TblOrdersBOM_ItemsCustomization.OrderItemsID = TblOrdersBOM_Items.OrderItemsID
									GROUP BY TblOrdersBOM_Items.OrderItemsID
								), 0))
								AS perAccountingTypeSubtotal
							FROM TblOrdersBOM_Items
								INNER JOIN TblOrdersBOM_ActiveVersion ON TblOrdersBOM_ActiveVersion.OrderVersionID = TblOrdersBOM_Items.OrderVersionID
								INNER JOIN TblProducts                ON TblOrdersBOM_Items.ProductID = TblProducts.productID
								INNER JOIN TblProductType             ON TblProductType.ProductType_id = TblProducts.ProductType_id
							WHERE TblOrdersBOM_ActiveVersion.OrderID = argOrderID
							GROUP BY TblProductType.AccountingTypeID

						UNION
							--  We need a separate sum for "Sales tax" because it applies to all products and we need to not include tax exempt products
							SELECT 9 AS AccountingTypeID,
								Sum( OrderItemPricePerUnit * (1 - DiscountPercent) * TblOrdersBOM_Items.quantityOrdered ) AS perAccountingTypeSubtotal
							FROM TblOrdersBOM_Items
								INNER JOIN TblOrdersBOM_ActiveVersion ON TblOrdersBOM_ActiveVersion.OrderVersionID = TblOrdersBOM_Items.OrderVersionID
								INNER JOIN TblProducts                ON TblOrdersBOM_Items.ProductID = TblProducts.productID
								INNER JOIN TblProductType             ON TblProductType.ProductType_id = TblProducts.ProductType_id
							WHERE TblOrdersBOM_ActiveVersion.OrderID = argOrderID
								AND TblProductType.isTaxExempt = 0

						UNION

							--  Features
							SELECT AccountingTypeID,
								Sum( TblOrdersBOM_ItemsFeature.AdditionalUnitPrice * (1 - DiscountPercent) * TblOrdersBOM_Items.quantityOrdered ) AS perAccountingTypeSubtotal
							FROM TblOrdersBOM_Items
								INNER JOIN TblOrdersBOM_ActiveVersion ON TblOrdersBOM_ActiveVersion.OrderVersionID = TblOrdersBOM_Items.OrderVersionID
								INNER JOIN TblOrdersBOM_ItemsFeature  ON TblOrdersBOM_ItemsFeature.OrderItemsID = TblOrdersBOM_Items.OrderItemsID
								INNER JOIN TblProductFeature          ON TblProductFeature.FeatureID = TblOrdersBOM_ItemsFeature.FeatureID
							WHERE TblOrdersBOM_ActiveVersion.OrderID = argOrderID
							GROUP BY AccountingTypeID

						UNION

							--  Customizations
							SELECT AccountingTypeID,
								Sum( TblOrdersBOM_ItemsCustomization.AdditionalUnitPrice * (1 - DiscountPercent) * TblOrdersBOM_Items.quantityOrdered ) AS perAccountingTypeSubtotal
							FROM TblOrdersBOM_Items
								INNER JOIN TblOrdersBOM_ActiveVersion      ON TblOrdersBOM_ActiveVersion.OrderVersionID = TblOrdersBOM_Items.OrderVersionID
								INNER JOIN TblOrdersBOM_ItemsCustomization ON TblOrdersBOM_ItemsCustomization.OrderItemsID = TblOrdersBOM_Items.OrderItemsID
								INNER JOIN TblProductCustomization         ON TblProductCustomization.CustomizationID = TblOrdersBOM_ItemsCustomization.CustomizationID
							WHERE TblOrdersBOM_ActiveVersion.OrderID = argOrderID
							GROUP BY AccountingTypeID
						) AS dummy1
					GROUP BY AccountingTypeID
					) AS ExistingItemsTypes ON ExistingItemsTypes.AccountingTypeID = TblProductTypeAccountingType.id
	ORDER BY SortOrder ASC;

END
$$


DELIMITER ;
DELIMITER $$



DROP PROCEDURE IF EXISTS `spOrderVersionRevenuePerAccountingType`
$$
CREATE PROCEDURE `spOrderVersionRevenuePerAccountingType`(
	IN `argOrderVersionID` INTEGER(11)
	)
	DETERMINISTIC
	READS SQL DATA
	SQL SECURITY INVOKER
	COMMENT 'For a given order return the sum of prices in each accounting type (LED, Stock, etc)'
BEGIN
	DECLARE localWoodFinishPrice DECIMAL(19,2);
	DECLARE localCableRailFinish DECIMAL(19,2);
	DECLARE localFreightCharge DECIMAL(19,2);
	DECLARE localSalesTaxRate DECIMAL(19,4);


	SELECT FreightCharge, SalesTaxRate
	INTO localFreightCharge, localSalesTaxRate
	FROM TblOrdersBOM_Version
		INNER JOIN TblOrdersBOM ON TblOrdersBOM.OrderID = TblOrdersBOM_Version.OrderID
	WHERE TblOrdersBOM_Version.OrderVersionID = argOrderVersionID;


	--  Calculate Wood Finish and Cable Rail Finish separately because it makes the final query easier to understand
	SELECT Coalesce(Sum( (TblProducts.FinishPrice * FinishPriceMultiplier) * (1 - TblOrdersBOM_Items.DiscountPercent) * TblOrdersBOM_Items.quantityOrdered ), 0) INTO localWoodFinishPrice
	FROM TblOrdersBOM_Items
		INNER JOIN TblProducts    ON TblOrdersBOM_Items.ProductID = TblProducts.productID
		INNER JOIN TblProductType ON TblProductType.ProductType_id = TblProducts.ProductType_id
		LEFT JOIN TblFinishOption ON TblFinishOption.id = TblOrdersBOM_Items.FinishOptionID
	WHERE TblOrdersBOM_Items.OrderVersionID = argOrderVersionID
		--  only 'Wood Production' production type items
		AND ProductionTypeID = 2;


	SELECT Coalesce(Sum( (TblProducts.FinishPrice * FinishPriceMultiplier) * (1 - TblOrdersBOM_Items.DiscountPercent) * TblOrdersBOM_Items.quantityOrdered ), 0) INTO localCableRailFinish
	FROM TblOrdersBOM_Items
		INNER JOIN TblProducts    ON TblOrdersBOM_Items.ProductID = TblProducts.productID
		INNER JOIN TblProductType ON TblProductType.ProductType_id = TblProducts.ProductType_id
		LEFT JOIN TblFinishOption ON TblFinishOption.id = TblOrdersBOM_Items.FinishOptionID
	WHERE TblOrdersBOM_Items.OrderVersionID = argOrderVersionID
		--  only 'Cable Production' production type items
		AND ProductionTypeID = 3;


	--  Production includes "Wood Finish" so we need to cut it out
	--  The same for "Cable Rail - Production" (it includes localCableRailFinish)
	SELECT TblProductTypeAccountingType.id, title, SortOrder,
		CASE
			WHEN id = 2  THEN Coalesce(Coalesce(perAccountingTypeSubtotal, 0) - localWoodFinishPrice, 0)
			WHEN id = 5  THEN Coalesce(Coalesce(perAccountingTypeSubtotal, 0) - localCableRailFinish, 0)
			WHEN id = 7  THEN Coalesce(localWoodFinishPrice, 0)
			WHEN id = 8  THEN Coalesce(localCableRailFinish, 0)
			WHEN id = 9  THEN Coalesce((Coalesce(perAccountingTypeSubtotal, 0) + localFreightCharge) * localSalesTaxRate, 0)
			WHEN id = 10 THEN Coalesce(Coalesce(perAccountingTypeSubtotal, 0) + localFreightCharge, 0)
			ELSE Coalesce(perAccountingTypeSubtotal, 0)
		END AS amount
	FROM TblProductTypeAccountingType
		LEFT JOIN (
					SELECT AccountingTypeID, Sum(perAccountingTypeSubtotal) AS perAccountingTypeSubtotal
					FROM (
							--  From the item price we need to subtract features and customizations because those might be
							-- assigned to a different accounting types.
							SELECT AccountingTypeID,
								Sum( OrderItemPricePerUnit * (1 - DiscountPercent) * TblOrdersBOM_Items.quantityOrdered )
								- Sum((
									SELECT Sum(TblOrdersBOM_ItemsFeature.AdditionalUnitPrice * (1 - DiscountPercent) * QuantityOrdered)
									FROM TblOrdersBOM_ItemsFeature
									WHERE TblOrdersBOM_ItemsFeature.OrderItemsID = TblOrdersBOM_Items.OrderItemsID
									GROUP BY TblOrdersBOM_Items.OrderItemsID
								))
								- Sum(Coalesce((
									SELECT Sum(TblOrdersBOM_ItemsCustomization.AdditionalUnitPrice * (1 - DiscountPercent) * QuantityOrdered)
									FROM TblOrdersBOM_ItemsCustomization
									WHERE TblOrdersBOM_ItemsCustomization.OrderItemsID = TblOrdersBOM_Items.OrderItemsID
									GROUP BY TblOrdersBOM_Items.OrderItemsID
								), 0))
								AS perAccountingTypeSubtotal
							FROM TblOrdersBOM_Items
								INNER JOIN TblProducts    ON TblOrdersBOM_Items.ProductID = TblProducts.productID
								INNER JOIN TblProductType ON TblProductType.ProductType_id = TblProducts.ProductType_id
							WHERE TblOrdersBOM_Items.OrderVersionID = argOrderVersionID
							GROUP BY TblProductType.AccountingTypeID

						UNION

							--  We need a separate sum for "Sales tax" because it applies to all products and we need to not include tax exempt products
							SELECT 9 AS AccountingTypeID,
								Sum( OrderItemPricePerUnit * (1 - DiscountPercent) * TblOrdersBOM_Items.quantityOrdered ) AS perAccountingTypeSubtotal
							FROM TblOrdersBOM_Items
								INNER JOIN TblProducts    ON TblOrdersBOM_Items.ProductID = TblProducts.productID
								INNER JOIN TblProductType ON TblProductType.ProductType_id = TblProducts.ProductType_id
							WHERE TblOrdersBOM_Items.OrderVersionID = argOrderVersionID
								AND TblProductType.isTaxExempt = 0

						UNION

							--  Features
							SELECT AccountingTypeID,
								Sum( TblOrdersBOM_ItemsFeature.AdditionalUnitPrice * (1 - DiscountPercent) * TblOrdersBOM_Items.quantityOrdered ) AS perAccountingTypeSubtotal
							FROM TblOrdersBOM_Items
								INNER JOIN TblOrdersBOM_ItemsFeature ON TblOrdersBOM_ItemsFeature.OrderItemsID = TblOrdersBOM_Items.OrderItemsID
								INNER JOIN TblProductFeature         ON TblProductFeature.FeatureID = TblOrdersBOM_ItemsFeature.FeatureID
							WHERE TblOrdersBOM_Items.OrderVersionID = argOrderVersionID
							GROUP BY AccountingTypeID

						UNION

							--  Customizations
							SELECT AccountingTypeID,
								Sum( TblOrdersBOM_ItemsCustomization.AdditionalUnitPrice * (1 - DiscountPercent) * TblOrdersBOM_Items.quantityOrdered ) AS perAccountingTypeSubtotal
							FROM TblOrdersBOM_Items
								INNER JOIN TblOrdersBOM_ItemsCustomization ON TblOrdersBOM_ItemsCustomization.OrderItemsID = TblOrdersBOM_Items.OrderItemsID
								INNER JOIN TblProductCustomization         ON TblProductCustomization.CustomizationID = TblOrdersBOM_ItemsCustomization.CustomizationID
							WHERE TblOrdersBOM_Items.OrderVersionID = argOrderVersionID
							GROUP BY AccountingTypeID
							) AS dummy1
					GROUP BY AccountingTypeID
					) AS ExistingItemsTypes ON ExistingItemsTypes.AccountingTypeID = TblProductTypeAccountingType.id
	ORDER BY SortOrder ASC;

END
$$


DELIMITER ;