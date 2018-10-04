ALTER TABLE `TblOrdersBOM_Items`
	CHANGE COLUMN `QuantityPulled` `_unused_QuantityPulled` INT(11) NULL DEFAULT '0' AFTER `QuantityInProcess`;