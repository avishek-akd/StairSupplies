DELIMITER $$


DROP FUNCTION IF EXISTS fUnitCost
$$
CREATE FUNCTION `fUnitCost`(
        Purchase_price DECIMAL(19,4),
        LaborCost DECIMAL(10,2),
        PreFinishCost DECIMAL(10,2),
        lumber_rate DECIMAL(10,2),
        boardFootage DECIMAL(7,2)
    )
    RETURNS decimal(19,4)
    DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY DEFINER
    COMMENT ''
BEGIN
	RETURN Purchase_price + LaborCost + PreFinishCost + Coalesce(lumber_rate * boardFootage, 0);
END
$$


DELIMITER ;