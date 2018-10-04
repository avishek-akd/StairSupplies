ALTER TABLE `tbl_settings_per_company`
	ADD COLUMN `d_email_noreply` VARCHAR(100) NULL DEFAULT NULL AFTER `d_email_sales`;
UPDATE `tbl_settings_per_company` SET `d_email_noreply`='noreply@stairsupplies.com' WHERE  `id`=1; 
UPDATE `tbl_settings_per_company` SET `d_email_noreply`='noreply@nu-wood.com' WHERE  `id`=2; 
UPDATE `tbl_settings_per_company` SET `d_email_noreply`='noreply@wildwoodmillwork.com' WHERE  `id`=3; 
UPDATE `tbl_settings_per_company` SET `d_email_noreply`='noreply@viewrailsystems.com' WHERE  `id`=4; 

