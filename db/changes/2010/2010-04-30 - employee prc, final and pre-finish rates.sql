ALTER TABLE `Products`
	CHANGE COLUMN `EmployeeRate` `EmployeeRatePRC` DECIMAL(10,4) NOT NULL DEFAULT '0.0000' AFTER `PUnitPrice`,
	ADD COLUMN `EmployeeRateFinal` DECIMAL(10,4) NOT NULL DEFAULT '0.0000' AFTER `EmployeeRatePRC`,
	ADD COLUMN `EmployeeRatePreFinish` DECIMAL(10,4) NOT NULL DEFAULT '0.0000' AFTER `EmployeeRateFinal`;