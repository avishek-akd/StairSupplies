ALTER TABLE TblFinishOption
	ADD COLUMN `VictorName` VARCHAR(100) NULL DEFAULT NULL COMMENT 'Victor mapping for this finish, used to match finishes when importing from Victor' AFTER `description`
;
UPDATE TblFinishOption
SET
	VictorName = 'Black'
WHERE id = 231
;

ALTER TABLE tbl_settings_global
	ADD COLUMN `VictorImportEnabled` TINYINT(1) NOT NULL DEFAULT 0
;
UPDATE tbl_settings_global
SET VictorImportEnabled = 1
;