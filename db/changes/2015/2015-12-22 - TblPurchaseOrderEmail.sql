CREATE TABLE `TblPurchaseOrderEmail` (
	`id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`PurchaseOrderID` INT NOT NULL,
	`Message` VARCHAR(500) NOT NULL,
	`RecordCreated` DATETIME NOT NULL,
	PRIMARY KEY (`id`),
	CONSTRAINT `FK__TblPurchaseOrder` FOREIGN KEY (`PurchaseOrderID`) REFERENCES `TblPurchaseOrder` (`id`)
)
ENGINE=InnoDB
;
