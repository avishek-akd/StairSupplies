DELIMITER $$


DROP TRIGGER IF EXISTS `trgTblProductType_before_update`
$$
CREATE TRIGGER `trgTblProductType_before_update` BEFORE UPDATE ON `TblProductType` FOR EACH ROW BEGIN

IF Not (NEW.ShowOnAddOrderItem2 IN (1, 2, 3)) THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Valid values for ShowOnAddOrderItem2 are 1, 2 or 3.';
END IF;
IF Not (NEW.ShowInLateOrderReports IN ('wood', 'cable', 'both', 'neither')) THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Valid values for ShowInLateOrderReports are "wood", "cable", "both" or "neither".';
END IF;
IF Not (NEW.warnOnUnsetPRCOrFinal IN (0, 1)) THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Valid values for warnOnUnsetPRCOrFinal are 0 or 1.';
END IF;

END
$$


DELIMITER ;