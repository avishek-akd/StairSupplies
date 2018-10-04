CREATE TABLE `TblOrdersBOM_Version` (
	`OrderVersionID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`OrderID` INT(10) NOT NULL,
	`Description` VARCHAR(50) NOT NULL,
	`RecordCreated` DATETIME NOT NULL,
	`RecordUpdated` DATETIME NULL DEFAULT NULL,
	PRIMARY KEY (`OrderVersionID`),
	INDEX `idx_OrderID` (`OrderID`),
	CONSTRAINT `FK_TblOrdersBOM_Version_TblOrdersBOM` FOREIGN KEY (`OrderID`) REFERENCES `TblOrdersBOM` (`OrderID`) ON UPDATE NO ACTION ON DELETE NO ACTION
) ENGINE=INNODB
;


CREATE TABLE `TblOrdersBOM_ActiveVersion` (
	`OrderID` INT(10) NOT NULL,
	`OrderVersionID` INT UNSIGNED NOT NULL,
	`RecordCreated` DATETIME NOT NULL,
	`RecordUpdated` DATETIME NULL DEFAULT NULL,
	PRIMARY KEY (`OrderID`, `OrderVersionID`),
	UNIQUE `idx_OrderID`(`OrderID`),
	UNIQUE `idx_OrderVersionID`(`OrderVersionID`),
	CONSTRAINT `FK_TblOrdersBOM_ActiveVersion_TblOrdersBOM` FOREIGN KEY (`OrderID`) REFERENCES `TblOrdersBOM` (`OrderID`) ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT `FK_TblOrdersBOM_ActiveVersion_TblOrdersBOM_Version` FOREIGN KEY (`OrderVersionID`) REFERENCES `TblOrdersBOM_Version` (`OrderVersionID`) ON UPDATE NO ACTION ON DELETE NO ACTION
) ENGINE=INNODB
;



--  Each order gets a default active version
INSERT INTO TblOrdersBOM_Version
	(OrderID, Description, RecordCreated)
SELECT OrderID, 'Default', Now()
FROM TblOrdersBOM
ORDER BY OrderID ASC
;
INSERT INTO TblOrdersBOM_ActiveVersion
	(OrderID, OrderVersionID, RecordCreated)
SELECT OrderID, OrderVersionID, Now()
FROM TblOrdersBOM_Version
ORDER BY OrderID ASC
;



ALTER TABLE `TblOrdersBOM_Items`
	CHANGE COLUMN `OrderID` `_unused_OrderID` INT(10) NULL DEFAULT NULL COMMENT 'Old column linking items directly to orders. Items are linked to order-versions now.'
;
ALTER TABLE `TblOrdersBOM_Items`
	ADD COLUMN `OrderVersionID` INT UNSIGNED NULL DEFAULT NULL AFTER `_unused_OrderID`,
	ADD INDEX `idx_OrderVersionID` (`OrderVersionID`),
	ADD CONSTRAINT `FK_TblOrdersBOM_Items_TblOrdersBOM_Version` FOREIGN KEY (`OrderVersionID`) REFERENCES `TblOrdersBOM_Version` (`OrderVersionID`) ON UPDATE NO ACTION ON DELETE CASCADE
;


ALTER TABLE `TblOrdersBOM_Groups`
	CHANGE COLUMN `OrderID` `_unused_OrderID` INT(10) NULL DEFAULT NULL COMMENT 'Old column linking groups directly to orders. Groups are linked to order-versions now.'
;
ALTER TABLE `TblOrdersBOM_Groups`
	ADD COLUMN `OrderVersionID` INT UNSIGNED NULL DEFAULT NULL AFTER `_unused_OrderID`,
	ADD INDEX `idx_OrderVersionID` (`OrderVersionID`),
	ADD CONSTRAINT `FK_TblOrdersBOM_Groups_TblOrdersBOM_Version` FOREIGN KEY (`OrderVersionID`) REFERENCES `TblOrdersBOM_Version` (`OrderVersionID`) ON UPDATE NO ACTION ON DELETE CASCADE
;


UPDATE TblOrdersBOM_Items
SET OrderVersionID = (SELECT OrderVersionID FROM TblOrdersBOM_ActiveVersion WHERE TblOrdersBOM_ActiveVersion.OrderID = TblOrdersBOM_Items._unused_OrderID)
;
UPDATE TblOrdersBOM_Groups
SET OrderVersionID = (SELECT OrderVersionID FROM TblOrdersBOM_ActiveVersion WHERE TblOrdersBOM_ActiveVersion.OrderID = TblOrdersBOM_Groups._unused_OrderID)
;


ALTER TABLE `TblOrdersBOM_Items`
	CHANGE COLUMN `OrderVersionID` `OrderVersionID` INT UNSIGNED NOT NULL
;
ALTER TABLE `TblOrdersBOM_Groups`
	CHANGE COLUMN `OrderVersionID` `OrderVersionID` INT UNSIGNED NOT NULL
;



ALTER TABLE `TblOrdersBOM`
	ADD COLUMN `CustomerSelectedVersionID` INT UNSIGNED NULL DEFAULT NULL COMMENT 'What version did the customer select' AFTER `CustomerQuotationPONumber`,
	ADD INDEX `idx_CustomerSelectedVersionID`(`CustomerSelectedVersionID`),
	ADD CONSTRAINT `FK_TblOrdersBOM_TblOrdersBOM_Version` FOREIGN KEY (`CustomerSelectedVersionID`) REFERENCES `TblOrdersBOM_Version` (`OrderVersionID`) ON UPDATE NO ACTION ON DELETE NO ACTION
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
		INNER JOIN TblOrdersBOM_ActiveVersion ON TblOrdersBOM_ActiveVersion.OrderVersionID = TblOrdersBOM_Items.OrderVersionID
		INNER JOIN TblProducts                ON TblProducts.ProductID = TblOrdersBOM_Items.ProductID
		LEFT JOIN TblMaterial                 ON TblMaterial.id = TblProducts.MaterialID
	WHERE TblOrdersBOM_ActiveVersion.OrderID = orderID;

	RETURN Result;
END
$$



DELIMITER ;
DELIMITER $$



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
		INNER JOIN TblOrdersBOM_ActiveVersion ON TblOrdersBOM_ActiveVersion.OrderVersionID = TblOrdersBOM_Items.OrderVersionID
		INNER JOIN TblProducts                ON TblProducts.ProductID = TblOrdersBOM_Items.ProductID
		LEFT JOIN TblMaterial                 ON TblMaterial.id = TblProducts.MaterialID
	WHERE TblOrdersBOM_ActiveVersion.OrderID = orderID;

	RETURN Result;
END
$$



DELIMITER ;
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
						SELECT AccountingTypeID,
							Sum( vOrderItemPrice.unitPriceDiscounted * TblOrdersBOM_Items.quantityOrdered ) AS perAccountingTypeSubtotal
						FROM TblOrdersBOM_Items
							INNER JOIN TblOrdersBOM_ActiveVersion ON TblOrdersBOM_ActiveVersion.OrderVersionID = TblOrdersBOM_Items.OrderVersionID
							INNER JOIN TblProducts                ON TblOrdersBOM_Items.ProductID = TblProducts.productID
							INNER JOIN TblProductType             ON TblProductType.ProductType_id = TblProducts.ProductType_id
							INNER JOIN vOrderItemPrice            ON vOrderItemPrice.OrderItemsID = TblOrdersBOM_Items.OrderItemsID
						WHERE TblOrdersBOM_ActiveVersion.OrderID = argOrderID
						GROUP BY TblProductType.AccountingTypeID

					UNION
						--  We need a separate sum for "Sales tax" because it applies to all products and we need to not include tax exempt products
						SELECT 9 AS AccountingTypeID,
							Sum( vOrderItemPrice.unitPriceDiscounted * TblOrdersBOM_Items.quantityOrdered ) AS perAccountingTypeSubtotal
						FROM TblOrdersBOM_Items
							INNER JOIN TblOrdersBOM_ActiveVersion ON TblOrdersBOM_ActiveVersion.OrderVersionID = TblOrdersBOM_Items.OrderVersionID
							INNER JOIN vOrderItemPrice            ON vOrderItemPrice.OrderItemsID = TblOrdersBOM_Items.OrderItemsID
							INNER JOIN TblProducts                ON TblOrdersBOM_Items.ProductID = TblProducts.productID
							INNER JOIN TblProductType             ON TblProductType.ProductType_id = TblProducts.ProductType_id
						WHERE TblOrdersBOM_ActiveVersion.OrderID = argOrderID
							AND TblProductType.isTaxExempt = 0

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
						SELECT AccountingTypeID,
							Sum( vOrderItemPrice.unitPriceDiscounted * TblOrdersBOM_Items.quantityOrdered ) AS perAccountingTypeSubtotal
						FROM TblOrdersBOM_Items
							INNER JOIN TblOrdersBOM_Version ON TblOrdersBOM_Version.OrderVersionID = TblOrdersBOM_Items.OrderVersionID
							INNER JOIN TblProducts          ON TblOrdersBOM_Items.ProductID = TblProducts.productID
							INNER JOIN TblProductType       ON TblProductType.ProductType_id = TblProducts.ProductType_id
							INNER JOIN vOrderItemPrice      ON vOrderItemPrice.OrderItemsID = TblOrdersBOM_Items.OrderItemsID
						WHERE TblOrdersBOM_Items.OrderVersionID = argOrderVersionID
						GROUP BY TblProductType.AccountingTypeID

					UNION
						--  We need a separate sum for "Sales tax" because it applies to all products and we need to not include tax exempt products
						SELECT 9 AS AccountingTypeID,
							Sum( vOrderItemPrice.unitPriceDiscounted * TblOrdersBOM_Items.quantityOrdered ) AS perAccountingTypeSubtotal
						FROM TblOrdersBOM_Items
							INNER JOIN TblOrdersBOM_Version ON TblOrdersBOM_Version.OrderVersionID = TblOrdersBOM_Items.OrderVersionID
							INNER JOIN vOrderItemPrice      ON vOrderItemPrice.OrderItemsID = TblOrdersBOM_Items.OrderItemsID
							INNER JOIN TblProducts          ON TblOrdersBOM_Items.ProductID = TblProducts.productID
							INNER JOIN TblProductType       ON TblProductType.ProductType_id = TblProducts.ProductType_id
						WHERE TblOrdersBOM_Items.OrderVersionID = argOrderVersionID
							AND TblProductType.isTaxExempt = 0

					) AS ExistingItemsTypes ON ExistingItemsTypes.AccountingTypeID = TblProductTypeAccountingType.id
	ORDER BY SortOrder ASC;

END
$$


DELIMITER ;






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
	INNER JOIN TblOrdersBOM_Version ON TblOrdersBOM_Version.OrderVersionID = OBOMI.OrderVersionID
	INNER JOIN TblOrdersBOM         ON TblOrdersBOM.OrderID = TblOrdersBOM_Version.OrderID
	LEFT JOIN TblEmployee           ON TblEmployee.EmployeeID = TblOrdersBOM.SalesmanEmployeeID
	INNER JOIN TblProducts          ON TblProducts.productID = OBOMI.productID
	LEFT JOIN TblFinishOption       ON TblFinishOption.id = OBOMI.FinishOptionID
	LEFT JOIN TblMaterial           ON TblMaterial.id = TblProducts.MaterialID
	LEFT JOIN TblMaterialSizeLink   ON (TblMaterialSizeLink.d_material_id = TblProducts.MaterialID
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
	INNER JOIN TblProducts          ON TblProducts.productID = TblOrdersBOM_Items.productID
	INNER JOIN TblOrdersBOM_Version ON TblOrdersBOM_Version.OrderVersionID = TblOrdersBOM_Items.OrderVersionID
	INNER JOIN TblOrdersBOM         ON TblOrdersBOM.orderID = TblOrdersBOM_Version.OrderID
	INNER JOIN TblCustomerContact   ON TblCustomerContact.CustomerContactID = TblOrdersBOM.CustomerContactID
	INNER JOIN TblCustomer          ON TblCustomer.CustomerID = TblCustomerContact.CustomerID
;





CREATE OR REPLACE SQL SECURITY INVOKER VIEW `vOrderItems` AS
SELECT
	`TblOrdersBOM_Items`.`OrderItemsID`,
	`TblOrdersBOM_Items`.`OrderVersionID`,
	`TblOrdersBOM_Items`.`GroupID`,
	`TblOrdersBOM_Items`.`AutoSuggestionParentID`,
	`TblOrdersBOM_Items`.`OrderItemPricePerUnit`,
	`TblOrdersBOM_Items`.`OrderItemName`,
	`TblOrdersBOM_Items`.`OrderItemDescription`,
	`TblOrdersBOM_Items`.`In_House_Notes`,
	`TblOrdersBOM_Items`.`Customer_Notes`,
	`TblOrdersBOM_Items`.`PostNumbersList`,
	`TblOrdersBOM_Items`.`HandrailNumbersList`,
	`TblOrdersBOM_Items`.`GlassPanelNumbersList`,
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




CREATE OR REPLACE SQL SECURITY INVOKER VIEW `vShipWorksOrders` AS
SELECT
	TblOrdersBOM.OrderID, TblOrdersBOM.RecordCreated, Coalesce(TblOrdersBOM.RecordUpdated, TblOrdersBOM.RecordCreated) AS RecordUpdated,

	BillCompanyName, BillContactFirstName, BillContactLastName,
	BillContactFullName AS BillFullName,
	BillAddress1, BillAddress2, BillAddress3, BillCity, BillState,
	BillStateOther, BillPostalCode, billingCountry.Name AS BillCountryName,
	BillPhoneNumber, BillFaxNumber, BillCellPhone, BillEmails AS BillEmail,

	ShipCompanyName, ShipContactFirstName, ShipContactLastName,
	ShipContactFullName AS ShipFullName,
	ShipAddress1, ShipAddress2, ShipAddress3, ShipCity, ShipState,
	ShipStateOther, ShipPostalCode, shippingCountry.Name AS ShipCountryName,
	ShipPhoneNumber, ShipFaxNumber, ShipCellPhone, ShipEmails AS ShipEmail

FROM TblOrdersBOM
	LEFT JOIN TblOrdersBOM_Shipments        ON TblOrdersBOM_Shipments.OrderID = TblOrdersBOM.OrderID
	LEFT JOIN TblCountry AS billingCountry  ON billingCountry.id = BillCountryId
	LEFT JOIN TblCountry AS shippingCountry ON shippingCountry.id = ShipCountryId
;