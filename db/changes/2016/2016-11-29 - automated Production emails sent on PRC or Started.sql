--  Better name for the field
ALTER TABLE `TblOrdersBOM`
	CHANGE COLUMN `WoodOrCableProductionDateSet` `ProductionEmailWasSent` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0'
		COMMENT '=1 if email was sent to customer about production starting' AFTER `_unused_ShipPhoneNumber`;


--  Keep the email content in the db so it can be edited
ALTER TABLE `tbl_settings_per_company`
	ADD COLUMN `d_email_content_production_started` VARCHAR(1000) NULL AFTER `d_email_footer_purchasing`;

UPDATE `tbl_settings_per_company`
SET `d_email_content_production_started`='Greetings!\r\n\r\nIf we haven\'t done so already, we thank you for your order.\r\n\r\nOur goal is to always bring you first-class, organized details while we are working on your order.  With that in mind, your order is scheduled to begin the production process on <strong>[ProductionDate]</strong>.  Once your order is produced and packaged, you will receive another email that will provide you with a confirmation of shipping and tracking number provided by the selected carrier.\r\n\r\nIf you have additional questions between now and then, please feel free to contact any member of our Customer Support team using the email address I have provided below.\r\n\r\nWe look forward to serving you well.\r\n\r\nTroy Burns\r\nStair Supplies Customer Support Manager\r\ncustserv@stairsupplies.com\r\n(866) 226-6536 ext. 106'
WHERE id=1;