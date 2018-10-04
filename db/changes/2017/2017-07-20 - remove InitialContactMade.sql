ALTER TABLE TblOrdersBOM
	CHANGE COLUMN `InitialContactMade` `_unused_InitialContactMade` TINYINT NOT NULL DEFAULT 0,
	CHANGE COLUMN `InitialContactMade_date` `_unused_InitialContactMade_date` DATETIME NULL DEFAULT NULL,
	CHANGE COLUMN `InitialContactMade_userId` `_unused_InitialContactMade_userId` INT(11) NULL DEFAULT NULL
;
