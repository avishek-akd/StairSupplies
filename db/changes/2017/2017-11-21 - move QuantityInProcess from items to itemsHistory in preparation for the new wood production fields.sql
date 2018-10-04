ALTER TABLE `TblOrdersBOM_Items`
	CHANGE COLUMN `QuantityInProcess` `_unused_QuantityInProcess` INT(11) NOT NULL DEFAULT '0' AFTER `UnitWeight`
;
ALTER TABLE `TblOrdersBOM_ItemsHistory`
	ALTER `EmployeeID` DROP DEFAULT
;
ALTER TABLE `TblOrdersBOM_ItemsHistory`
	CHANGE COLUMN `EmployeeID` `EmployeeID` INT(11) NULL COMMENT 'If this is NULL then it\'s SYSTEM generated' AFTER `OrderItemsID`
;


DELETE
FROM TblOrdersBOM_ItemsHistory
WHERE QuantityInProcess = 0
	OR QuantityPulled = 0
;


INSERT INTO TblOrdersBOM_ItemsHistory
	(OrderItemsID, EmployeeID, QuantityInProcess, RecordCreated)
SELECT OrderItemsID, NULL, _unused_QuantityInProcess, Now()
FROM TblOrdersBOM_Items
WHERE _unused_QuantityInProcess IS NOT NULL
	AND _unused_QuantityInProcess > 0
;