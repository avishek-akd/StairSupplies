ALTER TABLE TblProductType
	CHANGE COLUMN `ShowOnAddOrderItem2` `ShowOnAddOrderItem2` TINYINT(1) NOT NULL DEFAULT '1' COMMENT 'Controls if the products of this type of displayed when adding products to order. =1 Always show; =2  Use material filter; =3 Always hide' AFTER `ShowOnAddOrderItem`,
	CHANGE COLUMN `isPost2` `isPost2` TINYINT(1) UNSIGNED NOT NULL DEFAULT '0' AFTER `isPost`,
	CHANGE COLUMN `isHandrail2` `isHandrail2` TINYINT(1) UNSIGNED NOT NULL DEFAULT '0' AFTER `isHandrail`,
	CHANGE COLUMN `archived` `archived` TINYINT(4) NOT NULL DEFAULT '0' AFTER `isHandrail2`
;
ALTER TABLE TblProductType
	CHANGE COLUMN `isPost` `_unused_isPost` TINYINT(1) UNSIGNED NOT NULL DEFAULT '0',
	CHANGE COLUMN `isHandrail` `_unused_isHandrail` TINYINT(1) UNSIGNED NOT NULL DEFAULT '0',
	CHANGE COLUMN `ShowOnAddOrderItem` `_unused_ShowOnAddOrderItem` TINYINT(1) NOT NULL DEFAULT '1' COMMENT 'Controls if the products of this type of displayed when adding products to order. =1 Always show; =2  Show only if "All items" is checked; =3 Always hide'
;
DROP TABLE `TblProductTypeInclude`
;

--  Delete "1" product group and all it's children
DELETE
FROM TblProductType
WHERE TypeGroupID = 18
;
DELETE
FROM TblProductTypeGroup
WHERE ProductTypeGroupID = 18
;

-- Delete groups marked by Brett as for deletion
DELETE
FROM TblProductType
WHERE ProductTypeName LIKE 'Delete _'
;