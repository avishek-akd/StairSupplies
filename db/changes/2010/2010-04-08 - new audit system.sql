RENAME TABLE `TblOrdersBOM_Update` TO `TblAudit`;
RENAME TABLE `TblOrdersBOM_UpdateDetails` TO `TblAuditFieldChange`;


ALTER TABLE `TblAudit`
	DROP FOREIGN KEY `TblOrdersBOM_Update_fk`,
	DROP FOREIGN KEY `TblOrdersBOM_Update_fk2`,
	DROP INDEX `TblOrdersBOM_Update_idx`, 
	DROP INDEX `TblOrdersBOM_Update_idx2`;
	
ALTER TABLE `TblAudit`
	ADD COLUMN `d_table_name` VARCHAR(50) NULL AFTER `id`,
	CHANGE COLUMN orderID `d_item_id` INT(10) NULL DEFAULT NULL AFTER `d_table_name`,
	CHANGE COLUMN employeeID `d_employee_id` INT(10) NULL DEFAULT NULL AFTER `d_item_id`,
	CHANGE COLUMN d_update_date `d_record_created` DATETIME NULL DEFAULT NULL AFTER `d_employee_id`,
	ADD COLUMN `d_message` VARCHAR(200) NULL DEFAULT NULL AFTER `d_employee_id`;

ALTER TABLE `TblAudit`
	ADD INDEX `idxEmployee` (`d_employee_id`),
	ADD INDEX `idxItem` (`d_item_id`),
	ADD CONSTRAINT `TblOrdersBOM_Update_fk2` FOREIGN KEY (`d_employee_id`) REFERENCES `Employees` (`EmployeeID`) ON UPDATE NO ACTION ON DELETE NO ACTION;


ALTER TABLE `TblAuditFieldChange`
	DROP FOREIGN KEY `TblOrdersBOM_UpdateDetails_fk`,
	CHANGE COLUMN `orderUpdateID` `d_audit_id` INT(10) NULL DEFAULT NULL AFTER `id`,
	CHANGE COLUMN `field_name` `d_field_name` VARCHAR(50) NULL DEFAULT NULL AFTER `d_audit_id`,
	CHANGE COLUMN `old_value` `d_old_value` VARCHAR(200) NULL DEFAULT NULL AFTER `d_field_name`,
	CHANGE COLUMN `new_value` `d_new_value` VARCHAR(200) NULL DEFAULT NULL AFTER `d_old_value`;

ALTER TABLE `TblAuditFieldChange`
	ADD CONSTRAINT `TblOrdersBOM_UpdateDetails_fk` FOREIGN KEY (`d_audit_id`) REFERENCES `TblAudit` (`id`) ON UPDATE NO ACTION ON DELETE CASCADE;


UPDATE TblAudit SET d_table_name = 'TblOrdersBOM';


ALTER TABLE `TblOrdersBOM`
	ADD COLUMN `Remake` TINYINT(1) NULL DEFAULT '0' AFTER `CustomerAcknowledgementSignature`,
	ADD COLUMN `RemakeNotes` VARCHAR(100) NULL DEFAULT NULL AFTER `Remake`;