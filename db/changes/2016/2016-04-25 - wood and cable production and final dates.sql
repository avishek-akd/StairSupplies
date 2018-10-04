ALTER TABLE `TblOrdersBOM`
	CHANGE COLUMN `ProductionDate` `WoodProductionDate` DATE NULL DEFAULT NULL AFTER `Email`,
	CHANGE COLUMN `ProductionDateSet` `WoodProductionDateSet` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0' COMMENT '=1 if ProductionDate was set at least once (the customer was is sent an email about a production date being assigned on first set)' AFTER `WoodProductionDate`,
	CHANGE COLUMN `FinalDate` `WoodFinalDate` DATE NULL DEFAULT NULL AFTER `WoodProductionDateSet`,
	ADD COLUMN `CableProductionDate` DATE NULL DEFAULT NULL AFTER `WoodFinalDate`,
	ADD COLUMN `CableFinalDate` DATE NULL DEFAULT NULL AFTER `CableProductionDate`;