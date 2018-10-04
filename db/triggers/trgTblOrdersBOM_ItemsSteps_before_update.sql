DELIMITER $$


DROP TRIGGER IF EXISTS `trgTblOrdersBOM_ItemsSteps_before_update`
$$
CREATE TRIGGER `trgTblOrdersBOM_ItemsSteps_before_update` AFTER UPDATE ON `TblOrdersBOM_ItemsSteps` FOR EACH ROW
BEGIN


SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Entries cannot be updated, only inserted or deleted.';


END
$$


DELIMITER ;