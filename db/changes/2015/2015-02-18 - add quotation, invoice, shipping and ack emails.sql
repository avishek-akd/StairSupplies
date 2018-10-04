UPDATE `tbl_settings_per_company` SET `d_email_subject_quotation`='Your Stairsupplies Order Quotation #Form.orderId#' WHERE  `id`=1;
UPDATE `tbl_settings_per_company` SET `d_email_subject_quotation`='Your Nu-Wood Order Quotation #Form.orderId#' WHERE  `id`=2;
UPDATE `tbl_settings_per_company` SET `d_email_subject_quotation`='Your WildWood Order Quotation #Form.orderId#' WHERE  `id`=3;
UPDATE `tbl_settings_per_company` SET `d_email_subject_quotation`='Your Viewrail Order Quotation #Form.orderId#' WHERE  `id`=4;



UPDATE `tbl_settings_per_company`
SET `d_email_subject_ack`='Your Stair Supplies Order Acknowledgement #Form.orderId#',
`d_email_subject_quotation`='Your Stair Supplies Order Quotation #Form.orderId#',
`d_email_subject_invoice`='Your Stair Supplies Invoice #Form.orderId#',
`d_email_subject_invoice_shipment`='Your Stair Supplies Invoice #shipment.ShipmentNumber#',
`d_email_footer`='Stair Supplies | 1722 Eisenhower Dr. North, Suite B | Goshen, IN 46526<br />\r\n  Phone: 574 975 0288 | Toll Free: 866 226 6536 | Fax: 253 595 3715<br />\r\n  <a href="http://www.stairsupplies.net/" target="_blank">www.stairsupplies.net</a>\r\n  |\r\n  <a href="mailto:orders@stairsupplies.com">orders@stairsupplies.com</a>\r\n  |\r\n  <a href="http://www.stairsupplies.com/net/Policies" target="_blank">View Stair Supplies Policies</a>'
WHERE  `id`=1;



ALTER TABLE `tbl_settings_per_company`
	ADD COLUMN `d_email_quotation` VARCHAR(100) NULL DEFAULT NULL AFTER `d_email_noreply`,
	ADD COLUMN `d_email_invoice` VARCHAR(100) NULL DEFAULT NULL AFTER `d_email_quotation`,
	ADD COLUMN `d_email_shipping` VARCHAR(100) NULL DEFAULT NULL AFTER `d_email_invoice`,
	ADD COLUMN `d_email_acknowledgment` VARCHAR(100) NULL DEFAULT NULL AFTER `d_email_shipping`;

	
UPDATE tbl_settings_per_company
SET
	d_email_quotation=d_email_sales,
	d_email_invoice=d_email_accounting,
	d_email_shipping=d_email_accounting,
	d_email_acknowledgment=d_email_sales
WHERE  `id`=1;
UPDATE tbl_settings_per_company
SET
	d_email_quotation=d_email_sales,
	d_email_invoice=d_email_accounting,
	d_email_shipping=d_email_accounting,
	d_email_acknowledgment=d_email_sales
WHERE  `id`=2;
UPDATE tbl_settings_per_company
SET
	d_email_quotation=d_email_sales,
	d_email_invoice=d_email_accounting,
	d_email_shipping=d_email_accounting,
	d_email_acknowledgment=d_email_sales
WHERE  `id`=3;
UPDATE tbl_settings_per_company
SET
	d_email_quotation='quotes@viewrailsystems.com',
	d_email_invoice='invoices@viewrailsystems.com',
	d_email_shipping='shipping@viewrailsystems.com',
	d_email_acknowledgment='acknowledgement@viewrailsystems.com'
WHERE  `id`=4;




ALTER TABLE `tbl_settings_per_company`
	CHANGE COLUMN `d_email_support` `_unused_d_email_support` VARCHAR(200) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `d_email_accounting`;
ALTER TABLE `tbl_settings_per_company`
	CHANGE COLUMN `d_email_sales` `_unused_d_email_sales` VARCHAR(100) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `_unused_d_email_support`;

	
	
	
UPDATE `tbl_settings_per_company`
SET `d_email_customer_service`='"Stair Supplies Customer Service" <custservice@stairsupplies.com>'
WHERE  `id`=1;
