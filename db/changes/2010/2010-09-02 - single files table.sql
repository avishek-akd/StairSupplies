CREATE TABLE `TblFile` (
	`id` INT(10) NOT NULL AUTO_INCREMENT,
	`orderID` INT(10) NULL DEFAULT NULL,
	`productID` INT(10) NULL DEFAULT NULL,
	`orderItemsID` INT(10) NULL DEFAULT NULL,
	`orderShipmentID` INT(10) NULL DEFAULT NULL,
	`customerID` INT(10) NULL DEFAULT NULL,
	`file_name` VARCHAR(50) NOT NULL,
	`thumbnail` VARCHAR(100) NULL DEFAULT NULL,
	`thumbnail_width` INT(11) NULL DEFAULT NULL,
	`thumbnail_height` INT(11) NULL DEFAULT NULL,
	`record_created` DATETIME NOT NULL,
	`record_updated` DATETIME NULL DEFAULT NULL,
	PRIMARY KEY (`id`),
	INDEX `idxOrder` (`orderID`),
	INDEX `idxProduct` (`productID`),
	INDEX `idxOrderItems` (`orderItemsID`),
	INDEX `idxOrderShipment` (`orderShipmentID`),
	INDEX `idxCustomer` (`customerID`),
	CONSTRAINT `FK_TblFile_TblOrdersBOM` FOREIGN KEY (`orderID`) REFERENCES `TblOrdersBOM` (`OrderID`) ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT `FK_TblFile_Products` FOREIGN KEY (`productID`) REFERENCES `Products` (`ProductID`) ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT `FK_TblFile_TblOrdersBOM_Items` FOREIGN KEY (`orderItemsID`) REFERENCES `TblOrdersBOM_Items` (`OrderItemsID`) ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT `FK_TblFile_TblOrdersBOM_Shipments` FOREIGN KEY (`orderShipmentID`) REFERENCES `TblOrdersBOM_Shipments` (`OrderShipment_id`) ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT `FK_TblFile_Customers` FOREIGN KEY (`customerID`) REFERENCES `Customers` (`CustomerID`) ON UPDATE NO ACTION ON DELETE NO ACTION
) ENGINE=InnoDB;


INSERT INTO TblFile
(productID, file_name, record_created)
SELECT productID, file_name, record_created
FROM Products_OrderItems_Files
WHERE productID IS NOT NULL;

INSERT INTO TblFile
(orderItemsID, file_name, record_created)
SELECT orderItemsID, file_name, record_created
FROM Products_OrderItems_Files
WHERE orderItemsID IS NOT NULL;

INSERT INTO TblFile
(orderID, file_name, thumbnail, thumbnail_width, thumbnail_height, record_created)
SELECT orderID, file_name, thumbnail, thumbnail_width, thumbnail_height, record_created
FROM TblOrdersBOM_Files;

INSERT INTO TblFile
(orderShipmentID, file_name, record_created)
SELECT orderShipment_ID, ShipmentImage, DateAdded
FROM TblOrdersBOM_Shipments
WHERE ShipmentImage IS NOT NULL;


RENAME TABLE `Products_OrderItems_Files` TO `z_unused_Products_OrderItems_Files`;
RENAME TABLE `TblOrdersBOM_Files` TO `z_unused_TblOrdersBOM_Files`;
ALTER TABLE `TblOrdersBOM_Shipments`
	CHANGE COLUMN `ShipmentImage` `z_unused_ShipmentImage` VARCHAR(100) NULL DEFAULT NULL AFTER `delivered`;
