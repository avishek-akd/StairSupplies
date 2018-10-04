ALTER TABLE `tbl_settings`  
	ADD COLUMN `d_email_header` VARCHAR(500) NULL DEFAULT NULL AFTER `d_email_subject_invoice_shipment`, 
	ADD COLUMN `d_email_footer` VARCHAR(500) NULL DEFAULT NULL AFTER `d_email_header`;

UPDATE `tbl_settings` SET `d_email_header`='<div id="logo">\r\n  <a href="http://www.stairsupplies.com/" target="_blank"><img src="cid:CompanyLogo"></a>\r\n  1 (866) 226 6536\r\n  <div id="openHours">Open Monday-Friday</div>\r\n </div>\r\n' WHERE `id`=1;
UPDATE `tbl_settings` SET `d_email_header`='<div id="logo">\r\n  <a href="http://www.nu-wood.com/" target="_blank"><img src="cid:CompanyLogo"></a>\r\n  1 (800) 526 1278\r\n  <div id="openHours">Open Monday-Friday</div>\r\n </div>' WHERE `id`=2;
UPDATE `tbl_settings` SET `d_email_header`='<div id="logo">\r\n  <a href="http://www.wildwoodbuildingsupply.com/" target="_blank"><img src="cid:CompanyLogo"></a>\r\n  574-538-4091\r\n  <div id="openHours">Open Monday-Friday</div>\r\n </div>' WHERE `id`=3;

UPDATE `tbl_settings` SET `d_email_footer`='StairSupplies | Suite A 1722 Eisenhower Dr. North | Goshen, IN 46526<br />\r\n  Phone: 574 975 0288 | Toll Free: 866 226 6536 | Fax: 253 595 3715<br />\r\n  <a href="http://www.stairsupplies.com/" target="_blank">www.stairsupplies.com</a>\r\n  |\r\n  <a href="mailto:orders@stairsupplies.com">orders@stairsupplies.com</a>' WHERE `id`=1;
UPDATE `tbl_settings` SET `d_email_footer`='Nu-Wood | Suite B 1722 Eisenhower Dr. North | Goshen, IN 46526<br />\r\n  Phone: 574-534-1192 | Toll Free: 800 526 1278<br />\r\n  <a href="http://www.nu-wood.com/" target="_blank">www.nu-wood.com</a>\r\n  |\r\n  <a href="mailto:orders@nu-wood.com">orders@nu-wood.com</a>' WHERE `id`=2;
UPDATE `tbl_settings` SET `d_email_footer`='WildWood | Suite C 1722 Eisenhower Dr. North | Goshen, IN 46526<br />\r\n  Phone: 574-538-4091<br />\r\n  <a href="http://www.wildwoodbuildingsupply.com/" target="_blank">www.wildwoodbuildingsupply.com</a>\r\n  |\r\n  <a href="mailto:info@wildwoodbuildingsupply.com">info@wildwoodbuildingsupply.com</a>' WHERE `id`=3 ;