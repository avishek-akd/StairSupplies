ALTER TABLE `TblOrdersBOM_Items`
	CHANGE COLUMN `Product_Descripton` `ProductDescription` VARCHAR(500) NULL DEFAULT NULL AFTER `ProductName`;
ALTER TABLE `Products`
	CHANGE COLUMN `Product_Descripton` `ProductDescription` VARCHAR(500) NULL DEFAULT NULL AFTER `ProductName`;

	
ALTER VIEW `orderItems` AS select `stairs5_intranet`.`TblOrdersBOM_Items`.`OrderItemsID` AS `orderItemsID`,`stairs5_intranet`.`TblOrdersBOM_Items`.`OrderID` AS `orderID`,`stairs5_intranet`.`TblOrdersBOM_Items`.`UnitPrice` AS `unitPrice`,`stairs5_intranet`.`TblOrdersBOM_Items`.`ProductName` AS `ProductName`,`stairs5_intranet`.`TblOrdersBOM_Items`.`ProductDescription` AS `ProductDescription`,`stairs5_intranet`.`TblOrdersBOM_Items`.`In_House_Notes` AS `in_house_notes`,`stairs5_intranet`.`TblOrdersBOM_Items`.`Quantity` AS `quantity`,`stairs5_intranet`.`TblOrdersBOM_Items`.`QuantityShipped` AS `quantityShipped`,`stairs5_intranet`.`TblOrdersBOM_Items`.`Customer_Notes` AS `Customer_Notes`,`stairs5_intranet`.`TblOrdersBOM_Items`.`Discount` AS `discount`,`stairs5_intranet`.`TblOrdersBOM_Items`.`Shipped` AS `shipped`,`stairs5_intranet`.`TblOrdersBOM_Items`.`Special_Instructions` AS `Special_Instructions`,round((`stairs5_intranet`.`TblOrdersBOM_Items`.`UnitPrice` * (1 - `stairs5_intranet`.`TblOrdersBOM_Items`.`Discount`)),2) AS `discountedUnitPrice`,(round((`stairs5_intranet`.`TblOrdersBOM_Items`.`UnitPrice` * (1 - `stairs5_intranet`.`TblOrdersBOM_Items`.`Discount`)),2) * `stairs5_intranet`.`TblOrdersBOM_Items`.`Quantity`) AS `itemPrice`,`stairs5_intranet`.`tbl_lumber_species`.`d_name` AS `speciesName`,`stairs5_intranet`.`FinishOption`.`title` AS `finishOptionTitle`,`stairs5_intranet`.`Products`.`Unit_of_Measure` AS `Unit_of_Measure`,`stairs5_intranet`.`Products`.`ProductType_id` AS `ProductType_Id` from (((`stairs5_intranet`.`TblOrdersBOM_Items` left join `stairs5_intranet`.`Products` on((`stairs5_intranet`.`Products`.`ProductID` = `stairs5_intranet`.`TblOrdersBOM_Items`.`ProductID`))) left join `stairs5_intranet`.`tbl_lumber_species` on((`stairs5_intranet`.`tbl_lumber_species`.`id` = `stairs5_intranet`.`Products`.`SpeciesID`))) left join `stairs5_intranet`.`FinishOption` on((`stairs5_intranet`.`FinishOption`.`id` = `stairs5_intranet`.`TblOrdersBOM_Items`.`FinishOptionID`))) order by `stairs5_intranet`.`TblOrdersBOM_Items`.`OrderItemsID` ;
