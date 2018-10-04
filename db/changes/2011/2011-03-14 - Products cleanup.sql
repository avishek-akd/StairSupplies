ALTER TABLE `TblProductVendors`
	RENAME TO `z_unused_TblProductVendors`;


ALTER TABLE `Products` 
	CHANGE COLUMN `Qty_On_Hand` `z_unused_Qty_On_Hand` INT(10) NOT NULL DEFAULT '0' AFTER `DateUpdated`,
	CHANGE COLUMN `Pcs_Per_box` `z_unused_Pcs_Per_box` VARCHAR(50) NULL DEFAULT NULL AFTER `z_unused_Qty_On_Hand`,
	CHANGE COLUMN `PiecesPerCarton` `z_unused_PiecesPerCarton` VARCHAR(255) NULL DEFAULT NULL AFTER `z_unused_Qty_On_Hand`,
	
	ADD COLUMN `WebsitePart` VARCHAR(50) NULL DEFAULT NULL COMMENT 'Stairsupplies.com part number' AFTER `CompetitorEquivalent`,
	ADD COLUMN `WebsiteID` VARCHAR(50) NULL DEFAULT NULL COMMENT 'Stairsupplies.com ID' AFTER `WebsitePart`;