ALTER TABLE TblOrdersBOM
	ADD COLUMN `hiddenInUnbalancedOrdersReport` BIT NOT NULL DEFAULT 0 AFTER `_unused_CableRailProductionDayID`
;