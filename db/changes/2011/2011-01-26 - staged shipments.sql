ALTER TABLE `TblOrdersBOM_Shipments`
	CHANGE COLUMN `ShippingMethodUPS` `z_unused_ShippingMethodUPS` VARCHAR(200) NULL DEFAULT NULL AFTER `ShippingMethodID`;
ALTER TABLE `TblOrdersBOM_Shipments`
	CHANGE COLUMN `ShipmentNumber` `ShipmentNumber` VARCHAR(10) NOT NULL COMMENT 'Shipment Number is the order number plus the shipment index as a letter. For example for order 28000 we will have shipments: 28000-A, 28000-B, 28000-C, 28000-D, etc' AFTER `OrderShipment_id`;
ALTER TABLE `TblOrdersBOM_Shipments` 
	CHANGE COLUMN `delivered` `isDelivered` TINYINT(4) NOT NULL DEFAULT '0' COMMENT '=1 if the shipment was delivered, =0 otherwise. This is used for the iPhone application to avoid displaying shipments that are delivered.' AFTER `isShipped`;
ALTER TABLE `TblOrdersBOM_Shipments`
	CHANGE COLUMN `actual_shipping_cost` `actualShippingCosts` DECIMAL(10,2) NULL DEFAULT NULL AFTER `InvoiceDate`;

UPDATE TblOrdersBOM_Shipments SET DateAdded = DateUpdated WHERE DateAdded IS NULL;
ALTER TABLE `TblOrdersBOM_Shipments`
	CHANGE COLUMN `DateAdded` `DateAdded` DATETIME NOT NULL COMMENT 'Date when the shipment was added. Could be different from the date the shipment actually shipped';

	
ALTER TABLE `TblOrdersBOM_Shipments` 
	ADD COLUMN `isShipped` TINYINT(3) NOT NULL COMMENT '=1 if the shipment was shipped, =0 if it is staged and not yet shipped' AFTER `actualShippingCosts`,
	ADD COLUMN `ShippedDate` DATETIME NULL DEFAULT NULL COMMENT 'Date when the shipment is actually shipped (it is different than DateAdded for staged shipments)' AFTER `isShipped`;

UPDATE TblOrdersBOM_Shipments SET isShipped = 1;
UPDATE TblOrdersBOM_Shipments SET ShippedDate = DateAdded;



CREATE VIEW `vShipmentsShipped` AS 
  select 
    `TblOrdersBOM_Shipments`.`OrderShipment_id` AS `OrderShipment_id`,
    `TblOrdersBOM_Shipments`.`ShipmentNumber` AS `ShipmentNumber`,
    `TblOrdersBOM_Shipments`.`OrderID` AS `OrderID`,
    `TblOrdersBOM_Shipments`.`ShippingMethodID` AS `ShippingMethodID`,
    `TblOrdersBOM_Shipments`.`z_unused_ShippingMethodUPS` AS `z_unused_ShippingMethodUPS`,
    `TblOrdersBOM_Shipments`.`ShippedBy_Id` AS `ShippedBy_Id`,
    `TblOrdersBOM_Shipments`.`TrackingNumber` AS `TrackingNumber`,
    `TblOrdersBOM_Shipments`.`EstimatedArrivalDate` AS `EstimatedArrivalDate`,
    `TblOrdersBOM_Shipments`.`Paid` AS `Paid`,
    `TblOrdersBOM_Shipments`.`Invoiced` AS `Invoiced`,
    `TblOrdersBOM_Shipments`.`InvoiceDate` AS `InvoiceDate`,
    `TblOrdersBOM_Shipments`.`actualShippingCosts` AS `actualShippingCosts`,
    `TblOrdersBOM_Shipments`.`isShipped` AS `isShipped`,
    `TblOrdersBOM_Shipments`.`isDelivered` AS `isDelivered`,
    `TblOrdersBOM_Shipments`.`ShippedDate` AS `ShippedDate`,
    `TblOrdersBOM_Shipments`.`DateAdded` AS `DateAdded`,
    `TblOrdersBOM_Shipments`.`DateUpdated` AS `DateUpdated` 
  from 
    `TblOrdersBOM_Shipments` 
  where 
    (`TblOrdersBOM_Shipments`.`isShipped` = 1);