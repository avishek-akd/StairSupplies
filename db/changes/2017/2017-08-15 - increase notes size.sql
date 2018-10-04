ALTER TABLE `TblOrdersBOM_Note`
	CHANGE COLUMN `NoteInHouse` `NoteInHouse` VARCHAR(5000) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `EmployeeID`,
	CHANGE COLUMN `NoteFromCustomer` `NoteFromCustomer` VARCHAR(5000) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `NoteInHouse`,
	CHANGE COLUMN `NoteProjectTimeFrame` `NoteProjectTimeFrame` VARCHAR(5000) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `NoteFromCustomer`,
	DROP COLUMN `_unused_NoteReasonForLoss`,
	DROP COLUMN `_unused_NoteReasonForWin`
;