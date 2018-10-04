ALTER TABLE `TblOrdersBOM_Items`
	CHANGE COLUMN `Unit_of_Measure` `z_unused_Unit_of_Measure` VARCHAR(10) NULL DEFAULT NULL AFTER `QuantityShipped`;
	