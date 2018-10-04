ALTER TABLE `TblOrdersBOM`
	CHANGE COLUMN `notesLateOrderReport` `notesLateWoodOrderReport` VARCHAR(500) NULL DEFAULT NULL COMMENT 'Notes that appear only in Production > Late Wood Order' AFTER `hiddenInStockReport`,
	CHANGE COLUMN `hiddenInLateOrderRport` `hiddenInLateWoodOrderRport` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '=1 if the order is not displayed in Production > Late Wood Order report' AFTER `notesLateWoodOrderReport`,
	ADD COLUMN `notesLateCableOrderReport` VARCHAR(500) NULL DEFAULT NULL COMMENT 'Notes that appear only in Production > Late Cable Order' AFTER `hiddenInLateWoodOrderRport`,
	ADD COLUMN `hiddenInLateCableOrderRport` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '=1 if the order is not displayed in Production > Late Cable Order report' AFTER `notesLateCableOrderReport`;
