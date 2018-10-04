
ALTER TABLE Products
	CHANGE COLUMN `ProductionComplexityPoints` `_unused_ProductionComplexityPoints` TINYINT(3) UNSIGNED NULL DEFAULT 0;
ALTER TABLE TblMaterial
	CHANGE COLUMN `d_cable_rail_css_style` `_unused_d_cable_rail_css_style` VARCHAR(100) NULL DEFAULT NULL;
ALTER TABLE TblFinishOption
	CHANGE COLUMN `CableRailCssStyle` `_unused_CableRailCssStyle` VARCHAR(100) NULL DEFAULT NULL,
	CHANGE COLUMN `ProductionTimeInDays` `_unused_ProductionTimeInDays` TINYINT(3) UNSIGNED NULL DEFAULT NULL;
ALTER TABLE TblOrdersBOM_Items
	CHANGE COLUMN `CableRailProgress` `_unused_CableRailProgress` VARCHAR(50) NULL DEFAULT NULL;
ALTER TABLE TblOrdersBOM
	CHANGE COLUMN `CableRailProductionDayID` `_unused_CableRailProductionDayID` INT UNSIGNED NULL DEFAULT NULL;


RENAME TABLE TblCableRailProductionDay TO _unused_TblCableRailProductionDay;
