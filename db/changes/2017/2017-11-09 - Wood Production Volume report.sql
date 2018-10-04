CREATE TABLE `TblOrdersBOM_LateOrders` (
	`Day` DATE NOT NULL,
	`NumberOfLateOrders` INT UNSIGNED NOT NULL,
	PRIMARY KEY(`Day`)
)
;


ALTER TABLE `tbl_settings_global`
	CHANGE COLUMN `emails_production_volume_report` `emails_cable_production_volume_report` VARCHAR(500) NOT NULL DEFAULT '' COLLATE 'utf8_unicode_ci' AFTER `emails_shipping_volume_report`,
	ADD COLUMN `emails_wood_production_volume_report` VARCHAR(500) NOT NULL DEFAULT '' AFTER `emails_cable_production_volume_report`
;



ALTER TABLE `TblOrdersBOM`
	ADD INDEX `idxCancelledReleasedOnHold` (`Cancelled`, `Released`, `OnHold`)
;
