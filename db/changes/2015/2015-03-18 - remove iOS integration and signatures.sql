RENAME TABLE `CustomerLogins` TO `_unused_CustomerLogins`;
RENAME TABLE `Sites` TO `_unused_Sites`;
RENAME TABLE `TblOrdersBOM_Signature` TO `_unused_TblOrdersBOM_Signature`;
RENAME TABLE `TblOrdersBOM_Shipments_Signature` TO `_unused_TblOrdersBOM_Shipments_Signature`;


ALTER TABLE `CustomerContact`
	CHANGE COLUMN `iPhoneToken` `_unused_iPhoneToken` CHAR(64) NULL DEFAULT NULL COMMENT 'Device token ID used by the customer when he last signed in.' COLLATE 'utf8_unicode_ci' AFTER `BillingEmails`;