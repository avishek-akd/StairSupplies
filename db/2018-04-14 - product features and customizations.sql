CREATE TABLE TblProductFeature (
	`FeatureID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`FeatureName` VARCHAR(100) NOT NULL,
	`NameSuffix` VARCHAR(20) NOT NULL COMMENT 'Short amount of text added at the end of the product name',
	`DescriptionPrefix` VARCHAR(100) NOT NULL COMMENT 'Text added at the beginning of product description',
	`AdditionalUnitPrice` DECIMAL(19,4) NOT NULL,
	`AdditionalLaborCost` DECIMAL(10,2) NOT NULL,
	`AccountingTypeID` INT(10) UNSIGNED NOT NULL,
	`Image` VARCHAR(100) NULL DEFAULT NULL,
	`RecordCreated` DATETIME NOT NULL,
	`RecordUpdated` DATETIME NULL DEFAULT NULL,
	PRIMARY KEY (`FeatureID`),
	INDEX `idxFK_AccountingTypeID` (`AccountingTypeID`),
	CONSTRAINT `FK_TblProductFeature_AccountingTypeID` FOREIGN KEY (`AccountingTypeID`) REFERENCES `TblProductTypeAccountingType` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION
) Engine=Innodb
;

INSERT INTO TblProductFeature (
	FeatureName, NameSuffix, DescriptionPrefix, AdditionalUnitPrice, AdditionalLaborCost, AccountingTypeID, Image, RecordCreated
)
SELECT 'Hand Scraped', 'HS', 'Hand Scraped Finish', 15, 7.50, 2, 'HS.jpg', Now()
UNION ALL
SELECT 'Distressed', 'DIST', 'Distressed Finish', 20, 10, 2, 'Dist.jpg', Now()
UNION ALL
SELECT 'Under Mount Milling - Left Hand', 'UM Milling - LH', 'Left hand side milled for under mount posts', 8, 5, 2, NULL, Now()
UNION ALL
SELECT 'Industrial Mono Stringer Milling', 'Ind Mono Stringer', 'Milling in underside of tread for Industrial Mono Stringer', 15, 9, 2, NULL, Now()
;

CREATE TABLE TblProductFeatureProductType (
	`FeatureID` INT UNSIGNED NOT NULL,
	`ProductTypeID` INT(10) NOT NULL,
	PRIMARY KEY (`FeatureID`, `ProductTypeID`),
	INDEX `idxFK_ProductTypeID` (`ProductTypeID`),
	CONSTRAINT `FK_TblProductFeatureProductType_FeatureID` FOREIGN KEY (`FeatureID`) REFERENCES `TblProductFeature` (`FeatureID`) ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT `FK_TblProductFeatureProductType_ProductTypeID` FOREIGN KEY (`ProductTypeID`) REFERENCES `TblProductType` (`ProductType_id`) ON UPDATE NO ACTION ON DELETE NO ACTION
) Engine=Innodb
;

CREATE TABLE TblOrdersBOM_ItemsFeature (
	`OrderItemsID` INT(10) NOT NULL,
	`FeatureID` INT UNSIGNED NOT NULL,
	`NameSuffix` VARCHAR(20) NOT NULL COMMENT 'Short amount of text added at the end of the product name',
	`DescriptionPrefix` VARCHAR(100) NOT NULL COMMENT 'Text added at the beginning of product description',
	`AdditionalUnitPrice` DECIMAL(19,4) NOT NULL,
	`AdditionalLaborCost` DECIMAL(10,2) NOT NULL,
	`RecordCreated` DATETIME NOT NULL,
	PRIMARY KEY (`OrderItemsID`, `FeatureID`),
	INDEX `idxFK_FeatureID` (`FeatureID`),
	CONSTRAINT `FK_TblOrdersBOM_ItemsFeature_OrderItemsID` FOREIGN KEY (`OrderItemsID`) REFERENCES `TblOrdersBOM_Items` (`OrderItemsID`) ON UPDATE NO ACTION ON DELETE CASCADE,
	CONSTRAINT `FK_TblOrdersBOM_ItemsFeature_FeatureID` FOREIGN KEY (`FeatureID`) REFERENCES `TblProductFeature` (`FeatureID`) ON UPDATE NO ACTION ON DELETE NO ACTION
) Engine=Innodb
;




CREATE TABLE TblProductCustomization (
	`CustomizationID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`CustomizationName` VARCHAR(100) NOT NULL,
	`NameSuffix` VARCHAR(20) NOT NULL COMMENT 'Short amount of text added at the end of the product name',
	`DescriptionPrefix` VARCHAR(100) NOT NULL COMMENT 'Text added at the beginning of product description',
	`AdditionalUnitPrice` DECIMAL(19,4) NOT NULL,
	`AdditionalLaborCost` DECIMAL(10,2) NOT NULL,
	`AccountingTypeID` INT(10) UNSIGNED NOT NULL,
	`RecordCreated` DATETIME NOT NULL,
	`RecordUpdated` DATETIME NULL DEFAULT NULL,
	PRIMARY KEY (`CustomizationID`),
	INDEX `idxFK_AccountingTypeID` (`AccountingTypeID`),
	CONSTRAINT `FK_TblProductCustomization_AccountingTypeID` FOREIGN KEY (`AccountingTypeID`) REFERENCES `TblProductTypeAccountingType` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION
) Engine=Innodb
;

INSERT INTO TblProductCustomization (
	CustomizationName, NameSuffix, DescriptionPrefix, AdditionalUnitPrice, AdditionalLaborCost, AccountingTypeID, RecordCreated
)
SELECT 'Custom Foot - Large', 'CFL', 'Larger than standard foot.', 20, 8, 5, Now()
UNION ALL
SELECT 'Custom Foot - Small', 'CFS', 'Smaller than standard foot.', 12, 6, 5, Now()
;

CREATE TABLE TblProductCustomizationProductType (
	`CustomizationID` INT UNSIGNED NOT NULL,
	`ProductTypeID` INT(10) NOT NULL,
	PRIMARY KEY (`CustomizationID`, `ProductTypeID`),
	INDEX `idxFK_ProductTypeID` (`ProductTypeID`),
	CONSTRAINT `FK_TblProductCustomizationProductType_CustomizationID` FOREIGN KEY (`CustomizationID`) REFERENCES `TblProductCustomization` (`CustomizationID`) ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT `FK_TblProductCustomizationProductType_ProductTypeID` FOREIGN KEY (`ProductTypeID`) REFERENCES `TblProductType` (`ProductType_id`) ON UPDATE NO ACTION ON DELETE NO ACTION
) Engine=Innodb
;

CREATE TABLE TblOrdersBOM_ItemsCustomization (
	`OrderItemsID` INT(10) NOT NULL,
	`CustomizationID` INT UNSIGNED NOT NULL,
	`NameSuffix` VARCHAR(20) NOT NULL COMMENT 'Short amount of text added at the end of the product name',
	`DescriptionPrefix` VARCHAR(100) NOT NULL COMMENT 'Text added at the beginning of product description',
	`AdditionalUnitPrice` DECIMAL(19,4) NOT NULL,
	`AdditionalLaborCost` DECIMAL(10,2) NOT NULL,
	`Image` VARCHAR(100) NULL DEFAULT NULL,
	`RecordCreated` DATETIME NOT NULL,
	PRIMARY KEY (`OrderItemsID`, `CustomizationID`),
	INDEX `idxFK_CustomizationID` (`CustomizationID`),
	CONSTRAINT `FK_TblOrdersBOM_ItemsCustomization_OrderItemsID` FOREIGN KEY (`OrderItemsID`) REFERENCES `TblOrdersBOM_Items` (`OrderItemsID`) ON UPDATE NO ACTION ON DELETE CASCADE,
	CONSTRAINT `FK_TblOrdersBOM_ItemsCustomization_CustomizationID` FOREIGN KEY (`CustomizationID`) REFERENCES `TblProductCustomization` (`CustomizationID`) ON UPDATE NO ACTION ON DELETE NO ACTION
) Engine=Innodb
;






ALTER TABLE TblOrdersBOM_Items
	CHANGE COLUMN `OrderItemName` `OrderItemBaseName` VARCHAR(100) NULL DEFAULT NULL,
	ADD COLUMN `OrderItemNameSuffix` VARCHAR(50) NOT NULL DEFAULT '' COMMENT 'Features and customizations additional name. Updated by triggers.' AFTER `OrderItemBaseName`,
	ADD COLUMN `OrderItemName` VARCHAR(150) GENERATED ALWAYS
			AS (Concat(Coalesce(OrderItemBaseName, ''), IF(OrderItemNameSuffix <> '', Concat(' - ', OrderItemNameSuffix), ''))) STORED NOT NULL AFTER `OrderItemNameSuffix`,

	CHANGE COLUMN `OrderItemDescription` `OrderItemBaseDescription` VARCHAR(500) NULL DEFAULT NULL,
	ADD COLUMN `OrderItemDescriptionPrefix` VARCHAR(250) NOT NULL DEFAULT '' AFTER `OrderItemBaseDescription`,
	ADD COLUMN `OrderItemDescription` VARCHAR(750) GENERATED ALWAYS
			AS (Concat(IF(OrderItemDescriptionPrefix <> '', Concat(OrderItemDescriptionPrefix, ' - '), ''), Coalesce(OrderItemBaseDescription, ''))) STORED NOT NULL AFTER `OrderItemDescriptionPrefix`
;


ALTER TABLE TblOrdersBOM_Items
	CHANGE COLUMN `OrderItemPricePerUnit` `OrderItemBasePrice` DECIMAL(19,4) NOT NULL DEFAULT 0 COMMENT 'Unit price excluding features and customizations, excluding discount',
	ADD COLUMN `OrderItemFeaturesAndCustomizationsPrice` DECIMAL(19,4) NOT NULL DEFAULT 0 COMMENT 'Sum of features and customizations price per unit, excluding discount' AFTER `OrderItemBasePrice`,
	ADD COLUMN `OrderItemPricePerUnit` DECIMAL(19,4) GENERATED ALWAYS
			AS (OrderItemBasePrice + OrderItemFeaturesAndCustomizationsPrice) STORED NOT NULL AFTER `OrderItemFeaturesAndCustomizationsPrice`,

	ADD COLUMN `costOfFeaturesAndCustomizations` DECIMAL(10,2) NOT NULL DEFAULT 0 AFTER `costGeneral`
;









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
							--  Here we use the base price, without features or customizations because those might be part
							SELECT AccountingTypeID,
								Sum( OrderItemBasePrice * (1 - DiscountPercent) * TblOrdersBOM_Items.quantityOrdered ) AS perAccountingTypeSubtotal
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

							SELECT AccountingTypeID,
								Sum( TblOrdersBOM_ItemsFeature.AdditionalUnitPrice * (1 - DiscountPercent) * TblOrdersBOM_Items.quantityOrdered ) AS perAccountingTypeSubtotal
							FROM TblOrdersBOM_Items
								INNER JOIN TblOrdersBOM_ActiveVersion ON TblOrdersBOM_ActiveVersion.OrderVersionID = TblOrdersBOM_Items.OrderVersionID
								INNER JOIN TblOrdersBOM_ItemsFeature  ON TblOrdersBOM_ItemsFeature.OrderItemsID = TblOrdersBOM_Items.OrderItemsID
								INNER JOIN TblProductFeature          ON TblProductFeature.FeatureID = TblOrdersBOM_ItemsFeature.FeatureID
							WHERE TblOrdersBOM_ActiveVersion.OrderID = argOrderID
							GROUP BY AccountingTypeID

						UNION

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
							SELECT AccountingTypeID,
								Sum( OrderItemBasePrice * (1 - DiscountPercent) * TblOrdersBOM_Items.quantityOrdered ) AS perAccountingTypeSubtotal
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

							SELECT AccountingTypeID,
								Sum( TblOrdersBOM_ItemsFeature.AdditionalUnitPrice * (1 - DiscountPercent) * TblOrdersBOM_Items.quantityOrdered ) AS perAccountingTypeSubtotal
							FROM TblOrdersBOM_Items
								INNER JOIN TblOrdersBOM_ItemsFeature ON TblOrdersBOM_ItemsFeature.OrderItemsID = TblOrdersBOM_Items.OrderItemsID
								INNER JOIN TblProductFeature         ON TblProductFeature.FeatureID = TblOrdersBOM_ItemsFeature.FeatureID
							WHERE TblOrdersBOM_Items.OrderVersionID = argOrderVersionID
							GROUP BY AccountingTypeID

						UNION

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
		OrderItemFeaturesAndCustomizationsPrice = Coalesce((SELECT Sum(AdditionalUnitPrice) FROM TblOrdersBOM_ItemsFeature WHERE OrderItemsID = vOrderItemID), 0)
													+ Coalesce((SELECT Sum(AdditionalUnitPrice) FROM TblOrdersBOM_ItemsCustomization WHERE OrderItemsID = vOrderItemID), 0),
		costOfFeaturesAndCustomizations         = Coalesce((SELECT Sum(AdditionalLaborCost) FROM TblOrdersBOM_ItemsFeature WHERE OrderItemsID = vOrderItemID), 0)
													+ Coalesce((SELECT Sum(AdditionalLaborCost) FROM TblOrdersBOM_ItemsCustomization WHERE OrderItemsID = vOrderItemID), 0)
	WHERE OrderItemsID = vOrderItemID;
END
$$


DELIMITER ;














DELIMITER $$


DROP TRIGGER IF EXISTS `trgTblOrdersBOM_ItemsCustomization_after_delete`
$$
CREATE TRIGGER `trgTblOrdersBOM_ItemsCustomization_after_delete` AFTER DELETE ON `TblOrdersBOM_ItemsCustomization` FOR EACH ROW BEGIN
	CALL spUpdateOrderItemFeaturesAndCustomizations(OLD.OrderItemsID);
END
$$


DELIMITER ;
DELIMITER $$


DROP TRIGGER IF EXISTS `trgTblOrdersBOM_ItemsCustomization_after_insert`
$$
CREATE TRIGGER `trgTblOrdersBOM_ItemsCustomization_after_insert` AFTER INSERT ON `TblOrdersBOM_ItemsCustomization` FOR EACH ROW BEGIN
	CALL spUpdateOrderItemFeaturesAndCustomizations(NEW.OrderItemsID);
END
$$


DELIMITER ;
DELIMITER $$


DROP TRIGGER IF EXISTS `trgTblOrdersBOM_ItemsFeatures_after_delete`
$$
CREATE TRIGGER `trgTblOrdersBOM_ItemsFeatures_after_delete` AFTER DELETE ON `TblOrdersBOM_ItemsFeature` FOR EACH ROW BEGIN
	CALL spUpdateOrderItemFeaturesAndCustomizations(OLD.OrderItemsID);
END
$$


DELIMITER ;
DELIMITER $$


DROP TRIGGER IF EXISTS `trgTblOrdersBOM_ItemsFeatures_after_insert`
$$
CREATE TRIGGER `trgTblOrdersBOM_ItemsFeatures_after_insert` AFTER INSERT ON `TblOrdersBOM_ItemsFeature` FOR EACH ROW BEGIN
	CALL spUpdateOrderItemFeaturesAndCustomizations(NEW.OrderItemsID);
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
			) + Coalesce(costOfFeaturesAndCustomizations, 0)
 			AS costOfLabor,
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