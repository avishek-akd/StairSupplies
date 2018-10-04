ALTER TABLE `TblOrdersBOM_Items`
	CHANGE COLUMN `Discount` `DiscountPercent` DECIMAL(10,4) NULL DEFAULT '0.0000' COMMENT 'Discount percent applied to each item' AFTER `UnitPrice`;


CREATE FUNCTION `fUnitPriceWithDiscount`(`unitPrice` DECIMAL(19,4), `discountPercent` DECIMAL(10,4))
	RETURNS decimal(19,4)
	LANGUAGE SQL
	DETERMINISTIC
	CONTAINS SQL
	SQL SECURITY DEFINER
	COMMENT ''
RETURN Round(unitPrice * (1 - discountPercent), 2);


CREATE FUNCTION `fUnitDiscount`(`unitPrice` DECIMAL(19,4), `discountPercent` DECIMAL(10,4))
	RETURNS decimal(19,4)
	LANGUAGE SQL
	DETERMINISTIC
	CONTAINS SQL
	SQL SECURITY DEFINER
	COMMENT ''
RETURN Round(unitPrice * discountPercent, 2);


CREATE FUNCTION fItemPriceWithDiscount(`unitPrice` DECIMAL(19,4), `discountPercent` DECIMAL(10,4), quantity DECIMAL(10,2))
	RETURNS decimal(19,4)
	LANGUAGE SQL
	DETERMINISTIC
	CONTAINS SQL
	SQL SECURITY DEFINER
	COMMENT ''
RETURN Round(unitPrice * (1 - discountPercent), 2) * quantity;


CREATE FUNCTION fPreFinishCost(finishTitle VARCHAR(100), preFinishCost DECIMAL(10,2))
	RETURNS decimal(10,2)
	LANGUAGE SQL
	DETERMINISTIC
	CONTAINS SQL
	SQL SECURITY DEFINER
	COMMENT ''
RETURN IF(finishTitle IS NULL, 0, preFinishCost);


CREATE FUNCTION fUnitCost(Purchase_price DECIMAL(19,4), LaborCost DECIMAL(10,2), PreFinishCost DECIMAL(10,2), lumber_rate DECIMAL(10,2), boardFootage DECIMAL(7,2))
	RETURNS decimal(19,4)
	LANGUAGE SQL
	DETERMINISTIC
	CONTAINS SQL
	SQL SECURITY DEFINER
	COMMENT ''
BEGIN
	IF ( Purchase_price > 0) THEN
		RETURN Purchase_price;
	ELSE 
		RETURN LaborCost + PreFinishCost + Coalesce(lumber_rate * boardFootage, 0);
	END IF;
END


CREATE PROCEDURE `spPricePerCategory`(IN `orderID` INTEGER(11))
	LANGUAGE SQL
	NOT DETERMINISTIC
	CONTAINS SQL
	SQL SECURITY INVOKER
	COMMENT ''
BEGIN
SELECT TblProductTypeType.title, Coalesce(Sum( fItemPriceWithDiscount(unitPrice, discountPercent, quantity) ), 0) as total
FROM TblProductType
	INNER JOIN TblProductTypeType ON TblProductTypeType.id = TblProductType.type_id
	LEFT JOIN Products            ON Products.ProductType_id = TblProductType.ProductType_id
	LEFT JOIN TblOrdersBOM_Items  ON (TblOrdersBOM_Items.ProductID = Products.ProductId
										AND TblOrdersBOM_Items.OrderId = orderID)
GROUP BY TblProductType.type_id
ORDER BY TblProductType.type_id ASC;
END;



CREATE PROCEDURE `spShipmentItemUpdateQuantity`(IN `OrderShipmentItemsID` INT, IN `quantityToShip` deCIMAL(10,2), IN `BoxSkidNumber` VARCHAR(100))
	LANGUAGE SQL
	NOT DETERMINISTIC
	CONTAINS SQL
	SQL SECURITY DEFINER
	COMMENT ''
BEGIN
DECLARE shipmentQuantity DECIMAL(10,2);
DECLARE itemShippedQuantity DECIMAL(10,2);
DECLARE orderItemsID INT;
DECLARE newItemShippedQuantity DECIMAL(10,2);
DECLARE itemQuantity DECIMAL(10,2);


SELECT TblOrdersBOM_ShipmentsItems.QuantityShipped,
TblOrdersBOM_Items.QuantityShipped, TblOrdersBOM_Items.Quantity, TblOrdersBOM_Items.orderItemsID
INTO @shipmentQuantity,
@itemShippedQuantity, @itemQuantity, @orderItemsID
FROM TblOrdersBOM_ShipmentsItems
INNER JOIN TblOrdersBOM_Items ON TblOrdersBOM_Items.OrderItemsID = TblOrdersBOM_ShipmentsItems.OrderItemsID
WHERE TblOrdersBOM_ShipmentsItems.OrderShipmentItemsID = OrderShipmentItemsID;

UPDATE TblOrdersBOM_ShipmentsItems
SET
TblOrdersBOM_ShipmentsItems.QuantityShipped = quantityToShip,
TblOrdersBOM_ShipmentsItems.BoxSkidNumber   = BoxSkidNumber,
DateUpdated                                 = Now()
WHERE TblOrdersBOM_ShipmentsItems.OrderShipmentItemsID = OrderShipmentItemsID;


SET @newItemShippedQuantity = @itemShippedQuantity - @shipmentQuantity + quantityToShip;
UPDATE TblOrdersBOM_Items
SET
Shipped = if(@itemQuantity <= @newItemShippedQuantity, 1, 0),
QuantityShipped = @newItemShippedQuantity
WHERE TblOrdersBOM_Items.OrderItemsID = @orderItemsID;
END;



ALTER VIEW `vOrderItems` AS
SELECT `stairs5_intranet`.`TblOrdersBOM_Items`.`OrderItemsID` AS `orderItemsID`,`stairs5_intranet`.`TblOrdersBOM_Items`.`OrderID` AS `orderID`,`stairs5_intranet`.`TblOrdersBOM_Items`.`GroupID` AS `GroupID`,`stairs5_intranet`.`TblOrdersBOM_Items`.`UnitPrice` AS `unitPrice`,`stairs5_intranet`.`TblOrdersBOM_Items`.`ProductName` AS `ProductName`,`stairs5_intranet`.`TblOrdersBOM_Items`.`ProductDescription` AS `ProductDescription`,`stairs5_intranet`.`TblOrdersBOM_Items`.`In_House_Notes` AS `in_house_notes`,`stairs5_intranet`.`TblOrdersBOM_Items`.`Quantity` AS `quantity`,`stairs5_intranet`.`TblOrdersBOM_Items`.`UnitWeight` AS `unitWeight`,`stairs5_intranet`.`TblOrdersBOM_Items`.`QuantityShipped` AS `quantityShipped`,`stairs5_intranet`.`TblOrdersBOM_Items`.`Customer_Notes` AS `Customer_Notes`,
	`stairs5_intranet`.`TblOrdersBOM_Items`.`DiscountPercent` AS `discountPercent`,`stairs5_intranet`.`TblOrdersBOM_Items`.`Shipped` AS `shipped`,`stairs5_intranet`.`TblOrdersBOM_Items`.`sortField` AS `sortField`,`stairs5_intranet`.`TblOrdersBOM_Items`.`Special_Instructions` AS `Special_Instructions`,
	fUnitPriceWithDiscount(`TblOrdersBOM_Items`.`UnitPrice`, `TblOrdersBOM_Items`.`DiscountPercent`) AS `discountedUnitPrice`,
	fItemPriceWithDiscount(`TblOrdersBOM_Items`.`UnitPrice`, `TblOrdersBOM_Items`.`DiscountPercent`, `TblOrdersBOM_Items`.`Quantity`) AS `itemPrice`,
	`stairs5_intranet`.`tbl_wood_type`.`d_name` AS `woodTypeName`,`stairs5_intranet`.`FinishOption`.`title` AS `finishOptionTitle`,`stairs5_intranet`.`Products`.`Unit_of_Measure` AS `Unit_of_Measure`,`stairs5_intranet`.`Products`.`ProductType_id` AS `ProductType_Id`,`stairs5_intranet`.`Products`.`ProductID` AS `ProductID`
FROM (((`stairs5_intranet`.`TblOrdersBOM_Items`
	LEFT JOIN `stairs5_intranet`.`Products` ON((`stairs5_intranet`.`Products`.`ProductID` = `stairs5_intranet`.`TblOrdersBOM_Items`.`ProductID`)))
	LEFT JOIN `stairs5_intranet`.`tbl_wood_type` ON((`stairs5_intranet`.`tbl_wood_type`.`id` = `stairs5_intranet`.`Products`.`WoodTypeID`)))
	LEFT JOIN `stairs5_intranet`.`FinishOption` ON((`stairs5_intranet`.`FinishOption`.`id` = `stairs5_intranet`.`TblOrdersBOM_Items`.`FinishOptionID`)))
ORDER BY `stairs5_intranet`.`TblOrdersBOM_Items`.`OrderItemsID`;

