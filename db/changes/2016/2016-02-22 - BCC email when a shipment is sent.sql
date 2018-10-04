ALTER TABLE `tbl_settings_per_company`
	ADD COLUMN `d_email_shipment_shipped_bcc` VARCHAR(100) NULL DEFAULT '' AFTER `d_email_acknowledgment`;

UPDATE `tbl_settings_per_company`
SET `d_email_shipment_shipped_bcc`='d5dba7de70@trustpilotservice.com'
WHERE  `id`=1;
UPDATE `tbl_settings_per_company`
SET `d_email_shipment_shipped_bcc`=''
WHERE  `id`=4; 