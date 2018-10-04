ALTER TABLE `CustomerContact`
	CHANGE COLUMN `BillingEmails` `_unused_BillingEmails` VARCHAR(255) NULL DEFAULT NULL COMMENT 'The invoice from the invoicing module is sent to these emails.' COLLATE 'utf8_unicode_ci' AFTER `CanLogin`;
ALTER TABLE `Customers`
	ADD COLUMN `BillingEmails` VARCHAR(255) NULL DEFAULT NULL COMMENT 'The invoice from the invoicing module is sent to these emails.' AFTER `CustomerServicePersonID`;

UPDATE Customers
SET BillingEmails = (
					SELECT _unused_BillingEmails
					FROM CustomerContact
					WHERE CustomerID = Customers.CustomerID
					LIMIT 0,1);
