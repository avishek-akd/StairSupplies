ALTER TABLE TblOrdersBOM
	ADD COLUMN `Backordered` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '=1 this order is backordered and it will be shown on the Backorder report' AFTER `hiddenInProductionReport`
;
