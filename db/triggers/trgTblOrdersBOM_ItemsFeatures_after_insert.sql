DELIMITER $$


DROP TRIGGER IF EXISTS `trgTblOrdersBOM_ItemsFeatures_after_insert`
$$
CREATE TRIGGER `trgTblOrdersBOM_ItemsFeatures_after_insert` AFTER INSERT ON `TblOrdersBOM_ItemsFeature` FOR EACH ROW BEGIN
	CALL spUpdateOrderItemFeaturesAndCustomizations(NEW.OrderItemsID);
END
$$


DELIMITER ;