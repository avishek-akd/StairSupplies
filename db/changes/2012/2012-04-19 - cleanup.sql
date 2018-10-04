	
-- vShipmentsShipped view uses one of the deprecated fields
select `TblOrdersBOM_Shipments`.`OrderShipment_id` AS `OrderShipment_id`,`TblOrdersBOM_Shipments`.`ShipmentNumber` AS `ShipmentNumber`,`TblOrdersBOM_Shipments`.`OrderID` AS `OrderID`,`TblOrdersBOM_Shipments`.`ShippingMethodID` AS `ShippingMethodID`,`TblOrdersBOM_Shipments`.`ShippedBy_Id` AS `ShippedBy_Id`,`TblOrdersBOM_Shipments`.`TrackingNumber` AS `TrackingNumber`,`TblOrdersBOM_Shipments`.`EstimatedArrivalDate` AS `EstimatedArrivalDate`,`TblOrdersBOM_Shipments`.`Paid` AS `Paid`,`TblOrdersBOM_Shipments`.`Invoiced` AS `Invoiced`,`TblOrdersBOM_Shipments`.`InvoiceDate` AS `InvoiceDate`,`TblOrdersBOM_Shipments`.`actualShippingCosts` AS `actualShippingCosts`,`TblOrdersBOM_Shipments`.`isShipped` AS `isShipped`,`TblOrdersBOM_Shipments`.`isDelivered` AS `isDelivered`,`TblOrdersBOM_Shipments`.`ShippedDate` AS `ShippedDate`,`TblOrdersBOM_Shipments`.`DateAdded` AS `DateAdded`,`TblOrdersBOM_Shipments`.`DateUpdated` AS `DateUpdated` from `TblOrdersBOM_Shipments` where (`TblOrdersBOM_Shipments`.`isShipped` = 1) 


ALTER TABLE Products
	DROP COLUMN z_unused_Qty_On_Hand,
	DROP COLUMN z_unused_PiecesPerCarton,
	DROP COLUMN z_unused_Pcs_Per_box;
ALTER TABLE TblOrdersBOM_Shipments
	DROP COLUMN z_unused_ShippingMethodUPS;
ALTER TABLE TblProductType
	DROP COLUMN z_unused_type;

