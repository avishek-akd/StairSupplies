ALTER TABLE TblTerms
	CHANGE COLUMN `id` `TermsID` INT(11) NOT NULL AUTO_INCREMENT,
	CHANGE COLUMN `Terms` `TermsName` VARCHAR(50) NOT NULL,
	ADD COLUMN `AllowPaymentByCreditCard` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '=1 CC payment is allowed for customer' AFTER `TermsName`,
	ADD COLUMN `DownpaymentPercent` DECIMAL(10,4) NULL DEFAULT NULL COMMENT 'Downpayment as % of total order, for terms that allow payment by CC' AFTER `AllowPaymentByCreditCard`,
	ADD COLUMN `DownpaymentAmount` DECIMAL(10,2) NULL DEFAULT NULL COMMENT 'Downpayment in $, for terms that allow payment by CC' AFTER `DownpaymentPercent`,
	ADD COLUMN `AlwaysAllowOrderAck` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '=1 the order can still be confimed/ackd, at all times, even if it\'s already been Ordered, Released, paid, etc' AFTER `DownpaymentPercent`,
	ADD COLUMN `RecordCreated` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	ADD COLUMN `RecordUpdated` DATETIME NULL DEFAULT NULL
;


--  All existing terms can be payed by CC (Brett will change them later)
UPDATE TblTerms
SET AllowPaymentByCreditCard = 1
;


--  Some
UPDATE `TblTerms` SET `DownpaymentPercent`='0.25' WHERE  `TermsID`=17;
UPDATE `TblTerms` SET `DownpaymentPercent`='0.50' WHERE  `TermsID`=26;
UPDATE `TblTerms` SET `DownpaymentPercent`='0.50' WHERE  `TermsID`=27;
UPDATE `TblTerms` SET `DownpaymentPercent`='0.70' WHERE  `TermsID`=24;




DELIMITER $$


DROP TRIGGER IF EXISTS `trgTblTerms_before_insert`
$$
CREATE TRIGGER `trgTblTerms_before_insert` BEFORE INSERT ON `TblTerms` FOR EACH ROW BEGIN


IF NEW.DownpaymentPercent IS NOT NULL AND NEW.DownpaymentAmount IS NOT NULL THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Only one of the downpayment fields can be filled in.';
END IF;


END
$$


DELIMITER ;
DELIMITER $$


DROP TRIGGER IF EXISTS `trgTblTerms_before_update`
$$
CREATE TRIGGER `trgTblTerms_before_update` BEFORE INSERT ON `TblTerms` FOR EACH ROW BEGIN


IF NEW.DownpaymentPercent IS NOT NULL AND NEW.DownpaymentAmount IS NOT NULL THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Only one of the downpayment fields can be filled in.';
END IF;


END
$$


DELIMITER ;