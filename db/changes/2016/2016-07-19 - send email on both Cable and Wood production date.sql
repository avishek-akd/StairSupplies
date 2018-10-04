ALTER TABLE `TblOrdersBOM`
	CHANGE COLUMN `WoodProductionDateSet` `WoodOrCableProductionDateSet` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0' COMMENT '=1 if WoodProductionDate was set at least once (the customer was is sent an email about a production date being assigned on first set)' AFTER `Email`;
