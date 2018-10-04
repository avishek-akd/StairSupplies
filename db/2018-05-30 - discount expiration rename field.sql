ALTER TABLE TblOrdersBOM_Version
	CHANGE COLUMN `DiscountPercentAfterExpiration` `AfterExpirationDiscountPercent` DECIMAL(10,2) NULL DEFAULT NULL COMMENT 'Discount percent to be applied after expiration'
;