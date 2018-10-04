ALTER TABLE `Products`
	ADD COLUMN `DefaultFinishOptionID` INT(10) UNSIGNED NULL COMMENT 'The default finish option that will be selected when this product is added to an order' AFTER `UnitWeight`;
ALTER TABLE `Products`
	ADD CONSTRAINT `FK_Products_FinishOption` FOREIGN KEY (`DefaultFinishOptionID`) REFERENCES `FinishOption` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION;
