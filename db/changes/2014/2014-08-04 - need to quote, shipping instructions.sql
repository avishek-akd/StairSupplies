ALTER TABLE `TblOrdersBOM`
	ADD COLUMN `NeedToQuote` TINYINT(4) NOT NULL DEFAULT '0' AFTER `TermsID`,
	ADD COLUMN `NeedToQuote_date` DATETIME NULL DEFAULT NULL AFTER `_unused_Remake_UserLastName`,
	ADD COLUMN `NeedToQuote_userId` INT(10) NULL DEFAULT NULL AFTER `NeedToQuote_date`,
	ADD CONSTRAINT `FK_TblOrdersBOM_Employees_10` FOREIGN KEY (`NeedToQuote_userId`) REFERENCES `Employees` (`EmployeeID`) ON UPDATE NO ACTION ON DELETE NO ACTION;

	
ALTER TABLE `TblOrdersBOM`
	ADD COLUMN `Notes_From_Customer` LONGTEXT NULL AFTER `In_House_Notes`;

ALTER TABLE `Shipping_Methods`
	ADD COLUMN `ShippingInstructions` VARCHAR(1000) NULL AFTER `ShippingMethod`;
