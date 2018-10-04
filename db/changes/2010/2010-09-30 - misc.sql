ALTER TABLE `Shipping_Methods`
	CHANGE COLUMN `ShippingMethod` `ShippingMethod` VARCHAR(50) NULL DEFAULT NULL AFTER `ShippingMethodID`;