ALTER TABLE TblOrdersBOM
	ADD COLUMN `ProductsFilterMaterialD` INT(11) NULL DEFAULT NULL AFTER `hiddenInProductionReport`,
	ADD COLUMN `ProductsFilterPostSystemTypeID` INT UNSIGNED NULL DEFAULT NULL AFTER `ProductsFilterMaterialD`,
	ADD COLUMN `ProductsFilterPostMountingStyleID` INT UNSIGNED NULL DEFAULT NULL AFTER `ProductsFilterPostSystemTypeID`,
	ADD COLUMN `ProductsFilterPostTopStyleID` INT UNSIGNED NULL DEFAULT NULL AFTER `ProductsFilterPostMountingStyleID`,

	ADD CONSTRAINT `FK_TblOrdersBOM_TblMaterial_filter` FOREIGN KEY (`ProductsFilterMaterialD`) REFERENCES `TblMaterial` (`id`)
			ON UPDATE NO ACTION ON DELETE NO ACTION,
	ADD CONSTRAINT `FK_TblOrdersBOM_TblPostSystemType` FOREIGN KEY (`ProductsFilterPostSystemTypeID`) REFERENCES `TblPostSystemType` (`PostSystemTypeID`)
			ON UPDATE NO ACTION ON DELETE NO ACTION,
	ADD CONSTRAINT `FK_TblOrdersBOM_TblPostMountingStyle` FOREIGN KEY (`ProductsFilterPostMountingStyleID`) REFERENCES `TblPostMountingStyle` (`PostMountingStyleID`)
			ON UPDATE NO ACTION ON DELETE NO ACTION,
	ADD CONSTRAINT `FK_TblOrdersBOM_TblPostTopStyle2` FOREIGN KEY (`ProductsFilterPostTopStyleID`) REFERENCES `TblPostTopStyle2` (`PostTopStyleID`)
			ON UPDATE NO ACTION ON DELETE NO ACTION
;