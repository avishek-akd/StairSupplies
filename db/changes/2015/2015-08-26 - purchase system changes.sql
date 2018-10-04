DELIMITER $$



ALTER TABLE `TblPurchaseOrder`
	ADD COLUMN `ProductsTotalAmount` DECIMAL(10,2) NOT NULL DEFAULT '0' COMMENT 'Subtotal for products, in dollars. This is updated automatically via triggers' AFTER `RequestedByEmployeeID`,
	ADD COLUMN `TaxAmount` DECIMAL(10,2) NOT NULL DEFAULT '0' COMMENT 'Tax amount, in dollars.' AFTER `ProductsTotalAmount`,
	ADD COLUMN `ShippingAmount` DECIMAL(10,2) NOT NULL DEFAULT '0' COMMENT 'Shipping amount, in dollars.' AFTER `TaxAmount`
$$



DROP TRIGGER IF EXISTS TblPurchaseOrderItem_after_ins_tr1
$$
CREATE TRIGGER `TblPurchaseOrderItem_after_ins_tr1` AFTER INSERT ON `TblPurchaseOrderItem`
  FOR EACH ROW
BEGIN

UPDATE TblPurchaseOrder
SET
	ProductsTotalAmount = Coalesce(ProductsTotalAmount, 0) + NEW.PurchasePrice * NEW.QuantityRequested
WHERE id = NEW.PurchaseOrderID;
UPDATE TblPurchaseOrder
SET
	TotalAmount = ProductsTotalAmount + TaxAmount + ShippingAmount
WHERE id = NEW.PurchaseOrderID;

END
$$


DROP TRIGGER IF EXISTS TblPurchaseOrderItem_after_upd_tr1
$$
CREATE TRIGGER `TblPurchaseOrderItem_after_upd_tr1` AFTER UPDATE ON `TblPurchaseOrderItem`
  FOR EACH ROW
BEGIN

UPDATE TblPurchaseOrder
SET
	ProductsTotalAmount = ProductsTotalAmount - OLD.PurchasePrice * OLD.QuantityRequested + NEW.PurchasePrice * NEW.QuantityRequested
WHERE id = NEW.PurchaseOrderID;
UPDATE TblPurchaseOrder
SET
	TotalAmount = ProductsTotalAmount + TaxAmount + ShippingAmount
WHERE id = NEW.PurchaseOrderID;

END
$$


DROP TRIGGER IF EXISTS TblPurchaseOrderItem_after_del_tr1
$$
CREATE TRIGGER `TblPurchaseOrderItem_after_del_tr1` AFTER DELETE ON `TblPurchaseOrderItem`
  FOR EACH ROW
BEGIN

UPDATE TblPurchaseOrder
SET
	ProductsTotalAmount = ProductsTotalAmount - OLD.PurchasePrice * OLD.QuantityRequested
WHERE id = OLD.PurchaseOrderID;
UPDATE TblPurchaseOrder
SET
	TotalAmount = ProductsTotalAmount + TaxAmount + ShippingAmount
WHERE id = OLD.PurchaseOrderID;

END
$$


DELETE FROM TblPurchaseOrderItem
$$
DELETE FROM TblPurchaseOrder
$$
ALTER TABLE `TblPurchaseOrder`
	AUTO_INCREMENT=1000
$$



DELIMITER ;
