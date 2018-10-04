CREATE TABLE `ProductsAutoSuggestGroup` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`Name` VARCHAR(100) NOT NULL,
	`RecordCreated` DATETIME NOT NULL,
	`RecordUpdated` DATETIME NULL,
	PRIMARY KEY (`id`)
)
ENGINE=InnoDB
;


CREATE TABLE `ProductsAutoSuggestGroupProduct` (
	`GroupID` INT NOT NULL,
	`ProductID` INT NOT NULL,
	PRIMARY KEY (`GroupID`, `ProductID`),
	CONSTRAINT `FK_ProductsAutoSuggestGroupProduct_ProductsAutoSuggestGroup` FOREIGN KEY (`GroupID`) REFERENCES `ProductsAutoSuggestGroup` (`id`),
	CONSTRAINT `FK_ProductsAutoSuggestGroupProduct_Products` FOREIGN KEY (`ProductID`) REFERENCES `Products` (`ProductID`)
)
ENGINE=InnoDB
;


INSERT INTO ProductsAutoSuggestGroup (Name, RecordCreated) VALUES ('Handrail Mounting Screws', Now());
INSERT INTO ProductsAutoSuggestGroupProduct (GroupID, ProductID) VALUES
(LAST_INSERT_ID(), (SELECT ProductID FROM Products where ProductName = 'Steel Handrail Mounting Screw - Black - 6pk')),
(LAST_INSERT_ID(), (SELECT ProductID FROM Products where ProductName = 'Steel Handrail Mounting Screw - Stainless Steel - 6pk')),
(LAST_INSERT_ID(), (SELECT ProductID FROM Products where ProductName = 'Wood Handrail Mounting Screw - Black - 6pk')),
(LAST_INSERT_ID(), (SELECT ProductID FROM Products where ProductName = 'Wood Handrail Mounting Screw - Stainless Steel - 6pk'));

INSERT INTO ProductsAutoSuggestGroup (Name, RecordCreated) VALUES ('Surface Mount Post Screws', Now());
INSERT INTO ProductsAutoSuggestGroupProduct (GroupID, ProductID) VALUES
(LAST_INSERT_ID(), (SELECT ProductID FROM Products where ProductName = 'Post Mounting Screw 4" - Stainless Steel - 4pk')),
(LAST_INSERT_ID(), (SELECT ProductID FROM Products where ProductName = 'Post Mounting Screw 4" - Steel - 4pk')),
(LAST_INSERT_ID(), (SELECT ProductID FROM Products where ProductName = 'Stainless Steel Carriage Bolt - 2 1/2" - 4pk')),
(LAST_INSERT_ID(), (SELECT ProductID FROM Products where ProductName = 'Stainless Steel Carriage Bolt - 3" - 4pk')),
(LAST_INSERT_ID(), (SELECT ProductID FROM Products where ProductName = 'Stainless Steel Carriage Bolt - 4" - 4pk'));

INSERT INTO ProductsAutoSuggestGroup (Name, RecordCreated) VALUES ('Side Mount Post Screws', Now());
INSERT INTO ProductsAutoSuggestGroupProduct (GroupID, ProductID) VALUES
(LAST_INSERT_ID(), (SELECT ProductID FROM Products where ProductName = 'Post Mounting Screw 6" - Stainless Steel - 4pk')),
(LAST_INSERT_ID(), (SELECT ProductID FROM Products where ProductName = 'Stainless Steel Carriage Bolt - 2 1/2" - 4pk')),
(LAST_INSERT_ID(), (SELECT ProductID FROM Products where ProductName = 'Stainless Steel Carriage Bolt - 3" - 4pk')),
(LAST_INSERT_ID(), (SELECT ProductID FROM Products where ProductName = 'Stainless Steel Carriage Bolt - 4" - 4pk'));

INSERT INTO ProductsAutoSuggestGroup (Name, RecordCreated) VALUES ('Angle Foot Post Screws', Now());
INSERT INTO ProductsAutoSuggestGroupProduct (GroupID, ProductID) VALUES
(LAST_INSERT_ID(), (SELECT ProductID FROM Products where ProductName = 'Post Mounting Screw 4" - Stainless Steel - 4pk')),
(LAST_INSERT_ID(), (SELECT ProductID FROM Products where ProductName = 'Post Mounting Screw 4" - Steel - 4pk'));



ALTER TABLE `ProductsAutoSuggest`
	ALTER `ProductSuggestionID` DROP DEFAULT;
ALTER TABLE `ProductsAutoSuggest`
	ADD COLUMN `id` INT(11) NOT NULL AUTO_INCREMENT FIRST,
	CHANGE COLUMN `ProductSuggestionID` `ProductSuggestionID` INT(11) NULL AFTER `ProductID`,
	ADD COLUMN `GroupSuggestionID` INT(11) NULL AFTER `ProductSuggestionID`,
	DROP PRIMARY KEY,
	ADD PRIMARY KEY (`id`),
	ADD UNIQUE INDEX `Index 3` (`ProductID`, `ProductSuggestionID`),
	ADD UNIQUE INDEX `Index 4` (`ProductID`, `GroupSuggestionID`),
	ADD CONSTRAINT `FK_ProductsAutoSuggest_ProductsAutoSuggestGroup` FOREIGN KEY (`GroupSuggestionID`) REFERENCES `ProductsAutoSuggestGroup` (`id`);
