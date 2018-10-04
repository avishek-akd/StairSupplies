RENAME TABLE `TblOrdersBOM_CustomerEmail` TO `TblOrdersBOM_SentEmail`;
ALTER TABLE `TblOrdersBOM_SentEmail`
	ADD COLUMN `type` VARCHAR(15) NOT NULL AFTER `d_employee_id`;
UPDATE TblOrdersBOM_SentEmail SET type='customer_email';


RENAME TABLE `TblOrdersBOM_CustomerEmailFile` TO `TblOrdersBOM_SentEmailFile`;
ALTER TABLE `TblOrdersBOM_SentEmailFile`
	ALTER `d_customer_email_id` DROP DEFAULT;
ALTER TABLE `TblOrdersBOM_SentEmailFile`
	CHANGE COLUMN `d_customer_email_id` `d_sent_email_id` INT(11) NOT NULL AFTER `id`;
