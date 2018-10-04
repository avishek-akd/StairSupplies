UPDATE Products SET WebsiteID = NULL WHERE WebsiteID = '';
ALTER TABLE Products
	CHANGE COLUMN WebsiteID WebsiteID INT UNSIGNED NULL DEFAULT NULL COMMENT 'Stairsupplies.com ID' AFTER WebsitePart;
