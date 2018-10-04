ALTER TABLE TblProducts
	CHANGE COLUMN `QuantityInStock` `_unused_QuantityInStock` INT(10) NULL DEFAULT NULL,
	CHANGE COLUMN `InventoryNote` `_unused_InventoryNote` VARCHAR(255) NULL DEFAULT NULL
;


CREATE TABLE `TblProductsInventoryIn` (
	`InventoryInID` INT(10) NOT NULL AUTO_INCREMENT,
	`ProductID` INT(10) NOT NULL,
	`AddedByID` INT(11) NULL DEFAULT NULL COMMENT 'Employee who added this entry. If NULL this entry was taken migrated from TblProducts.QuantityInStock',
	`QuantityIn` DECIMAL(10,2) UNSIGNED NOT NULL,
	`CostPerUnit` DECIMAL(10,4) NOT NULL,
	`RecordCreated` DATETIME NOT NULL,
	`RecordUpdated` DATETIME NULL DEFAULT NULL,
	PRIMARY KEY (`InventoryInID`),
	INDEX `idxFK_ProductID` (`ProductID`),
	INDEX `idxFK_AddedByID` (`AddedByID`),
	CONSTRAINT `FK_TblProductsInventoryIn_ProductID` FOREIGN KEY (`ProductID`) REFERENCES `TblProducts` (`ProductID`) ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT `FK_TblProductsInventoryIn_AddedByID` FOREIGN KEY (`AddedByID`) REFERENCES `TblEmployee` (`EmployeeID`) ON UPDATE NO ACTION ON DELETE NO ACTION
);


CREATE TABLE `TblProductsInventoryOut` (
	`InventoryOutID` INT(10) NOT NULL AUTO_INCREMENT,
	`ProductID` INT(10) NOT NULL,
	`InventoryInID` INT(10) NULL DEFAULT NULL,
	`OrderShipmentItemsID` INT(10) NULL DEFAULT NULL,
	`TakenOutByID` INT(11) NULL DEFAULT NULL COMMENT 'Employee who took out the inventory. If NULL it\'s an automated process',
	`QuantityOut` DECIMAL(10,2) UNSIGNED NOT NULL,
	`RecordCreated` DATETIME NOT NULL,
	`RecordUpdated` DATETIME NULL DEFAULT NULL,
	PRIMARY KEY (`InventoryOutID`),
	INDEX `idxFK_ProductID` (`ProductID`),
	INDEX `idxFK_InventoryInID` (`InventoryInID`),
	INDEX `idxFK_TakenOutByID` (`TakenOutByID`),
	INDEX `idxFK_OrderShipmentItemsID` (`OrderShipmentItemsID`),

	CONSTRAINT `FK_TblProductsInventoryOut_ProductID` FOREIGN KEY (`ProductID`) REFERENCES `TblProducts` (`ProductID`) ON UPDATE NO ACTION ON DELETE NO ACTION,

	CONSTRAINT `FK_TblProductsInventoryOut_InventoryInID` FOREIGN KEY (`InventoryInID`)
			REFERENCES `TblProductsInventoryIn` (`InventoryInID`) ON UPDATE NO ACTION ON DELETE NO ACTION,

	CONSTRAINT `FK_TblProductsInventoryOut_OrderShipmentItemsID` FOREIGN KEY (`OrderShipmentItemsID`)
			REFERENCES `TblOrdersBOM_ShipmentsItems` (`OrderShipmentItemsID`) ON UPDATE NO ACTION ON DELETE CASCADE,

	CONSTRAINT `FK_TblProductsInventoryOut_TakenOutByID` FOREIGN KEY (`TakenOutByID`) REFERENCES `TblEmployee` (`EmployeeID`) ON UPDATE NO ACTION ON DELETE NO ACTION
);


INSERT INTO TblProductsInventoryIn (
	ProductID, AddedByID, QuantityIn, CostPerUnit, RecordCreated
)
SELECT ProductID, NULL, _unused_QuantityInStock, Purchase_Price, Now()
FROM TblProducts
WHERE _unused_QuantityInStock IS NOT NULL
	AND _unused_QuantityInStock > 0
;



--  Improve performance of the inventory page
ALTER TABLE `TblOrdersBOM_Items`
	ADD INDEX `idx_ProductID_OrderVersionID_QuantityOrdered_Shi_QShipped` (`ProductID`,`OrderVersionID`, `QuantityOrdered`, `Shipped`, `QuantityShipped`);