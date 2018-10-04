ALTER TABLE `TblOrdersBOM`
	CHANGE COLUMN `ProductsFilterMaterialD` `ProductsFilterWoodMaterialD` INT(11) NULL DEFAULT NULL AFTER `hiddenInProductionReport`,
	ADD COLUMN `ProductsFilterMetalMaterialD` INT(11) NULL DEFAULT NULL AFTER `ProductsFilterWoodMaterialD`
;


ALTER TABLE `TblOrdersBOM`
	ADD CONSTRAINT `FK_TblOrdersBOM_TblMaterial_filter_metal` FOREIGN KEY (`ProductsFilterMetalMaterialD`) REFERENCES `TblMaterial` (`id`)
			ON UPDATE NO ACTION ON DELETE NO ACTION
;


ALTER TABLE `TblOrdersBOM`
	DROP FOREIGN KEY `FK_TblOrdersBOM_TblMaterial_filter`;
ALTER TABLE `TblOrdersBOM`
	ADD CONSTRAINT `FK_TblOrdersBOM_TblMaterial_filter_wood` FOREIGN KEY (`ProductsFilterWoodMaterialD`) REFERENCES `TblMaterial` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION
;
