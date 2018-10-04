ALTER TABLE TblPurchaseOrderRequestProduct
	ADD COLUMN ReuqestedQuantity INT UNSIGNED NULL DEFAULT NULL AFTER EmployeeID;