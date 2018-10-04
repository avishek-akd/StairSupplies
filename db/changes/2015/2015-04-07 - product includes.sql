CREATE TABLE `ProductsInclude` (
	`ParentProductID` INT(11) NOT NULL,
	`IncludedProductID` INT(11) NOT NULL,
	PRIMARY KEY (`ParentProductID`, `IncludedProductID`),
	INDEX `FK__Products_2` (`IncludedProductID`),
	CONSTRAINT `FK__Products` FOREIGN KEY (`ParentProductID`) REFERENCES `Products` (`ProductID`),
	CONSTRAINT `FK__Products_2` FOREIGN KEY (`IncludedProductID`) REFERENCES `Products` (`ProductID`)
)
COMMENT='Products can include other products, kind of like products bundles.'
COLLATE='utf8_unicode_ci'
ENGINE=InnoDB
;
