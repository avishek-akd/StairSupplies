ALTER TABLE `tbl_settings_per_company`
	ADD COLUMN `d_email_orders` VARCHAR(200) NULL DEFAULT NULL AFTER `d_order_policy`;

UPDATE tbl_settings_per_company
SET d_email_orders = 'orders@stairsupplies.com'
WHERE id = 1;

UPDATE tbl_settings_per_company
SET d_email_orders = 'orders@viewrailsystems.com'
WHERE id = 4;