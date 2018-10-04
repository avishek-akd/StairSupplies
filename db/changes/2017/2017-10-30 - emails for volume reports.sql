ALTER TABLE `tbl_settings_global`
	ADD COLUMN `emails_shipping_volume_report` VARCHAR(500) NOT NULL DEFAULT '' AFTER `production_activity_show_all`,
	ADD COLUMN `emails_production_volume_report` VARCHAR(500) NOT NULL DEFAULT '' AFTER `emails_shipping_volume_report`
;
