ALTER TABLE `Products`
	DROP COLUMN `AutoSuggestProductID`,
	DROP INDEX `FK_Products_Products`,
	DROP FOREIGN KEY `FK_Products_Products`;

CREATE TABLE `ProductsAutoSuggest` (
	`ProductID` INT(11) NOT NULL,
	`ProductSuggestionID` INT(11) NOT NULL,
	PRIMARY KEY (`ProductID`, `ProductSuggestionID`),
	INDEX `ProductsAutoSuggest_ProductSuggestionID` (`ProductSuggestionID`),
	FOREIGN KEY (`ProductID`) REFERENCES `Products` (`ProductID`),
	FOREIGN KEY (`ProductSuggestionID`) REFERENCES `Products` (`ProductID`)
)
 ENGINE=InnoDB COMMENT='When a product is added to an order auto-suggest products to be added also.';
