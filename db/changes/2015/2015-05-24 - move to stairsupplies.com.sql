UPDATE `stairs5_intranet`.`Company`
SET
	`webAddress`='http://www.stairsupplies.com',
	`salesUrlPrefix`='http://sales.stairsupplies.com/sales'
WHERE  `CompanyID`=1;


ALTER TABLE `Products`
	CHANGE COLUMN `_unused_WebsitePartNumber` `_unused_WebsitePartNumber` VARCHAR(50) NULL DEFAULT NULL COMMENT 'Stairsupplies.com part number' COLLATE 'utf8_unicode_ci' AFTER `WebsitePartName`,
	CHANGE COLUMN `WebsiteURL` `WebsiteURL` VARCHAR(255) NULL DEFAULT NULL COMMENT 'Stairsupplies.com address of the product' COLLATE 'utf8_unicode_ci' AFTER `_unused_WebsitePartNumber`;

UPDATE Products
SET WebsiteURL = Replace(WebsiteURL, 'www.stairsupplies.net', 'www.stairsupplies.com'),
	WebsiteImageURL = Replace(WebsiteImageURL, 'www.stairsupplies.net', 'www.stairsupplies.com'),
	Customer_Notes = Replace(Customer_Notes, 'www.stairsupplies.net', 'www.stairsupplies.com');

UPDATE Products
SET WebsiteURL = Replace(WebsiteURL, 'office.stairsupplies.net', 'office.stairsupplies.com'),
	WebsiteImageURL = Replace(WebsiteImageURL, 'office.stairsupplies.net', 'office.stairsupplies.com'),
	Customer_Notes = Replace(Customer_Notes, 'office.stairsupplies.net', 'office.stairsupplies.com');
