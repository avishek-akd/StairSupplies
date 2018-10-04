ALTER TABLE TblPurchaseRequestPart
	ADD COLUMN `RequestedDueDate` DATE NULL DEFAULT NULL AFTER `RequestedQuantity`
;