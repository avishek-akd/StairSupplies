ALTER TABLE TblPurchaseOrderRequestProduct
	CHANGE COLUMN ReuqestedQuantity RequestedQuantity INT UNSIGNED NULL DEFAULT NULL AFTER EmployeeID;