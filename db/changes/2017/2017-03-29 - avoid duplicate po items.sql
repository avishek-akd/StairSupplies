ALTER TABLE TblPurchaseOrderItem
	ADD UNIQUE INDEX `idx_PreventDuplicateProducts`(PurchaseOrderID, ProductID)
;