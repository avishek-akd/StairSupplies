ALTER TABLE `TblOrdersBOM`
	ADD COLUMN `notesLateOrderReport` VARCHAR(500) NULL DEFAULT NULL COMMENT 'Notes that appear only in Production > Late Order' AFTER `hiddenInStockReport`;

ALTER TABLE `TblOrdersBOM`
	ADD COLUMN `hiddenInLateOrderRport` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '=1 if the order is not displayed in Production > Late Order report' AFTER `notesLateOrderReport`;
