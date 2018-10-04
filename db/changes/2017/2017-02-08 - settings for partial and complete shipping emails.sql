ALTER TABLE `tbl_settings_per_company`
	CHANGE COLUMN `d_email_shipment_shipped_bcc` `d_email_shipped_partial_bcc` VARCHAR(100) NULL DEFAULT '' COLLATE 'utf8_unicode_ci' AFTER `d_email_acknowledgment_in_house`,
	ADD COLUMN `d_email_shipped_partial_subject` VARCHAR(100) NULL DEFAULT '' AFTER `d_email_shipped_partial_bcc`,
	ADD COLUMN `d_email_shipped_partial_content` VARCHAR(500) NULL DEFAULT '' AFTER `d_email_shipped_partial_subject`,
	ADD COLUMN `d_email_shipped_complete_bcc` VARCHAR(100) NULL DEFAULT '' AFTER `d_email_shipped_partial_content`,
	ADD COLUMN `d_email_shipped_complete_subject` VARCHAR(100) NULL DEFAULT '' AFTER `d_email_shipped_complete_bcc`,
	ADD COLUMN `d_email_shipped_complete_content` VARCHAR(500) NULL DEFAULT '' AFTER `d_email_shipped_complete_subject`;
