-- The field is actually used as In Process so rename it
ALTER TABLE `TblOrdersBOM_Items`
	ADD COLUMN `QuantityPulled` INT NULL DEFAULT '0' AFTER `QuantityInProcess`;


-- Add Started
ALTER TABLE `TblOrdersBOM_Items`
	ADD COLUMN `Started` TINYINT(4) NULL DEFAULT '0' AFTER `PRC_EmployeeID`,
	ADD COLUMN `Started_Date` DATETIME NULL DEFAULT NULL AFTER `Started`,
	ADD COLUMN `Started_EmployeeID` INT(11) NULL DEFAULT NULL AFTER `Started_Date`,
	ADD CONSTRAINT `FK_TblOrdersBOM_Items_Employees_6` FOREIGN KEY (`Started_EmployeeID`) REFERENCES `Employees` (`EmployeeID`);


ALTER TABLE `TblProductTypeProductionType`
	ALTER `Name` DROP DEFAULT;
ALTER TABLE `TblProductTypeProductionType`
	CHANGE COLUMN `Name` `name` VARCHAR(50) NOT NULL COLLATE 'utf8_unicode_ci' AFTER `id`,
	ADD COLUMN `internal_name` VARCHAR(50) NULL COMMENT 'Internal name, used to decide which fields to show on production status page.' AFTER `name`;
UPDATE `TblProductTypeProductionType` SET `internal_name`='other' WHERE  `id`=1;
UPDATE `TblProductTypeProductionType` SET `internal_name`='wood' WHERE  `id`=2;
UPDATE `TblProductTypeProductionType` SET `internal_name`='cable' WHERE  `id`=3;
UPDATE `TblProductTypeProductionType` SET `internal_name`='other' WHERE  `id`=4;
UPDATE `TblProductTypeProductionType` SET `internal_name`='other' WHERE  `id`=5;



CREATE TABLE `TblOrdersBOM_ItemsHistory` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`OrderItemsID` INT NOT NULL,
	`fieldName` VARCHAR(50) NOT NULL COMMENT 'Ex: \'QuantityInProcess\', \'QuantityPulled\'',
	`value` INT NOT NULL COMMENT 'Value that the field is changed by. This is NOT the new value, it\'s a change applied to the initial value',
	`EmployeeID` INT NOT NULL,
	`RecordCreated` DATETIME NOT NULL,
	PRIMARY KEY (`id`),
	INDEX `OrderItemsID` (`OrderItemsID`),
	INDEX `employeeID` (`employeeID`),
	CONSTRAINT `FK__TblOrdersBOM_ItemsHistory_Employees` FOREIGN KEY (`employeeID`) REFERENCES `Employees` (`EmployeeID`),
	CONSTRAINT `FK_TblOrdersBOM_ItemsHistory_TblOrdersBOM_Items` FOREIGN KEY (`OrderItemsID`) REFERENCES `TblOrdersBOM_Items` (`OrderItemsID`)
)
ENGINE=InnoDB
;