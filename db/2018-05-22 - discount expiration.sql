ALTER TABLE TblOrdersBOM_Version
	ADD COLUMN `DiscountExpiresOn` DATETIME NULL DEFAULT NULL COMMENT 'After this point in time the discount is reset to DiscountPercentAfterExpiration on all items in this version' AFTER `VersionName`,
	ADD COLUMN `DiscountPercentAfterExpiration` DECIMAL(10,4) NULL DEFAULT NULL COMMENT 'Discount percent that is used after deadline' AFTER `DiscountExpiresOn`
;



ALTER TABLE TblProductType
	ADD COLUMN `CanHaveDiscount` TINYINT(1) NOT NULL DEFAULT 1 AFTER `canEditCostGeneral`
;