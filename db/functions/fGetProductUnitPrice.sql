DELIMITER $$



--  Product pricing depends on:,
-- customer type - NAC and Distributor types have special prices.
-- UnitSalePrice - for all other customer types if the sale price is filled in use that, if not use the regular unit price
DROP FUNCTION IF EXISTS `fGetProductUnitPrice`
$$
CREATE FUNCTION `fGetProductUnitPrice`(
		`companyID` INTEGER,
		`CustomerTypeID` INTEGER,
		`UnitPrice` DECIMAL(19,2),
		`UnitSalePrice` DECIMAL(19,2),
		`UnitPriceDistributor` DECIMAL(19,2),
		`unitPriceNAC` DECIMAL(19,2)
	)
	RETURNS decimal(19,2)
	DETERMINISTIC
	SQL SECURITY INVOKER
	COMMENT ''
BEGIN
	DECLARE CUSTOMER_TYPE_ID_NAC INT DEFAULT 14;
	DECLARE CUSTOMER_TYPE_ID_DISTRIBUTOR INT DEFAULT 2;
	DECLARE vSalePriceEnabled TINYINT;


	SET vSalePriceEnabled = (SELECT SalePriceEnabled FROM tbl_settings_per_company WHERE d_company_id = companyID);


	CASE
		WHEN CustomerTypeID = CUSTOMER_TYPE_ID_NAC
			THEN RETURN unitPriceNAC;
		WHEN CustomerTypeID = CUSTOMER_TYPE_ID_DISTRIBUTOR
			THEN RETURN UnitPriceDistributor;
		ELSE
			/*  If UnitSalePrice is filled in it has priority over UnitPrice  */
			RETURN IF(vSalePriceEnabled = 1 AND UnitSalePrice IS NOT NULL, UnitSalePrice, UnitPrice);
	END CASE;
END
$$



DELIMITER ;