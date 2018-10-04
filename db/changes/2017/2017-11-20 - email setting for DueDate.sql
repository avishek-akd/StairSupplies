ALTER TABLE `tbl_settings_global`
	ADD COLUMN `emails_due_date_changed` VARCHAR(500) NULL DEFAULT NULL COMMENT 'List of emails that get an email when the due date changes.' AFTER `emails_wood_production_volume_report`
;