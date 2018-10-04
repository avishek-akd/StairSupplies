ALTER TABLE TblRGARequest
	ADD COLUMN CompanyID INT(10) NULL DEFAULT NULL AFTER `id`
;

UPDATE TblRGARequest
SET CompanyID = (SELECT CompanyID FROM TblOrdersBOM WHERE OrderNumber = TblRGARequest.d_order_number)
;
