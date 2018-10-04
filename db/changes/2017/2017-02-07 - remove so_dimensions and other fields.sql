ALTER TABLE `TblOrdersBOM_Items`
	CHANGE COLUMN `so_dimensions` `_unused_so_dimensions` TINYINT(4) NOT NULL DEFAULT '0' AFTER `ExceptionCostEstimate`,
	CHANGE COLUMN `so_dimensions_date` `_unused_so_dimensions_date` DATETIME NULL DEFAULT NULL AFTER `_unused_so_dimensions`,
	CHANGE COLUMN `so_dimensions_employeeID` `_unused_so_dimensions_employeeID` INT(11) NULL DEFAULT NULL AFTER `_unused_so_dimensions_date`,
	CHANGE COLUMN `so_email_sent` `_unused_so_email_sent` TINYINT(4) NOT NULL DEFAULT '0' AFTER `_unused_so_dimensions_employeeID`,
	CHANGE COLUMN `so_email_sent_date` `_unused_so_email_sent_date` DATETIME NULL DEFAULT NULL AFTER `_unused_so_email_sent`,
	CHANGE COLUMN `so_email_sent_employeeID` `_unused_so_email_sent_employeeID` INT(11) NULL DEFAULT NULL AFTER `_unused_so_email_sent_date`,
	CHANGE COLUMN `so_customer_approved` `_unused_so_customer_approved` TINYINT(4) NOT NULL DEFAULT '0' AFTER `_unused_so_email_sent_employeeID`,
	CHANGE COLUMN `so_customer_approved_date` `_unused_so_customer_approved_date` DATETIME NULL DEFAULT NULL AFTER `_unused_so_customer_approved`,
	CHANGE COLUMN `so_customer_approved_employeeID` `_unused_so_customer_approved_employeeID` INT(11) NULL DEFAULT NULL AFTER `_unused_so_customer_approved_date`,
	CHANGE COLUMN `so_programming_complete` `_unused_so_programming_complete` TINYINT(4) NOT NULL DEFAULT '0' AFTER `_unused_so_customer_approved_employeeID`,
	CHANGE COLUMN `so_programming_complete_date` `_unused_so_programming_complete_date` DATETIME NULL DEFAULT NULL AFTER `_unused_so_programming_complete`,
	CHANGE COLUMN `so_programming_complete_employeeID` `_unused_so_programming_complete_employeeID` INT(11) NULL DEFAULT NULL AFTER `_unused_so_programming_complete_date`;