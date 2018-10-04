ALTER TABLE `Customers`
	ADD COLUMN `SalesPersonCommission` DECIMAL(10,4) NULL DEFAULT '0' COMMENT 'Commision paid to the sales person when a customer pays a bill. For example 0.055 for 5.5%. This should always be < 0.' AFTER `iPhoneToken`;
