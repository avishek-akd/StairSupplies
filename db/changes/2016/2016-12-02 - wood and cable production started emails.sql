ALTER TABLE `tbl_settings_per_company`
	CHANGE COLUMN `d_email_content_production_started` `d_email_content_wood_production_started` VARCHAR(1000) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `d_email_footer_purchasing`,
	ADD COLUMN `d_email_content_cable_production_started` VARCHAR(1000) NULL DEFAULT NULL AFTER `d_email_content_wood_production_started`;

UPDATE tbl_settings_per_company
SET d_email_content_cable_production_started = d_email_content_wood_production_started;



ALTER TABLE `TblOrdersBOM`
	CHANGE COLUMN `ProductionEmailWasSent` `WoodProductionEmailWasSent` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0'
			COMMENT '=1 if email was sent to customer about wood production starting' AFTER `_unused_ShipPhoneNumber`,
	ADD COLUMN `CableProductionEmailWasSent` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0'
			COMMENT '=1 if email was sent to customer about cable production starting' AFTER `WoodProductionEmailWasSent`;

UPDATE TblOrdersBOM
SET CableProductionEmailWasSent = WoodProductionEmailWasSent;