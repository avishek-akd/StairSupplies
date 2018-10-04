DELIMITER $$


/*  fix incorrect usage of local variables (shipmentQuantity should not have @ because it's a local variable) */
DROP PROCEDURE IF EXISTS spShipmentItemUpdateQuantity
$$
CREATE PROCEDURE `spShipmentItemUpdateQuantity`(
        IN `OrderShipmentItemsID` INT,
        IN `quantityToShip` DECIMAL(10,2),
        IN `BoxSkidNumber` VARCHAR(100)
    )
    NOT DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY DEFINER
    COMMENT ''
BEGIN
	DECLARE shipmentQuantity DECIMAL(10,2);
	DECLARE itemShippedQuantity DECIMAL(10,2);
	DECLARE orderItemsID INT;
	DECLARE newItemShippedQuantity DECIMAL(10,2);
	DECLARE itemOrderedQuantity DECIMAL(10,2);


	SELECT TblOrdersBOM_ShipmentsItems.QuantityShipped, TblOrdersBOM_Items.QuantityShipped, TblOrdersBOM_Items.QuantityOrdered, TblOrdersBOM_Items.orderItemsID
		INTO shipmentQuantity, itemShippedQuantity, itemOrderedQuantity, orderItemsID
	FROM TblOrdersBOM_ShipmentsItems
		INNER JOIN TblOrdersBOM_Items ON TblOrdersBOM_Items.OrderItemsID = TblOrdersBOM_ShipmentsItems.OrderItemsID
	WHERE TblOrdersBOM_ShipmentsItems.OrderShipmentItemsID = OrderShipmentItemsID;


	UPDATE TblOrdersBOM_ShipmentsItems
	SET
		TblOrdersBOM_ShipmentsItems.QuantityShipped = quantityToShip,
		TblOrdersBOM_ShipmentsItems.BoxSkidNumber   = BoxSkidNumber,
		DateUpdated                                 = Now()
	WHERE TblOrdersBOM_ShipmentsItems.OrderShipmentItemsID = OrderShipmentItemsID;
	
	
	SET newItemShippedQuantity = itemShippedQuantity - shipmentQuantity + quantityToShip;
	UPDATE TblOrdersBOM_Items
	SET
		Shipped         = IF(itemOrderedQuantity <= newItemShippedQuantity, 1, 0),
		QuantityShipped = newItemShippedQuantity
	WHERE TblOrdersBOM_Items.OrderItemsID = orderItemsID;
END
$$


DELIMITER ;