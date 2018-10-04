ALTER TABLE `Products`
	ADD COLUMN `AutoSuggestProductID` INT NULL DEFAULT NULL COMMENT 'ID of product to auto-suggest after this product is added to an order' AFTER `PurchasePriceOfIncludedProducts`,
	ADD CONSTRAINT `FK_Products_Products` FOREIGN KEY (`AutoSuggestProductID`) REFERENCES `Products` (`ProductID`);
