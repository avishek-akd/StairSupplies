DELIMITER $$



ALTER TABLE `TblProductType`
	CHANGE COLUMN `ShowInProductionReport` `_unused_ShowInProductionReport` TINYINT(1) UNSIGNED NOT NULL DEFAULT '1' COMMENT '=1 The product type is displayed in the report, =0 not' AFTER `description`,
	ADD COLUMN `ShowInLateOrderReports` VARCHAR(10) NOT NULL DEFAULT 'neither' COMMENT 'Show this product type in the Production: Late Order reports. Valid values are: wood, cable, both, neither.' AFTER `_unused_ShowInProductionReport`;


	
DROP TRIGGER IF EXISTS TblProductType_before_ins_tr1
$$
CREATE TRIGGER `TblProductType_before_ins_tr1` BEFORE INSERT ON `TblProductType`
  FOR EACH ROW
BEGIN

IF Not (NEW.ShowOnAddOrderItem IN (1, 2, 3)) THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Valid values for ShowOnAddOrderItem are 1, 2 or 3.';
END IF;
IF Not (NEW.ShowInLateOrderReports IN ("wood", "cable", "both", "neither")) THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Valid values for ShowInLateOrderReports are "wood", "cable", "both" or "neither".';
END IF;
IF Not (NEW.warnOnUnsetPRCOrFinal IN (0, 1)) THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Valid values for warnOnUnsetPRCOrFinal are 0 or 1.';
END IF;

END
$$


DROP TRIGGER IF EXISTS TblProductType_before_upd_tr1
$$
CREATE TRIGGER `TblProductType_before_upd_tr1` BEFORE UPDATE ON `TblProductType`
  FOR EACH ROW
BEGIN

IF Not (NEW.ShowOnAddOrderItem IN (1, 2, 3)) THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Valid values for ShowOnAddOrderItem are 1, 2 or 3.';
END IF;
IF Not (NEW.ShowInLateOrderReports IN ("wood", "cable", "both", "neither")) THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Valid values for ShowInLateOrderReports are "wood", "cable", "both" or "neither".';
END IF;
IF Not (NEW.warnOnUnsetPRCOrFinal IN (0, 1)) THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Valid values for warnOnUnsetPRCOrFinal are 0 or 1.';
END IF;

END
$$



DELIMITER ;
