DELIMITER $$



ALTER TABLE TblAudit
	ADD COLUMN groupActionsJSON VARCHAR(2000) NULL DEFAULT NULL COMMENT 'While a group is open this holds the actions in JSON format.' AFTER d_file,
	ADD COLUMN groupLastAction DATETIME NULL DEFAULT NULL COMMENT 'Time of the last recorded action on this group ' AFTER groupActionsJSON,
	ADD INDEX idxLastGroupUpdate(`groupLastAction`)
$$



DROP TRIGGER IF EXISTS `TblAudit_before_ins_tr1`
$$
CREATE TRIGGER `TblAudit_before_ins_tr1` BEFORE INSERT ON `TblAudit`
  FOR EACH ROW
BEGIN

DECLARE nonNullKeys INT DEFAULT 0;

SET nonNullKeys = nonNullKeys + (NEW.orderID IS NOT NULL);
SET nonNullKeys = nonNullKeys + (NEW.CustomerID IS NOT NULL);

IF nonNullKeys <> 1 THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Exactly one of the foregin keys must be NON NULL.';
END IF;

END
$$



DROP TRIGGER IF EXISTS `TblAudit_before_upd_tr1`
$$
CREATE TRIGGER `TblAudit_before_upd_tr1` BEFORE UPDATE ON `TblAudit`
  FOR EACH ROW
BEGIN

DECLARE nonNullKeys INT DEFAULT 0;

SET nonNullKeys = nonNullKeys + (NEW.orderID IS NOT NULL);
SET nonNullKeys = nonNullKeys + (NEW.CustomerID IS NOT NULL);

IF nonNullKeys <> 1 THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Exactly one of the foregin keys must be NON NULL.';
END IF;

END
$$



DELIMITER ;