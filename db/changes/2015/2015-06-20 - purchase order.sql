CREATE TABLE `TblPurchaseOrder` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`vendorID` INT(11) NOT NULL,
	`RequestedByEmployeeID` INT(11) NOT NULL,
	`TotalAmount` DECIMAL(10,2) NOT NULL,
	`RecordCreated` DATETIME NOT NULL,
	`RecordUpdated` DATETIME NULL DEFAULT NULL,
	PRIMARY KEY (`id`),
	INDEX `FK__TBLVendor` (`vendorID`),
	INDEX `FK_TblPurchaseOrder_Employees` (`RequestedByEmployeeID`),
	CONSTRAINT `FK_TblPurchaseOrder_Employees` FOREIGN KEY (`RequestedByEmployeeID`) REFERENCES `Employees` (`EmployeeID`),
	CONSTRAINT `FK__TBLVendor` FOREIGN KEY (`vendorID`) REFERENCES `TBLVendor` (`Vendor_ID`)
)
COLLATE='utf8_unicode_ci'
ENGINE=InnoDB
;
CREATE TABLE `TblPurchaseOrderItem` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`PurchaseOrderID` INT(11) NOT NULL,
	`ProductID` INT(11) NOT NULL,
	`ProductName` VARCHAR(100) NOT NULL COLLATE 'utf8_unicode_ci',
	`PurchasePrice` DECIMAL(19,2) NOT NULL,
	`QuantityRequested` INT(11) NOT NULL,
	`QuantityReceived` INT(11) NULL DEFAULT NULL,
	PRIMARY KEY (`id`),
	INDEX `FK_TblPurchaseOrderItem_TblPurchaseOrder` (`PurchaseOrderID`),
	INDEX `FK_TblPurchaseOrderItem_Products` (`ProductID`),
	CONSTRAINT `FK_TblPurchaseOrderItem_Products` FOREIGN KEY (`ProductID`) REFERENCES `Products` (`ProductID`),
	CONSTRAINT `FK_TblPurchaseOrderItem_TblPurchaseOrder` FOREIGN KEY (`PurchaseOrderID`) REFERENCES `TblPurchaseOrder` (`id`)
)
COLLATE='utf8_unicode_ci'
ENGINE=InnoDB
;


DELIMITER $$ 



CREATE TRIGGER `TblPurchaseOrderItem_after_ins_tr1` AFTER INSERT ON `TblPurchaseOrderItem`
  FOR EACH ROW
BEGIN

UPDATE TblPurchaseOrder
SET TotalAmount = Coalesce(TotalAmount, 0) + NEW.PurchasePrice * NEW.QuantityRequested
WHERE id = NEW.PurchaseOrderID;

END
$$



CREATE TRIGGER `TblPurchaseOrderItem_after_upd_tr1` AFTER UPDATE ON `TblPurchaseOrderItem`
  FOR EACH ROW
BEGIN

UPDATE TblPurchaseOrder
SET TotalAmount = TotalAmount - OLD.PurchasePrice * OLD.QuantityRequested + NEW.PurchasePrice * NEW.QuantityRequested
WHERE id = NEW.PurchaseOrderID;

END
$$



CREATE TRIGGER `TblPurchaseOrderItem_after_del_tr1` AFTER DELETE ON `TblPurchaseOrderItem`
  FOR EACH ROW
BEGIN

UPDATE TblPurchaseOrder
SET TotalAmount = TotalAmount - OLD.PurchasePrice * OLD.QuantityRequested
WHERE id = OLD.PurchaseOrderID;

END;
$$



DELIMITER ;