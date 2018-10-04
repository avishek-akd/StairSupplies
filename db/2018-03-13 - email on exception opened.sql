ALTER TABLE `tbl_settings_global`
	ADD COLUMN `emails_on_exception_opened` VARCHAR(500) NULL DEFAULT NULL COMMENT 'List of emails that get an email when a new exception is opened on an order item' AFTER `emails_due_date_changed`
;
UPDATE tbl_settings_global
SET emails_on_exception_opened = 'bharbaugh@stairsupplies.com'
;