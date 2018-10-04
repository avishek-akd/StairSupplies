--  view vOrderItems
select 
    `TblOrdersBOM_Items`.`OrderItemsID` AS `orderItemsID`,
    `TblOrdersBOM_Items`.`OrderID` AS `orderID`,
    `TblOrdersBOM_Items`.`GroupID` AS `GroupID`,
    `TblOrdersBOM_Items`.`UnitPrice` AS `unitPrice`,
    `TblOrdersBOM_Items`.`ProductName` AS `ProductName`,
    `TblOrdersBOM_Items`.`ProductDescription` AS `ProductDescription`,
    `TblOrdersBOM_Items`.`In_House_Notes` AS `in_house_notes`,
    `TblOrdersBOM_Items`.`Quantity` AS `quantity`,
    `TblOrdersBOM_Items`.`unitWeight` AS `unitWeight`,
    `TblOrdersBOM_Items`.`QuantityShipped` AS `quantityShipped`,
    `TblOrdersBOM_Items`.`Customer_Notes` AS `Customer_Notes`,
    `TblOrdersBOM_Items`.`Discount` AS `discount`,
    `TblOrdersBOM_Items`.`Shipped` AS `shipped`,
    `TblOrdersBOM_Items`.`sortField` AS `sortField`,
    `TblOrdersBOM_Items`.`Special_Instructions` AS `Special_Instructions`,
    round((`TblOrdersBOM_Items`.`UnitPrice` * (1 - `TblOrdersBOM_Items`.`Discount`)),2) AS `discountedUnitPrice`,
    (round((`TblOrdersBOM_Items`.`UnitPrice` * (1 - `TblOrdersBOM_Items`.`Discount`)),2) * `TblOrdersBOM_Items`.`Quantity`) AS `itemPrice`,
    `tbl_wood_type`.`d_name` AS `woodTypeName`,
    `FinishOption`.`title` AS `finishOptionTitle`,
    `Products`.`Unit_of_Measure` AS `Unit_of_Measure`,
    `Products`.`ProductType_id` AS `ProductType_Id` 
  from 
    (((`TblOrdersBOM_Items` left join `Products` on((`Products`.`ProductID` = `TblOrdersBOM_Items`.`ProductID`))) left join `tbl_wood_type` on((`tbl_wood_type`.`id` = `Products`.`WoodTypeID`))) left join `FinishOption` on((`FinishOption`.`id` = `TblOrdersBOM_Items`.`FinishOptionID`))) 
  order by 
    `TblOrdersBOM_Items`.`OrderItemsID`;