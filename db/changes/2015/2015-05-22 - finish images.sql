ALTER TABLE `tbl_wood_type`
	ADD COLUMN `d_finish_image_unfinished` VARCHAR(100) NULL COMMENT 'Image representing the how the wood looks like unfinished' AFTER `d_name`,
	ADD COLUMN `d_finish_image_standard` VARCHAR(100) NULL COMMENT 'How wood looks like with Standard Clearcoat 30 sheen' AFTER `d_finish_image_unfinished`;
ALTER TABLE `FinishOption`
	ADD COLUMN `FinishImage` VARCHAR(100) NOT NULL AFTER `FinishPriceMultiplier`;

	
ALTER ALGORITHM = UNDEFINED VIEW `vOrderItems` AS
SELECT `TblOrdersBOM_Items`.`OrderItemsID` AS `orderItemsID`,`TblOrdersBOM_Items`.`OrderID` AS `orderID`,`TblOrdersBOM_Items`.`GroupID` AS `GroupID`,
	`TblOrdersBOM_Items`.`UnitPrice` AS `unitPrice`,`TblOrdersBOM_Items`.`ProductName` AS `ProductName`,`TblOrdersBOM_Items`.`ProductDescription` AS `ProductDescription`,
	`TblOrdersBOM_Items`.`In_House_Notes` AS `in_house_notes`,`TblOrdersBOM_Items`.`QuantityOrdered` AS `QuantityOrdered`,
	`TblOrdersBOM_Items`.`UnitWeight` AS `unitWeight`,`TblOrdersBOM_Items`.`QuantityShipped` AS `quantityShipped`,
	`TblOrdersBOM_Items`.`Customer_Notes` AS `Customer_Notes`,`TblOrdersBOM_Items`.`DiscountPercent` AS `discountPercent`,`TblOrdersBOM_Items`.`Shipped` AS `shipped`,
	`TblOrdersBOM_Items`.`GroupSortField` AS `GroupSortField`,`TblOrdersBOM_Items`.`Special_Instructions` AS `Special_Instructions`,
	`fUnitPriceWithDiscount`(`TblOrdersBOM_Items`.`UnitPrice`,`TblOrdersBOM_Items`.`DiscountPercent`) AS `discountedUnitPrice`,
	`fItemPriceWithDiscount`(`TblOrdersBOM_Items`.`UnitPrice`,`TblOrdersBOM_Items`.`DiscountPercent`,`TblOrdersBOM_Items`.`QuantityOrdered`) AS `itemPrice`,
	`TblOrdersBOM_Items`.`FinishOptionID` AS `FinishOptionID`,`Products`.`WoodTypeID` AS `WoodTypeID`,`tbl_wood_type`.`d_name` AS `woodTypeName`,
	tbl_wood_type.d_finish_image_unfinished, tbl_wood_type.d_finish_image_standard, FinishOption.FinishImage,
	`FinishOption`.`title` AS `finishOptionTitle`,`Products`.`Unit_of_Measure` AS `Unit_of_Measure`,`Products`.`ProductType_id` AS `ProductType_Id`,
	`Products`.`ProductID` AS `ProductID`
FROM (((`TblOrdersBOM_Items`
LEFT JOIN `Products` ON((`Products`.`ProductID` = `TblOrdersBOM_Items`.`ProductID`)))
LEFT JOIN `tbl_wood_type` ON((`tbl_wood_type`.`id` = `Products`.`WoodTypeID`)))
LEFT JOIN `FinishOption` ON((`FinishOption`.`id` = `TblOrdersBOM_Items`.`FinishOptionID`)))
ORDER BY `TblOrdersBOM_Items`.`OrderItemsID`;