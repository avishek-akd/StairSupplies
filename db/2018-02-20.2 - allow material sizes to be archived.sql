ALTER TABLE `TblMaterialSize`
	ALTER `d_sort_field` DROP DEFAULT
;
ALTER TABLE `TblMaterialSize`
	CHANGE COLUMN `d_sort_field` `d_sort_field` TINYINT(4) NOT NULL AFTER `d_name`,
	ADD COLUMN `d_is_active` TINYINT(1) NOT NULL DEFAULT 0 AFTER `d_sort_field`,
	ADD COLUMN `d_record_created` DATETIME NULL DEFAULT NULL AFTER `d_is_active`,
	ADD COLUMN `d_record_updated` DATETIME NULL DEFAULT NULL AFTER `d_record_created`
;
UPDATE TblMaterialSize
SET d_is_active = 1
;
INSERT INTO TblMaterialSize
	(d_name, d_sort_field, d_is_active, d_record_created)
VALUES
	('4/4 x 9-10', 0, 1, Now()),
	('4/4 x 11-12', 0, 1, Now()),
	('4/4 x 13+', 0, 1, Now()),
	('5/4 x 9-10', 0, 1, Now()),
	('5/4 x 11-12', 0, 1, Now()),
	('5/4 x 13+', 0, 1, Now()),
	('6/4 x 9-10', 0, 1, Now()),
	('6/4 x 11-12', 0, 1, Now()),
	('8/4 x 7-8', 0, 1, Now()),
	('8/4 x 9-10', 0, 1, Now()),
	('8/4 x 11-12', 0, 1, Now()),
	('8/4 x 13+', 0, 1, Now())
;
