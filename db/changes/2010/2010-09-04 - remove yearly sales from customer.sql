ALTER TABLE `Customers`
	CHANGE COLUMN `YTD_Sales` `z_unused_YTD_Sales` DECIMAL(19,4) NULL DEFAULT NULL AFTER `DateEntered`,
	CHANGE COLUMN `Last_years_Sales` `z_unused_Last_years_Sales` DECIMAL(19,4) NULL DEFAULT NULL AFTER `z_unused_YTD_Sales`,
	CHANGE COLUMN `LastSale` `z_unused_LastSale` CHAR(10) NULL DEFAULT NULL AFTER `z_unused_Last_years_Sales`;
