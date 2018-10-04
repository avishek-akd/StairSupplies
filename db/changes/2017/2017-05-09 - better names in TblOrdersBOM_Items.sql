ALTER TABLE TblOrdersBOM_Items
	CHANGE COLUMN `ProductName` `OrderItemName` VARCHAR(100) NULL DEFAULT NULL,
	CHANGE COLUMN `ProductDescription` `OrderItemDescription` VARCHAR(500) NULL DEFAULT NULL,
	CHANGE COLUMN `UnitPrice` `OrderItemPricePerUnit` DECIMAL(19,4) NOT NULL DEFAULT 0
;
ALTER TABLE TblOrdersBOM_ItemsInclude
	CHANGE COLUMN `ProductName` `OrderItemName` VARCHAR(100) NULL DEFAULT NULL
;



DELIMITER $$



DROP VIEW IF EXISTS vOrderItemPrice
$$
CREATE SQL SECURITY INVOKER VIEW `vOrderItemPrice` AS
  select
    `TblOrdersBOM_Items`.`OrderItemsID` AS `orderItemsId`,
    (`TblOrdersBOM_Items`.`OrderItemPricePerUnit` * (1 - `TblOrdersBOM_Items`.`DiscountPercent`)) AS `unitPriceDiscounted`,
    (`TblOrdersBOM_Items`.`OrderItemPricePerUnit` * `TblOrdersBOM_Items`.`DiscountPercent`) AS `unitDiscountAmount`
  from
    `TblOrdersBOM_Items`
$$


DROP VIEW IF EXISTS vOrderItems
$$
CREATE ALGORITHM=UNDEFINED SQL SECURITY INVOKER VIEW `vOrderItems` AS
select `TblOrdersBOM_Items`.`OrderItemsID` AS `orderItemsID`,
       `TblOrdersBOM_Items`.`OrderID` AS `orderID`,
       `TblOrdersBOM_Items`.`GroupID` AS `GroupID`,
       `TblOrdersBOM_Items`.`AutoSuggestionParentID` AS `AutoSuggestionParentID`,
       `TblOrdersBOM_Items`.`OrderItemPricePerUnit` AS `OrderItemPricePerUnit`,
       `TblOrdersBOM_Items`.`OrderItemName` AS `OrderItemName`,
       `TblOrdersBOM_Items`.`OrderItemDescription` AS `OrderItemDescription`,
       `TblOrdersBOM_Items`.`In_House_Notes` AS `in_house_notes`,
       `TblOrdersBOM_Items`.`Customer_Notes` AS `Customer_Notes`,
       `TblOrdersBOM_Items`.`PostNumbersList` AS `PostNumbersList`,
       `TblOrdersBOM_Items`.`QuantityOrdered` AS `QuantityOrdered`,
       `TblOrdersBOM_Items`.`UnitWeight` AS `unitWeight`,
       `TblOrdersBOM_Items`.`QuantityShipped` AS `quantityShipped`,
       `TblOrdersBOM_Items`.`DiscountPercent` AS `discountPercent`,
       `TblOrdersBOM_Items`.`Shipped` AS `shipped`,
       `TblOrdersBOM_Items`.`GroupSortField` AS `GroupSortField`,
       `TblOrdersBOM_Items`.`Special_Instructions` AS `Special_Instructions`,
       vOrderItemPrice.unitPriceDiscounted AS `discountedUnitPrice`,
       vOrderItemPrice.unitPriceDiscounted * QuantityOrdered AS itemPrice,
       `TblOrdersBOM_Items`.`FinishOptionID` AS `FinishOptionID`,
       `Products`.`MaterialID` AS `MaterialID`,
       `TblMaterial`.`d_name` AS `materialName`,
       `TblMaterial`.`d_finish_image_unfinished` AS `d_finish_image_unfinished`,
       `TblMaterial`.`d_finish_image_standard` AS `d_finish_image_standard`,
       `TblFinishOption`.`FinishImage` AS `FinishImage`,
       `TblFinishOption`.`title` AS `finishOptionTitle`,
       `Products`.`Unit_of_Measure` AS `Unit_of_Measure`,
       `Products`.`ProductType_id` AS `ProductType_Id`,
       `Products`.`ProductID` AS `ProductID`
from `TblOrdersBOM_Items`
	INNER JOIN vOrderItemPrice    ON vOrderItemPrice.OrderItemsID = TblOrdersBOM_Items.OrderItemsID
     left join `Products`         ON `Products`.`ProductID` = `TblOrdersBOM_Items`.`ProductID`
     left join `TblMaterial`      ON `TblMaterial`.`id` = `Products`.`MaterialID`
     left join `TblFinishOption`  ON `TblFinishOption`.`id` = `TblOrdersBOM_Items`.`FinishOptionID`
order by `TblOrdersBOM_Items`.`OrderItemsID`
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
	    OBOMI.OrderItemPricePerUnit * (1 - OBOMI.DiscountPercent) * Employees.SalesCommission AS costOfSalesCommision,

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
			)
		+ OBOMI.OrderItemPricePerUnit * (1 - OBOMI.DiscountPercent) * Employees.SalesCommission
		AS costPerUnit
FROM TblOrdersBOM_Items AS OBOMI
	INNER JOIN TblOrdersBOM       ON TblOrdersBOM.OrderID = OBOMI.OrderID
	LEFT JOIN Employees           ON Employees.EmployeeID = TblOrdersBOM.SalesmanEmployeeID
	INNER JOIN Products           ON Products.productID = OBOMI.productID
	LEFT JOIN TblFinishOption     ON TblFinishOption.id = OBOMI.FinishOptionID
	LEFT JOIN TblMaterial         ON TblMaterial.id = Products.MaterialID
	LEFT JOIN TblMaterialSizeLink ON (TblMaterialSizeLink.d_material_id = Products.MaterialID
											AND TblMaterialSizeLink.d_material_size_id = Products.MaterialSizeID)
$$



DROP PROCEDURE IF EXISTS spFreezeItemsCostsAndIncludedProducts
$$
CREATE PROCEDURE `spFreezeItemsCostsAndIncludedProducts`(
        IN `orderID` INTEGER(11)
    )
    NOT DETERMINISTIC
    CONTAINS SQL
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
                      INNER JOIN vOrderItemCosts ON vOrderItemCosts.orderItemsID = TblOrdersBOM_Items.orderItemsID
                  WHERE TblOrdersBOM_Items.OrderID = orderID
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
                SELECT OrderItemsID, includedProduct.ProductID, includedProduct.ProductName, ProductsInclude.Quantity, includedProduct.Purchase_Price
                FROM TblOrdersBOM_Items
                    INNER JOIN ProductsInclude             ON ProductsInclude.ParentProductID = TblOrdersBOM_Items.ProductID
                    INNER JOIN Products AS includedProduct ON includedProduct.ProductID = ProductsInclude.IncludedProductID
                WHERE TblOrdersBOM_Items.orderItemsID = varOrderItemsID
                    AND EXISTS (SELECT 1 FROM ProductsInclude WHERE ProductsInclude.ParentProductID = TblOrdersBOM_Items.ProductID)
            );


            INSERT INTO TblOrdersBOM_ItemsInclude
                (OrderItemsID, BundledProductID, OrderItemName, BundledQuantity, PurchasePrice)
            SELECT OrderItemsID, ProductID, OrderItemName, Quantity, Purchase_Price
            FROM temporaryIncludedProducts;

            DROP TEMPORARY TABLE temporaryIncludedProducts;
        END IF;
	END LOOP;


    CLOSE items;
END
$$



DELIMITER ;