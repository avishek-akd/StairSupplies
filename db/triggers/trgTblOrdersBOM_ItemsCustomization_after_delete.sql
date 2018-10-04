DELIMITER $$


DROP TRIGGER IF EXISTS `trgTblOrdersBOM_ItemsCustomization_after_delete`
$$
CREATE TRIGGER `trgTblOrdersBOM_ItemsCustomization_after_delete` AFTER DELETE ON `TblOrdersBOM_ItemsCustomization` FOR EACH ROW BEGIN
	CALL spUpdateOrderItemFeaturesAndCustomizations(OLD.OrderItemsID);
END
$$


DELIMITER ;