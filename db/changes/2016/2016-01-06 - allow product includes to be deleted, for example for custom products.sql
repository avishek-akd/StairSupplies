ALTER TABLE `ProductsInclude`
	DROP FOREIGN KEY `FK__Products`;
ALTER TABLE `ProductsInclude`
	ADD CONSTRAINT `FK__Products` FOREIGN KEY (`ParentProductID`) REFERENCES `Products` (`ProductID`) ON DELETE CASCADE;
