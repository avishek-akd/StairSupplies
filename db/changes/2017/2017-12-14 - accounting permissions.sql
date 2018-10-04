ALTER TABLE `TblEmployee`
	CHANGE COLUMN `hasAccountingAccess` `accountingAccessLevel` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '=0 No access; =1 View only; =2 Basic access; =3 Basic + QB; =4 Full access' AFTER `StartDate`
;