ALTER TABLE `TblProductType`
	ADD COLUMN `warnOnUnsetPRCOrFinal` TINYINT(1) NULL DEFAULT '0' COMMENT '=1 the shipping module will issue a warning when PRC or Final are unset when shipping an item' AFTER `DailyFinalThreshold`;




