ALTER TABLE TblProductType
	ADD COLUMN ShowInProductionReport TINYINT(1) UNSIGNED NOT NULL DEFAULT '1' COMMENT '=1 The product type is displayed in the report, =0 not' AFTER description,
	ADD COLUMN DailyFinalThreshold INT UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Used in the weekly final activity report to show products that daily are over the threshold' AFTER ShowInProductionReport;
