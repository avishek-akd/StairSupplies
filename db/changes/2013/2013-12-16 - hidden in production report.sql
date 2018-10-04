ALTER TABLE `TblOrdersBOM`
	ADD COLUMN `hiddenInProductionReport` TINYINT(1) NOT NULL DEFAULT '1' COMMENT '=1 if the order is not displayed in Production > Production Activity' AFTER `hiddenInLateOrderRport`;

UPDATE TblOrdersBOM
SET hiddenInProductionReport = 0;