ALTER TABLE `TblOrdersBOM_Items`
	ADD COLUMN `isSpecialOrderItem` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '=1 if this items is special order built (longer length, different build, etc)' AFTER `ProductDescription`;


UPDATE TblOrdersBOM_Items
SET isSpecialOrderItem = 1
WHERE TblOrdersBOM_Items.ProductName like '%Special order%';