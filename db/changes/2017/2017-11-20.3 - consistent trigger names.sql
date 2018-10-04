DELIMITER $$



DROP TRIGGER IF EXISTS `TblAllowedIPsIP_before_ins_tr1`
$$
CREATE TRIGGER `trgTblAllowedIPsIP_before_insert` BEFORE INSERT ON `TblAllowedIPsIP` FOR EACH ROW BEGIN
IF NEW.IPAddress <> '*' THEN
	IF INET_ATON(NEW.IPAddress) IS NULL THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid IP address.';
    END IF;
END IF;
END
$$



DROP TRIGGER IF EXISTS `TblAllowedIPsIP_before_upd_tr1`
$$
CREATE TRIGGER `trgTblAllowedIPsIP_before_update` BEFORE UPDATE ON `TblAllowedIPsIP` FOR EACH ROW BEGIN
IF NEW.IPAddress <> '*' THEN
	IF INET_ATON(NEW.IPAddress) IS NULL THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid IP address.';
    END IF;
END IF;
END
$$



DROP TRIGGER IF EXISTS `TblAudit_before_ins_tr1`
$$
CREATE TRIGGER `trgTblAudit_before_insert` BEFORE INSERT ON `TblAudit` FOR EACH ROW BEGIN

DECLARE nonNullKeys INT DEFAULT 0;

SET nonNullKeys = nonNullKeys + (NEW.orderID IS NOT NULL);
SET nonNullKeys = nonNullKeys + (NEW.CustomerID IS NOT NULL);

IF nonNullKeys <> 1 THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Exactly one of the foregin keys must be NON NULL.';
END IF;

END
$$



DROP TRIGGER IF EXISTS `TblAudit_before_upd_tr1`
$$
CREATE TRIGGER `trgTblAudit_before_update` BEFORE UPDATE ON `TblAudit` FOR EACH ROW BEGIN

DECLARE nonNullKeys INT DEFAULT 0;

SET nonNullKeys = nonNullKeys + (NEW.orderID IS NOT NULL);
SET nonNullKeys = nonNullKeys + (NEW.CustomerID IS NOT NULL);

IF nonNullKeys <> 1 THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Exactly one of the foregin keys must be NON NULL.';
END IF;

END
$$



DROP TRIGGER IF EXISTS `TblCustomerContact_before_ins_tr1`
$$
CREATE TRIGGER `trgTblCustomerContact_before_insert` BEFORE INSERT ON `TblCustomerContact` FOR EACH ROW BEGIN
DECLARE stateCountry INT;


IF NEW.ContactState IS NOT NULL THEN
		select CountryID
		INTO @stateCountry
		from TblState
		where state = NEW.ContactState;

		IF @stateCountry <> NEW.ContactCountryID THEN
			SET @message_text = Concat('State and country must match. State=', NEW.ContactState, '; CountryID=', NEW.ContactCountryID);
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @message_text;
		END IF;
END IF;

IF NEW.ContactState IS NOT NULL AND NEW.ContactStateOther IS NOT NULL
THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Only one of ContactState or ContactStateOther must be given.';
END IF;

IF NEW.AddressType NOT BETWEEN 0 AND 2
THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'AddressType must be between 0 and 2';
END IF;


END
$$



DROP TRIGGER IF EXISTS `TblFile_before_ins_tr1`
$$
CREATE TRIGGER `trgTblFile_before_insert` BEFORE INSERT ON `TblFile` FOR EACH ROW BEGIN

DECLARE nonNullKeys INT DEFAULT 0;

SET nonNullKeys = nonNullKeys + (NEW.orderID IS NOT NULL);
SET nonNullKeys = nonNullKeys + (NEW.productID IS NOT NULL);
SET nonNullKeys = nonNullKeys + (NEW.orderItemsID IS NOT NULL);
SET nonNullKeys = nonNullKeys + (NEW.orderShipmentID IS NOT NULL);
SET nonNullKeys = nonNullKeys + (NEW.inHouseOrderShipmentID IS NOT NULL);
SET nonNullKeys = nonNullKeys + (NEW.customerID IS NOT NULL);
SET nonNullKeys = nonNullKeys + (NEW.rgaRequestStatusID IS NOT NULL);
SET nonNullKeys = nonNullKeys + (NEW.orderCustomerVisibleID IS NOT NULL);

IF nonNullKeys <> 1 THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Exactly one of the foregin keys must be NON NULL.';
END IF;

END
$$



DROP TRIGGER IF EXISTS `TblFile_before_upd_tr1`
$$
CREATE TRIGGER `trgTblFile_before_update` BEFORE UPDATE ON `TblFile` FOR EACH ROW BEGIN

DECLARE nonNullKeys INT DEFAULT 0;

SET nonNullKeys = nonNullKeys + (NEW.orderID IS NOT NULL);
SET nonNullKeys = nonNullKeys + (NEW.productID IS NOT NULL);
SET nonNullKeys = nonNullKeys + (NEW.orderItemsID IS NOT NULL);
SET nonNullKeys = nonNullKeys + (NEW.orderShipmentID IS NOT NULL);
SET nonNullKeys = nonNullKeys + (NEW.inHouseOrderShipmentID IS NOT NULL);
SET nonNullKeys = nonNullKeys + (NEW.customerID IS NOT NULL);
SET nonNullKeys = nonNullKeys + (NEW.rgaRequestStatusID IS NOT NULL);
SET nonNullKeys = nonNullKeys + (NEW.orderCustomerVisibleID IS NOT NULL);

IF nonNullKeys <> 1 THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Exactly one of the foregin keys must be NON NULL.';
END IF;

END
$$



DROP TRIGGER IF EXISTS `TblOrdersBOM_before_ins_tr1`
$$
CREATE TRIGGER `trgTblOrdersBOM_before_insert` BEFORE INSERT ON `TblOrdersBOM` FOR EACH ROW BEGIN
DECLARE stateCountry INT;

IF NEW.BillState IS NOT NULL THEN
		select CountryID
		INTO @stateCountry
		from TblState
		where state = NEW.BillState;

		IF @stateCountry <> NEW.BillCountryID THEN
			SET @message_text = Concat('Billing state and country must match. State=', NEW.BillState, '; CountryID=', NEW.BillCountryID);
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @message_text;
		END IF;
END IF;
IF NEW.BillState IS NOT NULL AND NEW.BillStateOther IS NOT NULL
THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Only one of BillState or BillStateOther must be given.';
END IF;

IF NEW.ShipState IS NOT NULL THEN
		select CountryID
		INTO @stateCountry
		from TblState
		where state = NEW.ShipState;

		IF @stateCountry <> NEW.ShipCountryID THEN
			SET @message_text = Concat('Shippingstate and country must match. State=', NEW.ShipState, '; CountryID=', NEW.ShipCountryID);
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @message_text;
		END IF;
END IF;
IF NEW.ShipState IS NOT NULL AND NEW.ShipStateOther IS NOT NULL
THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Only one of ShipState or ShipStateOther must be given.';
END IF;

END
$$





DROP TRIGGER IF EXISTS `TblOrdersBOM_before_upd_tr1`
$$
CREATE TRIGGER `trgTblOrdersBOM_before_update` BEFORE UPDATE ON `TblOrdersBOM` FOR EACH ROW BEGIN
DECLARE stateCountry INT;

IF NEW.BillState IS NOT NULL THEN
		select CountryID
		INTO @stateCountry
		from TblState
		where state = NEW.BillState;

		IF @stateCountry <> NEW.BillCountryID THEN
			SET @message_text = Concat('Billing state and country must match. State=', NEW.BillState, '; CountryID=', NEW.BillCountryID);
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @message_text;
		END IF;
END IF;
IF NEW.BillState IS NOT NULL AND NEW.BillStateOther IS NOT NULL
THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Only one of BillState or BillStateOther must be given.';
END IF;

IF NEW.ShipState IS NOT NULL THEN
		select CountryID
		INTO @stateCountry
		from TblState
		where state = NEW.ShipState;

		IF @stateCountry <> NEW.ShipCountryID THEN
			SET @message_text = Concat('Shippingstate and country must match. State=', NEW.ShipState, '; CountryID=', NEW.ShipCountryID);
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @message_text;
		END IF;
END IF;
IF NEW.ShipState IS NOT NULL AND NEW.ShipStateOther IS NOT NULL
THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Only one of ShipState or ShipStateOther must be given.';
END IF;

END
$$



DROP TRIGGER IF EXISTS `TblOrdersBOM_Items_before_ins_tr`
$$
CREATE TRIGGER `trgTblOrdersBOM_Items_before_insert` BEFORE INSERT ON `TblOrdersBOM_Items` FOR EACH ROW BEGIN

IF NEW.DiscountPercent < 0 THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Discount percent must be greater than 0.';
END IF;

IF NEW.DiscountPercent > 1 THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Discount percent must be lower than 1.';
END IF;

IF NEW.ExceptionFaultId IS NOT NULL AND NEW.ExceptionFaultEmployeeId IS NOT NULL THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Only one of ExceptionFaultID or ExceptionFaultEmployeeId must be NON NULL.';
END IF;

END
$$



DROP TRIGGER IF EXISTS `TblOrdersBOM_Items_before_upd_tr`
$$
CREATE TRIGGER `trgTblOrdersBOM_Items_before_update` BEFORE UPDATE ON `TblOrdersBOM_Items` FOR EACH ROW BEGIN

IF NEW.DiscountPercent < 0 THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Discount percent must be greater than 0.';
END IF;

IF NEW.DiscountPercent > 1 THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Discount percent must be lower than 1.';
END IF;

IF NEW.ExceptionFaultId IS NOT NULL AND NEW.ExceptionFaultEmployeeId IS NOT NULL THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Only one of ExceptionFaultID or ExceptionFaultEmployeeId must be NON NULL.';
END IF;

END
$$



DROP TRIGGER IF EXISTS `TblOrdersBOM_ItemsInclude_after_del_tr1`
$$
CREATE TRIGGER `trgTblOrdersBOM_ItemsInclude_after_delete` AFTER DELETE ON `TblOrdersBOM_ItemsInclude` FOR EACH ROW BEGIN
	DECLARE newPurchasePrice DECIMAL(19,2) DEFAULT (SELECT Purchase_Price FROM TblProducts WHERE ProductID = OLD.BundledProductID);
	DECLARE remainingIncludedProducts INT  DEFAULT (SELECT Count(*) FROM TblOrdersBOM_ItemsInclude WHERE OrderItemsID = OLD.OrderItemsID);


	IF remainingIncludedProducts = 0 THEN
		UPDATE TblOrdersBOM_Items
		SET	costPurchaseIncludedProducts = NULL,
			costPurchase                 = IF(costPurchase IS NULL, 0, costPurchase)
		WHERE OrderItemsID = OLD.OrderItemsID;
	ELSE
		UPDATE TblOrdersBOM_Items
		SET	costPurchaseIncludedProducts = costPurchaseIncludedProducts
												- (newPurchasePrice * OLD.BundledQuantity)
		WHERE OrderItemsID = OLD.OrderItemsID;
	END IF;
END
$$




DROP TRIGGER IF EXISTS `TblOrdersBOM_ItemsInclude_after_ins_tr1`
$$
CREATE TRIGGER `trgTblOrdersBOM_ItemsInclude_after_insert` AFTER INSERT ON `TblOrdersBOM_ItemsInclude` FOR EACH ROW BEGIN
	DECLARE newPurchasePrice DECIMAL(19,2) DEFAULT (SELECT Purchase_Price FROM TblProducts WHERE ProductID = NEW.BundledProductID);


	UPDATE TblOrdersBOM_Items
	SET	costPurchaseIncludedProducts = Coalesce(costPurchaseIncludedProducts, 0)
	                                        + (newPurchasePrice * NEW.BundledQuantity)
	WHERE OrderItemsID = NEW.OrderItemsID;
END
$$





DROP TRIGGER IF EXISTS `TblOrdersBOM_ItemsInclude_after_upd_tr1`
$$
CREATE TRIGGER `trgTblOrdersBOM_ItemsInclude_after_update` AFTER UPDATE ON `TblOrdersBOM_ItemsInclude` FOR EACH ROW BEGIN
	DECLARE newPurchasePrice DECIMAL(19,2) DEFAULT (SELECT Purchase_Price FROM TblProducts WHERE ProductID = NEW.BundledProductID);


	UPDATE TblOrdersBOM_Items
	SET	costPurchaseIncludedProducts = costPurchaseIncludedProducts
											- (newPurchasePrice * OLD.BundledQuantity)
	                                        + (newPurchasePrice * NEW.BundledQuantity)
	WHERE OrderItemsID = NEW.OrderItemsID;
END
$$



DROP TRIGGER IF EXISTS `TblProductsAutoSuggest_before_ins_tr1`
$$
CREATE TRIGGER `trgTblProductsAutoSuggest_before_insert` BEFORE INSERT ON `TblProductsAutoSuggest` FOR EACH ROW BEGIN

IF ((NEW.ProductSuggestionID IS NULL and NEW.GroupSuggestionID IS NULL)
	OR (NEW.ProductSuggestionID IS NOT NULL and NEW.GroupSuggestionID IS NOT NULL)) THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Only one of ProductSuggestionID or GroupSuggestionID must be filled.';
END IF;

IF NEW.GroupSuggestionID IS NOT NULL AND NEW.Mandatory = 1 THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Mandatory cannot be set for groups.';
END IF;

END
$$




DROP TRIGGER IF EXISTS `TblProductsAutoSuggest_before_upd_tr1`
$$
CREATE TRIGGER `trgTblProductsAutoSuggest_before_update` BEFORE UPDATE ON `TblProductsAutoSuggest` FOR EACH ROW BEGIN

IF ((NEW.ProductSuggestionID IS NULL and NEW.GroupSuggestionID IS NULL)
	OR (NEW.ProductSuggestionID IS NOT NULL and NEW.GroupSuggestionID IS NOT NULL)) THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Only one of ProductSuggestionID or GroupSuggestionID must be filled.';
END IF;

IF NEW.GroupSuggestionID IS NOT NULL AND NEW.Mandatory = 1 THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Mandatory cannot be set for groups.';
END IF;

END
$$



DROP TRIGGER IF EXISTS `TblProductsInclude_after_del_tr1`
$$
CREATE TRIGGER `trgTblProductsInclude_after_delete` AFTER DELETE ON `TblProductsInclude` FOR EACH ROW BEGIN
	DECLARE newPurchasePrice DECIMAL(19,2) DEFAULT (SELECT Purchase_Price FROM TblProducts WHERE ProductID = OLD.IncludedProductID);
	DECLARE remainingIncludedProducts INT DEFAULT (SELECT Count(*) FROM TblProductsInclude WHERE ParentProductID = OLD.ParentProductID);


	IF remainingIncludedProducts = 0 THEN
		UPDATE TblProducts
		SET	PurchasePriceOfIncludedProducts = NULL,
			Purchase_Price = IF(Purchase_Price IS NULL, 0, Purchase_Price)
		WHERE ProductID = OLD.ParentProductID;
	ELSE
		UPDATE TblProducts
		SET	PurchasePriceOfIncludedProducts = PurchasePriceOfIncludedProducts
												- (newPurchasePrice * OLD.Quantity)
		WHERE ProductID = OLD.ParentProductID;
	END IF;
END
$$



DROP TRIGGER IF EXISTS `TblProductsInclude_after_ins_tr1`
$$
CREATE TRIGGER `trgTblProductsInclude_after_insert` AFTER INSERT ON `TblProductsInclude` FOR EACH ROW BEGIN
	DECLARE newPurchasePrice DECIMAL(19,2) DEFAULT (SELECT Purchase_Price FROM TblProducts WHERE ProductID = NEW.IncludedProductID);


	UPDATE TblProducts
	SET	PurchasePriceOfIncludedProducts = Coalesce(PurchasePriceOfIncludedProducts, 0)
	                                        + (newPurchasePrice * NEW.Quantity)
	WHERE ProductID = NEW.ParentProductID;

END
$$



DROP TRIGGER IF EXISTS `TblProductsInclude_after_upd_tr1`
$$
CREATE TRIGGER `trgTblProductsInclude_after_update` AFTER UPDATE ON `TblProductsInclude` FOR EACH ROW BEGIN
	DECLARE newPurchasePrice DECIMAL(19,2) DEFAULT (SELECT Purchase_Price FROM TblProducts WHERE ProductID = NEW.IncludedProductID);


	UPDATE TblProducts
	SET	PurchasePriceOfIncludedProducts = PurchasePriceOfIncludedProducts
											- (newPurchasePrice * OLD.Quantity)
	                                        + (newPurchasePrice * NEW.Quantity)
	WHERE ProductID = NEW.ParentProductID;

END
$$




DROP TRIGGER IF EXISTS `TblProductType_before_ins_tr1`
$$
CREATE TRIGGER `trgTblProductType_before_insert` BEFORE INSERT ON `TblProductType` FOR EACH ROW BEGIN

IF Not (NEW.ShowOnAddOrderItem2 IN (1, 2, 3)) THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Valid values for ShowOnAddOrderItem2 are 1, 2 or 3.';
END IF;
IF Not (NEW.ShowInLateOrderReports IN ('wood', 'cable', 'both', 'neither')) THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Valid values for ShowInLateOrderReports are "wood", "cable", "both" or "neither".';
END IF;
IF Not (NEW.warnOnUnsetPRCOrFinal IN (0, 1)) THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Valid values for warnOnUnsetPRCOrFinal are 0 or 1.';
END IF;

END
$$



DROP TRIGGER IF EXISTS `TblProductType_before_upd_tr1`
$$
CREATE TRIGGER `trgTblProductType_before_update` BEFORE UPDATE ON `TblProductType` FOR EACH ROW BEGIN

IF Not (NEW.ShowOnAddOrderItem2 IN (1, 2, 3)) THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Valid values for ShowOnAddOrderItem2 are 1, 2 or 3.';
END IF;
IF Not (NEW.ShowInLateOrderReports IN ('wood', 'cable', 'both', 'neither')) THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Valid values for ShowInLateOrderReports are "wood", "cable", "both" or "neither".';
END IF;
IF Not (NEW.warnOnUnsetPRCOrFinal IN (0, 1)) THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Valid values for warnOnUnsetPRCOrFinal are 0 or 1.';
END IF;

END
$$



DROP TRIGGER IF EXISTS `trg_TblProductsIns`
$$
CREATE TRIGGER `trgTblProducts_before_insert` BEFORE INSERT ON `TblProducts` FOR EACH ROW BEGIN

IF NEW.CutAngle NOT BETWEEN 0 and 90
THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'CutAngle must be between 0 and 90.';
END IF;

END
$$



DROP TRIGGER IF EXISTS `trg_TblProductsUpd`
$$
CREATE TRIGGER `trgTblProducts_before_update` BEFORE UPDATE ON `TblProducts` FOR EACH ROW BEGIN

IF NEW.CutAngle NOT BETWEEN 0 and 90
THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'CutAngle must be between 0 and 90.';
END IF;

END
$$


DELIMITER ;