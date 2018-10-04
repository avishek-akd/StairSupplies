ALTER TABLE `Products`
	ADD COLUMN `WebsiteImageURL` VARCHAR(200) NULL DEFAULT NULL COMMENT 'URL address of the image on the stairsupplies site' AFTER `WebsiteID`;
