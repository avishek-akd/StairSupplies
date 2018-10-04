ALTER TABLE `TblProducts`
	CHANGE COLUMN `CustomerProductName` `CustomerProductName` VARCHAR(100) NULL DEFAULT NULL COMMENT 'Customer friendly name (internal names can be cryptic)' COLLATE 'utf8_unicode_ci' AFTER `ProductDescription`,
	CHANGE COLUMN `CustomerProductDescription` `CustomerProductDescription` VARCHAR(500) NULL DEFAULT NULL COMMENT 'Customer friendly description' COLLATE 'utf8_unicode_ci' AFTER `CustomerProductName`
;




ALTER TABLE `TblOrdersBOM_Items`
	ALTER `OrderItemCustomerName` DROP DEFAULT,
	ALTER `OrderItemCustomerDescription` DROP DEFAULT;
ALTER TABLE `TblOrdersBOM_Items`
	CHANGE COLUMN `OrderItemCustomerBaseName` `_unused_OrderItemCustomerBaseName` VARCHAR(100) NULL DEFAULT NULL COMMENT 'Base name (excluding features and customizations)',
	CHANGE COLUMN `OrderItemCustomerName` `_unused_OrderItemCustomerName` VARCHAR(150) AS (concat(coalesce(`_unused_OrderItemCustomerBaseName`,`OrderItemBaseName`,''),if((`OrderItemNameSuffix` <> ''),concat(' - ',`OrderItemNameSuffix`),''))) STORED COMMENT 'Customer friendly name, displayed on all places where the customer can see it',
	CHANGE COLUMN `OrderItemCustomerBaseDescription` `_unused_OrderItemCustomerBaseDescription` VARCHAR(500) NULL DEFAULT NULL,
	CHANGE COLUMN `OrderItemCustomerDescription` `_unused_OrderItemCustomerDescription` VARCHAR(750) AS (concat(if((`OrderItemDescriptionPrefix` <> ''),concat(`OrderItemDescriptionPrefix`,' - '),''),coalesce(`_unused_OrderItemCustomerBaseDescription`,`OrderItemBaseDescription`,''))) STORED COMMENT 'Customer friendly description'
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
	`TblOrdersBOM_Items`.`OrderItemBaseDescription`,
	Concat(
		IF(TblProducts.CustomerProductName IS NOT NULL, TblProducts.CustomerProductName, TblProducts.ProductName),
		IF(OrderItemNameSuffix IS NOT NULL AND OrderItemNameSuffix <> '', Concat(' - ', OrderItemNameSuffix), '')
	) AS OrderItemCustomerFriendlyName,
	Concat(
		IF(OrderItemDescriptionPrefix IS NOT NULL AND OrderItemDescriptionPrefix <> '', Concat(OrderItemDescriptionPrefix, ' - '), ''),
		IF(TblProducts.CustomerProductDescription IS NOT NULL, TblProducts.CustomerProductDescription, TblProducts.ProductDescription)
	) AS OrderItemCustomerFriendlyDescription,
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