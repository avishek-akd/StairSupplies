ALTER TABLE `Customers`
	ADD COLUMN `defaultDiscount` DECIMAL(10,4) UNSIGNED NULL DEFAULT '0' COMMENT 'Default discount applied to all new orders' AFTER `BillingEmails`;
