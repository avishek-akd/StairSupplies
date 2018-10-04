CREATE PROCEDURE `pricePerCategory`(IN orderID INTEGER(11), OUT totalStock DECIMAL(10,2), OUT totalProduction DECIMAL(10,2))
    NOT DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY INVOKER
    COMMENT ''
BEGIN

DECLARE a VARCHAR(255);
DECLARE cur1 CURSOR FOR 

SELECT Coalesce(Sum( Round((1 - discount) * unitPrice, 2) * quantity ), 0) as total, TblProductType.Type
FROM TblProductType
	LEFT JOIN Products           ON Products.ProductType_id = TblProductType.ProductType_id
	LEFT JOIN TblOrdersBOM_Items ON (TblOrdersBOM_Items.ProductID = Products.ProductId
										AND TblOrdersBOM_Items.OrderId = orderID)
GROUP BY TblProductType.Type
ORDER BY TblProductType.Type ASC;

OPEN cur1;

FETCH cur1 INTO totalStock, a;
FETCH cur1 INTO totalProduction, a;

CLOSE cur1;

END;