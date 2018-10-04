ALTER TABLE `tbl_settings1`
	ALTER `conversion_factor_machine1` DROP DEFAULT,
	ALTER `conversion_factor_machine2` DROP DEFAULT;
ALTER TABLE `tbl_settings1`
	CHANGE COLUMN `conversion_factor_machine1` `conversion_factor_machine1` DECIMAL(5,2) NOT NULL AFTER `id`,
	CHANGE COLUMN `conversion_factor_machine2` `conversion_factor_machine2` DECIMAL(5,2) NOT NULL AFTER `conversion_factor_machine1`,
	ADD COLUMN `stain_costs_multiplier` DECIMAL(5,2) NOT NULL COMMENT '1.2 for 120%, 0.9 for 90% (smaller costs)' AFTER `conversion_factor_machine2`;

	
RENAME TABLE `tbl_settings1` TO `tbl_settings_global`;

RENAME TABLE `tbl_settings` TO `tbl_settings_per_company`;