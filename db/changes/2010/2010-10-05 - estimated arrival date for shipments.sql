ALTER TABLE `TblOrdersBOM_Shipments`
	ADD COLUMN `EstimatedArrivalDate` DATE NULL
		COMMENT 'When the shipping method is some combination of Truck this contains the date the shipment is estimated to reach the client.' AFTER `TrackingNumber`;


ALTER TABLE `Shipping_Methods`  DROP COLUMN `display_in_confirmation`;

ALTER TABLE `Shipping_Methods`
	CHANGE COLUMN `is_required` `TrackingNumberRequired` TINYINT(4) NULL DEFAULT NULL AFTER `active`,
	ADD COLUMN `EstimatedArrivalDateRequired` TINYINT(4) NULL DEFAULT NULL AFTER `TrackingNumberRequired`;

UPDATE Shipping_Methods
SET EstimatedArrivalDateRequired = 0;

ALTER TABLE `Shipping_Methods`
	CHANGE COLUMN `TrackingNumberRequired` `TrackingNumberRequired` TINYINT(4) NOT NULL COMMENT 'Is the tracking number required when adding a shipment ?' AFTER `active`,  CHANGE COLUMN `EstimatedArrivalDateRequired` `EstimatedArrivalDateRequired` TINYINT(4) NOT NULL AFTER `TrackingNumberRequired`,
	CHANGE COLUMN `EstimatedArrivalDateRequired` `EstimatedArrivalDateRequired` TINYINT(4) NOT NULL COMMENT 'Is the estimated arrival date required when adding a shipment ? The date is required only for Truck shipments .' AFTER `TrackingNumberRequired`,
	CHANGE COLUMN `ShippingMethod` `ShippingMethod` VARCHAR(50) NOT NULL AFTER `ShippingMethodID`;
