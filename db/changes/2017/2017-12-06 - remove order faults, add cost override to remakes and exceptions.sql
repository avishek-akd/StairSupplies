RENAME TABLE `TblOrdersBOM_Faults` TO `_unused_TblOrdersBOM_Faults`
;

ALTER TABLE TblOrdersBOM_Items
	ADD COLUMN `ManualCostExceptionsRemakes` DECIMAL(10,2) NULL DEFAULT NULL AFTER `costBoardFootage`
;

ALTER TABLE `TblOrdersBOM_Items`
	CHANGE COLUMN `ExceptionFaultId` `_unused_ExceptionFaultId` INT(10) UNSIGNED NULL DEFAULT NULL AFTER `ExceptionClosed_Date`,
	CHANGE COLUMN `ExceptionFaultEmployeeId` `_unused_ExceptionFaultEmployeeId` INT(10) NULL DEFAULT NULL AFTER `_unused_ExceptionFaultId`,
	CHANGE COLUMN `ExceptionCostEstimate` `_unused_ExceptionCostEstimate` DECIMAL(10,2) NULL DEFAULT NULL AFTER `_unused_ExceptionFaultEmployeeId`
;
ALTER TABLE `TblOrdersBOM`
	CHANGE COLUMN `RemakeFaultID` `_unused_RemakeFaultID` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT 'Why did we have to remake (XOR RemakeFaultEmployeeID)' AFTER `RemakeNoteID`,
	CHANGE COLUMN `RemakeFaultEmployeeID` `_unused_RemakeFaultEmployeeID` INT(11) NULL DEFAULT NULL COMMENT 'Who\'s to blame for the remake (XOR RemakeFaultID)' AFTER `_unused_RemakeFaultID`,
	CHANGE COLUMN `RemakeCostEstimate` `_unused_RemakeCostEstimate` DECIMAL(10,2) NULL DEFAULT NULL COMMENT 'How much does the remake cost ?' AFTER `_unused_RemakeFaultEmployeeID`
;







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
DELIMITER $$


DROP TRIGGER IF EXISTS `trgTblOrdersBOM_Items_before_update`
$$
CREATE TRIGGER `trgTblOrdersBOM_Items_before_update` BEFORE UPDATE ON `TblOrdersBOM_Items` FOR EACH ROW BEGIN

IF NEW.DiscountPercent < 0 THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Discount percent must be greater than 0.';
END IF;

IF NEW.DiscountPercent > 1 THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Discount percent must be lower than 1.';
END IF;

END
$$


DELIMITER ;