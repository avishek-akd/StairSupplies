ALTER TABLE `TblAudit`
	CHANGE COLUMN `d_email_message` `d_email_message` VARCHAR(3000) NULL DEFAULT NULL COMMENT 'The message that the user typed (not the actual full email).' COLLATE 'utf8_unicode_ci' AFTER `d_email_sent_to`;
