INSERT INTO `Employees_module` (`Module_id`, `Module_name`, `Module_directory`)
VALUES (15, 'Machines', '/machines/');



ALTER TABLE `tbl_settings_global`
	ADD COLUMN `machine_down_emails` VARCHAR(500) NULL COMMENT 'Comma separated list of emails that receive emails about machines being up or down.' AFTER `production_activity_show_all`;


CREATE TABLE `TblMachine` (
	`id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`Name` VARCHAR(100) NOT NULL,
	`Department` VARCHAR(50) NOT NULL,
	`Description` VARCHAR(500) NULL,
	`InstructionGuideFile` VARCHAR(100) NULL,
	`InstructionSafetyFile` VARCHAR(100) NULL,
	`isDown` TINYINT NOT NULL DEFAULT '0',
	`isDownReason` VARCHAR(50) NULL,
	`isDownTime` DATETIME NULL,
	`isDownEmployeeID` INT NULL,
	`RecordCreated` DATETIME NOT NULL,
	`RecordUpdated` DATETIME NULL,
	PRIMARY KEY (`id`),
	CONSTRAINT `FK_TblMachine_Employees` FOREIGN KEY (`isDownEmployeeID`) REFERENCES `Employees` (`EmployeeID`)
)
ENGINE=InnoDB
;


CREATE TABLE `TblMachineTrainedEmployee` (
	`MachineID` INT UNSIGNED NOT NULL,
	`EmployeeID` INT NOT NULL,
	PRIMARY KEY (`MachineID`, `EmployeeID`),
	CONSTRAINT `FK_TblMachineTrainedEmployee_TblMachine` FOREIGN KEY (`MachineID`) REFERENCES `TblMachine` (`id`),
	CONSTRAINT `FK_TblMachineTrainedEmployee_Employees` FOREIGN KEY (`EmployeeID`) REFERENCES `Employees` (`EmployeeID`)
)
ENGINE=InnoDB
;