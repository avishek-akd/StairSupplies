DELIMITER $$



DROP PROCEDURE IF EXISTS `spUpdateOrderItemFeaturesAndCustomizations`
$$
/*
	Stored procedure used in when a feature or customization is added/removed from an order item.
	The SP is called from triggers on TblOrdersBOM_ItemsFeature and TblOrdersBOM_ItemsCustomization.
*/
CREATE PROCEDURE `spUpdateOrderItemFeaturesAndCustomizations`(
	IN `vOrderItemID` INTEGER(11)
	)
	DETERMINISTIC
	READS SQL DATA
	SQL SECURITY INVOKER
	COMMENT ''
BEGIN
	UPDATE TblOrdersBOM_Items
	SET
		OrderItemNameSuffix        = Coalesce((SELECT Group_concat(NameSuffix SEPARATOR ' - ')
												FROM (SELECT NameSuffix FROM TblOrdersBOM_ItemsFeature WHERE OrderItemsID = vOrderItemID
														UNION
														SELECT NameSuffix FROM TblOrdersBOM_ItemsCustomization WHERE OrderItemsID = vOrderItemID) AS dummy), ''),
		OrderItemDescriptionPrefix = Coalesce((SELECT Group_concat(DescriptionPrefix SEPARATOR ' - ')
												FROM (SELECT DescriptionPrefix FROM TblOrdersBOM_ItemsFeature WHERE OrderItemsID = vOrderItemID
													UNION
													SELECT DescriptionPrefix FROM TblOrdersBOM_ItemsCustomization WHERE OrderItemsID = vOrderItemID) AS dummy), ''),
		costOfFeaturesAndCustomizations         = Coalesce((SELECT Sum(AdditionalLaborCost) FROM TblOrdersBOM_ItemsFeature WHERE OrderItemsID = vOrderItemID), 0)
													+ Coalesce((SELECT Sum(AdditionalLaborCost) FROM TblOrdersBOM_ItemsCustomization WHERE OrderItemsID = vOrderItemID), 0)
	WHERE OrderItemsID = vOrderItemID;
END
$$


DELIMITER ;
