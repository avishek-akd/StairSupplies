ALTER TABLE TblOrdersBOM
	CHANGE COLUMN `_unused_InitialContactMade` `InitialContactMade` TINYINT NOT NULL DEFAULT 0,
	CHANGE COLUMN `_unused_InitialContactMade_date` `InitialContactMade_date` DATETIME NULL DEFAULT NULL,
	CHANGE COLUMN `_unused_InitialContactMade_userId` `InitialContactMade_userId` INT(11) NULL DEFAULT NULL
;
