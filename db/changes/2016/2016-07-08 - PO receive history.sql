CREATE TABLE `TblPurchaseOrderReceive` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`PurchaseOrderID` INT(11) NULL DEFAULT NULL,
	`ReceivedOn` DATE NULL DEFAULT NULL,
	`RecordCreated` DATETIME NULL DEFAULT NULL,
	PRIMARY KEY (`id`),
	INDEX `FK_TblPurchaseOrderReceive_TblPurchaseOrder` (`PurchaseOrderID`),
	CONSTRAINT `FK_TblPurchaseOrderReceive_TblPurchaseOrder` FOREIGN KEY (`PurchaseOrderID`) REFERENCES `TblPurchaseOrder` (`id`)
)
ENGINE=InnoDB
;

CREATE TABLE `TblPurchaseOrderReceiveItem` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`PurchaseOrderReceiveID` INT(11) NOT NULL,
	`PurchaseOrderItemID` INT(11) NOT NULL,
	`QuantityReceived` INT(11) NOT NULL,
	PRIMARY KEY (`id`),
	INDEX `FK_TblPurchaseOrderReceiveItem_TblPurchaseOrderReceive` (`PurchaseOrderReceiveID`),
	INDEX `FK_TblPurchaseOrderReceiveItem_TblPurchaseOrderItem` (`PurchaseOrderItemID`),
	CONSTRAINT `FK_TblPurchaseOrderReceiveItem_TblPurchaseOrderItem` FOREIGN KEY (`PurchaseOrderItemID`) REFERENCES `TblPurchaseOrderItem` (`id`),
	CONSTRAINT `FK_TblPurchaseOrderReceiveItem_TblPurchaseOrderReceive` FOREIGN KEY (`PurchaseOrderReceiveID`) REFERENCES `TblPurchaseOrderReceive` (`id`)
)
ENGINE=InnoDB
;


ALTER TABLE `TblPurchaseOrderItem`
	CHANGE COLUMN `QuantityReceived` `_unused_QuantityReceived` INT(11) NULL DEFAULT NULL AFTER `QuantityRequested`;
