ALTER TABLE `Products`
	CHANGE COLUMN `EmployeeRatePRC` `EmployeeRatePRC` DECIMAL(10,2) NOT NULL DEFAULT '0.0000' AFTER `PUnitPrice`,
	CHANGE COLUMN `EmployeeRateFinal` `EmployeeRateFinal` DECIMAL(10,2) NOT NULL DEFAULT '0.0000' AFTER `EmployeeRatePRC`,
	CHANGE COLUMN `EmployeeRatePreFinish` `EmployeeRatePreFinish` DECIMAL(10,2) NOT NULL DEFAULT '0.0000' AFTER `EmployeeRateFinal`;
