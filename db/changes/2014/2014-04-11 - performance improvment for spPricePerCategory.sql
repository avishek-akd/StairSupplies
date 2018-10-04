DELIMITER $$



DROP PROCEDURE IF EXISTS spPricePerCategory
$$


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
	INNER JOIN TblProductType ON TblProductTypeType.id = TblProductType.type_id
	LEFT JOIN (
				SELECT type_id, Sum( Round(OBOMI.unitPrice * (1 - OBOMI.discountPercent), 2) * OBOMI.quantityOrdered ) AS total
				FROM TblOrdersBOM_Items AS OBOMI
					INNER JOIN Products       ON OBOMI.ProductID = Products.productID
					INNER JOIN TblProductType ON TblProductType.ProductType_id = Products.ProductType_id
				WHERE OBOMI.OrderId = orderID
				GROUP BY TblProductType.type_id
				) AS ExistingItemsTypes ON ExistingItemsTypes.type_id = TblProductTypeType.id
GROUP BY TblProductTypeType.title
ORDER BY TblProductTypeType.id ASC;


END
$$


DELIMITER ;