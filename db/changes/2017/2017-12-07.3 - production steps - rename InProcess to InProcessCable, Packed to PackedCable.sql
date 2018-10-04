ALTER TABLE `TblOrdersBOM_ItemsSteps`
	CHANGE COLUMN `QuantityInProcess` `QuantityInProcessCable` INT(11) NULL DEFAULT NULL AFTER `QuantityPrefinishedWood`
;
ALTER TABLE `TblOrdersBOM_Items`
	CHANGE COLUMN `InProcessTotalQuantity` `InProcessCableTotalQuantity` INT(11) NOT NULL DEFAULT '0' COMMENT 'Quantity updated by trigger from TblOrdersBOM_ItemsSteps' AFTER `PrefinishedWoodLastUpdated`,
	CHANGE COLUMN `InProcessLastUpdated` `InProcessCableLastUpdated` DATETIME NULL DEFAULT NULL COMMENT 'Updated by trigger from TblOrdersBOM_ItemsSteps' AFTER `InProcessCableTotalQuantity`
;




ALTER TABLE `TblOrdersBOM_ItemsSteps`
	CHANGE COLUMN `QuantityPacked` `QuantityPackedCable` INT(11) NULL DEFAULT NULL AFTER `QuantityFinish`
;
ALTER TABLE `TblOrdersBOM_Items`
	CHANGE COLUMN `PackedTotalQuantity` `PackedCableTotalQuantity` INT(11) NOT NULL DEFAULT '0' COMMENT 'Quantity updated by trigger from TblOrdersBOM_ItemsSteps' AFTER `FinishLastUpdated`,
	CHANGE COLUMN `PackedLastUpdated` `PackedCableLastUpdated` DATETIME NULL DEFAULT NULL COMMENT 'Updated by trigger from TblOrdersBOM_ItemsSteps' AFTER `PackedCableTotalQuantity`
;
