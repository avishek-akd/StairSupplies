ALTER TABLE `TblOrdersBOM`
	CHANGE COLUMN `FreightCharge` `FreightCharge` DECIMAL(19,2) NULL DEFAULT '0.00' AFTER `OrderTotal`;
