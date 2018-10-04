ALTER TABLE `tbl_settings_global`
	ADD COLUMN `production_activity_show_all` TINYINT(1) NOT NULL COMMENT 'Show all orders on Production Activity report' AFTER `late_order_days`;
UPDATE `tbl_settings_global` SET `production_activity_show_all`=0 WHERE  `id`=1;