--  Not NULL  
ALTER TABLE `TblProductType`
	CHANGE COLUMN `warnOnUnsetPRCOrFinal` `warnOnUnsetPRCOrFinal` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '=1 the shipping module will issue a warning when PRC or Final are unset when shipping an item' AFTER `DailyFinalThreshold`;
	
	
--  type_id is not a good name, ProductTypeTypeId is better because it links to the tblProductTypeType table
ALTER TABLE `TblProductType`
	ALTER `type_id` DROP DEFAULT;
ALTER TABLE `TblProductType`
	CHANGE COLUMN `type_id` `ProductTypeTypeId` INT(10) UNSIGNED NOT NULL AFTER `ProductType`;


--  ProductType should be ProductTypeName (avoids confusion with table name)
ALTER TABLE `TblProductType`
	ALTER `ProductType` DROP DEFAULT;
ALTER TABLE `TblProductType`
	CHANGE COLUMN `ProductType` `ProductTypeName` VARCHAR(50) NOT NULL COLLATE 'utf8_unicode_ci' AFTER `ProductType_id`;

	
DELIMITER $$

	
CREATE PROCEDURE `spPricePerCategory`(IN `orderID` INTEGER(11))
	LANGUAGE SQL
	DETERMINISTIC
	CONTAINS SQL
	SQL SECURITY INVOKER
	COMMENT ''
BEGIN

--  Performance note:
--    * The derived query gets the total for the existing items (very efficiently) and then we join with product types
--  to get all the types, even those types that don't exist on the requested order
--    * Calling fItemPriceWithDiscount here adds 1 second to the total time so we inline it instead
SELECT TblProductTypeType.title, Coalesce(total, 0) AS total
FROM TblProductTypeType
	INNER JOIN TblProductType ON TblProductTypeType.id = TblProductType.ProductTypeTypeId
	LEFT JOIN (
				SELECT ProductTypeTypeId, Sum( Round(OBOMI.unitPrice * (1 - OBOMI.discountPercent), 2) * OBOMI.quantityOrdered ) AS total
				FROM TblOrdersBOM_Items AS OBOMI
					INNER JOIN Products       ON OBOMI.ProductID = Products.productID
					INNER JOIN TblProductType ON TblProductType.ProductType_id = Products.ProductType_id
				WHERE OBOMI.OrderId = orderID
				GROUP BY TblProductType.ProductTypeTypeId
				) AS ExistingItemsTypes ON ExistingItemsTypes.ProductTypeTypeId = TblProductTypeType.id
GROUP BY TblProductTypeType.title
ORDER BY TblProductTypeType.id ASC;


END
$$


DELIMITER ;