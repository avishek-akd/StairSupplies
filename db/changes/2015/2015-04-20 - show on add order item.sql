DELIMITER $$



ALTER TABLE `TblProductType`
	ADD COLUMN `ShowOnAddOrderItem` TINYINT(1) NOT NULL DEFAULT '1' COMMENT 'Controls if the products of this type of displayed when adding products to order. =1 Always show; =2  Show only if "All items" is checked; =3 Always hide' AFTER `warnOnUnsetPRCOrFinal`
$$	

	
CREATE DEFINER = CURRENT_USER TRIGGER `TblProductType_before_ins_tr1` BEFORE INSERT ON `TblProductType`
  FOR EACH ROW
BEGIN

IF Not (NEW.ShowOnAddOrderItem IN (1, 2, 3)) THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Valid values for ShowOnAddOrderItem are 1, 2 or 3.';
END IF;
IF Not (NEW.ShowInProductionReport IN (0, 1)) THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Valid values for ShowInProductionReport are 0 or 1.';
END IF;
IF Not (NEW.warnOnUnsetPRCOrFinal IN (0, 1)) THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Valid values for warnOnUnsetPRCOrFinal are 0 or 1.';
END IF;

END
$$


CREATE DEFINER = CURRENT_USER TRIGGER `TblProductType_before_upd_tr1` BEFORE UPDATE ON `TblProductType`
  FOR EACH ROW
BEGIN

IF Not (NEW.ShowOnAddOrderItem IN (1, 2, 3)) THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Valid values for ShowOnAddOrderItem are 1, 2 or 3.';
END IF;
IF Not (NEW.ShowInProductionReport IN (0, 1)) THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Valid values for ShowInProductionReport are 0 or 1.';
END IF;
IF Not (NEW.warnOnUnsetPRCOrFinal IN (0, 1)) THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Valid values for warnOnUnsetPRCOrFinal are 0 or 1.';
END IF;

END
$$



DELIMITER ;