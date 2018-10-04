DELIMITER $$


DROP TRIGGER IF EXISTS `trgTblOrdersBOM_ItemsCustomization_after_insert`
$$
CREATE TRIGGER `trgTblOrdersBOM_ItemsCustomization_after_insert` AFTER INSERT ON `TblOrdersBOM_ItemsCustomization` FOR EACH ROW BEGIN
	CALL spUpdateOrderItemFeaturesAndCustomizations(NEW.OrderItemsID);
END
$$


DELIMITER ;