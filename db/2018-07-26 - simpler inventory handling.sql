DROP TABLE `TblProductsInventoryOut`
;

DELETE
FROM TblProductsInventoryIn
WHERE 1 = 1
;


ALTER TABLE `TblProductsInventoryIn`
	CHANGE COLUMN `QuantityIn` `QuantityInitialIn` DECIMAL(10,2) UNSIGNED NOT NULL DEFAULT 0 AFTER `AddedByID`,
	ADD COLUMN `QuantityAvailable` DECIMAL(10,2) UNSIGNED NOT NULL DEFAULT 0 AFTER `QuantityInitialIn`
;