ALTER TABLE `TblOrdersBOM_Transactions`
	COLLATE='utf8_unicode_ci'
;
ALTER TABLE `TblOrdersBOM_Transactions_Accounting`
	COLLATE='utf8_unicode_ci'
;


ALTER TABLE `TblAudit`
	CHANGE COLUMN `id` `AuditID` INT(10) NOT NULL AUTO_INCREMENT FIRST,
	CHANGE COLUMN `d_table_name` `TableName` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `AuditID`,
	CHANGE COLUMN `d_employee_id` `EmployeeID` INT(10) NULL DEFAULT NULL AFTER `CustomerID`,
	CHANGE COLUMN `d_message` `AuditMessage` VARCHAR(200) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `EmployeeID`,
	CHANGE COLUMN `d_email_sent_to` `EmailSentTo` VARCHAR(200) NULL DEFAULT NULL COMMENT 'For email audit entries this keeps the email address it was sent to.' COLLATE 'utf8_unicode_ci' AFTER `AuditMessage`,
	CHANGE COLUMN `d_email_message` `EmailMessage` VARCHAR(3000) NULL DEFAULT NULL COMMENT 'The message that the user typed (not the actual full email).' COLLATE 'utf8_unicode_ci' AFTER `EmailSentTo`,
	CHANGE COLUMN `d_file` `AuditFileName` VARCHAR(100) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `EmailMessage`,
	CHANGE COLUMN `groupActionsJSON` `GroupActionsJSON` VARCHAR(2000) NULL DEFAULT NULL COMMENT 'While a group is open this holds the actions in JSON format.' COLLATE 'utf8_unicode_ci' AFTER `AuditFileName`,
	CHANGE COLUMN `groupLastAction` `GroupLastAction` DATETIME NULL DEFAULT NULL COMMENT 'Time of the last recorded action on this group ' AFTER `GroupActionsJSON`,
	CHANGE COLUMN `d_record_created` `RecordCreated` DATETIME NULL DEFAULT NULL AFTER `GroupLastAction`
;
ALTER TABLE `TblAuditFieldChange`
	CHANGE COLUMN `id` `AuditFieldChangeID` INT(10) NOT NULL AUTO_INCREMENT FIRST,
	CHANGE COLUMN `d_audit_id` `AuditID` INT(10) NULL DEFAULT NULL AFTER `AuditFieldChangeID`,
	CHANGE COLUMN `d_field_name` `FieldName` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `AuditID`,
	CHANGE COLUMN `d_old_value` `OldValue` VARCHAR(200) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `FieldName`,
	CHANGE COLUMN `d_new_value` `NewValue` VARCHAR(200) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `OldValue`
;



ALTER TABLE `TblAudit`
	DROP FOREIGN KEY `FK_TblAudit_d_employee_id`
;
ALTER TABLE `TblAudit`
	DROP INDEX `idxFK_d_employee_id`,
	ADD INDEX `idxFK_EmployeeID` (`EmployeeID`),
	DROP INDEX `idx_LastGroupUpdate`,
	ADD INDEX `idx_GroupLastAction` (`GroupLastAction`),
	ADD CONSTRAINT `FK_TblAudit_EmployeeID` FOREIGN KEY (`EmployeeID`) REFERENCES `TblEmployee` (`EmployeeID`) ON UPDATE NO ACTION ON DELETE NO ACTION
;
ALTER TABLE `TblAuditFieldChange`
	DROP FOREIGN KEY `FK_TblAuditFieldChange_d_audit_id`
;
ALTER TABLE `TblAuditFieldChange`
	ADD CONSTRAINT `FK_TblAuditFieldChange_AuditID` FOREIGN KEY (`AuditID`) REFERENCES `TblAudit` (`AuditID`) ON UPDATE NO ACTION ON DELETE CASCADE
;