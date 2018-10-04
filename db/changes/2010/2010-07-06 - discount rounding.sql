ALTER TABLE `TblOrdersBOM_Items`
	CHANGE COLUMN `so_programming_complete_employeeID` `so_programming_complete_employeeID` INT(11) NULL DEFAULT NULL AFTER `so_programming_complete_date`,
	CHANGE COLUMN `Purchase_Price` `z_unused_Purchase_Price` DECIMAL(19,4) NULL DEFAULT '0.0000' AFTER `so_programming_complete_employeeID`,
	CHANGE COLUMN `z_unused_Outsource` `z_unused_Outsource` TINYINT(4) NULL DEFAULT NULL AFTER `z_unused_Purchase_Price`,
	CHANGE COLUMN `z_unused_OutsourceDate` `z_unused_OutsourceDate` DATETIME NULL DEFAULT NULL AFTER `z_unused_Outsource`,
	CHANGE COLUMN `z_unused_OutsourceInitials` `z_unused_OutsourceInitials` LONGTEXT NULL AFTER `z_unused_OutsourceDate`,
	CHANGE COLUMN `z_unused_outsource_EmployeeID` `z_unused_outsource_EmployeeID` BIGINT(19) NULL DEFAULT NULL AFTER `z_unused_OutsourceInitials`,
	CHANGE COLUMN `z_unused_ReadytoShip` `z_unused_ReadytoShip` TINYINT(4) NULL DEFAULT '0' AFTER `z_unused_outsource_EmployeeID`,
	CHANGE COLUMN `z_unused_Status` `z_unused_Status` VARCHAR(50) NULL DEFAULT NULL AFTER `z_unused_ReadytoShip`;


ALTER TABLE `TblOrdersBOM_Shipments`
	CHANGE COLUMN `DateAdded` `DateAdded` DATETIME NULL DEFAULT NULL AFTER `delivered`,
	CHANGE COLUMN `DateUpdated` `DateUpdated` DATETIME NULL DEFAULT NULL AFTER `DateAdded`;

ALTER TABLE `TblOrdersBOM` 
	CHANGE COLUMN `AcknowledgmentSent` `AcknowledgmentSent` TINYINT(1) NULL DEFAULT '0' COMMENT 'Acknowledgement was sent to customer ?' AFTER `invoiced_UserLastName`,
	CHANGE COLUMN `z_unused_Notes` `z_unused_Notes` LONGTEXT NULL AFTER `AcknowledgmentSent`,
	CHANGE COLUMN `z_unused_EstimateDate` `z_unused_EstimateDate` DATETIME NULL DEFAULT NULL AFTER `z_unused_Notes`,
	CHANGE COLUMN `z_unused_PONumber` `z_unused_PONumber` VARCHAR(50) NULL DEFAULT NULL AFTER `z_unused_EstimateDate`, 
	CHANGE COLUMN `z_unused_OrderDate` `z_unused_OrderDate` DATETIME NULL DEFAULT NULL AFTER `z_unused_PONumber`, 
	CHANGE COLUMN `z_unused_ReadytoShipUser` `z_unused_ReadytoShipUser` VARCHAR(50) NULL DEFAULT NULL AFTER `z_unused_OrderDate`,
	CHANGE COLUMN `z_unused_ShippedUser` `z_unused_ShippedUser` VARCHAR(50) NULL DEFAULT NULL AFTER `z_unused_ReadytoShipUser`, 
	CHANGE COLUMN `z_unused_ShippedPartialDate` `z_unused_ShippedPartialDate` DATETIME NULL DEFAULT NULL AFTER `z_unused_ShippedUser`, 
	CHANGE COLUMN `z_unused_orderedDate` `z_unused_orderedDate` DATETIME NULL DEFAULT NULL AFTER `z_unused_ShippedPartialDate`, 
	CHANGE COLUMN `z_unused_Archived` `z_unused_Archived` TINYINT(4) NULL DEFAULT '0' AFTER `z_unused_orderedDate`, 
	CHANGE COLUMN `z_unused_OrderedUser` `z_unused_OrderedUser` VARCHAR(50) NULL DEFAULT NULL AFTER `z_unused_Archived`,
	CHANGE COLUMN `z_unused_ArchivedDate` `z_unused_ArchivedDate` DATETIME NULL DEFAULT NULL AFTER `z_unused_OrderedUser`,
	CHANGE COLUMN `z_unused_OrderSubTotal` `z_unused_OrderSubTotal` DECIMAL(19,4) NULL DEFAULT '0.0000' AFTER `z_unused_ArchivedDate`,
	CHANGE COLUMN `ShippedPartial` `z_unused_ShippedPartial` TINYINT(4) NULL DEFAULT '0' AFTER `z_unused_OrderSubTotal`, 
	CHANGE COLUMN `z_unused_ReleasedUser` `z_unused_ReleasedUser` VARCHAR(50) NULL DEFAULT NULL AFTER `z_unused_ShippedPartial`, 
	CHANGE COLUMN `z_unused_Status` `z_unused_Status` VARCHAR(50) NULL DEFAULT NULL AFTER `z_unused_ReleasedUser`, 
	CHANGE COLUMN `z_unused_PaidDate` `z_unused_PaidDate` DATETIME NULL DEFAULT NULL AFTER `z_unused_Status`,
	CHANGE COLUMN `z_unused_releasedDate` `z_unused_releasedDate` DATETIME NULL DEFAULT NULL AFTER `z_unused_PaidDate`,  
	CHANGE COLUMN `z_unused_EstimateUser` `z_unused_EstimateUser` VARCHAR(50) NULL DEFAULT NULL AFTER `z_unused_releasedDate`,
	CHANGE COLUMN `z_unused_ActFreightCharge` `z_unused_ActFreightCharge` DECIMAL(19,4) NULL DEFAULT '0.0000' AFTER `z_unused_EstimateUser`, 
	CHANGE COLUMN `z_unused_PaidUser` `z_unused_PaidUser` VARCHAR(50) NULL DEFAULT NULL AFTER `z_unused_ActFreightCharge`,
	CHANGE COLUMN `z_unused_EmailAck` `z_unused_EmailAck` TINYINT(4) NULL DEFAULT '0' AFTER `z_unused_PaidUser`, 
	CHANGE COLUMN `z_unused_EmailAckDate` `z_unused_EmailAckDate` DATETIME NULL DEFAULT NULL AFTER `z_unused_EmailAck`,
	CHANGE COLUMN `z_unused_EmailAckUser` `z_unused_EmailAckUser` VARCHAR(50) NULL DEFAULT NULL AFTER `z_unused_EmailAckDate`,
	CHANGE COLUMN `z_unused_EmailShipAck` `z_unused_EmailShipAck` TINYINT(4) NULL DEFAULT '0' AFTER `z_unused_EmailAckUser`, 
	CHANGE COLUMN `z_unused_EmailShipAckDate` `z_unused_EmailShipAckDate` DATETIME NULL DEFAULT NULL AFTER `z_unused_EmailShipAck`,
	CHANGE COLUMN `z_unused_EmailShipAckUser` `z_unused_EmailShipAckUser` VARCHAR(50) NULL DEFAULT NULL AFTER `z_unused_EmailShipAckDate`, 
	CHANGE COLUMN `z_unused_FinishShop` `z_unused_FinishShop` TINYINT(4) NULL DEFAULT '0' AFTER `z_unused_EmailShipAckUser`, 
	CHANGE COLUMN `z_unused_FinishShopDate` `z_unused_FinishShopDate` DATETIME NULL DEFAULT NULL AFTER `z_unused_FinishShop`, 
	CHANGE COLUMN `z_unused_invoicedDate` `z_unused_invoicedDate` DATETIME NULL DEFAULT NULL AFTER `z_unused_FinishShopDate`, 
	CHANGE COLUMN `z_unused_Updated` `z_unused_Updated` TINYINT(4) NULL DEFAULT '0' AFTER `z_unused_invoicedDate`, 
	CHANGE COLUMN `z_unused_CreditCardChargeddate` `z_unused_CreditCardChargeddate` DATETIME NULL DEFAULT NULL AFTER `z_unused_Updated`,
	CHANGE COLUMN `z_unused_UpdatedDate` `z_unused_UpdatedDate` DATETIME NULL DEFAULT NULL AFTER `z_unused_CreditCardChargeddate`, 
	CHANGE COLUMN `z_unused_UpdatedBy` `z_unused_UpdatedBy` VARCHAR(50) NULL DEFAULT NULL AFTER `z_unused_UpdatedDate`, 
	CHANGE COLUMN `z_unused_cancelledDate` `z_unused_cancelledDate` DATETIME NULL DEFAULT NULL AFTER `z_unused_UpdatedBy`,
	CHANGE COLUMN `z_unused_BackOrderID` `z_unused_BackOrderID` INT(10) NULL DEFAULT '0' AFTER `z_unused_cancelledDate`, 
	CHANGE COLUMN `z_unused_ShippedBy_Id` `z_unused_ShippedBy_Id` INT(10) NULL DEFAULT '0' AFTER `z_unused_BackOrderID`,
	CHANGE COLUMN `z_unused_PickedBy_Id` `z_unused_PickedBy_Id` INT(10) NULL DEFAULT '0' AFTER `z_unused_ShippedBy_Id`, 
	CHANGE COLUMN `z_unused_PackedBy_Id` `z_unused_PackedBy_Id` INT(10) NULL DEFAULT '0' AFTER `z_unused_PickedBy_Id`, 
	CHANGE COLUMN `z_unused_ShipAddress` `z_unused_ShipAddress` VARCHAR(255) NULL DEFAULT NULL AFTER `z_unused_PackedBy_Id`, 
	CHANGE COLUMN `z_unused_Backorder` `z_unused_Backorder` TINYINT(4) NULL DEFAULT '0' AFTER `z_unused_ShipAddress`, 
	CHANGE COLUMN `z_unused_Production` `z_unused_Production` TINYINT(4) NULL DEFAULT '0' AFTER `z_unused_Backorder`,
	CHANGE COLUMN `z_unused_ProductName` `z_unused_ProductName` VARCHAR(50) NULL DEFAULT NULL AFTER `z_unused_Production`,
	CHANGE COLUMN `z_old_ReadytoShipDate` `z_old_ReadytoShipDate` DATETIME NULL DEFAULT NULL AFTER `z_unused_ProductName`, 
	CHANGE COLUMN `z_unused_InvoicedBy` `z_unused_InvoicedBy` VARCHAR(50) NULL DEFAULT NULL AFTER `z_old_ReadytoShipDate`;


ALTER TABLE `TblOrdersBOM` 
	CHANGE COLUMN `CompanyID` `CompanyID` INT(10) NOT NULL AFTER `CustomerID`,
	CHANGE COLUMN `Cancelled` `Cancelled` TINYINT(4) NULL DEFAULT '0' AFTER `Released`, 
	CHANGE COLUMN `Invoiced` `Invoiced` TINYINT(4) NULL DEFAULT '0' AFTER `Cancelled`, 
	CHANGE COLUMN `statustext` `statustext` VARCHAR(50) NULL DEFAULT NULL AFTER `Invoiced`;

ALTER TABLE `Products` 
	CHANGE COLUMN `PUnitPrice_old` `z_unused_PUnitPrice_old` DECIMAL(19,4) NOT NULL DEFAULT '0.0000' AFTER `inboundFreightCost`,
	CHANGE COLUMN `DropShip` `z_unused_DropShip` TINYINT(4) NULL DEFAULT '0' AFTER `z_unused_PUnitPrice_old`, 
	CHANGE COLUMN `z_unused_Inventory_Number` `z_unused_Inventory_Number` VARCHAR(50) NULL DEFAULT '0' AFTER `z_unused_DropShip`,
	CHANGE COLUMN `z_unused_Qty_Reorder_Min` `z_unused_Qty_Reorder_Min` INT(10) NOT NULL DEFAULT '0' AFTER `z_unused_Inventory_Number`, 
	CHANGE COLUMN `z_unused_Qty_On_Order` `z_unused_Qty_On_Order` INT(10) NOT NULL DEFAULT '0' AFTER `z_unused_Qty_Reorder_Min`, 
	CHANGE COLUMN `z_unused_Qty_Available` `z_unused_Qty_Available` INT(10) NOT NULL DEFAULT '0' AFTER `z_unused_Qty_On_Order`,  
	CHANGE COLUMN `z_unused_Qty_to_reorder` `z_unused_Qty_to_reorder` INT(10) NOT NULL DEFAULT '0' AFTER `z_unused_Qty_Available`, 
	CHANGE COLUMN `z_unused_Qty_Allocated` `z_unused_Qty_Allocated` INT(10) NOT NULL DEFAULT '0' AFTER `z_unused_Qty_to_reorder`, 
	CHANGE COLUMN `z_unused_Qty_BackOrdered` `z_unused_Qty_BackOrdered` INT(10) NOT NULL DEFAULT '0' AFTER `z_unused_Qty_Allocated`,
	CHANGE COLUMN `DateEntered` `DateEntered` DATETIME NULL DEFAULT NULL AFTER `inboundFreightCost`,
	CHANGE COLUMN `DateUpdated` `DateUpdated` DATETIME NULL DEFAULT NULL AFTER `DateEntered`;


/*
	SELECT TblOrdersBOM_Items.orderItemsID, TblOrdersBOM_Items.orderID, TblOrdersBOM_Items.unitPrice, TblOrdersBOM_Items.ProductName, TblOrdersBOM_Items.Product_descripton,
			TblOrdersBOM_Items.in_house_notes, TblOrdersBOM_Items.quantity, TblOrdersBOM_Items.quantityShipped, TblOrdersBOM_Items.Customer_Notes,
			TblOrdersBOM_Items.discount, TblOrdersBOM_Items.shipped, TblOrdersBOM_Items.Special_Instructions,
			Round(unitPrice * (1 - discount), 2) AS discountedUnitPrice,
			Round(unitPrice * (1 - discount), 2) * quantity AS itemPrice,
			tbl_lumber_species.d_name AS speciesName,
			FinishOption.title AS finishOptionTitle,
			Products.Unit_of_Measure, Products.ProductType_Id
	FROM TblOrdersBOM_Items
		LEFT JOIN Products           ON Products.ProductID = TblOrdersBOM_Items.ProductID
		LEFT JOIN tbl_lumber_species ON tbl_lumber_species.id = Products.SpeciesID
		LEFT JOIN FinishOption       ON FinishOption.id = TblOrdersBOM_Items.FinishOptionID
	ORDER BY OrderItemsID ASC; 
 */
CREATE ALGORITHM=UNDEFINED SQL SECURITY INVOKER VIEW `orderItems` AS 
  select 
    `TblOrdersBOM_Items`.`OrderItemsID` AS `orderItemsID`,
    `TblOrdersBOM_Items`.`OrderID` AS `orderID`,
    `TblOrdersBOM_Items`.`UnitPrice` AS `unitPrice`,
    `TblOrdersBOM_Items`.`ProductName` AS `ProductName`,
    `TblOrdersBOM_Items`.`Product_Descripton` AS `Product_descripton`,
    `TblOrdersBOM_Items`.`In_House_Notes` AS `in_house_notes`,
    `TblOrdersBOM_Items`.`Quantity` AS `quantity`,
    `TblOrdersBOM_Items`.`QuantityShipped` AS `quantityShipped`,
    `TblOrdersBOM_Items`.`Customer_Notes` AS `Customer_Notes`,
    `TblOrdersBOM_Items`.`Discount` AS `discount`,
    `TblOrdersBOM_Items`.`Shipped` AS `shipped`,
    `TblOrdersBOM_Items`.`Special_Instructions` AS `Special_Instructions`,
    round((`TblOrdersBOM_Items`.`UnitPrice` * (1 - `TblOrdersBOM_Items`.`Discount`)),2) AS `discountedUnitPrice`,
    (round((`TblOrdersBOM_Items`.`UnitPrice` * (1 - `TblOrdersBOM_Items`.`Discount`)),2) * `TblOrdersBOM_Items`.`Quantity`) AS `itemPrice`,
    `tbl_lumber_species`.`d_name` AS `speciesName`,
    `FinishOption`.`title` AS `finishOptionTitle`,
    `Products`.`Unit_of_Measure` AS `Unit_of_Measure`,
    `Products`.`ProductType_id` AS `ProductType_Id` 
  from 
    (((`TblOrdersBOM_Items` left join `Products` on((`Products`.`ProductID` = `TblOrdersBOM_Items`.`ProductID`))) left join `tbl_lumber_species` on((`tbl_lumber_species`.`id` = `Products`.`SpeciesID`))) left join `FinishOption` on((`FinishOption`.`id` = `TblOrdersBOM_Items`.`FinishOptionID`))) 
  order by 
    `TblOrdersBOM_Items`.`OrderItemsID`;
 
    

CREATE PROCEDURE `pricePerCategory`(IN orderID INTEGER(11))
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY INVOKER
COMMENT ''
BEGIN
SELECT Coalesce(Sum( Round((1 - discount) * unitPrice, 2) * quantity ), 0) as total, TblProductType.Type
FROM TblProductType
LEFT JOIN Products           ON Products.ProductType_id = TblProductType.ProductType_id
LEFT JOIN TblOrdersBOM_Items ON (TblOrdersBOM_Items.ProductID = Products.ProductId
AND TblOrdersBOM_Items.OrderId = orderID)
GROUP BY TblProductType.Type
ORDER BY TblProductType.Type ASC;
END;