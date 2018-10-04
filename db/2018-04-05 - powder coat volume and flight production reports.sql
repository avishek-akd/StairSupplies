ALTER TABLE `tbl_settings_global`
	ADD COLUMN `emails_powder_coat_volume` VARCHAR(500) NULL DEFAULT NULL AFTER `emails_wood_production_volume_report`,
	ADD COLUMN `emails_flight_production` VARCHAR(500) NULL DEFAULT NULL AFTER `emails_powder_coat_volume`
;
UPDATE `tbl_settings_global`
SET
	emails_powder_coat_volume = 'bharbaugh@stairsupplies.com',
	emails_flight_production = 'bharbaugh@stairsupplies.com'
;