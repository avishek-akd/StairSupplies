ALTER TABLE `TblPurchaseOrderRequestProduct`
	CHANGE COLUMN `PurchaseOrderCreated` `_unused_PurchaseOrderCreated` TINYINT(4) NOT NULL DEFAULT '0' COMMENT '=1 if this product was ordered (purchase order was created)' AFTER `EmployeeID`;

	
delete from TblPurchaseOrderRequestProduct where _unused_PurchaseOrderCreated = 1