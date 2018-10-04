UPDATE TblOrdersBOM_Note
SET
	NoteInHouse = Concat('Reason For Loss: ', NoteReasonForLoss)
WHERE NoteReasonForLoss IS NOT NULL
;


ALTER TABLE `TblOrdersBOM_Note`
	CHANGE COLUMN `NoteReasonForLoss` `_unused_NoteReasonForLoss` VARCHAR(4000) NULL DEFAULT NULL,
	CHANGE COLUMN `NoteReasonForWin` `_unused_NoteReasonForWin` VARCHAR(4000) NULL DEFAULT NULL
;