DELIMITER $$


ALTER TABLE `TblFile`
	CHANGE COLUMN `customerContactID` `_unused_customerContactID` INT(10) UNSIGNED NULL DEFAULT NULL AFTER `customerID`
$$
	

DROP TRIGGER `TblFile_before_ins_tr1`
$$
CREATE TRIGGER `TblFile_before_ins_tr1` BEFORE INSERT ON `TblFile`
  FOR EACH ROW
BEGIN

DECLARE nonNullKeys INT DEFAULT 0;

SET nonNullKeys = nonNullKeys + (NEW.orderID IS NOT NULL);
SET nonNullKeys = nonNullKeys + (NEW.productID IS NOT NULL);
SET nonNullKeys = nonNullKeys + (NEW.orderItemsID IS NOT NULL);
SET nonNullKeys = nonNullKeys + (NEW.orderShipmentID IS NOT NULL);
SET nonNullKeys = nonNullKeys + (NEW.customerID IS NOT NULL);
SET nonNullKeys = nonNullKeys + (NEW.rgaRequestStatusID IS NOT NULL);
SET nonNullKeys = nonNullKeys + (NEW.orderCustomerVisibleID IS NOT NULL);

IF nonNullKeys <> 1 THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Exactly one of the foregin keys must be NON NULL.';
END IF;

END
$$



DROP TRIGGER `TblFile_before_upd_tr1`
$$
CREATE TRIGGER `TblFile_before_upd_tr1` BEFORE UPDATE ON `TblFile`
  FOR EACH ROW
BEGIN

DECLARE nonNullKeys INT DEFAULT 0;

SET nonNullKeys = nonNullKeys + (NEW.orderID IS NOT NULL);
SET nonNullKeys = nonNullKeys + (NEW.productID IS NOT NULL);
SET nonNullKeys = nonNullKeys + (NEW.orderItemsID IS NOT NULL);
SET nonNullKeys = nonNullKeys + (NEW.orderShipmentID IS NOT NULL);
SET nonNullKeys = nonNullKeys + (NEW.customerID IS NOT NULL);
SET nonNullKeys = nonNullKeys + (NEW.rgaRequestStatusID IS NOT NULL);
SET nonNullKeys = nonNullKeys + (NEW.orderCustomerVisibleID IS NOT NULL);

IF nonNullKeys <> 1 THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Exactly one of the foregin keys must be NON NULL.';
END IF;

END
$$


DELIMITER ;