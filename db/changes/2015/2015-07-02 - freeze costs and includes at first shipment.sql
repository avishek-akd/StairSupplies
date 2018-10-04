DELIMITER $$



ALTER TABLE `TblOrdersBOM_Items`
	ADD COLUMN `costsAreFrozen` TINYINT UNSIGNED NOT NULL DEFAULT '0' COMMENT '=1 Costs are saved to this order item, =0 costs are taken from the corresponding Product' AFTER `so_programming_complete_employeeID`,
	ADD COLUMN `costPurchase` DECIMAL(19,2) NULL COMMENT 'This is the Purchase Price of the product. If the order item has included products this is NULL' AFTER `costsAreFrozen`,
	ADD COLUMN `costPurchaseIncludedProducts` DECIMAL(19,2) NULL COMMENT 'Purchase price of the bundled products, if the order item has included products, otherwise NULL' AFTER `costPurchase`,
	ADD COLUMN `costOfLabor` DECIMAL(10,2) NULL AFTER `costPurchaseIncludedProducts`,
	ADD COLUMN `costPreFinish` DECIMAL(10,2) NULL AFTER `costOfLabor`,
	ADD COLUMN `costFinishOptionMultiplier` DECIMAL(5,2) NULL AFTER `costPreFinish`,
	ADD COLUMN `costLumberRate` DECIMAL(10,2) NULL AFTER `costFinishOptionMultiplier`,
	ADD COLUMN `costBoardFootage` DECIMAL(7,2) NULL AFTER `costLumberRate`
$$


CREATE TABLE `TblOrdersBOM_ItemsInclude` (
	`id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`OrderItemsID` INT NOT NULL,
	`BundledProductID` INT NOT NULL,
	`ProductName` VARCHAR(100) NOT NULL,
	`BundledQuantity` INT UNSIGNED NOT NULL,
	`PurchasePrice` DECIMAL(19,2) UNSIGNED NOT NULL,
	PRIMARY KEY (`id`),
	UNIQUE INDEX `Index 4` (`OrderItemsID`, `BundledProductID`),
	CONSTRAINT `FK_TblOrdersBOM_ItemsInclude_TblOrdersBOM_Items` FOREIGN KEY (`OrderItemsID`) REFERENCES `TblOrdersBOM_Items` (`OrderItemsID`),
	CONSTRAINT `FK_TblOrdersBOM_ItemsInclude_Products` FOREIGN KEY (`BundledProductID`) REFERENCES `Products` (`ProductID`)
)
COMMENT='Hold the products that are part of the bundle/deal. The included products are saved in a separate table when they are added'
COLLATE='utf8_unicode_ci'
ENGINE=InnoDB
$$



DROP VIEW IF EXISTS vOrderItemProductUnitPrice
$$
CREATE ALGORITHM=UNDEFINED SQL SECURITY INVOKER VIEW vOrderItemProductUnitPrice AS
/*
 * This view is used when retrieving the product (list) price for order items in the database.
 * NOTE: When adding a product to the database we don't have that line item saved yet so we use the function
 * fGetProductUnitPrice to get the per unit product price.
 */
SELECT orderItemsId,
		IF(`Customers`.`CustomerTypeID` = 14,
			`Products`.`UnitPriceNAC`,
			IF(`TblOrdersBOM`.`CompanyID` = 4, `Products`.`UnitPriceViewrail`, `Products`.`UnitPrice`)
		) AS productUnitPrice
FROM TblOrdersBOM_Items
	INNER JOIN Products        ON Products.productID = TblOrdersBOM_Items.productID
	INNER JOIN TblOrdersBOM    ON TblOrdersBOM.orderID = TblOrdersBOM_Items.orderID
	INNER JOIN CustomerContact ON CustomerContact.CustomerContactID = TblOrdersBOM.CustomerContactID
	INNER JOIN Customers       ON Customers.CustomerID = CustomerContact.CustomerID
$$


DROP VIEW IF EXISTS vOrderItemPrice
$$
CREATE ALGORITHM=UNDEFINED SQL SECURITY INVOKER VIEW vOrderItemPrice AS
SELECT orderItemsId,
		Round(unitPrice * (1 - discountPercent), 2) AS unitPriceDiscounted,
		Round(unitPrice * discountPercent, 2) AS unitDiscountAmount
FROM TblOrdersBOM_Items
$$


DROP VIEW IF EXISTS vOrderItemCosts
$$
CREATE ALGORITHM=UNDEFINED SQL SECURITY INVOKER VIEW vOrderItemCosts AS
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
		Round(
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
				),
			2) AS costPerUnit
FROM TblOrdersBOM_Items AS OBOMI
	INNER JOIN Products                 ON Products.productID = OBOMI.productID
	LEFT JOIN FinishOption              ON FinishOption.id = OBOMI.FinishOptionID
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
       `FinishOption`.`FinishImage` AS `FinishImage`,
       `FinishOption`.`title` AS `finishOptionTitle`,
       `Products`.`Unit_of_Measure` AS `Unit_of_Measure`,
       `Products`.`ProductType_id` AS `ProductType_Id`,
       `Products`.`ProductID` AS `ProductID`
from `TblOrdersBOM_Items`
	INNER JOIN vOrderItemPrice ON vOrderItemPrice.OrderItemsID = TblOrdersBOM_Items.OrderItemsID
     left join `Products`      on `Products`.`ProductID` = `TblOrdersBOM_Items`.`ProductID`
     left join `tbl_wood_type` on `tbl_wood_type`.`id` = `Products`.`WoodTypeID`
     left join `FinishOption`  on `FinishOption`.`id` = `TblOrdersBOM_Items`.`FinishOptionID`
order by `TblOrdersBOM_Items`.`OrderItemsID`
$$



DROP FUNCTION IF EXISTS fGetProductUnitPrice
$$
CREATE FUNCTION `fGetProductUnitPrice`(
        `companyID` INTEGER,
        `CustomerTypeID` INTEGER,
        `unitPrice` DECIMAL(19,2),
        `unitPriceViewrail` DECIMAL(19,2),
        `unitPriceNAC` DECIMAL(19,2)
    )
    RETURNS decimal(19,2)
    DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY INVOKER
    COMMENT ''
BEGIN
	/*  This function returns the proper per unit product price, depending on who the customer is
	 * and the company that we're adding this order for.  */

	DECLARE CUSTOMER_TYPE_NAC INT DEFAULT 14;
    DECLARE COMPANY_VIEWRAIL INT DEFAULT 4;

	IF ( CustomerTypeID = CUSTOMER_TYPE_NAC ) THEN
		RETURN unitPriceNAC;
	ELSE
		BEGIN
			IF ( companyID = COMPANY_VIEWRAIL ) THEN
				RETURN unitPriceViewrail;
			ELSE
				RETURN unitPrice;
			END IF;
		END;
	END IF;
END
$$


CREATE FUNCTION `_unused_fUnitCost`(
        Purchase_price DECIMAL(19,2),
        LaborCost DECIMAL(10,2),
        PreFinishCost DECIMAL(10,2),
        lumber_rate DECIMAL(10,2),
        boardFootage DECIMAL(7,2)
    )
    RETURNS decimal(19,2)
    DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY INVOKER
    COMMENT ''
BEGIN
	RETURN Purchase_price + LaborCost + PreFinishCost + Coalesce(lumber_rate * boardFootage, 0);
END
$$
DROP FUNCTION `fUnitCost`
$$


CREATE FUNCTION `_unused_fUnitDiscount`(
        `unitPrice` DECIMAL(19,4),
        `discountPercent` DECIMAL(10,4)
    )
    RETURNS decimal(19,4)
    DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY INVOKER
    COMMENT ''
RETURN Round(unitPrice * discountPercent, 2)
$$
DROP FUNCTION `fUnitDiscount`
$$



CREATE FUNCTION `_unused_fUnitPriceWithDiscount`(
        `unitPrice` DECIMAL(19,4),
        `discountPercent` DECIMAL(10,4)
    )
    RETURNS decimal(19,4)
    DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY INVOKER
    COMMENT ''
RETURN Round(unitPrice * (1 - discountPercent), 2)
$$
DROP FUNCTION `fUnitPriceWithDiscount`
$$


CREATE FUNCTION `_unused_fPreFinishCost`(
        finishTitle VARCHAR(100),
        preFinishCost DECIMAL(10,2),
        finishOptionMultiplier DECIMAL(5,2)
    )
    RETURNS decimal(10,2)
    DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY INVOKER
    COMMENT ''
RETURN IF(finishTitle IS NULL, 0, preFinishCost * Coalesce(finishOptionMultiplier, 0))
$$
DROP FUNCTION `fPreFinishCost`
$$


CREATE FUNCTION `_unused_fItemPriceWithDiscount`(
        `unitPrice` DECIMAL(19,4),
        `discountPercent` DECIMAL(10,4),
        quantity DECIMAL(10,2)
    )
    RETURNS decimal(19,4)
    DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY INVOKER
    COMMENT ''
RETURN Round(unitPrice * (1 - discountPercent), 2) * quantity
$$
DROP FUNCTION `fItemPriceWithDiscount`
$$



DROP PROCEDURE IF EXISTS spPricePerCategory
$$
CREATE PROCEDURE `spPricePerCategory`(
        IN `orderID` INTEGER(11)
    )
    DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY INVOKER
    COMMENT ''
BEGIN
SELECT TblProductTypeType.title, Coalesce(total, 0) AS total
FROM TblProductTypeType
	INNER JOIN TblProductType ON TblProductTypeType.id = TblProductType.ProductTypeTypeId
	LEFT JOIN (
				SELECT ProductTypeTypeId, Sum( vOrderItemPrice.unitPriceDiscounted * OBOMI.quantityOrdered ) AS total
				FROM TblOrdersBOM_Items AS OBOMI
					INNER JOIN Products        ON OBOMI.ProductID = Products.productID
					INNER JOIN TblProductType  ON TblProductType.ProductType_id = Products.ProductType_id
					INNER JOIN vOrderItemPrice ON vOrderItemPrice.OrderItemsID = OBOMI.OrderItemsID
				WHERE OBOMI.OrderId = orderID
				GROUP BY TblProductType.ProductTypeTypeId
				) AS ExistingItemsTypes ON ExistingItemsTypes.ProductTypeTypeId = TblProductTypeType.id
GROUP BY TblProductTypeType.title
ORDER BY TblProductTypeType.id ASC;
END
$$


DROP PROCEDURE IF EXISTS spFreezeItemsCostsAndIncludedProducts
$$
CREATE PROCEDURE `spFreezeItemsCostsAndIncludedProducts`(
        IN orderID INTEGER(11)
    )
    NOT DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY INVOKER
    COMMENT 'For the passed order freeze costs and bundled/included products for items that have at least 1 shipped piece (1 shipped shipment).'
BEGIN
    DECLARE done INT DEFAULT FALSE;
    
    /*  Prefix variables with 'var' to differentiate them from columns  */
    DECLARE varOrderItemsID INT;
    DECLARE varCostPurchase DECIMAL(19,2);
    DECLARE varCostPurchaseIncludedProducts DECIMAL(19,2);
    DECLARE varCostOfLabor DECIMAL(19,2);
    DECLARE varCostPreFinish DECIMAL(19,2);
    DECLARE varCostFinishOptionMultiplier DECIMAL(19,2);
    DECLARE varCostLumberRate DECIMAL(19,2);
    DECLARE varCostBoardFootage DECIMAL(19,2);

	/*
    Process items that:
    - belong to the current order
    - are unprocessed (costs are still taken from the Products table)
    - have at least 1 *shipped* shipment piece
    */
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

		/*  Use a temporary table instead of 'INSERT INTO ... SELECT' because MySQL throws
        error 1442 about the triggers on TblOrdersBOM_ItemsInclude  */
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
                (OrderItemsID, BundledProductID, ProductName, BundledQuantity, PurchasePrice)
            SELECT OrderItemsID, ProductID, ProductName, Quantity, Purchase_Price
            FROM temporaryIncludedProducts;
            
            DROP TEMPORARY TABLE temporaryIncludedProducts;
        END IF;
	END LOOP;


    CLOSE items;
END
$$



CREATE TRIGGER `TblOrdersBOM_ItemsInclude_after_ins_tr1` AFTER INSERT ON `TblOrdersBOM_ItemsInclude`
  FOR EACH ROW
BEGIN
	DECLARE newPurchasePrice DECIMAL(19,2) DEFAULT (SELECT Purchase_Price FROM Products WHERE ProductID = NEW.BundledProductID);

	
	UPDATE TblOrdersBOM_Items
	SET	costPurchaseIncludedProducts = Coalesce(costPurchaseIncludedProducts, 0)
	                                        + (newPurchasePrice * NEW.BundledQuantity)
	WHERE OrderItemsID = NEW.OrderItemsID;
END
$$
CREATE TRIGGER `TblOrdersBOM_ItemsInclude_after_upd_tr1` AFTER UPDATE ON `TblOrdersBOM_ItemsInclude`
  FOR EACH ROW
BEGIN
	DECLARE newPurchasePrice DECIMAL(19,2) DEFAULT (SELECT Purchase_Price FROM Products WHERE ProductID = NEW.BundledProductID);

	
	UPDATE TblOrdersBOM_Items
	SET	costPurchaseIncludedProducts = costPurchaseIncludedProducts
											- (newPurchasePrice * OLD.BundledQuantity)
	                                        + (newPurchasePrice * NEW.BundledQuantity)
	WHERE OrderItemsID = NEW.OrderItemsID;
END
$$
CREATE TRIGGER `TblOrdersBOM_ItemsInclude_after_del_tr1` AFTER DELETE ON `TblOrdersBOM_ItemsInclude`
  FOR EACH ROW
BEGIN
	DECLARE newPurchasePrice DECIMAL(19,2) DEFAULT (SELECT Purchase_Price FROM Products WHERE ProductID = OLD.BundledProductID);
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













DROP PROCEDURE IF EXISTS tmpFreezeOrderItemsCosts
$$
CREATE PROCEDURE `tmpFreezeOrderItemsCosts`(
    )
    NOT DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY INVOKER
    COMMENT 'Temporary SP to iterate over all orders and freeze the costs and bundled products.'
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE varOrderID INT;

    DECLARE orders CURSOR FOR
							SELECT OrderID
							FROM TblOrdersBOM
							WHERE EXISTS (SELECT 1
											FROM TblOrdersBOM_Items
											WHERE costsAreFrozen = 0
												AND TblOrdersBOM_Items.OrderID = TblOrdersBOM.OrderID
										);
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done := TRUE;


    OPEN orders;

	read_loop:
	LOOP
        FETCH orders INTO varOrderID;
        IF done THEN
          LEAVE read_loop;
        END IF;

        CALL spFreezeItemsCostsAndIncludedProducts(varOrderID);
	END LOOP;


    CLOSE orders;
END
$$
CALL tmpFreezeOrderItemsCosts()
$$
DROP PROCEDURE IF EXISTS tmpFreezeOrderItemsCosts
$$



DELIMITER ;