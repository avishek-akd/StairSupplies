RENAME TABLE `Products` TO `TblProducts`
;
RENAME TABLE `ProductsInclude` TO `TblProductsInclude`
;
RENAME TABLE `ProductsAutoSuggest` TO `TblProductsAutoSuggest`
;
RENAME TABLE `ProductsAutoSuggestGroup` TO `TblProductsAutoSuggestGroup`
;
RENAME TABLE `ProductsAutoSuggestGroupProduct` TO `TblProductsAutoSuggestGroupProduct`
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



CREATE OR REPLACE SQL SECURITY INVOKER VIEW `vOrderItemProductUnitPrice` AS
/*
 * This view is used when retrieving the product (list) price for order items in the database.
 * NOTE: When adding a product to the database we don't have that line item saved yet so we use the function
 * fGetProductUnitPrice to get the per unit product price.
 */
SELECT orderItemsId,
		IF(`TblCustomer`.`CustomerTypeID` = 14,
			`TblProducts`.`UnitPriceNAC`,
			IF(`TblCustomer`.`CustomerTypeID` = 16,
				`TblProducts`.`UnitPrice`,
				IF(`TblOrdersBOM`.`CompanyID` = 4, `TblProducts`.`UnitPriceViewrail`, `TblProducts`.`UnitPrice`))
		) AS productUnitPrice
FROM TblOrdersBOM_Items
	INNER JOIN TblProducts        ON TblProducts.productID = TblOrdersBOM_Items.productID
	INNER JOIN TblOrdersBOM       ON TblOrdersBOM.orderID = TblOrdersBOM_Items.orderID
	INNER JOIN TblCustomerContact ON TblCustomerContact.CustomerContactID = TblOrdersBOM.CustomerContactID
	INNER JOIN TblCustomer        ON TblCustomer.CustomerID = TblCustomerContact.CustomerID
;




CREATE OR REPLACE SQL SECURITY INVOKER VIEW `vOrderItems` AS
SELECT
	`TblOrdersBOM_Items`.`OrderItemsID`,
	`TblOrdersBOM_Items`.`OrderID`,
	`TblOrdersBOM_Items`.`GroupID`,
	`TblOrdersBOM_Items`.`AutoSuggestionParentID`,
	`TblOrdersBOM_Items`.`OrderItemPricePerUnit`,
	`TblOrdersBOM_Items`.`OrderItemName`,
	`TblOrdersBOM_Items`.`OrderItemDescription`,
	`TblOrdersBOM_Items`.`In_House_Notes`,
	`TblOrdersBOM_Items`.`Customer_Notes`,
	`TblOrdersBOM_Items`.`PostNumbersList`,
	`TblOrdersBOM_Items`.`HandrailNumbersList`,
	`TblOrdersBOM_Items`.`QuantityOrdered`,
	`TblOrdersBOM_Items`.`UnitWeight`,
	`TblOrdersBOM_Items`.`QuantityShipped`,
	`TblOrdersBOM_Items`.`DiscountPercent`,
	`TblOrdersBOM_Items`.`Shipped`,
	`TblOrdersBOM_Items`.`GroupSortField`,
	`TblOrdersBOM_Items`.`FinishOptionID`,
	vOrderItemPrice.unitPriceDiscounted AS `discountedUnitPrice`,
	vOrderItemPrice.unitPriceDiscounted * QuantityOrdered AS itemPrice,
	`TblProducts`.`ProductID`,
	`TblProducts`.`Unit_of_Measure`,
	`TblProducts`.`ProductType_id`,
	`TblProducts`.`MaterialID`,
	`TblMaterial`.`d_name` AS `materialName`,
	`TblMaterial`.`d_finish_image_unfinished`,
	`TblMaterial`.`d_finish_image_standard`,
	`TblFinishOption`.`FinishImage`,
	`TblFinishOption`.`title` AS `finishOptionTitle`
FROM `TblOrdersBOM_Items`
	INNER JOIN vOrderItemPrice  ON vOrderItemPrice.OrderItemsID = TblOrdersBOM_Items.OrderItemsID
	LEFT JOIN `TblProducts`     ON `TblProducts`.`ProductID` = `TblOrdersBOM_Items`.`ProductID`
	LEFT JOIN `TblMaterial`     ON `TblMaterial`.`id` = `TblProducts`.`MaterialID`
	LEFT JOIN `TblFinishOption` ON `TblFinishOption`.`id` = `TblOrdersBOM_Items`.`FinishOptionID`
ORDER BY `TblOrdersBOM_Items`.`OrderItemsID`
;





DELIMITER $$



DROP FUNCTION IF EXISTS `fGetOrderMaterialsIDs`
$$
--  Return a list of distinct material IDs on an order
CREATE FUNCTION `fGetOrderMaterialsIDs`(
	`orderID` INTEGER
)
RETURNS VARCHAR(1000)
DETERMINISTIC
SQL SECURITY INVOKER
COMMENT ''
BEGIN
	DECLARE Result VARCHAR(1000) DEFAULT '';

	SELECT Group_concat(DISTINCT TblMaterial.id) INTO Result
	FROM TblOrdersBOM_Items
		INNER JOIN TblProducts ON TblProducts.ProductID = TblOrdersBOM_Items.ProductID
		LEFT JOIN TblMaterial  ON TblMaterial.id = TblProducts.MaterialID
	WHERE TblOrdersBOM_Items.OrderID = orderID;

	RETURN Result;
END
$$



DROP FUNCTION IF EXISTS `fGetOrderMaterialsNames`
$$
--  Return a list of distinct material names on an order
CREATE FUNCTION `fGetOrderMaterialsNames`(
	`orderID` INTEGER
)
RETURNS VARCHAR(1000)
DETERMINISTIC
SQL SECURITY INVOKER
COMMENT ''
BEGIN
	DECLARE Result VARCHAR(1000) DEFAULT '';

	SELECT Group_concat(DISTINCT d_name ORDER BY d_name) INTO Result
	FROM TblOrdersBOM_Items
		INNER JOIN TblProducts ON TblProducts.ProductID = TblOrdersBOM_Items.ProductID
		LEFT JOIN TblMaterial  ON TblMaterial.id = TblProducts.MaterialID
	WHERE TblOrdersBOM_Items.OrderID = orderID;

	RETURN Result;
END
$$




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


	--  We need to calculate Wood Finish without actually adding it as an Accounting type
	--  (each Product Type can have only one associated accounting type) so we calculate it separately and use a fakeID of 2.5
	--  to insert it after Production Accounting type.
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


	(
		--  Production includes "Wood Finish" so we need to cut it out
		--  The same for "Cable Rail - Production" (it includes cableRailFinish)
		SELECT TblProductTypeAccountingType.id as fakeID, title, Coalesce(total - IF(id = 2, woodFinishPrice, 0) - IF(id = 5, cableRailFinish, 0), 0) AS total
		FROM TblProductTypeAccountingType
			LEFT JOIN (
						SELECT AccountingTypeID, Sum( vOrderItemPrice.unitPriceDiscounted * OBOMI.quantityOrdered ) AS total
						FROM TblOrdersBOM_Items AS OBOMI
							INNER JOIN TblProducts     ON OBOMI.ProductID = TblProducts.productID
							INNER JOIN TblProductType  ON TblProductType.ProductType_id = TblProducts.ProductType_id
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


	--  We need to calculate Wood Finish without actually adding it as an Accounting type
	--  (each Product Type can have only one associated accounting type) so we calculate it separately and use a fakeID of 2.5
	--  to insert it after Production Accounting type.
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


	(
		--  Production includes "Wood Finish" so we need to cut it out
		--  The same for "Cable Rail - Production" (it includes cableRailFinish)
		SELECT TblProductTypeAccountingType.id as fakeID, title, Coalesce(total - IF(id = 2, woodFinishPrice, 0) - IF(id = 5, cableRailFinish, 0), 0) AS total
		FROM TblProductTypeAccountingType
			LEFT JOIN (
						SELECT AccountingTypeID, Sum( vOrderItemPrice.unitPriceDiscounted * OBOMI.quantityOrdered ) AS total
						FROM TblOrdersBOM_Items AS OBOMI
							INNER JOIN TblProducts     ON OBOMI.ProductID = TblProducts.productID
							INNER JOIN TblProductType  ON TblProductType.ProductType_id = TblProducts.ProductType_id
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




DELIMITER $$


DROP TRIGGER IF EXISTS `TblOrdersBOM_ItemsInclude_after_del_tr1`
$$
CREATE TRIGGER `TblOrdersBOM_ItemsInclude_after_del_tr1` AFTER DELETE ON `TblOrdersBOM_ItemsInclude` FOR EACH ROW BEGIN
	DECLARE newPurchasePrice DECIMAL(19,2) DEFAULT (SELECT Purchase_Price FROM TblProducts WHERE ProductID = OLD.BundledProductID);
	DECLARE remainingIncludedProducts INT  DEFAULT (SELECT Count(*) FROM TblOrdersBOM_ItemsInclude WHERE OrderItemsID = OLD.OrderItemsID);


	IF remainingIncludedProducts = 0 THEN
		UPDATE TblOrdersBOM_Items
		SET	costPurchaseIncludedProducts = NULL,
			costPurchase                 = IF(costPurchase IS NULL, 0, costPurchase)
		WHERE OrderItemsID = OLD.OrderItemsID;
	ELSE
		UPDATE TblOrdersBOM_Items
		SET	costPurchaseIncludedProducts = costPurchaseIncludedProducts
												- (newPurchasePrice * OLD.BundledQuantity)
		WHERE OrderItemsID = OLD.OrderItemsID;
	END IF;
END
$$


DELIMITER ;





DELIMITER $$


DROP TRIGGER IF EXISTS `TblOrdersBOM_ItemsInclude_after_ins_tr1`
$$
CREATE TRIGGER `TblOrdersBOM_ItemsInclude_after_ins_tr1` AFTER INSERT ON `TblOrdersBOM_ItemsInclude` FOR EACH ROW BEGIN
	DECLARE newPurchasePrice DECIMAL(19,2) DEFAULT (SELECT Purchase_Price FROM TblProducts WHERE ProductID = NEW.BundledProductID);


	UPDATE TblOrdersBOM_Items
	SET	costPurchaseIncludedProducts = Coalesce(costPurchaseIncludedProducts, 0)
	                                        + (newPurchasePrice * NEW.BundledQuantity)
	WHERE OrderItemsID = NEW.OrderItemsID;
END
$$


DELIMITER ;




DELIMITER $$


DROP TRIGGER IF EXISTS `TblOrdersBOM_ItemsInclude_after_upd_tr1`
$$
CREATE TRIGGER `TblOrdersBOM_ItemsInclude_after_upd_tr1` AFTER UPDATE ON `TblOrdersBOM_ItemsInclude` FOR EACH ROW BEGIN
	DECLARE newPurchasePrice DECIMAL(19,2) DEFAULT (SELECT Purchase_Price FROM TblProducts WHERE ProductID = NEW.BundledProductID);


	UPDATE TblOrdersBOM_Items
	SET	costPurchaseIncludedProducts = costPurchaseIncludedProducts
											- (newPurchasePrice * OLD.BundledQuantity)
	                                        + (newPurchasePrice * NEW.BundledQuantity)
	WHERE OrderItemsID = NEW.OrderItemsID;
END
$$


DELIMITER ;







DELIMITER $$


DROP TRIGGER IF EXISTS `trg_ProductsIns`
$$
CREATE TRIGGER `trg_TblProductsIns` BEFORE INSERT ON `TblProducts` FOR EACH ROW BEGIN

IF NEW.CutAngle NOT BETWEEN 0 and 90
THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'CutAngle must be between 0 and 90.';
END IF;

END
$$


DELIMITER ;
DELIMITER $$


DROP TRIGGER IF EXISTS `trg_ProductsUpd`
$$
CREATE TRIGGER `trg_TblProductsUpd` BEFORE UPDATE ON `TblProducts` FOR EACH ROW BEGIN

IF NEW.CutAngle NOT BETWEEN 0 and 90
THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'CutAngle must be between 0 and 90.';
END IF;

END
$$


DELIMITER ;








DELIMITER $$


DROP TRIGGER IF EXISTS `ProductsAutoSuggest_before_upd_tr1`
$$
CREATE TRIGGER `TblProductsAutoSuggest_before_upd_tr1` BEFORE UPDATE ON `TblProductsAutoSuggest` FOR EACH ROW BEGIN

IF ((NEW.ProductSuggestionID IS NULL and NEW.GroupSuggestionID IS NULL)
	OR (NEW.ProductSuggestionID IS NOT NULL and NEW.GroupSuggestionID IS NOT NULL)) THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Only one of ProductSuggestionID or GroupSuggestionID must be filled.';
END IF;

IF NEW.GroupSuggestionID IS NOT NULL AND NEW.Mandatory = 1 THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Mandatory cannot be set for groups.';
END IF;

END
$$



DROP TRIGGER IF EXISTS `ProductsAutoSuggest_before_ins_tr1`
$$
CREATE TRIGGER `TblProductsAutoSuggest_before_ins_tr1` BEFORE INSERT ON `TblProductsAutoSuggest` FOR EACH ROW BEGIN

IF ((NEW.ProductSuggestionID IS NULL and NEW.GroupSuggestionID IS NULL)
	OR (NEW.ProductSuggestionID IS NOT NULL and NEW.GroupSuggestionID IS NOT NULL)) THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Only one of ProductSuggestionID or GroupSuggestionID must be filled.';
END IF;

IF NEW.GroupSuggestionID IS NOT NULL AND NEW.Mandatory = 1 THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Mandatory cannot be set for groups.';
END IF;

END
$$


DELIMITER ;















DELIMITER $$


DROP TRIGGER IF EXISTS `ProductsInclude_after_del_tr1`
$$
CREATE TRIGGER `TblProductsInclude_after_del_tr1` AFTER DELETE ON `TblProductsInclude` FOR EACH ROW BEGIN
	DECLARE newPurchasePrice DECIMAL(19,2) DEFAULT (SELECT Purchase_Price FROM TblProducts WHERE ProductID = OLD.IncludedProductID);
	DECLARE remainingIncludedProducts INT DEFAULT (SELECT Count(*) FROM TblProductsInclude WHERE ParentProductID = OLD.ParentProductID);


	IF remainingIncludedProducts = 0 THEN
		UPDATE TblProducts
		SET	PurchasePriceOfIncludedProducts = NULL,
			Purchase_Price = IF(Purchase_Price IS NULL, 0, Purchase_Price)
		WHERE ProductID = OLD.ParentProductID;
	ELSE
		UPDATE TblProducts
		SET	PurchasePriceOfIncludedProducts = PurchasePriceOfIncludedProducts
												- (newPurchasePrice * OLD.Quantity)
		WHERE ProductID = OLD.ParentProductID;
	END IF;
END
$$


DELIMITER ;
DELIMITER $$


DROP TRIGGER IF EXISTS `ProductsInclude_after_ins_tr1`
$$
CREATE TRIGGER `TblProductsInclude_after_ins_tr1` AFTER INSERT ON `TblProductsInclude` FOR EACH ROW BEGIN
	DECLARE newPurchasePrice DECIMAL(19,2) DEFAULT (SELECT Purchase_Price FROM TblProducts WHERE ProductID = NEW.IncludedProductID);


	UPDATE TblProducts
	SET	PurchasePriceOfIncludedProducts = Coalesce(PurchasePriceOfIncludedProducts, 0)
	                                        + (newPurchasePrice * NEW.Quantity)
	WHERE ProductID = NEW.ParentProductID;

END
$$


DELIMITER ;
DELIMITER $$


DROP TRIGGER IF EXISTS `ProductsInclude_after_upd_tr1`
$$
CREATE TRIGGER `TblProductsInclude_after_upd_tr1` AFTER UPDATE ON `TblProductsInclude` FOR EACH ROW BEGIN
	DECLARE newPurchasePrice DECIMAL(19,2) DEFAULT (SELECT Purchase_Price FROM TblProducts WHERE ProductID = NEW.IncludedProductID);


	UPDATE TblProducts
	SET	PurchasePriceOfIncludedProducts = PurchasePriceOfIncludedProducts
											- (newPurchasePrice * OLD.Quantity)
	                                        + (newPurchasePrice * NEW.Quantity)
	WHERE ProductID = NEW.ParentProductID;

END
$$


DELIMITER ;