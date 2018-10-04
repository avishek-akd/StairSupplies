CREATE TABLE `TblOrdersBOM_Shipments_Signature` ( 
	`id` INT(10) NOT NULL AUTO_INCREMENT,
	`shipmentID` INT(10) NOT NULL,
	`signature_file` VARCHAR(100) NOT NULL,
	`initials` VARCHAR(100) NOT NULL,
	`request_ip` VARCHAR(15) NOT NULL, 
	`record_created` DATETIME NOT NULL, 
	PRIMARY KEY (`id`),
	INDEX `idxShipment` (`shipmentID`),
	CONSTRAINT `FK_TblOrdersBOM_Shipments_Signature_TblOrdersBOM_Shipments` FOREIGN KEY (`shipmentID`) REFERENCES `TblOrdersBOM_Shipments` (`OrderShipment_id`) ON DELETE CASCADE
)
COLLATE='latin1_swedish_ci' ENGINE=InnoDB ROW_FORMAT=DEFAULT;


CREATE TABLE `TblOrdersBOM_Signature` ( 
	`id` INT(10) NOT NULL AUTO_INCREMENT,
	`orderID` INT(100) NOT NULL,
	`signature_file` VARCHAR(100) NOT NULL, 
	`initials` VARCHAR(100) NOT NULL,
	`request_ip` VARCHAR(15) NOT NULL, 
	`record_created` DATETIME NOT NULL,
	PRIMARY KEY (`id`),
	INDEX `idxOrder` (`orderID`),
	CONSTRAINT `FK_TblOrdersBOM_Signature_TblOrdersBOM` FOREIGN KEY (`orderID`) REFERENCES `TblOrdersBOM` (`OrderID`) ON DELETE CASCADE
)
COLLATE='latin1_swedish_ci' ENGINE=InnoDB ROW_FORMAT=DEFAULT;

	
ALTER TABLE `TblOrdersBOM`
	DROP COLUMN `CustomerAcknowledgementSignature`;
