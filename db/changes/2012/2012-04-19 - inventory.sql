ALTER TABLE `Products`
	ADD COLUMN `ShowOnInventory` TINYINT(1) UNSIGNED NULL DEFAULT '0' COMMENT '=1 if this product is displayed on the Sales -> Inventory page' AFTER `WebsiteID`,
	ADD COLUMN `QuantityInStock` INT UNSIGNED NULL DEFAULT NULL COMMENT 'The curent stock quantity' AFTER `ShowOnInventory`,
	ADD COLUMN `InventoryNote` VARCHAR(255) NULL DEFAULT NULL COMMENT 'Note visible and editable only from the inventory page' AFTER `QuantityInStock`;

	
ALTER TABLE `Products`
	CHANGE COLUMN `QuantityInStock` `QuantityInStock` INT(10) NULL DEFAULT NULL COMMENT 'The curent stock quantity. It can also be a negative number when a big shipment ships and the inventory is not updated.' AFTER `ShowOnInventory`;
