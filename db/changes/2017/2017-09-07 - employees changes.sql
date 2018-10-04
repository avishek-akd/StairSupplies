ALTER TABLE `TblEmployee`
	CHANGE COLUMN `Address` `_unused_Address` VARCHAR(100) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `Title`,
	CHANGE COLUMN `City` `_unused_City` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `_unused_Address`,
	CHANGE COLUMN `State` `_unused_State` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `_unused_City`,
	CHANGE COLUMN `Zip` `_unused_Zip` VARCHAR(10) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `_unused_State`,
	CHANGE COLUMN `WorkPhone` `_unused_WorkPhone` VARCHAR(30) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `_unused_Zip`,
	CHANGE COLUMN `Extension` `_unused_Extension` VARCHAR(30) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `_unused_WorkPhone`,
	CHANGE COLUMN `HomePhone` `_unused_HomePhone` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `CellPhone`,
	CHANGE COLUMN `EmergencyContactName` `_unused_EmergencyContactName` VARCHAR(100) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `email`,
	CHANGE COLUMN `EmergencyContactNumber` `_unused_EmergencyContactNumber` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `_unused_EmergencyContactName`,
	CHANGE COLUMN `ReceivedAccessHandbook` `_unused_ReceivedAccessHandbook` TINYINT(4) NULL DEFAULT '0' AFTER `StartDate`,
	CHANGE COLUMN `TrainingForkliftComplete` `_unused_TrainingForkliftComplete` TINYINT(4) NULL DEFAULT '0' AFTER `_unused_ReceivedAccessHandbook`,
	CHANGE COLUMN `TrainingHazComComplete` `_unused_TrainingHazComComplete` TINYINT(4) NULL DEFAULT '0' AFTER `_unused_TrainingForkliftComplete`,
	CHANGE COLUMN `TrainingConfinedSpaceComplete` `_unused_TrainingConfinedSpaceComplete` TINYINT(4) NULL DEFAULT '0' AFTER `_unused_TrainingHazComComplete`,
	CHANGE COLUMN `ChauffersLicenseLogged` `_unused_ChauffersLicenseLogged` TINYINT(4) NULL DEFAULT '0' AFTER `_unused_TrainingConfinedSpaceComplete`
;
ALTER TABLE `TblEmployee`
	CHANGE COLUMN `isSalesOrCustomerService` `isSalesOrCustomerService` TINYINT(3) NOT NULL DEFAULT '0' AFTER `_unused_iPhoneToken`
;
ALTER TABLE TblEmployee
	CHANGE COLUMN `isSalesOrCustomerService` `belongsToCustomerService` TINYINT(1) NOT NULL DEFAULT 0,
	ADD COLUMN `belongsToSales` TINYINT(1) NOT NULL DEFAULT 0 AFTER `_unused_iPhoneToken`
;
UPDATE TblEmployee
SET
	belongsToSales = belongsToCustomerService
;