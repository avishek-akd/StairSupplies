ALTER TABLE `TblOrdersBOM_ItemsSteps`
	ADD COLUMN `QuantityInProcessWood` INT(11) NULL DEFAULT NULL AFTER `QuantityGlue`
;
ALTER TABLE `TblOrdersBOM_Items`
	ADD COLUMN `InProcessWoodTotalQuantity` INT NOT NULL DEFAULT 0 COMMENT 'Quantity updated by trigger from TblOrdersBOM_ItemsSteps' AFTER `GlueLastUpdated`,
	ADD COLUMN `InProcessWoodLastUpdated` DATETIME NULL DEFAULT NULL COMMENT 'Updated by trigger from TblOrdersBOM_ItemsSteps' AFTER `InProcessWoodTotalQuantity`
;