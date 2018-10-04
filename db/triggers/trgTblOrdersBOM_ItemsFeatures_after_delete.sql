DELIMITER $$


DROP TRIGGER IF EXISTS `trgTblOrdersBOM_ItemsFeatures_after_delete`
$$
CREATE TRIGGER `trgTblOrdersBOM_ItemsFeatures_after_delete` AFTER DELETE ON `TblOrdersBOM_ItemsFeature` FOR EACH ROW BEGIN
	CALL spUpdateOrderItemFeaturesAndCustomizations(OLD.OrderItemsID);
END
$$


DELIMITER ;