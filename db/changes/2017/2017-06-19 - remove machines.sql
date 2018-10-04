RENAME TABLE `TblMachineTrainedEmployee` TO `_unused_TblMachineTrainedEmployee`;
RENAME TABLE `TblMachine` TO `_unused_TblMachine`;


ALTER TABLE `tbl_settings_global`
	CHANGE COLUMN `machine_down_emails` `_unused_machine_down_emails` VARCHAR(500) NULL DEFAULT NULL COMMENT 'Comma separated list of emails that receive emails about machines being up or down.' COLLATE 'utf8_unicode_ci' AFTER `production_activity_show_all`;


DELETE FROM `Employees_module` WHERE  `Module_directory` = '/machines/';