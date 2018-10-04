ALTER TABLE TblOrdersBOM_Items
	ADD COLUMN `HandrailNumbersList` VARCHAR(500) NULL DEFAULT NULL COMMENT 'Comma separated list of handrail numbers.' AFTER `PostNumbersList`
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
	`Products`.`ProductID`,
	`Products`.`Unit_of_Measure`,
	`Products`.`ProductType_id`,
	`Products`.`MaterialID`,
	`TblMaterial`.`d_name` AS `materialName`,
	`TblMaterial`.`d_finish_image_unfinished`,
	`TblMaterial`.`d_finish_image_standard`,
	`TblFinishOption`.`FinishImage`,
	`TblFinishOption`.`title` AS `finishOptionTitle`
FROM `TblOrdersBOM_Items`
	INNER JOIN vOrderItemPrice  ON vOrderItemPrice.OrderItemsID = TblOrdersBOM_Items.OrderItemsID
	LEFT JOIN `Products`        ON `Products`.`ProductID` = `TblOrdersBOM_Items`.`ProductID`
	LEFT JOIN `TblMaterial`     ON `TblMaterial`.`id` = `Products`.`MaterialID`
	LEFT JOIN `TblFinishOption` ON `TblFinishOption`.`id` = `TblOrdersBOM_Items`.`FinishOptionID`
ORDER BY `TblOrdersBOM_Items`.`OrderItemsID`
;