ALTER TABLE `tbl_settings_per_company`
	ADD COLUMN `d_email_acknowledgment_in_house` VARCHAR(100) NULL DEFAULT NULL AFTER `d_email_acknowledgment`;

UPDATE tbl_settings_per_company
SET
	d_email_acknowledgment_in_house = d_email_acknowledgment;

UPDATE tbl_settings_per_company
SET d_email_acknowledgment_in_house = 'Stair Supplies <acknowledgments@stairsupplies.com>'
WHERE id = 1;
