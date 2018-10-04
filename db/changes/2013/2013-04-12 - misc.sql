ALTER TABLE `TblProductType`
	ALTER `type_id` DROP DEFAULT;
ALTER TABLE `TblProductType`
	CHANGE COLUMN `type_id` `type_id` INT(10) UNSIGNED NOT NULL AFTER `ProductType`;


ALTER TABLE `TblOrdersBOM_Items`
	ADD INDEX `Index 18` (`OrderID`, `ProductID`);


RENAME TABLE `shippingMethodsActive` TO `vShippingMethodsActive`;