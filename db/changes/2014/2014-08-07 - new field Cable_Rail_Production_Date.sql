ALTER TABLE `TblOrdersBOM`
	CHANGE COLUMN `Production_In_House_Notes` `Production_In_House_Notes` VARCHAR(500) NULL COLLATE 'utf8_unicode_ci' AFTER `Notes_From_Customer`,
	ADD COLUMN `Cable_Rail_Production_Date` VARCHAR(500) NULL AFTER `Production_In_House_Notes`;
