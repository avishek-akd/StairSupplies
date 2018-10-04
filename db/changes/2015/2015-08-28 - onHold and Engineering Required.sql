ALTER TABLE `TblOrdersBOM`
	ADD COLUMN `onHold` TINYINT(1) NOT NULL DEFAULT '0' AFTER `estimated_shipping_cost`,
	ADD COLUMN `onHoldNotes` VARCHAR(255) NULL DEFAULT NULL AFTER `onHold`,
	ADD COLUMN `onHold_date` DATETIME NULL DEFAULT NULL AFTER `onHoldNotes`,
	ADD COLUMN `onHold_userId` INT(11) NULL DEFAULT NULL AFTER `onHold_date`,
	ADD INDEX `TblOrdersBOM_idx_onHold_userId` (`onHold_userId`),
	ADD CONSTRAINT `FK_TblOrdersBOM_Employees_12` FOREIGN KEY (`onHold_userId`) REFERENCES `Employees` (`EmployeeID`);

ALTER TABLE `TblOrdersBOM`
	ADD COLUMN `EngineeringRequired` TINYINT(1) NOT NULL DEFAULT '0' AFTER `estimated_shipping_cost`,
	ADD COLUMN `EngineeringRequired_date` DATETIME NULL DEFAULT NULL AFTER `EngineeringRequired`,
	ADD COLUMN `EngineeringRequired_userId` INT(11) NULL DEFAULT NULL AFTER `EngineeringRequired_date`,
	ADD INDEX `TblOrdersBOM_idx_EngineeringRequired_userId` (`EngineeringRequired_userId`),
	ADD CONSTRAINT `FK_TblOrdersBOM_Employees_13` FOREIGN KEY (`EngineeringRequired_userId`) REFERENCES `Employees` (`EmployeeID`);

ALTER TABLE `TblOrdersBOM`
	ADD COLUMN `EngineeringComplete` TINYINT(1) NOT NULL DEFAULT '0' AFTER `EngineeringRequired_userId`,
	ADD COLUMN `EngineeringComplete_date` DATETIME NULL DEFAULT NULL AFTER `EngineeringComplete`,
	ADD COLUMN `EngineeringComplete_userId` INT(11) NULL DEFAULT NULL AFTER `EngineeringComplete_date`,
	ADD INDEX `TblOrdersBOM_idx_EngineeringComplete_userId` (`EngineeringComplete_userId`),
	ADD CONSTRAINT `FK_TblOrdersBOM_Employees_14` FOREIGN KEY (`EngineeringComplete_userId`) REFERENCES `Employees` (`EmployeeID`);
