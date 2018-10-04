ALTER TABLE tbl_settings_per_company
	ADD COLUMN `d_email_signature_orders` VARCHAR(1500) NULL DEFAULT '' AFTER `d_email_acknowledgment_in_house`,
	ADD COLUMN `d_email_signature_customer_service` VARCHAR(1500) NULL DEFAULT '' AFTER `d_email_signature_orders`,
	ADD COLUMN `d_email_signature_accounting` VARCHAR(1500) NULL DEFAULT '' AFTER `d_email_signature_customer_service`,
	ADD COLUMN `d_email_signature_noreply` VARCHAR(1500) NULL DEFAULT '' AFTER `d_email_signature_accounting`,
	ADD COLUMN `d_email_signature_quotation` VARCHAR(1500) NULL DEFAULT '' AFTER `d_email_signature_noreply`,
	ADD COLUMN `d_email_signature_invoice` VARCHAR(1500) NULL DEFAULT '' AFTER `d_email_signature_quotation`,
	ADD COLUMN `d_email_signature_shipping` VARCHAR(1500) NULL DEFAULT '' AFTER `d_email_signature_invoice`,
	ADD COLUMN `d_email_signature_acknowledgment` VARCHAR(1500) NULL DEFAULT '' AFTER `d_email_signature_shipping`,
	ADD COLUMN `d_email_signature_acknowledgment_in_house` VARCHAR(1500) NULL DEFAULT '' AFTER `d_email_signature_acknowledgment`
;