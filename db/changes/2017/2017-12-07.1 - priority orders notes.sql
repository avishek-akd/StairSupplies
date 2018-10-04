ALTER TABLE TblOrdersBOM
	ADD COLUMN `PriorityReportNotes` VARCHAR(500) NULL DEFAULT NULL COMMENT 'Notes that appear and can be edited from the Priority Orders report' AFTER `Secondary_Production_Notes`
;