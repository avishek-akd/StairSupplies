ALTER TABLE `Products`
	ADD COLUMN `ProductionComplexityPoints` TINYINT UNSIGNED NULL DEFAULT 0 COMMENT 'How complex is the production for this product ? Higher values mean higher complexity.' AFTER `Production_Instructions`;

	
ALTER TABLE `FinishOption`
	ADD COLUMN `ProductionTimeInDays` TINYINT UNSIGNED NULL COMMENT 'How many days does it take to achieve this finish ?' AFTER `FinishImage`;

	
ALTER TABLE `TblProductType`
	ADD COLUMN `isPost` TINYINT(1) UNSIGNED NOT NULL DEFAULT '0' AFTER `ShowOnAddOrderItem`,
	ADD COLUMN `isHandrail` TINYINT(1) UNSIGNED NOT NULL DEFAULT '0' AFTER `isPost`;
