DELIMITER $$



DROP PROCEDURE IF EXISTS `spShipmentRevenuePerAccountingType`
$$
CREATE PROCEDURE `spShipmentRevenuePerAccountingType`(
	IN `OrderShipmentID` INTEGER(11)
	)
	DETERMINISTIC
	READS SQL DATA
	SQL SECURITY INVOKER
	COMMENT ''
BEGIN
	DECLARE localOrderID INT;
	DECLARE woodFinishPrice DECIMAL(19,2);
	DECLARE cableRailFinish DECIMAL(19,2);


	SELECT OrderID INTO localOrderID
	FROM TblOrdersBOM_Shipments
	WHERE OrderShipment_id = OrderShipmentID;


	--  Calculate Wood Finish and Cable Rail Finish separately because it makes the final query easier to understand
	SELECT Coalesce(Sum( (TblProducts.FinishPrice * FinishPriceMultiplier) * (1 - TblOrdersBOM_Items.DiscountPercent) * TblOrdersBOM_Items.QuantityShipped ), 0) INTO woodFinishPrice
	FROM TblOrdersBOM_ShipmentsItems
		INNER JOIN TblOrdersBOM_Items ON TblOrdersBOM_Items.OrderItemsID = TblOrdersBOM_ShipmentsItems.OrderItemsID
		INNER JOIN TblProducts        ON TblProducts.productID = TblOrdersBOM_Items.ProductID
		INNER JOIN TblProductType     ON TblProductType.ProductType_id = TblProducts.ProductType_id
		LEFT JOIN TblFinishOption     ON TblFinishOption.id = TblOrdersBOM_Items.FinishOptionID
	WHERE TblOrdersBOM_ShipmentsItems.OrderShipment_id = OrderShipmentID
		--  only 'Wood Production' production type items
		AND ProductionTypeID = 2
	GROUP BY TblOrdersBOM_ShipmentsItems.OrderShipment_id;


	SELECT Coalesce(Sum( (TblProducts.FinishPrice * FinishPriceMultiplier) * (1 - TblOrdersBOM_Items.DiscountPercent) * TblOrdersBOM_Items.QuantityShipped ), 0) INTO cableRailFinish
	FROM TblOrdersBOM_ShipmentsItems
		INNER JOIN TblOrdersBOM_Items ON TblOrdersBOM_Items.OrderItemsID = TblOrdersBOM_ShipmentsItems.OrderItemsID
		INNER JOIN TblProducts        ON TblProducts.productID = TblOrdersBOM_Items.ProductID
		INNER JOIN TblProductType     ON TblProductType.ProductType_id = TblProducts.ProductType_id
		LEFT JOIN TblFinishOption     ON TblFinishOption.id = TblOrdersBOM_Items.FinishOptionID
	WHERE TblOrdersBOM_ShipmentsItems.OrderShipment_id = OrderShipmentID
		--  only 'Cable Production' production type items
		AND ProductionTypeID = 3
	GROUP BY TblOrdersBOM_ShipmentsItems.OrderShipment_id;


	--  Production includes "Wood Finish" so we need to cut it out
	--  The same for "Cable Rail - Production" (it includes cableRailFinish)
	SELECT TblProductTypeAccountingType.id, title,
		CASE
			WHEN id = 2  THEN Coalesce(perAccountingTypeSubtotal - woodFinishPrice, 0)
			WHEN id = 5  THEN Coalesce(perAccountingTypeSubtotal - cableRailFinish, 0)
			WHEN id = 7  THEN Coalesce(woodFinishPrice, 0)
			WHEN id = 8  THEN Coalesce(cableRailFinish, 0)
			WHEN id = 9  THEN Coalesce((perAccountingTypeSubtotal + (SELECT FreightCharge FROM TblOrdersBOM WHERE TblOrdersBOM.OrderID = localOrderID)) * (SELECT SalesTaxRate FROM TblOrdersBOM WHERE TblOrdersBOM.OrderID = localOrderID), 0)
			WHEN id = 10 THEN Coalesce(perAccountingTypeSubtotal + (SELECT FreightCharge FROM TblOrdersBOM WHERE TblOrdersBOM.OrderID = localOrderID), 0)
			ELSE Coalesce(perAccountingTypeSubtotal, 0)
		END AS amount
	FROM TblProductTypeAccountingType
		LEFT JOIN (
					SELECT AccountingTypeID, Sum(perAccountingTypeSubtotal) AS perAccountingTypeSubtotal
					FROM (
							SELECT AccountingTypeID,
								Sum( vOrderItemPrice.unitPriceDiscounted * TblOrdersBOM_Items.QuantityShipped ) AS perAccountingTypeSubtotal
							FROM TblOrdersBOM_ShipmentsItems
								INNER JOIN TblOrdersBOM_Items ON TblOrdersBOM_Items.OrderItemsID = TblOrdersBOM_ShipmentsItems.OrderItemsID
								INNER JOIN TblProducts        ON TblProducts.productID = TblOrdersBOM_Items.ProductID
								INNER JOIN TblProductType     ON TblProductType.ProductType_id = TblProducts.ProductType_id
								INNER JOIN vOrderItemPrice    ON vOrderItemPrice.OrderItemsID = TblOrdersBOM_Items.OrderItemsID
							WHERE TblOrdersBOM_ShipmentsItems.OrderShipment_id = OrderShipmentID
							GROUP BY TblProductType.AccountingTypeID

						UNION
							--  We need a separate sum for "Sales tax" because it applies to all products and we need to not include tax exempt products
							SELECT 9 AS AccountingTypeID,
								Sum( vOrderItemPrice.unitPriceDiscounted * TblOrdersBOM_Items.QuantityShipped ) AS perAccountingTypeSubtotal
							FROM TblOrdersBOM_ShipmentsItems
								INNER JOIN TblOrdersBOM_Items ON TblOrdersBOM_Items.OrderItemsID = TblOrdersBOM_ShipmentsItems.OrderItemsID
								INNER JOIN TblProducts        ON TblProducts.productID = TblOrdersBOM_Items.ProductID
								INNER JOIN TblProductType     ON TblProductType.ProductType_id = TblProducts.ProductType_id
								INNER JOIN vOrderItemPrice    ON vOrderItemPrice.OrderItemsID = TblOrdersBOM_Items.OrderItemsID
							WHERE TblOrdersBOM_ShipmentsItems.OrderShipment_id = OrderShipmentID
								AND TblProductType.isTaxExempt = 0
							GROUP BY TblOrdersBOM_ShipmentsItems.OrderShipment_id

						UNION

							SELECT AccountingTypeID,
								Sum( TblOrdersBOM_ItemsFeature.AdditionalUnitPrice * (1 - DiscountPercent) * TblOrdersBOM_Items.QuantityShipped ) AS perAccountingTypeSubtotal
							FROM TblOrdersBOM_ShipmentsItems
								INNER JOIN TblOrdersBOM_Items        ON TblOrdersBOM_Items.OrderItemsID = TblOrdersBOM_ShipmentsItems.OrderItemsID
								INNER JOIN TblOrdersBOM_ItemsFeature ON TblOrdersBOM_ItemsFeature.OrderItemsID = TblOrdersBOM_Items.OrderItemsID
								INNER JOIN TblProductFeature         ON TblProductFeature.FeatureID = TblOrdersBOM_ItemsFeature.FeatureID
							WHERE TblOrdersBOM_ShipmentsItems.OrderShipment_id = OrderShipmentID
							GROUP BY AccountingTypeID

						UNION

							SELECT AccountingTypeID,
								Sum( TblOrdersBOM_ItemsCustomization.AdditionalUnitPrice * (1 - DiscountPercent) * TblOrdersBOM_Items.QuantityShipped ) AS perAccountingTypeSubtotal
							FROM TblOrdersBOM_ShipmentsItems
								INNER JOIN TblOrdersBOM_Items        ON TblOrdersBOM_Items.OrderItemsID = TblOrdersBOM_ShipmentsItems.OrderItemsID
								INNER JOIN TblOrdersBOM_ItemsCustomization ON TblOrdersBOM_ItemsCustomization.OrderItemsID = TblOrdersBOM_Items.OrderItemsID
								INNER JOIN TblProductCustomization         ON TblProductCustomization.CustomizationID = TblOrdersBOM_ItemsCustomization.CustomizationID
							WHERE TblOrdersBOM_ShipmentsItems.OrderShipment_id = OrderShipmentID
							GROUP BY AccountingTypeID
							) AS dummy1
					GROUP BY AccountingTypeID
					) AS ExistingItemsTypes ON ExistingItemsTypes.AccountingTypeID = TblProductTypeAccountingType.id
	ORDER BY SortOrder ASC;

END
$$


DELIMITER ;