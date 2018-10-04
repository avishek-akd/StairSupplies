ALTER TABLE `TblAudit`
	ADD COLUMN `d_email_sent_to` VARCHAR(200) NULL DEFAULT NULL COMMENT 'For email audit entries this keeps the email address it was sent to.' AFTER `d_message`,
	ADD COLUMN `d_email_message` VARCHAR(500) NULL DEFAULT NULL COMMENT 'The message that the user typed (not the actual full email).' AFTER `d_email_sent_to`;
