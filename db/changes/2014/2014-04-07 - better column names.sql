-- 
--  TblOrdersBOM_Items
-- 
-- Change name 
ALTER TABLE `TblOrdersBOM_Items`
	CHANGE COLUMN `Quantity` `QuantityOrdered` DECIMAL(10,2) NOT NULL DEFAULT '0.00' AFTER `ProductID`,
	CHANGE COLUMN `sortField` `GroupSortField` INT(11) UNSIGNED NULL DEFAULT NULL COMMENT 'Production position inside the group' AFTER `GroupID`;


--  There are a couple of items that don't have QuantityShipped
UPDATE TblOrdersBOM_Items
SET QuantityShipped = QuantityOrdered
WHERE QuantityShipped IS NULL;
--  6710 is Generic item, attach it to items that don't have a Product
UPDATE TblOrdersBOM_Items
SET ProductID = 6710
WHERE ProductID IS NULL;


-- NOT NULL
ALTER TABLE `TblOrdersBOM_Items`
	ALTER `ProductID` DROP DEFAULT;
ALTER TABLE `TblOrdersBOM_Items`
	CHANGE COLUMN `QuantityShipped` `QuantityShipped` DECIMAL(10,2) NOT NULL DEFAULT '0.00' COMMENT 'Quantity shipped might be higher then the ordered quantity' AFTER `QuantityOrdered`,
	CHANGE COLUMN `ProductID` `ProductID` INT(10) NOT NULL AFTER `OrderID`,
	CHANGE COLUMN `UnitWeight` `UnitWeight` DECIMAL(10,2) NOT NULL DEFAULT '0.00' AFTER `ProductDescription`,
	CHANGE COLUMN `Shipped` `Shipped` TINYINT(4) NOT NULL DEFAULT '0' AFTER `Prod_BoardFeet`,
	CHANGE COLUMN `DiscountPercent` `DiscountPercent` DECIMAL(10,4) NOT NULL DEFAULT '0.0000' COMMENT 'Discount percent applied to UnitPrice to get the actual price' AFTER `UnitPrice`;


	


-- 
--  TblOrdersBOM
-- 
UPDATE TblOrdersBOM
SET Paid = 0
WHERE Paid IS NULL;
UPDATE TblOrdersBOM
SET Estimate = 0
WHERE Estimate IS NULL;
UPDATE TblOrdersBOM
SET Ordered = 0
WHERE Ordered IS NULL;
UPDATE TblOrdersBOM
SET Shipped = 0
WHERE Shipped IS NULL;
UPDATE TblOrdersBOM
SET Released = 0
WHERE Released IS NULL;
UPDATE TblOrdersBOM
SET Cancelled = 0
WHERE Cancelled IS NULL;


-- NOT NULL
ALTER TABLE `TblOrdersBOM`
	CHANGE COLUMN `OrderTotal` `OrderTotal` DECIMAL(19,4) NOT NULL DEFAULT '0.0000' AFTER `Canonical_Job_Name`,
	CHANGE COLUMN `SalesTaxRate` `SalesTaxRate` DECIMAL(10,4) NOT NULL DEFAULT '0.0000' AFTER `OrderTotal`,
	CHANGE COLUMN `FreightCharge` `FreightCharge` DECIMAL(19,2) NOT NULL DEFAULT '0.00' AFTER `SalesTaxRate`,
	CHANGE COLUMN `FreightChargeTaxRate` `FreightChargeTaxRate` DECIMAL(10,4) NOT NULL DEFAULT '0.0000' COMMENT 'Tax rate that is applied to Freight Charge' AFTER `FreightCharge`,
	CHANGE COLUMN `Paid` `Paid` TINYINT(4) NOT NULL DEFAULT '0' AFTER `Terms`,
	CHANGE COLUMN `Estimate` `Estimate` TINYINT(4) NOT NULL DEFAULT '0' AFTER `Paid`,
	CHANGE COLUMN `Ordered` `Ordered` TINYINT(4) NOT NULL DEFAULT '0' AFTER `Estimate`,
	CHANGE COLUMN `Shipped` `Shipped` TINYINT(4) NOT NULL DEFAULT '0' AFTER `Ordered`,
	CHANGE COLUMN `Released` `Released` TINYINT(4) NOT NULL DEFAULT '0' AFTER `DueDate`,
	CHANGE COLUMN `Cancelled` `Cancelled` TINYINT(4) NOT NULL DEFAULT '0' AFTER `Released`,
	CHANGE COLUMN `Invoiced` `Invoiced` TINYINT(4) NOT NULL DEFAULT '0' AFTER `Cancelled`,
	CHANGE COLUMN `CreditCardCharged` `CreditCardCharged` TINYINT(4) NOT NULL DEFAULT '0' AFTER `OrderWeight`;


--  ID's actually contain the code instead of containing the employee ID	
UPDATE TblOrdersBOM
SET estimate_userId = (SELECT EmployeeID FROM Employees WHERE EmployeeCode = TblOrdersBOM.estimate_userId)
WHERE estimate_userId NOT IN (SELECT EmployeeID from Employees);
UPDATE TblOrdersBOM
SET ordered_userid = (SELECT EmployeeID FROM Employees WHERE EmployeeCode = TblOrdersBOM.ordered_userid)
WHERE ordered_userid NOT IN (SELECT EmployeeID from Employees);
UPDATE TblOrdersBOM
SET released_userid = (SELECT EmployeeID FROM Employees WHERE EmployeeCode = TblOrdersBOM.released_userid)
WHERE released_userid NOT IN (SELECT EmployeeID from Employees);
UPDATE TblOrdersBOM
SET cancelled_userid = (SELECT EmployeeID FROM Employees WHERE EmployeeCode = TblOrdersBOM.cancelled_userid)
WHERE cancelled_userid NOT IN (SELECT EmployeeID from Employees);
UPDATE TblOrdersBOM
SET paid_userid = (SELECT EmployeeID FROM Employees WHERE EmployeeCode = TblOrdersBOM.paid_userid)
WHERE paid_userid NOT IN (SELECT EmployeeID from Employees);
UPDATE TblOrdersBOM
SET DueDate_userid = (SELECT EmployeeID FROM Employees WHERE EmployeeCode = TblOrdersBOM.DueDate_userid)
WHERE DueDate_userid NOT IN (SELECT EmployeeID from Employees);
UPDATE TblOrdersBOM
SET credit_UserId = (SELECT EmployeeID FROM Employees WHERE EmployeeCode = TblOrdersBOM.credit_UserId)
WHERE credit_UserId NOT IN (SELECT EmployeeID from Employees);
UPDATE TblOrdersBOM
SET invoiced_UserId = (SELECT EmployeeID FROM Employees WHERE EmployeeCode = TblOrdersBOM.invoiced_UserId)
WHERE invoiced_UserId NOT IN (SELECT EmployeeID from Employees);

ALTER TABLE `TblOrdersBOM`
	ADD CONSTRAINT `FK_TblOrdersBOM_Employees`   FOREIGN KEY (`Remake_userId`) REFERENCES `Employees` (`EmployeeID`),
	ADD CONSTRAINT `FK_TblOrdersBOM_Employees_2` FOREIGN KEY (`estimate_userId`) REFERENCES `Employees` (`EmployeeID`),
	ADD CONSTRAINT `FK_TblOrdersBOM_Employees_3` FOREIGN KEY (`ordered_userid`) REFERENCES `Employees` (`EmployeeID`),
	ADD CONSTRAINT `FK_TblOrdersBOM_Employees_4` FOREIGN KEY (`released_userid`) REFERENCES `Employees` (`EmployeeID`),
	ADD CONSTRAINT `FK_TblOrdersBOM_Employees_5` FOREIGN KEY (`cancelled_userid`) REFERENCES `Employees` (`EmployeeID`),
	ADD CONSTRAINT `FK_TblOrdersBOM_Employees_6` FOREIGN KEY (`paid_userid`) REFERENCES `Employees` (`EmployeeID`),
	ADD CONSTRAINT `FK_TblOrdersBOM_Employees_7` FOREIGN KEY (`DueDate_userid`) REFERENCES `Employees` (`EmployeeID`),
	ADD CONSTRAINT `FK_TblOrdersBOM_Employees_8` FOREIGN KEY (`credit_UserId`) REFERENCES `Employees` (`EmployeeID`),
	ADD CONSTRAINT `FK_TblOrdersBOM_Employees_9` FOREIGN KEY (`invoiced_UserId`) REFERENCES `Employees` (`EmployeeID`);

ALTER TABLE `TblOrdersBOM`
	CHANGE COLUMN `Remake_UserLastName` `_unused_Remake_UserLastName` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `Remake_userId`,
	CHANGE COLUMN `estimate_UserLastName` `_unused_estimate_UserLastName` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `estimate_userId`,
	CHANGE COLUMN `ordered_UserLastName` `_unused_ordered_UserLastName` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `ordered_userid`,
	CHANGE COLUMN `released_userlastname` `_unused_released_userlastname` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `released_userid`,
	CHANGE COLUMN `cancelled_userLastName` `_unused_cancelled_userLastName` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `cancelled_userid`,
	CHANGE COLUMN `paid_userLastName` `_unused_paid_userLastName` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `paid_userid`,
	CHANGE COLUMN `DueDate_userlastname` `_unused_DueDate_userlastname` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `DueDate_userid`,
	CHANGE COLUMN `credit_UserLastName` `_unused_credit_UserLastName` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `credit_UserId`,
	CHANGE COLUMN `invoiced_UserLastName` `_unused_invoiced_UserLastName` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `invoiced_UserId`;

	
ALTER TABLE `TblOrdersBOM`
	DROP INDEX `TblOrdersBOM23`,
	ADD INDEX `idxShippingAddress` (`ShipCompanyName`, `ShipContactFirstName`, `ShipAddress1`, `ShipAddress2`, `ShipAddress3`, `ShipCity`, `ShipState`, `ShipPostalCode`, `PhoneNumber`, `FaxNumber`, `Email`),
	ADD INDEX `DateFinal` (`DateFinal`);

ALTER TABLE `TblOrdersBOM`
	CHANGE COLUMN `EmployeeID` `EnteredByEmployeeID` INT(10) NULL DEFAULT NULL AFTER `CompanyID`,
	CHANGE COLUMN `SalesMan_Id` `SalesmanEmployeeID` INT(10) NULL DEFAULT NULL AFTER `EnteredByEmployeeID`,
	CHANGE COLUMN `CustomerService_id` `CustomerServiceEmployeeID` INT(10) NULL DEFAULT NULL AFTER `SalesmanEmployeeID`;
	

ALTER TABLE `TblOrdersBOM`
	ALTER `DateCreated` DROP DEFAULT;
ALTER TABLE `TblOrdersBOM`
	CHANGE COLUMN `DateCreated` `DateCreated` DATETIME NOT NULL AFTER `hiddenInProductionReport`;


ALTER TABLE `TblOrdersBOM`
	CHANGE COLUMN `Estimate` `Estimate` TINYINT(4) NOT NULL DEFAULT '0' AFTER `Terms`,
	CHANGE COLUMN `Ordered` `Ordered` TINYINT(4) NOT NULL DEFAULT '0' AFTER `Estimate`,
	CHANGE COLUMN `Released` `Released` TINYINT(4) NOT NULL DEFAULT '0' AFTER `Ordered`,
	CHANGE COLUMN `Shipped` `Shipped` TINYINT(4) NOT NULL DEFAULT '0' AFTER `Released`,
	CHANGE COLUMN `Invoiced` `Invoiced` TINYINT(4) NOT NULL DEFAULT '0' AFTER `Shipped`,
	CHANGE COLUMN `Cancelled` `Cancelled` TINYINT(4) NOT NULL DEFAULT '0' AFTER `Invoiced`,
	CHANGE COLUMN `DueDate` `DueDate` DATETIME NULL DEFAULT NULL AFTER `Email`,
	CHANGE COLUMN `DateFinal` `DateFinal` DATETIME NULL DEFAULT NULL AFTER `DueDate`,
	CHANGE COLUMN `ShippedDate` `ShippedDate` DATETIME NULL DEFAULT NULL AFTER `ProductionDateSet`,
	CHANGE COLUMN `CreditCardCharged` `CreditCardCharged` TINYINT(4) NOT NULL DEFAULT '0' AFTER `Cancelled`;





	
	
	
	
	
DELIMITER $$
	
	
ALTER VIEW `vOrderItems` AS
SELECT `TblOrdersBOM_Items`.`OrderItemsID` AS `orderItemsID`,`TblOrdersBOM_Items`.`OrderID` AS `orderID`,
		`TblOrdersBOM_Items`.`GroupID` AS `GroupID`,`TblOrdersBOM_Items`.`UnitPrice` AS `unitPrice`,
		`TblOrdersBOM_Items`.`ProductName` AS `ProductName`,`TblOrdersBOM_Items`.`ProductDescription` AS `ProductDescription`,
		`TblOrdersBOM_Items`.`In_House_Notes` AS `in_house_notes`,`TblOrdersBOM_Items`.`QuantityOrdered` AS `QuantityOrdered`,
		`TblOrdersBOM_Items`.`UnitWeight` AS `unitWeight`,`TblOrdersBOM_Items`.`QuantityShipped` AS `quantityShipped`,
		`TblOrdersBOM_Items`.`Customer_Notes` AS `Customer_Notes`,`TblOrdersBOM_Items`.`DiscountPercent` AS `discountPercent`,
		`TblOrdersBOM_Items`.`Shipped` AS `shipped`,`TblOrdersBOM_Items`.`GroupSortField` AS `GroupSortField`,
		`TblOrdersBOM_Items`.`Special_Instructions` AS `Special_Instructions`,`fUnitPriceWithDiscount`(`TblOrdersBOM_Items`.`UnitPrice`,
		`TblOrdersBOM_Items`.`DiscountPercent`) AS `discountedUnitPrice`,
		`fItemPriceWithDiscount`(`TblOrdersBOM_Items`.`UnitPrice`,`TblOrdersBOM_Items`.`DiscountPercent`,`TblOrdersBOM_Items`.`QuantityOrdered`) AS `itemPrice`,
		`tbl_wood_type`.`d_name` AS `woodTypeName`,`FinishOption`.`title` AS `finishOptionTitle`,
		`Products`.`Unit_of_Measure` AS `Unit_of_Measure`,`Products`.`ProductType_id` AS `ProductType_Id`,
		`Products`.`ProductID` AS `ProductID`
FROM (((`TblOrdersBOM_Items`
LEFT JOIN `Products` ON((`Products`.`ProductID` = `TblOrdersBOM_Items`.`ProductID`)))
LEFT JOIN `tbl_wood_type` ON((`tbl_wood_type`.`id` = `Products`.`WoodTypeID`)))
LEFT JOIN `FinishOption` ON((`FinishOption`.`id` = `TblOrdersBOM_Items`.`FinishOptionID`)))
ORDER BY `TblOrdersBOM_Items`.`OrderItemsID` 
$$


DROP PROCEDURE IF EXISTS spPricePerCategory
$$

CREATE PROCEDURE `spPricePerCategory`(IN `orderID` INTEGER(11))
	LANGUAGE SQL
	DETERMINISTIC
	CONTAINS SQL
	SQL SECURITY INVOKER
	COMMENT ''
BEGIN

-- Calling fItemPriceWithDiscount here adds 1 second to the total time so we inline it instead
SELECT TblProductTypeType.title, Coalesce(Sum( Round(OBOMI.unitPrice * (1 - OBOMI.discountPercent), 2) * OBOMI.quantityOrdered ), 0) AS total
FROM TblProductType
	INNER JOIN TblProductTypeType ON TblProductTypeType.id = TblProductType.type_id
	LEFT JOIN Products            ON Products.ProductType_id = TblProductType.ProductType_id
	LEFT JOIN (
				SELECT ProductID, unitPrice, discountPercent, QuantityOrdered
				FROM TblOrdersBOM_Items
				WHERE TblOrdersBOM_Items.OrderId = orderID
				) AS OBOMI ON OBOMI.ProductID = Products.ProductId
GROUP BY TblProductType.type_id
ORDER BY TblProductType.type_id ASC;

END
$$

DROP PROCEDURE IF EXISTS spShipmentItemUpdateQuantity
$$

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
DECLARE itemOrderedQuantity DECIMAL(10,2);


SELECT TblOrdersBOM_ShipmentsItems.QuantityShipped, TblOrdersBOM_Items.QuantityShipped, TblOrdersBOM_Items.QuantityOrdered, TblOrdersBOM_Items.orderItemsID
INTO @shipmentQuantity, @itemShippedQuantity, @itemOrderedQuantity, @orderItemsID
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
Shipped = if(@itemOrderedQuantity <= @newItemShippedQuantity, 1, 0),
QuantityShipped = @newItemShippedQuantity
WHERE TblOrdersBOM_Items.OrderItemsID = @orderItemsID;
END
$$


DELIMITER ;