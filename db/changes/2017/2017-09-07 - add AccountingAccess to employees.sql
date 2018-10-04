ALTER TABLE TblEmployee
	ADD COLUMN `hasAccountingAccess` TINYINT(1) NOT NULL DEFAULT 0 AFTER `_unused_iPhoneToken`
;
