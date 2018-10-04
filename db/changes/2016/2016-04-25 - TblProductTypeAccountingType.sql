ALTER TABLE `TblProductTypeType`
	COMMENT='';
RENAME TABLE `TblProductTypeType` TO `TblProductTypeAccountingType`;


ALTER TABLE `TblProductType`
	ALTER `ProductTypeTypeId` DROP DEFAULT;
ALTER TABLE `TblProductType`
	CHANGE COLUMN `ProductTypeTypeId` `AccountingTypeID` INT(10) UNSIGNED NOT NULL AFTER `ProductTypeName`;


DELIMITER $$	


DROP PROCEDURE spPricePerCategory
$$
CREATE PROCEDURE `spPricePerAccountingType`(IN `orderID` INTEGER(11)
    )
	LANGUAGE SQL
	DETERMINISTIC
	CONTAINS SQL
	SQL SECURITY INVOKER
	COMMENT 'For a given order return the sum of prices in each accounting type (LED, Stock, etc)'
BEGIN
	
SELECT title, Coalesce(total, 0) AS total
FROM TblProductTypeAccountingType
	LEFT JOIN (
				SELECT AccountingTypeID, Sum( vOrderItemPrice.unitPriceDiscounted * OBOMI.quantityOrdered ) AS total
				FROM TblOrdersBOM_Items AS OBOMI
					INNER JOIN Products        ON OBOMI.ProductID = Products.productID
					INNER JOIN TblProductType  ON TblProductType.ProductType_id = Products.ProductType_id
					INNER JOIN vOrderItemPrice ON vOrderItemPrice.OrderItemsID = OBOMI.OrderItemsID
				WHERE OBOMI.OrderId = orderID
				GROUP BY TblProductType.AccountingTypeID
				) AS ExistingItemsTypes ON ExistingItemsTypes.AccountingTypeID = TblProductTypeAccountingType.id
GROUP BY TblProductTypeAccountingType.title
ORDER BY TblProductTypeAccountingType.id ASC;

END
$$


DELIMITER ;