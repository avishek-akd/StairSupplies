ALTER TABLE TblProductType
	ADD COLUMN `canBeSpecial` TINYINT NOT NULL DEFAULT 1 COMMENT '=1 if the product can be the base for a special product' AFTER `RequiresDropship`,
	ADD COLUMN `canEditListPrice` TINYINT NOT NULL DEFAULT 0 COMMENT '=1 if the list price can be edit for normal products of this type' AFTER `canBeSpecial`
;