DELIMITER $$


DROP TRIGGER IF EXISTS `trgTblOrdersBOM_Items_before_insert`
$$
CREATE TRIGGER `trgTblOrdersBOM_Items_before_insert` BEFORE INSERT ON `TblOrdersBOM_Items` FOR EACH ROW BEGIN

IF NEW.DiscountPercent < 0 THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Discount percent must be greater than 0.';
END IF;

IF NEW.DiscountPercent > 1 THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Discount percent must be lower than 1.';
END IF;

END
$$


DELIMITER ;