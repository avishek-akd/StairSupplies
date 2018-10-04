UPDATE TblPurchaseOrder
SET vendorAcknowledged = 0
WHERE vendorAcknowledged IS NULL;
ALTER TABLE `TblPurchaseOrder`
	CHANGE COLUMN `vendorAcknowledged` `vendorAcknowledged` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '=1 if Vendor acknowledged this order' AFTER `RequestedDueDate`;
