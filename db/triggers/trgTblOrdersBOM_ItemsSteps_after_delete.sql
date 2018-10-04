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

END IF;

END
$$


DELIMITER ;