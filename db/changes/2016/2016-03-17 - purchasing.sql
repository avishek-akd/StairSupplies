CREATE TABLE `TblPurchaseOrderRequestProduct` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`ProductID` INT NOT NULL,
	`EmployeeID` INT NOT NULL,
	`PurchaseOrderCreated` TINYINT NOT NULL DEFAULT '0',
	`RecordCreated` DATETIME NOT NULL,
	`RecordUpdated` DATETIME NULL DEFAULT NULL,
	PRIMARY KEY (`id`)
)
ENGINE=InnoDB
;
ALTER TABLE `TblPurchaseOrderRequestProduct`
	ADD CONSTRAINT `FK_TblPurchaseOrderRequestProduct_Products` FOREIGN KEY (`ProductID`) REFERENCES `Products` (`ProductID`),
	ADD CONSTRAINT `FK_TblPurchaseOrderRequestProduct_Employees` FOREIGN KEY (`EmployeeID`) REFERENCES `Employees` (`EmployeeID`);
ALTER TABLE `TblPurchaseOrderRequestProduct`
	CHANGE COLUMN `PurchaseOrderCreated` `PurchaseOrderCreated` TINYINT(4) NOT NULL DEFAULT '0' COMMENT '=1 if this product was ordered (purchase order was created)' AFTER `EmployeeID`;



ALTER TABLE `tbl_settings_per_company`
	ADD COLUMN `d_email_header_purchasing` VARCHAR(500) NULL DEFAULT NULL AFTER `d_email_header`,
	ADD COLUMN `d_email_footer_purchasing` VARCHAR(500) NULL DEFAULT NULL AFTER `d_email_footer`;
UPDATE tbl_settings_per_company
SET
	d_email_header_purchasing = d_email_header,
	d_email_footer_purchasing = d_email_footer
WHERE id = 1;
UPDATE `tbl_settings_per_company` SET
	`d_email_header_purchasing`='<div id="logo">\r\n  <a href="http://www.stairsupplies.com/" target="_blank"><img src="cid:CompanyLogo"><BR></a>\r\n  <div id="openHours">&nbsp;</div>\r\n </div>',
	`d_email_footer_purchasing`='Stair Supplies | 1722 Eisenhower Dr. North, Suite B | Goshen, IN 46526<br />\r\n  Phone: 574 975 0288 | Toll Free: 866 226 6536 | Fax: 253 595 3715<br />\r\n  <a href="http://www.stairsupplies.com/" target="_blank">www.stairsupplies.com</a>\r\n  |\r\n  <a href="mailto:purchasing@stairsupplies.com">purchasing@stairsupplies.com</a>'
WHERE  `id`=1;


ALTER TABLE `TblPurchaseOrderItem`
	DROP COLUMN `vendorShipDate`,
	DROP COLUMN `vendorPrice`;


ALTER TABLE `TblVendor`
	ADD COLUMN `PurchasingDefaultTaxPercent` DECIMAL(5,4) NULL DEFAULT '0' COMMENT 'Default Tax percentage applied to PO\'s for this vendor' AFTER `primaryEmail`;


ALTER TABLE `TblPurchaseOrder`
	ADD COLUMN `TaxPercent` DECIMAL(5,4) NOT NULL DEFAULT '0' COMMENT 'Tax amount applied to products, as a percentage.' AFTER `ProductsTotalAmount`,
	DROP COLUMN `TaxAmount`;


ALTER TABLE `TblPurchaseOrder`
	ADD COLUMN `vendorEstimatedShippingDate` DATE NULL AFTER `vendorNotes`;



DELIMITER $$


DROP TRIGGER TblPurchaseOrderItem_after_del_tr1
$$
CREATE TRIGGER `TblPurchaseOrderItem_after_del_tr1` AFTER DELETE ON `TblPurchaseOrderItem` FOR EACH ROW BEGIN

UPDATE TblPurchaseOrder
SET
	ProductsTotalAmount = ProductsTotalAmount - OLD.PurchasePrice * OLD.QuantityRequested
WHERE id = OLD.PurchaseOrderID;
UPDATE TblPurchaseOrder
SET
	TotalAmount = ProductsTotalAmount + ProductsTotalAmount * TaxPercent + ShippingAmount
WHERE id = OLD.PurchaseOrderID;

END
$$





DROP TRIGGER TblPurchaseOrderItem_after_ins_tr1
$$
CREATE TRIGGER `TblPurchaseOrderItem_after_ins_tr1` AFTER INSERT ON `TblPurchaseOrderItem` FOR EACH ROW BEGIN

UPDATE TblPurchaseOrder
SET
	ProductsTotalAmount = Coalesce(ProductsTotalAmount, 0) + NEW.PurchasePrice * NEW.QuantityRequested
WHERE id = NEW.PurchaseOrderID;
UPDATE TblPurchaseOrder
SET
	TotalAmount = ProductsTotalAmount + ProductsTotalAmount * TaxPercent + ShippingAmount
WHERE id = NEW.PurchaseOrderID;

END
$$




DROP TRIGGER TblPurchaseOrderItem_after_upd_tr1
$$
CREATE TRIGGER `TblPurchaseOrderItem_after_upd_tr1` AFTER UPDATE ON `TblPurchaseOrderItem` FOR EACH ROW BEGIN

UPDATE TblPurchaseOrder
SET
	ProductsTotalAmount = ProductsTotalAmount - OLD.PurchasePrice * OLD.QuantityRequested + NEW.PurchasePrice * NEW.QuantityRequested
WHERE id = NEW.PurchaseOrderID;
UPDATE TblPurchaseOrder
SET
	TotalAmount = ProductsTotalAmount + ProductsTotalAmount * TaxPercent + ShippingAmount
WHERE id = NEW.PurchaseOrderID;

END
$$


DELIMITER ;