ALTER TABLE `TblOrdersBOM_ItemsSteps`
	CHANGE COLUMN `QuantityFinish` `QuantityFinished` INT(11) NULL DEFAULT NULL AFTER `QuantityProduction`
;
ALTER TABLE `TblOrdersBOM_Items`
	CHANGE COLUMN `FinishTotalQuantity` `FinishedTotalQuantity` INT(11) NOT NULL DEFAULT '0' COMMENT 'Quantity updated by trigger from TblOrdersBOM_ItemsSteps' AFTER `ProductionLastUpdated`,
	CHANGE COLUMN `FinishLastUpdated` `FinishedLastUpdated` DATETIME NULL DEFAULT NULL COMMENT 'Updated by trigger from TblOrdersBOM_ItemsSteps' AFTER `FinishedTotalQuantity`
;
