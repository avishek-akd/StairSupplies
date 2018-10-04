ALTER TABLE `TblOrdersBOM_ItemsHistory`
	ALTER `fieldName` DROP DEFAULT,
	ALTER `value` DROP DEFAULT,
	ALTER `EmployeeID` DROP DEFAULT
;
ALTER TABLE `TblOrdersBOM_ItemsHistory`
	CHANGE COLUMN `EmployeeID` `EmployeeID` INT(11) NOT NULL AFTER `OrderItemsID`,
	ADD COLUMN `QuantityInProcess` INT(11) NULL AFTER `EmployeeID`,
	ADD COLUMN `QuantityPulled` INT(11) NULL AFTER `QuantityInProcess`,
	CHANGE COLUMN `fieldName` `_unused_fieldName` VARCHAR(50) NOT NULL COMMENT 'Ex: \'QuantityInProcess\', \'QuantityPulled\'' COLLATE 'utf8_unicode_ci' AFTER `QuantityPulled`,
	CHANGE COLUMN `value` `_unused_value` INT(11) NOT NULL COMMENT 'Value that the field is changed by. This is NOT the new value, it\'s a change applied to the initial value' AFTER `_unused_fieldName`
;
ALTER TABLE `TblOrdersBOM_ItemsHistory`
	CHANGE COLUMN `_unused_fieldName` `_unused_fieldName` VARCHAR(50) NOT NULL DEFAULT 'not_used_anymore' COMMENT 'Ex: \'QuantityInProcess\', \'QuantityPulled\'' COLLATE 'utf8_unicode_ci' AFTER `QuantityPulled`,
	CHANGE COLUMN `_unused_value` `_unused_value` INT(11) NOT NULL DEFAULT '0' COMMENT 'Value that the field is changed by. This is NOT the new value, it\'s a change applied to the initial value' AFTER `_unused_fieldName`;



UPDATE TblOrdersBOM_Items
SET QuantityInProcess = 0
WHERE QuantityInProcess IS NULL
;
ALTER TABLE `TblOrdersBOM_Items`
	CHANGE COLUMN `QuantityInProcess` `QuantityInProcess` INT(11) NOT NULL DEFAULT '0' AFTER `UnitWeight`
;



UPDATE TblOrdersBOM_ItemsHistory
SET
	QuantityInProcess = _unused_value,
	QuantityPulled    = NULL
WHERE _unused_fieldName = 'QuantityInProcess'
;
UPDATE TblOrdersBOM_ItemsHistory
SET
	QuantityInProcess = NULL,
	QuantityPulled    = _unused_value
WHERE _unused_fieldName = 'QuantityPulled'
;