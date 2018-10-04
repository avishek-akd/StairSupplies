DELIMITER $$



DROP FUNCTION IF EXISTS `fGetOrderMaterialsNames`
$$
--  Return a list of distinct material names on an order
CREATE FUNCTION `fGetOrderMaterialsNames`(
	`orderID` INTEGER
)
RETURNS VARCHAR(1000)
DETERMINISTIC
SQL SECURITY INVOKER
COMMENT ''
BEGIN
	DECLARE Result VARCHAR(1000) DEFAULT '';

	SELECT Group_concat(DISTINCT d_name ORDER BY d_name) INTO Result
	FROM TblOrdersBOM_Items
		INNER JOIN TblOrdersBOM_ActiveVersion ON TblOrdersBOM_ActiveVersion.OrderVersionID = TblOrdersBOM_Items.OrderVersionID 
		INNER JOIN TblProducts                ON TblProducts.ProductID = TblOrdersBOM_Items.ProductID
		LEFT JOIN TblMaterial                 ON TblMaterial.id = TblProducts.MaterialID
	WHERE TblOrdersBOM_ActiveVersion.OrderID = orderID;
	
	RETURN Result;
END
$$



DELIMITER ;