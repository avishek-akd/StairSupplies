ALTER TABLE `TblOrdersBOM`
	CHANGE COLUMN `Production_In_House_Notes` `Priority_Production_Notes` VARCHAR(500) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `Notes_From_Customer`,
	CHANGE COLUMN `Cable_Rail_Production_Date` `Secondary_Production_Notes` VARCHAR(500) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `Priority_Production_Notes`;
