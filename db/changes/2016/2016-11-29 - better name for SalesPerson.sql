ALTER TABLE `Customers`
	CHANGE COLUMN `SalesPerson` `SalesPersonID` INT(10) NULL DEFAULT NULL AFTER `_unused_FollowUp`;
