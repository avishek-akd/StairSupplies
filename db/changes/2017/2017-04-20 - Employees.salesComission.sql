ALTER TABLE Employees
	ADD COLUMN SalesCommission DECIMAL(10,4) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Commision paid to the sales person. For example 0.055 for 5.5%. This should always be < 1.' AFTER `_unused_iPhoneToken`
;
ALTER TABLE Customers
	CHANGE COLUMN `SalesPersonCommission` `_unused_SalesPersonCommission` DECIMAL(10,4) NULL DEFAULT 0 COMMENT 'Commision paid to the sales person when a customer pays a bill. For example 0.055 for 5.5%. This should always be < 1.'
;
