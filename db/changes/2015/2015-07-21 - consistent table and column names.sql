RENAME TABLE `Company` TO `TblCompany`;
RENAME TABLE `Country` TO `TblCountry`;
RENAME TABLE `Shipping_Methods` TO `TblShippingMethods`;




ALTER TABLE `FinishOption`
	ALTER `record_created` DROP DEFAULT;
ALTER TABLE `FinishOption`
	CHANGE COLUMN `record_created` `RecordCreated` DATETIME NOT NULL AFTER `archive`,
	CHANGE COLUMN `record_updated` `RecordUpdated` DATETIME NULL DEFAULT NULL AFTER `RecordCreated`;

ALTER TABLE `TblFile`
	ALTER `record_created` DROP DEFAULT;
ALTER TABLE `TblFile`
	CHANGE COLUMN `record_created` `RecordCreated` DATETIME NOT NULL AFTER `thumbnail_height`,
	CHANGE COLUMN `record_updated` `RecordUpdated` DATETIME NULL DEFAULT NULL AFTER `RecordCreated`;

ALTER TABLE `Customers`
	CHANGE COLUMN `DateEntered` `RecordCreated` DATETIME NULL DEFAULT NULL AFTER `Archived`,
	CHANGE COLUMN `DateUpdated` `RecordUpdated` DATETIME NULL DEFAULT NULL AFTER `RecordCreated`;

ALTER TABLE `CustomerContact`
	ALTER `DateEntered` DROP DEFAULT;
ALTER TABLE `CustomerContact`
	CHANGE COLUMN `DateEntered` `RecordCreated` DATETIME NULL AFTER `PosibleDuplicates`,
	CHANGE COLUMN `DateUpdated` `RecordUpdated` DATETIME NULL DEFAULT NULL AFTER `RecordCreated`;
	
ALTER TABLE `Products`
	CHANGE COLUMN `DateEntered` `RecordCreated` DATETIME NULL DEFAULT NULL AFTER `Archived`,
	CHANGE COLUMN `DateUpdated` `RecordUpdated` DATETIME NULL DEFAULT NULL AFTER `RecordCreated`;

ALTER TABLE `TblVendor`
	ALTER `DateEntered` DROP DEFAULT;
ALTER TABLE `TblVendor`
	CHANGE COLUMN `mfg` `mfg` TINYINT(4) NULL DEFAULT '0' AFTER `DropShip`,
	CHANGE COLUMN `DateEntered` `RecordCreated` DATETIME NOT NULL AFTER `active`,
	CHANGE COLUMN `DateUpdated` `RecordUpdated` DATETIME NULL DEFAULT NULL AFTER `RecordCreated`;

ALTER TABLE `TblOrdersBOM`
	ALTER `DateCreated` DROP DEFAULT;
ALTER TABLE `TblOrdersBOM`
	CHANGE COLUMN `DateCreated` `RecordCreated` DATETIME NOT NULL AFTER `CableRailProductionDayID`,
	CHANGE COLUMN `DateUpdated` `RecordUpdated` DATETIME NULL DEFAULT NULL AFTER `RecordCreated`;

ALTER TABLE `TblOrdersBOM_Shipments`
	ALTER `DateAdded` DROP DEFAULT;
ALTER TABLE `TblOrdersBOM_Shipments`
	CHANGE COLUMN `DateAdded` `RecordCreated` DATETIME NOT NULL COMMENT 'Date when the shipment was added. Could be different from the date the shipment actually shipped' AFTER `isDelivered`,
	CHANGE COLUMN `DateUpdated` `RecordUpdated` DATETIME NULL DEFAULT NULL AFTER `RecordCreated`;

ALTER TABLE `TblOrdersBOM_ShipmentsItems`
	CHANGE COLUMN `DateAdded` `RecordCreated` DATETIME NULL DEFAULT NULL AFTER `BoxSkidNumber`,
	CHANGE COLUMN `DateUpdated` `RecordUpdated` DATETIME NULL DEFAULT NULL AFTER `RecordCreated`;



DELIMITER $$


DROP VIEW IF EXISTS vShippingMethodsActive
$$
CREATE SQL SECURITY DEFINER VIEW `vShippingMethodsActive` AS 
  select 
    `TblShippingMethods`.`ShippingMethodID` AS `ShippingMethodID`,
    `TblShippingMethods`.`ShippingMethod` AS `ShippingMethod`,
    `TblShippingMethods`.`TrackingNumberRequired` AS `TrackingNumberRequired`,
    `TblShippingMethods`.`EstimatedArrivalDateRequired` AS `EstimatedArrivalDateRequired` 
  from 
    `TblShippingMethods` 
  where 
    (`TblShippingMethods`.`active` = 1) 
  order by 
    `TblShippingMethods`.`ShippingMethod`
$$


DROP VIEW IF EXISTS vShipmentsShipped
$$
CREATE SQL SECURITY DEFINER VIEW `vShipmentsShipped` AS 
  select 
    `TblOrdersBOM_Shipments`.`OrderShipment_id` AS `OrderShipment_id`,
    `TblOrdersBOM_Shipments`.`ShipmentNumber` AS `ShipmentNumber`,
    `TblOrdersBOM_Shipments`.`OrderID` AS `OrderID`,
    `TblOrdersBOM_Shipments`.`ShippingMethodID` AS `ShippingMethodID`,
    `TblOrdersBOM_Shipments`.`pulled_by_id` AS `pulled_by_id`,
    `TblOrdersBOM_Shipments`.`packaged_by_id` AS `packaged_by_id`,
    `TblOrdersBOM_Shipments`.`processed_by_id` AS `processed_by_id`,
    `TblOrdersBOM_Shipments`.`TrackingNumber` AS `TrackingNumber`,
    `TblOrdersBOM_Shipments`.`EstimatedArrivalDate` AS `EstimatedArrivalDate`,
    `TblOrdersBOM_Shipments`.`Paid` AS `Paid`,
    `TblOrdersBOM_Shipments`.`Invoiced` AS `Invoiced`,
    `TblOrdersBOM_Shipments`.`InvoiceDate` AS `InvoiceDate`,
    `TblOrdersBOM_Shipments`.`actualShippingCosts` AS `actualShippingCosts`,
    `TblOrdersBOM_Shipments`.`isShipped` AS `isShipped`,
    `TblOrdersBOM_Shipments`.`ShippedDate` AS `ShippedDate`,
    `TblOrdersBOM_Shipments`.`isDelivered` AS `isDelivered`,
    `TblOrdersBOM_Shipments`.`RecordCreated` AS `RecordCreated`,
    `TblOrdersBOM_Shipments`.`RecordUpdated` AS `RecordUpdated` 
  from 
    `TblOrdersBOM_Shipments` 
  where 
    (`TblOrdersBOM_Shipments`.`isShipped` = 1);
$$


DELIMITER ;


