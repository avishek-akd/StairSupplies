DELIMITER $$


ALTER TABLE `TblOrdersBOM_Items`
	ADD COLUMN `PostNumbersList` VARCHAR(100) NULL DEFAULT NULL COMMENT 'Comma separated list of post numbers.' AFTER `Customer_Notes`
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
       `Products`.`WoodTypeID` AS `WoodTypeID`,
       `tbl_wood_type`.`d_name` AS `woodTypeName`,
       `tbl_wood_type`.`d_finish_image_unfinished` AS
        `d_finish_image_unfinished`,
       `tbl_wood_type`.`d_finish_image_standard` AS `d_finish_image_standard`,
       `TblFinishOption`.`FinishImage` AS `FinishImage`,
       `TblFinishOption`.`title` AS `finishOptionTitle`,
       `Products`.`Unit_of_Measure` AS `Unit_of_Measure`,
       `Products`.`ProductType_id` AS `ProductType_Id`,
       `Products`.`ProductID` AS `ProductID`
from `TblOrdersBOM_Items`
	INNER JOIN vOrderItemPrice ON vOrderItemPrice.OrderItemsID = TblOrdersBOM_Items.OrderItemsID
     left join `Products`      on `Products`.`ProductID` = `TblOrdersBOM_Items`.`ProductID`
     left join `tbl_wood_type` on `tbl_wood_type`.`id` = `Products`.`WoodTypeID`
     left join `TblFinishOption`  on `TblFinishOption`.`id` = `TblOrdersBOM_Items`.`FinishOptionID`
order by `TblOrdersBOM_Items`.`OrderItemsID`
$$




DELIMITER ;