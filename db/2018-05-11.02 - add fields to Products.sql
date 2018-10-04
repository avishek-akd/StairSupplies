ALTER TABLE TblProducts
	ADD COLUMN `UnitSalePrice` DECIMAL(19,2) NULL DEFAULT NULL COMMENT 'Website price - promotion' AFTER `UnitPriceNAC`,
	ADD COLUMN `UnitListPrice` DECIMAL(19,2) NULL DEFAULT NULL COMMENT 'Website price - list' AFTER `UnitSalePrice`,
	ADD COLUMN `CustomerProductName` VARCHAR(100) NULL DEFAULT NULL COMMENT 'Customer friendly name (internal names can be cryptic)' AFTER `UnitListPrice`,
	ADD COLUMN `CustomerProductDescription` VARCHAR(500) NULL DEFAULT NULL COMMENT 'Customer friendly description' AFTER `CustomerProductName`,

	CHANGE COLUMN `WebsiteURL` `StairsuppliesWebsiteURL` VARCHAR(255),
	CHANGE COLUMN `WebsiteImageURL` `StairsuppliesWebsiteImageURL` VARCHAR(200),
	ADD COLUMN `ViewrailWebsiteURL` VARCHAR(255) NULL DEFAULT NULL AFTER `StairsuppliesWebsiteImageURL`,
	ADD COLUMN `ViewrailWebsiteImageURL` VARCHAR(200) NULL DEFAULT NULL AFTER `ViewrailWebsiteURL`,
	ADD COLUMN `WebsiteImageOverrideURL` VARCHAR(200) NULL DEFAULT NULL AFTER `ViewrailWebsiteImageURL`,

	CHANGE COLUMN `StairMargin` `_unused_StairMargin` DECIMAL(10,2) NULL DEFAULT NULL
;
UPDATE TblProducts
SET
	ViewrailWebsiteImageURL = StairsuppliesWebsiteImageURL
;


ALTER TABLE TblOrdersBOM_Items
	ADD COLUMN `OrderItemCustomerBaseName` VARCHAR(100) NULL DEFAULT NULL COMMENT 'Base name (excluding features and customizations)' AFTER `OrderItemName`,
	ADD COLUMN `OrderItemCustomerName` VARCHAR(150)
			AS (concat(coalesce(OrderItemCustomerBaseName, OrderItemBaseName, ''), if((`OrderItemNameSuffix` <> ''),concat(' - ',`OrderItemNameSuffix`),''))) STORED
			COMMENT 'Customer friendly name, displayed on all places where the customer can see it' AFTER `OrderItemCustomerBaseName`,
	ADD COLUMN `OrderItemCustomerBaseDescription` VARCHAR(500) NULL DEFAULT NULL AFTER `OrderItemCustomerName`,
	ADD COLUMN `OrderItemCustomerDescription` VARCHAR(750)
			AS (concat(if((`OrderItemDescriptionPrefix` <> ''),concat(`OrderItemDescriptionPrefix`,' - '),''), coalesce(OrderItemCustomerBaseDescription, OrderItemBaseDescription, ''))) STORED
			COMMENT 'Customer friendly description' AFTER `OrderItemCustomerBaseDescription`
;



CREATE TABLE TblTaskQueue (
	`TaskQueueID` INT(10) NOT NULL AUTO_INCREMENT,
	`TaskName` VARCHAR(50) NOT NULL,
	`ProductID` INT(10) NOT NULL,

	PRIMARY KEY (`TaskQueueID`),
	INDEX `idxFK_ProductID` (`ProductID`),

	CONSTRAINT `FK_TblTaskQueue_ProductID` FOREIGN KEY (`ProductID`) REFERENCES `TblProducts` (`ProductID`) ON UPDATE NO ACTION ON DELETE NO ACTION
) Engine=Innodb COMMENT 'For now this is used to queue the task of extracting images URL\'s from Stairsupplies'
;













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
			INSERT INTO TblOrdersBOM_ItemsInclude
			(
				OrderItemsID, BundledProductID, OrderItemName, BundledQuantity, PurchasePrice
			)
			SELECT OrderItemsID, includedProduct.ProductID, includedProduct.ProductName, TblProductsInclude.Quantity, includedProduct.Purchase_Price
			FROM TblOrdersBOM_Items
				INNER JOIN TblProductsInclude             ON TblProductsInclude.ParentProductID = TblOrdersBOM_Items.ProductID
				INNER JOIN TblProducts AS includedProduct ON includedProduct.ProductID = TblProductsInclude.IncludedProductID
			WHERE TblOrdersBOM_Items.orderItemsID = varOrderItemsID
				AND EXISTS (SELECT 1 FROM TblProductsInclude WHERE TblProductsInclude.ParentProductID = TblOrdersBOM_Items.ProductID);
		END IF;
	END LOOP;


	CLOSE items;
END
$$



DELIMITER ;







CREATE OR REPLACE SQL SECURITY INVOKER VIEW `vOrderItems` AS
SELECT
	`TblOrdersBOM_Items`.`OrderItemsID`,
	`TblOrdersBOM_Items`.`OrderVersionID`,
	`TblOrdersBOM_Items`.`GroupID`,
	`TblOrdersBOM_Items`.`AutoSuggestionParentID`,
	`TblOrdersBOM_Items`.`OrderItemPricePerUnit`,
	`TblOrdersBOM_Items`.`OrderItemName`,
	`TblOrdersBOM_Items`.`OrderItemDescription`,
	`TblOrdersBOM_Items`.`OrderItemBaseDescription`,
	`TblOrdersBOM_Items`.`OrderItemCustomerName`,
	`TblOrdersBOM_Items`.`OrderItemCustomerDescription`,
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