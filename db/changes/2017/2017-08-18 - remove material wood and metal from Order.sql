ALTER TABLE TblOrdersBOM
	CHANGE COLUMN `MaterialWoodID` `_unused_MaterialWoodID` INT NULL DEFAULT NULL,
	CHANGE COLUMN `MaterialMetalID` `_unused_MaterialMetalID` INT NULL DEFAULT NULL
;