DELIMITER $$


DROP TRIGGER IF EXISTS `trgTblTerms_before_insert`
$$
CREATE TRIGGER `trgTblTerms_before_insert` BEFORE INSERT ON `TblTerms` FOR EACH ROW BEGIN


IF NEW.DownpaymentAmount IS NOT NULL AND NEW.DownpaymentPercent IS NOT NULL  THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Only one of the downpayment fields can be filled in.';
END IF;


END
$$


DELIMITER ;
