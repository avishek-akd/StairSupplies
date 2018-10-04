ALTER TABLE `TblOrdersBOM`
	CHANGE COLUMN `OrderTotal` `_unused_OrderTotal` DECIMAL(19,2) NOT NULL DEFAULT '0.00' AFTER `Canonical_Job_Name`,
	CHANGE COLUMN `OrderWeight` `_unused_OrderWeight` DECIMAL(10,2) NULL DEFAULT '0.00' AFTER `ShippingInHouseNotes`
;
