RENAME TABLE `TblOrdersBOM_ItemsHistory` TO `TblOrdersBOM_ItemsSteps`
;



ALTER TABLE `TblOrdersBOM_ItemsSteps`
	ADD COLUMN `QuantityPRC` INT NULL DEFAULT NULL AFTER `EmployeeID`,
	ADD COLUMN `QuantityGlue` INT NULL DEFAULT NULL AFTER `QuantityPRC`,
	ADD COLUMN `QuantityFinalWood` INT NULL DEFAULT NULL AFTER `QuantityGlue`,
	ADD COLUMN `QuantitySanded` INT NULL DEFAULT NULL AFTER `QuantityFinalWood`,
	ADD COLUMN `QuantityPrefinishedWood` INT NULL DEFAULT NULL AFTER `QuantitySanded`,

	--  keep QuantityInProcess
	ADD COLUMN `QuantityProduction` INT NULL DEFAULT NULL AFTER `QuantityInProcess`,
	ADD COLUMN `QuantityFinish` INT NULL DEFAULT NULL AFTER `QuantityProduction`,
	ADD COLUMN `QuantityPacked` INT NULL DEFAULT NULL AFTER `QuantityFinish`,

	--  keep QuantityPulled
	ADD COLUMN `QuantityPrefinishedStock` INT NULL DEFAULT NULL AFTER `QuantityPulled`
;




ALTER TABLE `TblOrdersBOM_Items`
	CHANGE COLUMN `PRC` `_unused_PRC` TINYINT(4) NULL DEFAULT '0',
	CHANGE COLUMN `PRC_Date` `_unused_PRC_Date` DATETIME NULL DEFAULT NULL,
	CHANGE COLUMN `PRC_EmployeeID` `_unused_PRC_EmployeeID` INT(11) NULL DEFAULT NULL,

	CHANGE COLUMN `Final` `_unused_Final` TINYINT(4) NULL DEFAULT '0',
	CHANGE COLUMN `Final_Date` `_unused_Final_Date` DATETIME NULL DEFAULT NULL,
	CHANGE COLUMN `Final_EmployeeID` `_unused_Final_EmployeeID` INT(11) NULL DEFAULT NULL,

	CHANGE COLUMN `Started` `_unused_Started` TINYINT(4) NULL DEFAULT '0' AFTER `_unused_PRC_EmployeeID`,
	CHANGE COLUMN `Started_Date` `_unused_Started_Date` DATETIME NULL DEFAULT NULL AFTER `_unused_Started`,
	CHANGE COLUMN `Started_EmployeeID` `_unused_Started_EmployeeID` INT(11) NULL DEFAULT NULL AFTER `_unused_Started_Date`,

	CHANGE COLUMN `Prefinishing_Complete` `_unused_Prefinishing_Complete` TINYINT(4) NULL DEFAULT '0' AFTER `_unused_Final_EmployeeID`,
	CHANGE COLUMN `Prefinishing_Complete_Date` `_unused_Prefinishing_Complete_Date` DATETIME NULL DEFAULT NULL AFTER `_unused_Prefinishing_Complete`,
	CHANGE COLUMN `Prefinishing_Complete_EmployeeID` `_unused_Prefinishing_Complete_EmployeeID` INT(11) NULL DEFAULT NULL AFTER `_unused_Prefinishing_Complete_Date`

;
ALTER TABLE `TblOrdersBOM_Items`
	ADD COLUMN `PRCTotalQuantity` INT NOT NULL DEFAULT 0 COMMENT 'Quantity updated by trigger from TblOrdersBOM_ItemsSteps' AFTER `UnitWeight`,
	ADD COLUMN `PRCLastUpdated` DATETIME NULL DEFAULT NULL COMMENT 'Updated by trigger from TblOrdersBOM_ItemsSteps' AFTER `PRCTotalQuantity`,

	ADD COLUMN `GlueTotalQuantity` INT NOT NULL DEFAULT 0 COMMENT 'Quantity updated by trigger from TblOrdersBOM_ItemsSteps' AFTER `PRCLastUpdated`,
	ADD COLUMN `GlueLastUpdated` DATETIME NULL DEFAULT NULL COMMENT 'Updated by trigger from TblOrdersBOM_ItemsSteps' AFTER `GlueTotalQuantity`,

	ADD COLUMN `FinalWoodTotalQuantity` INT NOT NULL DEFAULT 0 COMMENT 'Quantity updated by trigger from TblOrdersBOM_ItemsSteps' AFTER `GlueLastUpdated`,
	ADD COLUMN `FinalWoodLastUpdated` DATETIME NULL DEFAULT NULL COMMENT 'Updated by trigger from TblOrdersBOM_ItemsSteps' AFTER `FinalWoodTotalQuantity`,

	ADD COLUMN `SandedTotalQuantity` INT NOT NULL DEFAULT 0 COMMENT 'Quantity updated by trigger from TblOrdersBOM_ItemsSteps' AFTER `FinalWoodLastUpdated`,
	ADD COLUMN `SandedLastUpdated` DATETIME NULL DEFAULT NULL COMMENT 'Updated by trigger from TblOrdersBOM_ItemsSteps' AFTER `SandedTotalQuantity`,

	ADD COLUMN `PrefinishedWoodTotalQuantity` INT NOT NULL DEFAULT 0 COMMENT 'Quantity updated by trigger from TblOrdersBOM_ItemsSteps' AFTER `SandedLastUpdated`,
	ADD COLUMN `PrefinishedWoodLastUpdated` DATETIME NULL DEFAULT NULL COMMENT 'Updated by trigger from TblOrdersBOM_ItemsSteps' AFTER `PrefinishedWoodTotalQuantity`,

	ADD COLUMN `InProcessTotalQuantity` INT NOT NULL DEFAULT 0 COMMENT 'Quantity updated by trigger from TblOrdersBOM_ItemsSteps' AFTER `PrefinishedWoodLastUpdated`,
	ADD COLUMN `InProcessLastUpdated` DATETIME NULL DEFAULT NULL COMMENT 'Updated by trigger from TblOrdersBOM_ItemsSteps' AFTER `InProcessTotalQuantity`,

	ADD COLUMN `ProductionTotalQuantity` INT NOT NULL DEFAULT 0 COMMENT 'Quantity updated by trigger from TblOrdersBOM_ItemsSteps' AFTER `InProcessLastUpdated`,
	ADD COLUMN `ProductionLastUpdated` DATETIME NULL DEFAULT NULL COMMENT 'Updated by trigger from TblOrdersBOM_ItemsSteps' AFTER `ProductionTotalQuantity`,

	ADD COLUMN `FinishTotalQuantity` INT NOT NULL DEFAULT 0 COMMENT 'Quantity updated by trigger from TblOrdersBOM_ItemsSteps' AFTER `ProductionLastUpdated`,
	ADD COLUMN `FinishLastUpdated` DATETIME NULL DEFAULT NULL COMMENT 'Updated by trigger from TblOrdersBOM_ItemsSteps' AFTER `FinishTotalQuantity`,

	ADD COLUMN `PackedTotalQuantity` INT NOT NULL DEFAULT 0 COMMENT 'Quantity updated by trigger from TblOrdersBOM_ItemsSteps' AFTER `FinishLastUpdated`,
	ADD COLUMN `PackedLastUpdated` DATETIME NULL DEFAULT NULL COMMENT 'Updated by trigger from TblOrdersBOM_ItemsSteps' AFTER `PackedTotalQuantity`,

	ADD COLUMN `PulledTotalQuantity` INT NOT NULL DEFAULT 0 COMMENT 'Quantity updated by trigger from TblOrdersBOM_ItemsSteps' AFTER `PackedLastUpdated`,
	ADD COLUMN `PulledLastUpdated` DATETIME NULL DEFAULT NULL COMMENT 'Updated by trigger from TblOrdersBOM_ItemsSteps' AFTER `PulledTotalQuantity`,

	ADD COLUMN `PrefinishedStockTotalQuantity` INT NOT NULL DEFAULT 0 COMMENT 'Quantity updated by trigger from TblOrdersBOM_ItemsSteps' AFTER `PulledLastUpdated`,
	ADD COLUMN `PrefinishedStockLastUpdated` DATETIME NULL DEFAULT NULL COMMENT 'Updated by trigger from TblOrdersBOM_ItemsSteps' AFTER `PrefinishedStockTotalQuantity`
;


--
--    WOOD
--


--  Transfer PRC
--    There are a couple of records that don't have a PRC_date so we use ShippedDate for those
INSERT INTO TblOrdersBOM_ItemsSteps
	(
		OrderItemsID, EmployeeID, QuantityPRC, RecordCreated
	)
SELECT OrderItemsID, _unused_PRC_EmployeeID, QuantityOrdered, Coalesce(_unused_PRC_Date, ShippedDate)
FROM TblOrdersBOM_Items
WHERE _unused_PRC = 1
	AND (_unused_PRC_Date IS NOT NULL OR ShippedDate IS NOT NULL)
;

--  Final for wood items ->  Glue and FinalWood
--    There are a couple of records that don't have a Final_date so we use ShippedDate for those
INSERT INTO TblOrdersBOM_ItemsSteps
	(
		OrderItemsID, EmployeeID, QuantityGlue, RecordCreated
	)
SELECT OrderItemsID, _unused_Final_EmployeeID, QuantityOrdered, Coalesce(_unused_Final_Date, ShippedDate)
FROM TblOrdersBOM_Items
	INNER JOIN TblProducts    ON TblProducts.ProductID = TblOrdersBOM_Items.ProductID
	INNER JOIN TblProductType ON TblProductType.ProductType_id = TblProducts.ProductType_id
WHERE _unused_Final = 1
	AND (_unused_Final_Date IS NOT NULL OR ShippedDate IS NOT NULL)
	AND ProductionTypeID = 2
;
INSERT INTO TblOrdersBOM_ItemsSteps
	(
		OrderItemsID, EmployeeID, QuantityFinalWood, RecordCreated
	)
SELECT OrderItemsID, _unused_Final_EmployeeID, QuantityOrdered, Coalesce(_unused_Final_Date, ShippedDate)
FROM TblOrdersBOM_Items
	INNER JOIN TblProducts    ON TblProducts.ProductID = TblOrdersBOM_Items.ProductID
	INNER JOIN TblProductType ON TblProductType.ProductType_id = TblProducts.ProductType_id
WHERE _unused_Final = 1
	AND (_unused_Final_Date IS NOT NULL OR ShippedDate IS NOT NULL)
	AND ProductionTypeID = 2
;

--  Prefinishing_complete for wood items ->  Sanded and PrefinishingWood
INSERT INTO TblOrdersBOM_ItemsSteps
	(
		OrderItemsID, EmployeeID,   QuantitySanded,   RecordCreated
	)
SELECT OrderItemsID, _unused_Prefinishing_Complete_EmployeeID, QuantityOrdered, _unused_Prefinishing_Complete_Date
FROM TblOrdersBOM_Items
	INNER JOIN TblProducts    ON TblProducts.ProductID = TblOrdersBOM_Items.ProductID
	INNER JOIN TblProductType ON TblProductType.ProductType_id = TblProducts.ProductType_id
WHERE _unused_Prefinishing_Complete = 1
	AND ProductionTypeID = 2
;
INSERT INTO TblOrdersBOM_ItemsSteps
	(
		OrderItemsID, EmployeeID,   QuantityPrefinishedWood,   RecordCreated
	)
SELECT OrderItemsID, _unused_Prefinishing_Complete_EmployeeID, QuantityOrdered, _unused_Prefinishing_Complete_Date
FROM TblOrdersBOM_Items
	INNER JOIN TblProducts    ON TblProducts.ProductID = TblOrdersBOM_Items.ProductID
	INNER JOIN TblProductType ON TblProductType.ProductType_id = TblProducts.ProductType_id
WHERE _unused_Prefinishing_Complete = 1
	AND ProductionTypeID = 2
;


--
--    CABLE
--


--  Started ->  Production
INSERT INTO TblOrdersBOM_ItemsSteps
	(
		OrderItemsID, EmployeeID,   QuantityProduction,   RecordCreated
	)
SELECT OrderItemsID, _unused_Started_EmployeeID AS EmployeeID, QuantityOrdered, _unused_Started_Date AS RecordCreated
FROM TblOrdersBOM_Items
WHERE _unused_Started = 1
;

--  Final for cable items ->  Packed
--    There are a couple of records that don't have a Final_date but those seem invalid anyway so ignore them
INSERT INTO TblOrdersBOM_ItemsSteps
	(
		OrderItemsID, EmployeeID, QuantityPacked, RecordCreated
	)
SELECT OrderItemsID, _unused_Final_EmployeeID, QuantityOrdered, _unused_Final_Date
FROM TblOrdersBOM_Items
	INNER JOIN TblProducts    ON TblProducts.ProductID = TblOrdersBOM_Items.ProductID
	INNER JOIN TblProductType ON TblProductType.ProductType_id = TblProducts.ProductType_id
WHERE _unused_Final = 1
	AND ProductionTypeID = 3
;


--  Prefinishing_complete for cable items ->  Finish
INSERT INTO TblOrdersBOM_ItemsSteps
	(
		OrderItemsID, EmployeeID,   QuantityFinish,   RecordCreated
	)
SELECT OrderItemsID, _unused_Prefinishing_Complete_EmployeeID, QuantityOrdered, _unused_Prefinishing_Complete_Date
FROM TblOrdersBOM_Items
	INNER JOIN TblProducts    ON TblProducts.ProductID = TblOrdersBOM_Items.ProductID
	INNER JOIN TblProductType ON TblProductType.ProductType_id = TblProducts.ProductType_id
WHERE _unused_Prefinishing_Complete = 1
	AND ProductionTypeID = 3
;


--
--    STOCK
--


--  Prefinishing_complete for stock items ->  PrefinishedStock
INSERT INTO TblOrdersBOM_ItemsSteps
	(
		OrderItemsID, EmployeeID,   QuantityPrefinishedStock,   RecordCreated
	)
SELECT OrderItemsID, _unused_Prefinishing_Complete_EmployeeID, QuantityOrdered, _unused_Prefinishing_Complete_Date
FROM TblOrdersBOM_Items
	INNER JOIN TblProducts    ON TblProducts.ProductID = TblOrdersBOM_Items.ProductID
	INNER JOIN TblProductType ON TblProductType.ProductType_id = TblProducts.ProductType_id
WHERE _unused_Prefinishing_Complete = 1
	AND ProductionTypeID IN (1, 4, 5)
;




UPDATE TblOrdersBOM_Items
SET
	PRCTotalQuantity = Coalesce((SELECT Sum(QuantityPRC) FROM TblOrdersBOM_ItemsSteps WHERE QuantityPRC IS NOT NULL AND OrderItemsID = TblOrdersBOM_Items.OrderItemsID), 0),
	PRCLastUpdated   = (SELECT RecordCreated FROM TblOrdersBOM_ItemsSteps WHERE QuantityPRC IS NOT NULL AND OrderItemsID = TblOrdersBOM_Items.OrderItemsID ORDER BY RecordCreated DESC LIMIT 0,1),

	GlueTotalQuantity = Coalesce((SELECT Sum(QuantityGlue) FROM TblOrdersBOM_ItemsSteps WHERE QuantityGlue IS NOT NULL AND OrderItemsID = TblOrdersBOM_Items.OrderItemsID), 0),
	GlueLastUpdated   = (SELECT RecordCreated FROM TblOrdersBOM_ItemsSteps WHERE QuantityGlue IS NOT NULL AND OrderItemsID = TblOrdersBOM_Items.OrderItemsID ORDER BY RecordCreated DESC LIMIT 0,1),

	FinalWoodTotalQuantity = Coalesce((SELECT Sum(QuantityFinalWood) FROM TblOrdersBOM_ItemsSteps WHERE QuantityFinalWood IS NOT NULL AND OrderItemsID = TblOrdersBOM_Items.OrderItemsID), 0),
	FinalWoodLastUpdated   = (SELECT RecordCreated FROM TblOrdersBOM_ItemsSteps WHERE QuantityFinalWood IS NOT NULL AND OrderItemsID = TblOrdersBOM_Items.OrderItemsID ORDER BY RecordCreated DESC LIMIT 0,1),

	SandedTotalQuantity = Coalesce((SELECT Sum(QuantitySanded) FROM TblOrdersBOM_ItemsSteps WHERE QuantitySanded IS NOT NULL AND OrderItemsID = TblOrdersBOM_Items.OrderItemsID), 0),
	SandedLastUpdated   = (SELECT RecordCreated FROM TblOrdersBOM_ItemsSteps WHERE QuantitySanded IS NOT NULL AND OrderItemsID = TblOrdersBOM_Items.OrderItemsID ORDER BY RecordCreated DESC LIMIT 0,1),

	PrefinishedWoodTotalQuantity = Coalesce((SELECT Sum(QuantityPrefinishedWood) FROM TblOrdersBOM_ItemsSteps WHERE QuantityPrefinishedWood IS NOT NULL AND OrderItemsID = TblOrdersBOM_Items.OrderItemsID), 0),
	PrefinishedWoodLastUpdated   = (SELECT RecordCreated FROM TblOrdersBOM_ItemsSteps WHERE QuantityPrefinishedWood IS NOT NULL AND OrderItemsID = TblOrdersBOM_Items.OrderItemsID ORDER BY RecordCreated DESC LIMIT 0,1),

	InProcessTotalQuantity = Coalesce((SELECT Sum(QuantityInProcess) FROM TblOrdersBOM_ItemsSteps WHERE QuantityInProcess IS NOT NULL AND OrderItemsID = TblOrdersBOM_Items.OrderItemsID), 0),
	InProcessLastUpdated   = (SELECT RecordCreated FROM TblOrdersBOM_ItemsSteps WHERE QuantityInProcess IS NOT NULL AND OrderItemsID = TblOrdersBOM_Items.OrderItemsID ORDER BY RecordCreated DESC LIMIT 0,1),

	ProductionTotalQuantity = Coalesce((SELECT Sum(QuantityProduction) FROM TblOrdersBOM_ItemsSteps WHERE QuantityProduction IS NOT NULL AND OrderItemsID = TblOrdersBOM_Items.OrderItemsID), 0),
	ProductionLastUpdated   = (SELECT RecordCreated FROM TblOrdersBOM_ItemsSteps WHERE QuantityProduction IS NOT NULL AND OrderItemsID = TblOrdersBOM_Items.OrderItemsID ORDER BY RecordCreated DESC LIMIT 0,1),

	FinishTotalQuantity = Coalesce((SELECT Sum(QuantityFinish) FROM TblOrdersBOM_ItemsSteps WHERE QuantityFinish IS NOT NULL AND OrderItemsID = TblOrdersBOM_Items.OrderItemsID), 0),
	FinishLastUpdated   = (SELECT RecordCreated FROM TblOrdersBOM_ItemsSteps WHERE QuantityFinish IS NOT NULL AND OrderItemsID = TblOrdersBOM_Items.OrderItemsID ORDER BY RecordCreated DESC LIMIT 0,1),

	PackedTotalQuantity = Coalesce((SELECT Sum(QuantityPacked) FROM TblOrdersBOM_ItemsSteps WHERE QuantityPacked IS NOT NULL AND OrderItemsID = TblOrdersBOM_Items.OrderItemsID), 0),
	PackedLastUpdated   = (SELECT RecordCreated FROM TblOrdersBOM_ItemsSteps WHERE QuantityPacked IS NOT NULL AND OrderItemsID = TblOrdersBOM_Items.OrderItemsID ORDER BY RecordCreated DESC LIMIT 0,1),

	PulledTotalQuantity = Coalesce((SELECT Sum(QuantityPulled) FROM TblOrdersBOM_ItemsSteps WHERE QuantityPulled IS NOT NULL AND OrderItemsID = TblOrdersBOM_Items.OrderItemsID), 0),
	PulledLastUpdated   = (SELECT RecordCreated FROM TblOrdersBOM_ItemsSteps WHERE QuantityPulled IS NOT NULL AND OrderItemsID = TblOrdersBOM_Items.OrderItemsID ORDER BY RecordCreated DESC LIMIT 0,1),

	PrefinishedStockTotalQuantity = Coalesce((SELECT Sum(QuantityPrefinishedStock) FROM TblOrdersBOM_ItemsSteps WHERE QuantityPrefinishedStock IS NOT NULL AND OrderItemsID = TblOrdersBOM_Items.OrderItemsID LIMIT 0,1), 0),
	PrefinishedStockLastUpdated   = (SELECT RecordCreated FROM TblOrdersBOM_ItemsSteps WHERE QuantityPrefinishedStock IS NOT NULL AND OrderItemsID = TblOrdersBOM_Items.OrderItemsID ORDER BY RecordCreated DESC LIMIT 0,1)
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

ELSEIF OLD.QuantityFinalWood IS NOT NULL THEN

	UPDATE TblOrdersBOM_Items
	SET
		FinalWoodTotalQuantity = Coalesce((SELECT Sum(QuantityFinalWood) FROM TblOrdersBOM_ItemsSteps WHERE QuantityFinalWood IS NOT NULL AND OrderItemsID = OLD.OrderItemsID), 0),
		FinalWoodLastUpdated   = (SELECT RecordCreated FROM TblOrdersBOM_ItemsSteps WHERE QuantityFinalWood IS NOT NULL AND OrderItemsID = OLD.OrderItemsID ORDER BY RecordCreated DESC LIMIT 0,1)
	WHERE OrderItemsID = OLD.OrderItemsID;

ELSEIF OLD.QuantitySanded IS NOT NULL THEN

	UPDATE TblOrdersBOM_Items
	SET
		SandedTotalQuantity = Coalesce((SELECT Sum(QuantitySanded) FROM TblOrdersBOM_ItemsSteps WHERE QuantitySanded IS NOT NULL AND OrderItemsID = OLD.OrderItemsID), 0),
		SandedLastUpdated   = (SELECT RecordCreated FROM TblOrdersBOM_ItemsSteps WHERE QuantitySanded IS NOT NULL AND OrderItemsID = OLD.OrderItemsID ORDER BY RecordCreated DESC LIMIT 0,1)
	WHERE OrderItemsID = OLD.OrderItemsID;

ELSEIF OLD.QuantityPrefinishedWood IS NOT NULL THEN

	UPDATE TblOrdersBOM_Items
	SET
		PrefinishedWoodTotalQuantity = Coalesce((SELECT Sum(QuantityPrefinishedWood) FROM TblOrdersBOM_ItemsSteps WHERE QuantityPrefinishedWood IS NOT NULL AND OrderItemsID = OLD.OrderItemsID), 0),
		PrefinishedWoodLastUpdated   = (SELECT RecordCreated FROM TblOrdersBOM_ItemsSteps WHERE QuantityPrefinishedWood IS NOT NULL AND OrderItemsID = OLD.OrderItemsID ORDER BY RecordCreated DESC LIMIT 0,1)
	WHERE OrderItemsID = OLD.OrderItemsID;




ELSEIF OLD.QuantityInProcess IS NOT NULL THEN

	UPDATE TblOrdersBOM_Items
	SET
		InProcessTotalQuantity = Coalesce((SELECT Sum(QuantityInProcess) FROM TblOrdersBOM_ItemsSteps WHERE QuantityInProcess IS NOT NULL AND OrderItemsID = OLD.OrderItemsID), 0),
		InProcessLastUpdated   = (SELECT RecordCreated FROM TblOrdersBOM_ItemsSteps WHERE QuantityInProcess IS NOT NULL AND OrderItemsID = OLD.OrderItemsID ORDER BY RecordCreated DESC LIMIT 0,1)
	WHERE OrderItemsID = OLD.OrderItemsID;

ELSEIF OLD.QuantityProduction IS NOT NULL THEN

	UPDATE TblOrdersBOM_Items
	SET
		ProductionTotalQuantity = Coalesce((SELECT Sum(QuantityProduction) FROM TblOrdersBOM_ItemsSteps WHERE QuantityProduction IS NOT NULL AND OrderItemsID = OLD.OrderItemsID), 0),
		ProductionLastUpdated   = (SELECT RecordCreated FROM TblOrdersBOM_ItemsSteps WHERE QuantityProduction IS NOT NULL AND OrderItemsID = OLD.OrderItemsID ORDER BY RecordCreated DESC LIMIT 0,1)
	WHERE OrderItemsID = OLD.OrderItemsID;

ELSEIF OLD.QuantityFinish IS NOT NULL THEN

	UPDATE TblOrdersBOM_Items
	SET
		FinishTotalQuantity = Coalesce((SELECT Sum(QuantityFinish) FROM TblOrdersBOM_ItemsSteps WHERE QuantityFinish IS NOT NULL AND OrderItemsID = OLD.OrderItemsID), 0),
		FinishLastUpdated   = (SELECT RecordCreated FROM TblOrdersBOM_ItemsSteps WHERE QuantityFinish IS NOT NULL AND OrderItemsID = OLD.OrderItemsID ORDER BY RecordCreated DESC LIMIT 0,1)
	WHERE OrderItemsID = OLD.OrderItemsID;

ELSEIF OLD.QuantityPacked IS NOT NULL THEN

	UPDATE TblOrdersBOM_Items
	SET
		PackedTotalQuantity = Coalesce((SELECT Sum(QuantityPacked) FROM TblOrdersBOM_ItemsSteps WHERE QuantityPacked IS NOT NULL AND OrderItemsID = OLD.OrderItemsID), 0),
		PackedLastUpdated   = (SELECT RecordCreated FROM TblOrdersBOM_ItemsSteps WHERE QuantityPacked IS NOT NULL AND OrderItemsID = OLD.OrderItemsID ORDER BY RecordCreated DESC LIMIT 0,1)
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
DELIMITER $$


DROP TRIGGER IF EXISTS `trgTblOrdersBOM_ItemsSteps_after_insert`
$$
CREATE TRIGGER `trgTblOrdersBOM_ItemsSteps_after_insert` AFTER INSERT ON `TblOrdersBOM_ItemsSteps` FOR EACH ROW
BEGIN

DECLARE nonNullQuantities INT DEFAULT 0;


SET nonNullQuantities = nonNullQuantities
							+ (NEW.QuantityPRC IS NOT NULL)
							+ (NEW.QuantityGlue IS NOT NULL)
							+ (NEW.QuantityFinalWood IS NOT NULL)
							+ (NEW.QuantitySanded IS NOT NULL)
							+ (NEW.QuantityPrefinishedWood IS NOT NULL)

							+ (NEW.QuantityInProcess IS NOT NULL)
							+ (NEW.QuantityProduction IS NOT NULL)
							+ (NEW.QuantityFinish IS NOT NULL)
							+ (NEW.QuantityPacked IS NOT NULL)

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

ELSEIF NEW.QuantityFinalWood IS NOT NULL THEN

	UPDATE TblOrdersBOM_Items
	SET
		FinalWoodTotalQuantity = FinalWoodTotalQuantity + NEW.QuantityFinalWood,
		FinalWoodLastUpdated   = NEW.RecordCreated
	WHERE OrderItemsID = NEW.OrderItemsID;

ELSEIF NEW.QuantitySanded IS NOT NULL THEN

	UPDATE TblOrdersBOM_Items
	SET
		SandedTotalQuantity = SandedTotalQuantity + NEW.QuantitySanded,
		SandedLastUpdated   = NEW.RecordCreated
	WHERE OrderItemsID = NEW.OrderItemsID;

ELSEIF NEW.QuantityPrefinishedWood IS NOT NULL THEN

	UPDATE TblOrdersBOM_Items
	SET
		PrefinishedWoodTotalQuantity = PrefinishedWoodTotalQuantity + NEW.QuantityPrefinishedWood,
		PrefinishedWoodLastUpdated   = NEW.RecordCreated
	WHERE OrderItemsID = NEW.OrderItemsID;




ELSEIF NEW.QuantityInProcess IS NOT NULL THEN

	UPDATE TblOrdersBOM_Items
	SET
		InProcessTotalQuantity = InProcessTotalQuantity + NEW.QuantityInProcess,
		InProcessLastUpdated   = NEW.RecordCreated
	WHERE OrderItemsID = NEW.OrderItemsID;

ELSEIF NEW.QuantityProduction IS NOT NULL THEN

	UPDATE TblOrdersBOM_Items
	SET
		ProductionTotalQuantity = ProductionTotalQuantity + NEW.QuantityProduction,
		ProductionLastUpdated   = NEW.RecordCreated
	WHERE OrderItemsID = NEW.OrderItemsID;

ELSEIF NEW.QuantityFinish IS NOT NULL THEN

	UPDATE TblOrdersBOM_Items
	SET
		FinishTotalQuantity = FinishTotalQuantity + NEW.QuantityFinish,
		FinishLastUpdated   = NEW.RecordCreated
	WHERE OrderItemsID = NEW.OrderItemsID;

ELSEIF NEW.QuantityPacked IS NOT NULL THEN

	UPDATE TblOrdersBOM_Items
	SET
		PackedTotalQuantity = PackedTotalQuantity + NEW.QuantityPacked,
		PackedLastUpdated   = NEW.RecordCreated
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
DELIMITER $$


DROP TRIGGER IF EXISTS `trgTblOrdersBOM_ItemsSteps_before_update`
$$
CREATE TRIGGER `trgTblOrdersBOM_ItemsSteps_before_update` AFTER UPDATE ON `TblOrdersBOM_ItemsSteps` FOR EACH ROW
BEGIN


SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Entries cannot be updated, only inserted or deleted.';


END
$$


DELIMITER ;