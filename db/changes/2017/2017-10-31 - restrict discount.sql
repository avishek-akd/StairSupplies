ALTER TABLE TblEmployee
	ADD COLUMN `MaxDiscountPercent` DECIMAL(5,4) NULL DEFAULT NULL COMMENT 'Max discount percent that the user is permitted to apply to an order. Value is between 0 (0%) and 1 (100%)' AFTER `SalesCommission`
;

--  Fill with with 10% discount for Sales employees
UPDATE TblEmployee
SET MaxDiscountPercent = 0.1
WHERE belongsToSales = 1
;