ALTER TABLE `TblProducts`
	CHANGE COLUMN `CutLength` `PostCutLength` DECIMAL(10,2) UNSIGNED NULL DEFAULT '0.00' AFTER `WebsiteImageURL`,
	CHANGE COLUMN `CutAngle` `PostCutAngle` INT(10) UNSIGNED NULL DEFAULT '0' AFTER `PostCutLength`,
	CHANGE COLUMN `Configuration` `PostConfiguration` VARCHAR(20) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `PostFootStyleID`,
	CHANGE COLUMN `HurcoProgram` `PostHurcoProgram` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `PostConfiguration`
;




DELIMITER $$


DROP TRIGGER IF EXISTS `trgTblProducts_before_insert`
$$
CREATE TRIGGER `trgTblProducts_before_insert` BEFORE INSERT ON `TblProducts` FOR EACH ROW BEGIN

IF NEW.PostCutAngle NOT BETWEEN 0 and 90
THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'PostCutAngle must be between 0 and 90.';
END IF;

END
$$


DELIMITER ;
DELIMITER $$


DROP TRIGGER IF EXISTS `trgTblProducts_before_update`
$$
CREATE TRIGGER `trgTblProducts_before_update` BEFORE UPDATE ON `TblProducts` FOR EACH ROW BEGIN

IF NEW.PostCutAngle NOT BETWEEN 0 and 90
THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'PostCutAngle must be between 0 and 90.';
END IF;

END
$$


DELIMITER ;