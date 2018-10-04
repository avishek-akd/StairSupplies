ALTER TABLE `TblOrdersBOM`
	ADD COLUMN `ProductionDateSet` TINYINT UNSIGNED NOT NULL DEFAULT '0' COMMENT '=1 if ProductionDate was set at least once (the customer was is sent an email about a production date being assigned on first set)' AFTER `ProductionDate`;


UPDATE TblOrdersBOM
SET ProductionDateSet = 1
WHERE ProductionDate IS NOT NULL;