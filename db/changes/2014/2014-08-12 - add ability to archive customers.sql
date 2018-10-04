ALTER TABLE `Customers`
	ADD COLUMN `Archived` TINYINT(1) NOT NULL DEFAULT '0' AFTER `SalesPersonCommission`;
