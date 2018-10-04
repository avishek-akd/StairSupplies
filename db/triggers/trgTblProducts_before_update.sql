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