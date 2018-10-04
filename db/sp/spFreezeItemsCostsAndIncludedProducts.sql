DELIMITER $$



DROP PROCEDURE IF EXISTS `spFreezeItemsCostsAndIncludedProducts`
$$
CREATE PROCEDURE `spFreezeItemsCostsAndIncludedProducts`(
		IN `orderID` INTEGER(11)
	)
	NOT DETERMINISTIC
	MODIFIES SQL DATA
	SQL SECURITY INVOKER
	COMMENT 'For the passed order freeze costs and bundled/included products'
BEGIN
	DECLARE done INT DEFAULT FALSE;


	DECLARE varOrderItemsID INT;
	DECLARE varCostPurchase DECIMAL(19,2);
	DECLARE varCostPurchaseIncludedProducts DECIMAL(19,2);
	DECLARE varCostOfLabor DECIMAL(19,2);
	DECLARE varCostPreFinish DECIMAL(19,2);
	DECLARE varCostFinishOptionMultiplier DECIMAL(19,2);
	DECLARE varCostLumberRate DECIMAL(19,2);
	DECLARE varCostBoardFootage DECIMAL(19,2);


	DECLARE items CURSOR FOR
					SELECT TblOrdersBOM_Items.orderItemsID,
						vOrderItemCosts.costPurchase, vOrderItemCosts.costPurchaseIncludedProducts, vOrderItemCosts.costOfLabor,
						vOrderItemCosts.costPreFinish, vOrderItemCosts.costFinishOptionMultiplier,
						vOrderItemCosts.costLumberRate, vOrderItemCosts.costBoardFootage
					FROM TblOrdersBOM_Items
						INNER JOIN TblOrdersBOM_ActiveVersion ON TblOrdersBOM_ActiveVersion.OrderVersionID = TblOrdersBOM_Items.OrderVersionID
						INNER JOIN vOrderItemCosts            ON vOrderItemCosts.orderItemsID = TblOrdersBOM_Items.orderItemsID
					WHERE TblOrdersBOM_ActiveVersion.OrderID = orderID
						AND TblOrdersBOM_Items.costsAreFrozen = 0
						AND EXISTS (
							SELECT 1
							FROM TblOrdersBOM_ShipmentsItems
							INNER JOIN TblOrdersBOM_Shipments ON TblOrdersBOM_Shipments.OrderShipment_id = TblOrdersBOM_ShipmentsItems.OrderShipment_id
							WHERE orderItemsID = TblOrdersBOM_Items.orderItemsID
							AND TblOrdersBOM_Shipments.isShipped = 1
						);
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done := TRUE;


	OPEN items;

	read_loop:
	LOOP
		FETCH items INTO varOrderItemsID, varCostPurchase, varCostPurchaseIncludedProducts, varCostOfLabor,
						varCostPreFinish, varCostFinishOptionMultiplier, varCostLumberRate, varCostBoardFootage;
		IF done THEN
			LEAVE read_loop;
		END IF;

		UPDATE TblOrdersBOM_Items
		SET
			costsAreFrozen               = 1,
			costPurchase                 = varCostPurchase,
			costPurchaseIncludedProducts = NULL,
			costOfLabor                  = varCostOfLabor,
			costPreFinish                = varCostPreFinish,
			costFinishOptionMultiplier   = varCostFinishOptionMultiplier,
			costLumberRate               = varCostLumberRate,
			costBoardFootage             = varCostBoardFootage
		WHERE orderItemsID = varOrderItemsID;


		IF varCostPurchaseIncludedProducts IS NOT NULL THEN
			DROP TEMPORARY TABLE IF EXISTS temporaryIncludedProducts;
			CREATE TEMPORARY TABLE temporaryIncludedProducts ENGINE=MEMORY
			AS (
				SELECT OrderItemsID, includedProduct.ProductID, includedProduct.ProductName, TblProductsInclude.Quantity, includedProduct.Purchase_Price
				FROM TblOrdersBOM_Items
					INNER JOIN TblProductsInclude             ON TblProductsInclude.ParentProductID = TblOrdersBOM_Items.ProductID
					INNER JOIN TblProducts AS includedProduct ON includedProduct.ProductID = TblProductsInclude.IncludedProductID
				WHERE TblOrdersBOM_Items.orderItemsID = varOrderItemsID
					AND EXISTS (SELECT 1 FROM TblProductsInclude WHERE TblProductsInclude.ParentProductID = TblOrdersBOM_Items.ProductID)
			);


			INSERT INTO TblOrdersBOM_ItemsInclude
				(OrderItemsID, BundledProductID, OrderItemName, BundledQuantity, PurchasePrice)
			SELECT OrderItemsID, ProductID, ProductName, Quantity, Purchase_Price
			FROM temporaryIncludedProducts;

			DROP TEMPORARY TABLE temporaryIncludedProducts;
		END IF;
	END LOOP;


	CLOSE items;
END
$$



DELIMITER ;