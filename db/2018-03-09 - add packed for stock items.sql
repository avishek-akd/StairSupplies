ALTER TABLE `TblOrdersBOM_ItemsSteps`
	ADD COLUMN `QuantityPackedStock` INT(11) NULL DEFAULT NULL AFTER `QuantityPrefinishedStock`
;
ALTER TABLE `TblOrdersBOM_Items`
	ADD COLUMN `PackedStockTotalQuantity` INT(11) NOT NULL DEFAULT '0' COMMENT 'Quantity updated by trigger from TblOrdersBOM_ItemsSteps' AFTER `PrefinishedStockLastUpdated`,
	ADD COLUMN `PackedStockLastUpdated` DATETIME NULL DEFAULT NULL COMMENT 'Updated by trigger from TblOrdersBOM_ItemsSteps' AFTER `PackedStockTotalQuantity`
;




DELIMITER $$


DROP TRIGGER IF EXISTS `trgTblOrdersBOM_ItemsSteps_after_delete`
$$
CREATE TRIGGER `trgTblOrdersBOM_ItemsSteps_after_delete` AFTER DELETE ON `TblOrdersBOM_ItemsSteps` FOR EACH ROW
BEGIN

IF OLD.QuantityPRC IS NOT NULL THEN

	UPDATE TblOrdersBOM_Items
	SET
		PRCTotalQuantity = Coalesce((SELECT Sum(QuantityPRC) FROM TblOrdersBOM_ItemsSteps WHERE QuantityPRC IS NOT NULL AND OrderItemsID = OLD.OrderItemsID), 0),
		PRCLastUpdated   = (SELECT RecordCreated FROM TblOrdersBOM_ItemsSteps WHERE QuantityPRC IS NOT NULL AND OrderItemsID = OLD.OrderItemsID ORDER BY RecordCreated DESC LIMIT 0,1)
	WHERE OrderItemsID = OLD.OrderItemsID;

ELSEIF OLD.QuantityGlue IS NOT NULL THEN

	UPDATE TblOrdersBOM_Items
	SET
		GlueTotalQuantity = Coalesce((SELECT Sum(QuantityGlue) FROM TblOrdersBOM_ItemsSteps WHERE QuantityGlue IS NOT NULL AND OrderItemsID = OLD.OrderItemsID), 0),
		GlueLastUpdated   = (SELECT RecordCreated FROM TblOrdersBOM_ItemsSteps WHERE QuantityGlue IS NOT NULL AND OrderItemsID = OLD.OrderItemsID ORDER BY RecordCreated DESC LIMIT 0,1)
	WHERE OrderItemsID = OLD.OrderItemsID;

ELSEIF OLD.QuantityInProcessWood IS NOT NULL THEN

	UPDATE TblOrdersBOM_Items
	SET
		InProcessWoodTotalQuantity = Coalesce((SELECT Sum(QuantityInProcessWood) FROM TblOrdersBOM_ItemsSteps WHERE QuantityInProcessWood IS NOT NULL AND OrderItemsID = OLD.OrderItemsID), 0),
		InProcessWoodLastUpdated   = (SELECT RecordCreated FROM TblOrdersBOM_ItemsSteps WHERE QuantityInProcessWood IS NOT NULL AND OrderItemsID = OLD.OrderItemsID ORDER BY RecordCreated DESC LIMIT 0,1)
	WHERE OrderItemsID = OLD.OrderItemsID;

ELSEIF OLD.QuantityFinalWood IS NOT NULL THEN

	UPDATE TblOrdersBOM_Items
	SET
		FinalWoodTotalQuantity = Coalesce((SELECT Sum(QuantityFinalWood) FROM TblOrdersBOM_ItemsSteps WHERE QuantityFinalWood IS NOT NULL AND OrderItemsID = OLD.OrderItemsID), 0),
		FinalWoodLastUpdated   = (SELECT RecordCreated FROM TblOrdersBOM_ItemsSteps WHERE QuantityFinalWood IS NOT NULL AND OrderItemsID = OLD.OrderItemsID ORDER BY RecordCreated DESC LIMIT 0,1)
	WHERE OrderItemsID = OLD.OrderItemsID;

ELSEIF OLD.QuantityPackedWood IS NOT NULL THEN

	UPDATE TblOrdersBOM_Items
	SET
		PackedWoodTotalQuantity = Coalesce((SELECT Sum(QuantityPackedWood) FROM TblOrdersBOM_ItemsSteps WHERE QuantityPackedWood IS NOT NULL AND OrderItemsID = OLD.OrderItemsID), 0),
		PackedWoodLastUpdated   = (SELECT RecordCreated FROM TblOrdersBOM_ItemsSteps WHERE QuantityPackedWood IS NOT NULL AND OrderItemsID = OLD.OrderItemsID ORDER BY RecordCreated DESC LIMIT 0,1)
	WHERE OrderItemsID = OLD.OrderItemsID;

ELSEIF OLD.QuantityPrefinishedWood IS NOT NULL THEN

	UPDATE TblOrdersBOM_Items
	SET
		PrefinishedWoodTotalQuantity = Coalesce((SELECT Sum(QuantityPrefinishedWood) FROM TblOrdersBOM_ItemsSteps WHERE QuantityPrefinishedWood IS NOT NULL AND OrderItemsID = OLD.OrderItemsID), 0),
		PrefinishedWoodLastUpdated   = (SELECT RecordCreated FROM TblOrdersBOM_ItemsSteps WHERE QuantityPrefinishedWood IS NOT NULL AND OrderItemsID = OLD.OrderItemsID ORDER BY RecordCreated DESC LIMIT 0,1)
	WHERE OrderItemsID = OLD.OrderItemsID;




ELSEIF OLD.QuantityInProcessCable IS NOT NULL THEN

	UPDATE TblOrdersBOM_Items
	SET
		InProcessCableTotalQuantity = Coalesce((SELECT Sum(QuantityInProcessCable) FROM TblOrdersBOM_ItemsSteps WHERE QuantityInProcessCable IS NOT NULL AND OrderItemsID = OLD.OrderItemsID), 0),
		InProcessCableLastUpdated   = (SELECT RecordCreated FROM TblOrdersBOM_ItemsSteps WHERE QuantityInProcessCable IS NOT NULL AND OrderItemsID = OLD.OrderItemsID ORDER BY RecordCreated DESC LIMIT 0,1)
	WHERE OrderItemsID = OLD.OrderItemsID;

ELSEIF OLD.QuantityProduction IS NOT NULL THEN

	UPDATE TblOrdersBOM_Items
	SET
		ProductionTotalQuantity = Coalesce((SELECT Sum(QuantityProduction) FROM TblOrdersBOM_ItemsSteps WHERE QuantityProduction IS NOT NULL AND OrderItemsID = OLD.OrderItemsID), 0),
		ProductionLastUpdated   = (SELECT RecordCreated FROM TblOrdersBOM_ItemsSteps WHERE QuantityProduction IS NOT NULL AND OrderItemsID = OLD.OrderItemsID ORDER BY RecordCreated DESC LIMIT 0,1)
	WHERE OrderItemsID = OLD.OrderItemsID;

ELSEIF OLD.QuantityFinished IS NOT NULL THEN

	UPDATE TblOrdersBOM_Items
	SET
		FinishedTotalQuantity = Coalesce((SELECT Sum(QuantityFinished) FROM TblOrdersBOM_ItemsSteps WHERE QuantityFinished IS NOT NULL AND OrderItemsID = OLD.OrderItemsID), 0),
		FinishedLastUpdated   = (SELECT RecordCreated FROM TblOrdersBOM_ItemsSteps WHERE QuantityFinished IS NOT NULL AND OrderItemsID = OLD.OrderItemsID ORDER BY RecordCreated DESC LIMIT 0,1)
	WHERE OrderItemsID = OLD.OrderItemsID;

ELSEIF OLD.QuantityPackedCable IS NOT NULL THEN

	UPDATE TblOrdersBOM_Items
	SET
		PackedCableTotalQuantity = Coalesce((SELECT Sum(QuantityPackedCable) FROM TblOrdersBOM_ItemsSteps WHERE QuantityPackedCable IS NOT NULL AND OrderItemsID = OLD.OrderItemsID), 0),
		PackedCableLastUpdated   = (SELECT RecordCreated FROM TblOrdersBOM_ItemsSteps WHERE QuantityPackedCable IS NOT NULL AND OrderItemsID = OLD.OrderItemsID ORDER BY RecordCreated DESC LIMIT 0,1)
	WHERE OrderItemsID = OLD.OrderItemsID;




ELSEIF OLD.QuantityPulled IS NOT NULL THEN

	UPDATE TblOrdersBOM_Items
	SET
		PulledTotalQuantity = Coalesce((SELECT Sum(QuantityPulled) FROM TblOrdersBOM_ItemsSteps WHERE QuantityPulled IS NOT NULL AND OrderItemsID = OLD.OrderItemsID), 0),
		PulledLastUpdated   = (SELECT RecordCreated FROM TblOrdersBOM_ItemsSteps WHERE QuantityPulled IS NOT NULL AND OrderItemsID = OLD.OrderItemsID ORDER BY RecordCreated DESC LIMIT 0,1)
	WHERE OrderItemsID = OLD.OrderItemsID;

ELSEIF OLD.QuantityPrefinishedStock IS NOT NULL THEN

	UPDATE TblOrdersBOM_Items
	SET
		PrefinishedStockTotalQuantity = Coalesce((SELECT Sum(QuantityPrefinishedStock) FROM TblOrdersBOM_ItemsSteps WHERE QuantityPrefinishedStock IS NOT NULL AND OrderItemsID = OLD.OrderItemsID), 0),
		PrefinishedStockLastUpdated   = (SELECT RecordCreated FROM TblOrdersBOM_ItemsSteps WHERE QuantityPrefinishedStock IS NOT NULL AND OrderItemsID = OLD.OrderItemsID ORDER BY RecordCreated DESC LIMIT 0,1)
	WHERE OrderItemsID = OLD.OrderItemsID;

ELSEIF OLD.QuantityPackedStock IS NOT NULL THEN

	UPDATE TblOrdersBOM_Items
	SET
		PackedStockTotalQuantity = Coalesce((SELECT Sum(QuantityPackedStock) FROM TblOrdersBOM_ItemsSteps WHERE QuantityPackedStock IS NOT NULL AND OrderItemsID = OLD.OrderItemsID), 0),
		PackedStockLastUpdated   = (SELECT RecordCreated FROM TblOrdersBOM_ItemsSteps WHERE QuantityPackedStock IS NOT NULL AND OrderItemsID = OLD.OrderItemsID ORDER BY RecordCreated DESC LIMIT 0,1)
	WHERE OrderItemsID = OLD.OrderItemsID;

END IF;

END
$$


DELIMITER ;









DELIMITER $$


DROP TRIGGER IF EXISTS `trgTblOrdersBOM_ItemsSteps_after_insert`
$$
CREATE TRIGGER `trgTblOrdersBOM_ItemsSteps_after_insert` AFTER INSERT ON `TblOrdersBOM_ItemsSteps` FOR EACH ROW
BEGIN

DECLARE nonNullQuantities INT DEFAULT 0;


SET nonNullQuantities = nonNullQuantities
							+ (NEW.QuantityPRC IS NOT NULL)
							+ (NEW.QuantityGlue IS NOT NULL)
							+ (NEW.QuantityInProcessWood IS NOT NULL)
							+ (NEW.QuantityFinalWood IS NOT NULL)
							+ (NEW.QuantityPackedWood IS NOT NULL)
							+ (NEW.QuantityPrefinishedWood IS NOT NULL)

							+ (NEW.QuantityInProcessCable IS NOT NULL)
							+ (NEW.QuantityProduction IS NOT NULL)
							+ (NEW.QuantityFinished IS NOT NULL)
							+ (NEW.QuantityPackedCable IS NOT NULL)

							+ (NEW.QuantityPulled IS NOT NULL)
							+ (NEW.QuantityPrefinishedStock IS NOT NULL)
							+ (NEW.QuantityPackedStock IS NOT NULL);

IF nonNullQuantities <> 1 THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Exactly one of the quantities must be NON NULL.';
END IF;


IF NEW.QuantityPRC IS NOT NULL THEN

	UPDATE TblOrdersBOM_Items
	SET
		PRCTotalQuantity = PRCTotalQuantity + NEW.QuantityPRC,
		PRCLastUpdated   = NEW.RecordCreated
	WHERE OrderItemsID = NEW.OrderItemsID;

ELSEIF NEW.QuantityGlue IS NOT NULL THEN

	UPDATE TblOrdersBOM_Items
	SET
		GlueTotalQuantity = GlueTotalQuantity + NEW.QuantityGlue,
		GlueLastUpdated   = NEW.RecordCreated
	WHERE OrderItemsID = NEW.OrderItemsID;

ELSEIF NEW.QuantityInProcessWood IS NOT NULL THEN

	UPDATE TblOrdersBOM_Items
	SET
		InProcessWoodTotalQuantity = InProcessWoodTotalQuantity + NEW.QuantityInProcessWood,
		InProcessWoodLastUpdated   = NEW.RecordCreated
	WHERE OrderItemsID = NEW.OrderItemsID;

ELSEIF NEW.QuantityFinalWood IS NOT NULL THEN

	UPDATE TblOrdersBOM_Items
	SET
		FinalWoodTotalQuantity = FinalWoodTotalQuantity + NEW.QuantityFinalWood,
		FinalWoodLastUpdated   = NEW.RecordCreated
	WHERE OrderItemsID = NEW.OrderItemsID;

ELSEIF NEW.QuantityPackedWood IS NOT NULL THEN

	UPDATE TblOrdersBOM_Items
	SET
		PackedWoodTotalQuantity = PackedWoodTotalQuantity + NEW.QuantityPackedWood,
		PackedWoodLastUpdated   = NEW.RecordCreated
	WHERE OrderItemsID = NEW.OrderItemsID;

ELSEIF NEW.QuantityPrefinishedWood IS NOT NULL THEN

	UPDATE TblOrdersBOM_Items
	SET
		PrefinishedWoodTotalQuantity = PrefinishedWoodTotalQuantity + NEW.QuantityPrefinishedWood,
		PrefinishedWoodLastUpdated   = NEW.RecordCreated
	WHERE OrderItemsID = NEW.OrderItemsID;




ELSEIF NEW.QuantityInProcessCable IS NOT NULL THEN

	UPDATE TblOrdersBOM_Items
	SET
		InProcessCableTotalQuantity = InProcessCableTotalQuantity + NEW.QuantityInProcessCable,
		InProcessCableLastUpdated   = NEW.RecordCreated
	WHERE OrderItemsID = NEW.OrderItemsID;

ELSEIF NEW.QuantityProduction IS NOT NULL THEN

	UPDATE TblOrdersBOM_Items
	SET
		ProductionTotalQuantity = ProductionTotalQuantity + NEW.QuantityProduction,
		ProductionLastUpdated   = NEW.RecordCreated
	WHERE OrderItemsID = NEW.OrderItemsID;

ELSEIF NEW.QuantityFinished IS NOT NULL THEN

	UPDATE TblOrdersBOM_Items
	SET
		FinishedTotalQuantity = FinishedTotalQuantity + NEW.QuantityFinished,
		FinishedLastUpdated   = NEW.RecordCreated
	WHERE OrderItemsID = NEW.OrderItemsID;

ELSEIF NEW.QuantityPackedCable IS NOT NULL THEN

	UPDATE TblOrdersBOM_Items
	SET
		PackedCableTotalQuantity = PackedCableTotalQuantity + NEW.QuantityPackedCable,
		PackedCableLastUpdated   = NEW.RecordCreated
	WHERE OrderItemsID = NEW.OrderItemsID;




ELSEIF NEW.QuantityPulled IS NOT NULL THEN

	UPDATE TblOrdersBOM_Items
	SET
		PulledTotalQuantity = PulledTotalQuantity + NEW.QuantityPulled,
		PulledLastUpdated   = NEW.RecordCreated
	WHERE OrderItemsID = NEW.OrderItemsID;

ELSEIF NEW.QuantityPrefinishedStock IS NOT NULL THEN

	UPDATE TblOrdersBOM_Items
	SET
		PrefinishedStockTotalQuantity = PrefinishedStockTotalQuantity + NEW.QuantityPrefinishedStock,
		PrefinishedStockLastUpdated   = NEW.RecordCreated
	WHERE OrderItemsID = NEW.OrderItemsID;

ELSEIF NEW.QuantityPackedStock IS NOT NULL THEN

	UPDATE TblOrdersBOM_Items
	SET
		PackedStockTotalQuantity = PackedStockTotalQuantity + NEW.QuantityPackedStock,
		PackedStockLastUpdated   = NEW.RecordCreated
	WHERE OrderItemsID = NEW.OrderItemsID;

END IF;

END
$$


DELIMITER ;