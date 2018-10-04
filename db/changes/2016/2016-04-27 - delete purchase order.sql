ALTER TABLE `TblPurchaseOrder`
	ADD COLUMN `Deleted` TINYINT(1) NOT NULL DEFAULT '0' AFTER `vendorEstimatedShippingDate`;
