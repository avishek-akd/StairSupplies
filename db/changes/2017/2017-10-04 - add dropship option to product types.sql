ALTER TABLE TblProductType
	ADD COLUMN `RequiresDropship` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '=1 if it requires dropship' AFTER `isHandrail2`
;