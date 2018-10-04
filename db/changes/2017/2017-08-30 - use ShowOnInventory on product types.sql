ALTER TABLE `Products`
	CHANGE COLUMN `ShowOnInventory` `_unused_ShowOnInventory` TINYINT(1) UNSIGNED NULL DEFAULT '0' COMMENT '=1 if this product is displayed on the Sales -> Inventory page' AFTER `HurcoProgram`;
