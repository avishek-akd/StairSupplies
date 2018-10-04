ALTER TABLE `TblOrdersBOM_Shipments_Signature`
	ADD COLUMN `location_lat` DECIMAL(10,6) NULL AFTER `request_ip`,
	ADD COLUMN `location_long` DECIMAL(10,6) NULL AFTER `location_lat`;
