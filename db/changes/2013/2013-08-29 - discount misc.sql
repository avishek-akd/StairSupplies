DELIMITER $$


UPDATE `Company` SET `FaxNumber`='509-463-4227' WHERE  `CompanyID`=1
$$


ALTER TABLE `Customers`
	CHANGE COLUMN `defaultDiscount` `defaultDiscountPercent` DECIMAL(10,4) UNSIGNED NULL DEFAULT '0.0000' COMMENT 'Default discount applied to each order item, as a percentage.' AFTER `CreditHold`
$$

	
ALTER TABLE `TblOrdersBOM_Items`
	CHANGE COLUMN `DiscountPercent` `DiscountPercent` DECIMAL(10,4) NULL DEFAULT '0.0000' COMMENT 'Discount percent applied to UnitPrice to get the actual price' AFTER `UnitPrice`
$$


--  Some discounts are actual percentages (16.00) instead of 0.1600
UPDATE TblOrdersBOM_Items
SET discountPercent = discountPercent / 100
WHERE discountPercent > 1
$$
--  Discounts applied to negative unit prices, orders don't work anyway
UPDATE TblOrdersBOM_Items
SET discountPercent = 0
WHERE OrderItemsID IN (68441, 68442)
$$


DELIMITER ;
