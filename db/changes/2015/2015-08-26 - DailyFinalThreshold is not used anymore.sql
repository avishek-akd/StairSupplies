ALTER TABLE `TblProductType`
	CHANGE COLUMN `DailyFinalThreshold` `_unused_DailyFinalThreshold` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Used in the weekly final activity report to show products that daily are over the threshold' AFTER `ShowInProductionReport`;
