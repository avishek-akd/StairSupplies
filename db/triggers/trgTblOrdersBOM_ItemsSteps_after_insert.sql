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
							+ (NEW.QuantityPrefinishedStock IS NOT NULL);

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

END IF;

END
$$


DELIMITER ;