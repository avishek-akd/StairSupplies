ALTER TABLE `tbl_settings_per_company`
	ADD COLUMN `d_email_shipped_partial_complete_subject` VARCHAR(100) NULL DEFAULT '' AFTER `d_email_shipped_complete_bcc`;



UPDATE tbl_settings_per_company SET d_email_shipped_partial_subject = 'Order [OrderID] Partially Shipped';
UPDATE tbl_settings_per_company SET d_email_shipped_partial_content = 'Dear [ContactFirstName],

This is a shipping acknowledgment to inform you that a portion of your order has shipped. The back ordered items can be viewed below. You should be getting a reply to this email within 24 hours with information regarding the back ordered items.

Thank You,
[CompanyName]';

UPDATE tbl_settings_per_company SET d_email_shipped_partial_complete_subject = 'Balance of Order [OrderID] Shipped';
UPDATE tbl_settings_per_company SET d_email_shipped_complete_subject         = 'Order [OrderID] Shipped';
UPDATE tbl_settings_per_company SET d_email_shipped_complete_content         = 'Dear [ContactFirstName],

This is a shipping acknowledgment only; please do not reply to this email.

Thank You,
[CompanyName]';

