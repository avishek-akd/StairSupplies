ALTER TABLE `TblOrdersBOM`
	CHANGE COLUMN `DueDate` `DueDate` DATETIME NULL DEFAULT NULL AFTER `paid_userLastName`, 
	CHANGE COLUMN `due_date` `DueDate_date` DATETIME NULL DEFAULT NULL AFTER `Duedate`, 
	CHANGE COLUMN `due_userid` `DueDate_userid` INT(10) NULL DEFAULT NULL AFTER `Duedate_date`,  
	CHANGE COLUMN `due_userlastname` `DueDate_userlastname` VARCHAR(50) NULL DEFAULT NULL AFTER `Duedate_userid`;

ALTER TABLE `TblOrdersBOM` 
	CHANGE COLUMN `DueDate` `DueDate` DATETIME NULL DEFAULT NULL AFTER `ShippedDate`;