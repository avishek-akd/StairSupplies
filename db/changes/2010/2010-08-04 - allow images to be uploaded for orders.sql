ALTER TABLE `TblOrdersBOM_Files`
	ADD COLUMN `thumbnail` VARCHAR(100) NULL AFTER `file_name`,
	ADD COLUMN `thumbnail_width` INT NULL AFTER `thumbnail`,
	ADD COLUMN `thumbnail_height` INT NULL AFTER `thumbnail_width`;
