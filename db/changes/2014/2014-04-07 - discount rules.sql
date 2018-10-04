DELIMITER $$


CREATE TRIGGER `TblOrdersBOM_Items_before_ins_tr` BEFORE INSERT ON `TblOrdersBOM_Items`
  FOR EACH ROW
BEGIN

IF NEW.DiscountPercent < 0 THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Discount percent must be greater than 0.';
END IF;

IF NEW.DiscountPercent > 1 THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Discount percent must be lower than 1.';
END IF;

END
$$


CREATE TRIGGER `TblOrdersBOM_Items_before_upd_tr` BEFORE UPDATE ON `TblOrdersBOM_Items`
  FOR EACH ROW
BEGIN

IF NEW.DiscountPercent < 0 THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Discount percent must be greater than 0.';
END IF;

IF NEW.DiscountPercent > 1 THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Discount percent must be lower than 1.';
END IF;

END
$$


DELIMITER ;