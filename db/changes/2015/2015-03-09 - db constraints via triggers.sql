DELIMITER $$




DROP TRIGGER IF EXISTS `TblOrdersBOM_Items_before_upd_tr`
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

IF NEW.ExceptionFaultId IS NOT NULL AND NEW.ExceptionFaultEmployeeId IS NOT NULL THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Only one of ExceptionFaultID or ExceptionFaultEmployeeId must be NON NULL.';
END IF;

END
$$


DROP TRIGGER IF EXISTS `TblOrdersBOM_Items_before_ins_tr`
$$
CREATE TRIGGER `TblOrdersBOM_Items_before_ins_tr` BEFORE INSERT ON `TblOrdersBOM_Items`
  FOR EACH ROW
BEGIN

IF NEW.DiscountPercent < 0 THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Discount percent must be greater than 0.';
END IF;

IF NEW.DiscountPercent > 1 THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Discount percent must be lower than 1.';
END IF;

IF NEW.ExceptionFaultId IS NOT NULL AND NEW.ExceptionFaultEmployeeId IS NOT NULL THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Only one of ExceptionFaultID or ExceptionFaultEmployeeId must be NON NULL.';
END IF;

END
$$






DROP TRIGGER IF EXISTS `TblFile_before_ins_tr1`
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
SET nonNullKeys = nonNullKeys + (NEW.customerContactID IS NOT NULL);
SET nonNullKeys = nonNullKeys + (NEW.rgaRequestStatusID IS NOT NULL);
SET nonNullKeys = nonNullKeys + (NEW.orderCustomerVisibleID IS NOT NULL);

IF nonNullKeys <> 1 THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Exactly one of the foregin keys must be NON NULL.';
END IF;

END
$$


DROP TRIGGER IF EXISTS `TblFile_before_upd_tr1`
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
SET nonNullKeys = nonNullKeys + (NEW.customerContactID IS NOT NULL);
SET nonNullKeys = nonNullKeys + (NEW.rgaRequestStatusID IS NOT NULL);
SET nonNullKeys = nonNullKeys + (NEW.orderCustomerVisibleID IS NOT NULL);

IF nonNullKeys <> 1 THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Exactly one of the foregin keys must be NON NULL.';
END IF;

END
$$



DELIMITER ;