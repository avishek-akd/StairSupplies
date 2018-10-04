ALTER TABLE `TblOrdersBOM_ItemsSteps`
	CHANGE COLUMN `QuantitySanded` `QuantityPackedWood` INT(11) NULL DEFAULT NULL AFTER `QuantityFinalWood`
;
ALTER TABLE `TblOrdersBOM_Items`
	CHANGE COLUMN `SandedTotalQuantity` `PackedWoodTotalQuantity` INT(11) NOT NULL DEFAULT '0' COMMENT 'Quantity updated by trigger from TblOrdersBOM_ItemsSteps' AFTER `FinalWoodLastUpdated`,
	CHANGE COLUMN `SandedLastUpdated` `PackedWoodLastUpdated` DATETIME NULL DEFAULT NULL COMMENT 'Updated by trigger from TblOrdersBOM_ItemsSteps' AFTER `PackedWoodTotalQuantity`
;