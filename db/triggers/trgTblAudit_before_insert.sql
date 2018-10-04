DELIMITER $$


DROP TRIGGER IF EXISTS `trgTblAudit_before_insert`
$$
CREATE TRIGGER `trgTblAudit_before_insert` BEFORE INSERT ON `TblAudit` FOR EACH ROW BEGIN

DECLARE nonNullKeys INT DEFAULT 0;

SET nonNullKeys = nonNullKeys + (NEW.orderID IS NOT NULL);
SET nonNullKeys = nonNullKeys + (NEW.CustomerID IS NOT NULL);

IF nonNullKeys <> 1 THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Exactly one of the foreign keys must be NON NULL.';
END IF;

END
$$


DELIMITER ;