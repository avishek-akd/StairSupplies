ALTER TABLE `TblOrdersBOM`
	DROP COLUMN `z_unused_WoodType`;
ALTER TABLE `TblOrdersBOM_Items`
	DROP COLUMN `z_unused_Unit_of_Measure`;
ALTER TABLE `TblOrdersBOM_Shipments`
	DROP COLUMN `_z_unused_ShippedBy_Id`,
	DROP INDEX `TblOrdersBOM_ShipmentsItems_idx3`,
	DROP FOREIGN KEY `TblOrdersBOM_Shipments_fk`;
ALTER TABLE `tblRGARequest`
	DROP COLUMN `_z_unused_d_notes_customer`;



--  view: vShipmentsShipped
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
    `TblOrdersBOM_Shipments`.`DateAdded` AS `DateAdded`,
    `TblOrdersBOM_Shipments`.`DateUpdated` AS `DateUpdated`
  from
    `TblOrdersBOM_Shipments`
  where
    (`TblOrdersBOM_Shipments`.`isShipped` = 1)