ALTER TABLE `Customers`
	ADD COLUMN `iPhoneToken` CHAR(64) NULL DEFAULT NULL COMMENT 'Device token ID used by the customer when he last signed in.';

ALTER TABLE `Employees`
	ADD COLUMN `iPhoneToken` CHAR(64) NULL DEFAULT NULL COMMENT 'Device token ID used by the employee when he last signed in.';
