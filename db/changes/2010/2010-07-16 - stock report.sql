ALTER TABLE `TblOrdersBOM`
	ADD COLUMN `hiddenInStockReport` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '=1 if the order is not displayed in Stock report' AFTER `AcknowledgmentSent`;
