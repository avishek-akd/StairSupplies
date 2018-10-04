ALTER TABLE `TblOrdersBOM_Version`
	CHANGE COLUMN `AfterExpirationDiscountPercent` `AfterExpirationDiscountPercent` DECIMAL(10,4) NULL DEFAULT NULL COMMENT 'Discount percent to be applied after expiration' AFTER `DiscountExpiresOn`
;

UPDATE TblOrdersBOM_Version
SET
	AfterExpirationDiscountPercent = AfterExpirationDiscountPercent / 100
WHERE AfterExpirationDiscountPercent IS NOT NULL
;