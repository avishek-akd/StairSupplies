ALTER TABLE `Shipping_Methods`
	ADD COLUMN `byTruck` TINYINT(4) NOT NULL DEFAULT '0' COMMENT 'Shipped by own Truck ?' AFTER `tracking_url`;
