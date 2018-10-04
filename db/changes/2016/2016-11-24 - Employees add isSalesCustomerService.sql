ALTER TABLE `Employees`
	ADD COLUMN `isSalesOrCustomerService` TINYINT(3) NOT NULL DEFAULT '0' AFTER `iPhoneToken`,
	CHANGE COLUMN `Archive` `Archive` TINYINT(4) NOT NULL DEFAULT '0' AFTER `isSalesOrCustomerService`;
