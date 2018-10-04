ALTER TABLE `Customers` DROP FOREIGN KEY `Customers_fk2`;
ALTER TABLE `Customers`
	CHANGE COLUMN `FollowUpPerson` `z_unused_FollowUpPerson` INT(10) NULL DEFAULT NULL AFTER `SalesPerson`,
	ADD CONSTRAINT `Customers_fk2` FOREIGN KEY (`z_unused_FollowUpPerson`) REFERENCES `Employees` (`EmployeeID`) ON UPDATE NO ACTION ON DELETE NO ACTION,
	ADD COLUMN `CustomerServicePersonID` INT(10) NULL DEFAULT NULL AFTER `SalesPerson`,
	ADD CONSTRAINT `FK_Customers_Employees` FOREIGN KEY (`CustomerServicePersonID`) REFERENCES `Employees` (`EmployeeID`) ON UPDATE NO ACTION ON DELETE NO ACTION;	
	
ALTER TABLE `Customers`
	CHANGE COLUMN `defaultDiscount` `defaultDiscount` DECIMAL(10,4) UNSIGNED NULL DEFAULT '0.0000' COMMENT 'Default discount applied to new orders' AFTER `BillingEmails`,
	ADD COLUMN `defaultShippingMethodID` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT 'Default shipping method for new orders' AFTER `iPhoneToken`;

ALTER TABLE `TblOrdersBOM`
	ADD COLUMN `AcknowledgmentSent` TINYINT(1) NULL DEFAULT '0' COMMENT 'Acknowledgement was sent to customer ?' AFTER `invoiced_UserLastName`;

-- Previous orders are considered to have the ack sent
UPDATE TblOrdersBOM
SET AcknowledgmentSent = 1;



CREATE TABLE `TblOrdersBOM_Files` (
	`id` INT(10) NOT NULL AUTO_INCREMENT,
	`orderID` INT(10) NOT NULL,
	`file_name` VARCHAR(50) NOT NULL,
	`record_created` DATETIME NOT NULL,
	PRIMARY KEY (`id`),
	INDEX `idxOrder` (`orderID`),
	CONSTRAINT `FK_TblOrdersBOM_Files_TblOrdersBOM` FOREIGN KEY (`orderID`)
			REFERENCES `TblOrdersBOM` (`orderID`) ON UPDATE NO ACTION ON DELETE NO ACTION
)  COLLATE 'utf8_general_ci' ENGINE=InnoDB;

ALTER TABLE `TBLVendor`  CHANGE COLUMN `Logo` `z_unused_Logo` LONGBLOB NULL AFTER `DropShip`;

ALTER TABLE `Products`  CHANGE COLUMN `ProductName` `ProductName` VARCHAR(100) NOT NULL AFTER `ProductType_id`;
ALTER TABLE `Products`  CHANGE COLUMN `Qty_Allocated` `z_unused_Qty_Allocated` INT(10) NOT NULL DEFAULT '0' AFTER `Qty_to_reorder`;
ALTER TABLE `Products`  CHANGE COLUMN `Qty_to_reorder` `z_unused_Qty_to_reorder` INT(10) NOT NULL DEFAULT '0' AFTER `Qty_Available`;
ALTER TABLE `Products`  CHANGE COLUMN `Qty_Reorder_Min` `z_unused_Qty_Reorder_Min` INT(10) NOT NULL DEFAULT '0' AFTER `Qty_On_Hand`;
ALTER TABLE `Products`  CHANGE COLUMN `Qty_BackOrdered` `z_unused_Qty_BackOrdered` INT(10) NOT NULL DEFAULT '0' AFTER `z_unused_Qty_Allocated`;
ALTER TABLE `Products`  CHANGE COLUMN `Qty_On_Order` `z_unused_Qty_On_Order` INT(10) NOT NULL DEFAULT '0' AFTER `z_unused_Qty_Reorder_Min`;
ALTER TABLE `Products`  CHANGE COLUMN `Qty_Available` `z_unused_Qty_Available` INT(10) NOT NULL DEFAULT '0' AFTER `z_unused_Qty_On_Order`;
ALTER TABLE `Products`  CHANGE COLUMN `PUnitPrice` `PUnitPrice` DECIMAL(19,4) NOT NULL DEFAULT '0.0000' AFTER `Product_Descripton`;
ALTER TABLE `Products`  CHANGE COLUMN `Inventory_Number` `z_unused_Inventory_Number` VARCHAR(50) NULL DEFAULT '0' AFTER `Purchase_Price`;

ALTER TABLE `Products`  DROP INDEX `Products60`;

ALTER TABLE `Products`
	DROP INDEX `idx_Products_ProductType_id`,
	ADD INDEX `idx_ProductType_id` (`ProductType_id`), 
	DROP INDEX `IX_Product_Descripton`,  
	ADD INDEX `idx_Product_Descripton` (`Product_Descripton`(255)),
	DROP INDEX `IX_ProductName`,
	ADD INDEX `idx_ProductName` (`ProductName`), 
	DROP INDEX `IX_Vendor_ID`, 
	ADD INDEX `idx_Vendor_ID` (`Vendor_ID`), 
	DROP INDEX `Products_idx`, 
	ADD INDEX `idx_CompanyID` (`CompanyID`), 
	DROP INDEX `Products_idx2`, 
	ADD INDEX `idx_SpeciesID` (`SpeciesID`);

ALTER TABLE `Products_OrderItems_Files`
	DROP INDEX `Index 2`,
	ADD INDEX `idx_productID` (`productID`),
	DROP INDEX `Index 3`,
	ADD INDEX `idx_orderItemsID` (`orderItemsID`);

	

CREATE VIEW `shippingMethodsActive` ALGORITHM = UNDEFINED AS
select `Shipping_Methods`.`ShippingMethodID` AS `ShippingMethodID`,`Shipping_Methods`.`ShippingMethod` AS `ShippingMethod`,`Shipping_Methods`.`is_required` AS `is_required`
from `Shipping_Methods` where (`Shipping_Methods`.`active` = 1) order by `Shipping_Methods`.`ShippingMethod`;



CREATE PROCEDURE `shipmentItemUpdateQuantity`(IN `OrderShipmentItemsID` INT, IN `quantityToShip` DECIMAL(10,2), IN `BoxSkidNumber` VARCHAR(100))
	LANGUAGE SQL  NOT DETERMINISTIC  CONTAINS SQL  SQL SECURITY DEFINER
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


	--
	-- Update shipment item
	--
	UPDATE TblOrdersBOM_ShipmentsItems
	SET
		TblOrdersBOM_ShipmentsItems.QuantityShipped = quantityToShip,
		TblOrdersBOM_ShipmentsItems.BoxSkidNumber   = BoxSkidNumber,
		DateUpdated                                 = Now()
	WHERE TblOrdersBOM_ShipmentsItems.OrderShipmentItemsID = OrderShipmentItemsID;
	

	-- 
	-- Update order item
	-- 
	SET @newItemShippedQuantity = @itemShippedQuantity - @shipmentQuantity + quantityToShip;
	UPDATE TblOrdersBOM_Items
	SET
		--  Mark the item as shipped if we shipped the whole quantity
		Shipped = if(@itemQuantity <= @newItemShippedQuantity, 1, 0),
		QuantityShipped = @newItemShippedQuantity
	WHERE TblOrdersBOM_Items.OrderItemsID = @orderItemsID;
END;
