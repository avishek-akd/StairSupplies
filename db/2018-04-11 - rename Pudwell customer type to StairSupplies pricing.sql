UPDATE `TblCustomerType`
SET `TypeName`='StairSupplies Pricing'
WHERE  `id`=16
;



DELIMITER $$



--  Product pricing depends on company and customer: StairSupplies and Viewrail have different prices for the same product,
-- some customers (like NAC) also have special prices.
-- CUSTOMER_TYPE_STAIRSUPPLIES used to be CUSTOMER_TYPE_PUDWELL and had separate pricing, now it's regular StairSupplies
DROP FUNCTION IF EXISTS `fGetProductUnitPrice`
$$
CREATE FUNCTION `fGetProductUnitPrice`(
		`companyID` INTEGER,
		`CustomerTypeID` INTEGER,
		`unitPrice` DECIMAL(19,2),
		`unitPriceViewrail` DECIMAL(19,2),
		`unitPriceNAC` DECIMAL(19,2)
	)
	RETURNS decimal(19,2)
	DETERMINISTIC
	SQL SECURITY INVOKER
	COMMENT ''
BEGIN
	DECLARE CUSTOMER_TYPE_NAC INT DEFAULT 14;
	DECLARE CUSTOMER_TYPE_STAIRSUPPLIES INT DEFAULT 16;
    DECLARE COMPANY_VIEWRAIL INT DEFAULT 4;

	IF ( CustomerTypeID = CUSTOMER_TYPE_NAC ) THEN
		RETURN unitPriceNAC;
	ELSE
		BEGIN
			IF ( CustomerTypeID = CUSTOMER_TYPE_STAIRSUPPLIES ) THEN
				RETURN unitPrice;
			ELSE
				BEGIN
					IF ( companyID = COMPANY_VIEWRAIL ) THEN
						RETURN unitPriceViewrail;
					ELSE
						RETURN unitPrice;
					END IF;
				END;
			END IF;
		END;
	END IF;
END
$$



DELIMITER ;



CREATE OR REPLACE SQL SECURITY INVOKER VIEW `vOrderItemProductUnitPrice` AS
/*
 * This view is used when retrieving the product (list) price for order items in the database.
 * NOTE: When adding a product to the database we don't have that line item saved yet so we use the function
 * fGetProductUnitPrice to get the per unit product price.
 * 
 * CustomerTypeID = 14 -> North Atlantic Corp
 * CustomerTypeID = 16 -> StairSupplies pricing
 */
SELECT orderItemsId,
		IF(`TblCustomer`.`CustomerTypeID` = 14,
			`TblProducts`.`UnitPriceNAC`,
			IF(`TblCustomer`.`CustomerTypeID` = 16,
				`TblProducts`.`UnitPrice`,
				IF(`TblOrdersBOM`.`CompanyID` = 4, `TblProducts`.`UnitPriceViewrail`, `TblProducts`.`UnitPrice`))
		) AS productUnitPrice
FROM TblOrdersBOM_Items
	INNER JOIN TblProducts          ON TblProducts.productID = TblOrdersBOM_Items.productID
	INNER JOIN TblOrdersBOM_Version ON TblOrdersBOM_Version.OrderVersionID = TblOrdersBOM_Items.OrderVersionID
	INNER JOIN TblOrdersBOM         ON TblOrdersBOM.orderID = TblOrdersBOM_Version.OrderID
	INNER JOIN TblCustomerContact   ON TblCustomerContact.CustomerContactID = TblOrdersBOM.CustomerContactID
	INNER JOIN TblCustomer          ON TblCustomer.CustomerID = TblCustomerContact.CustomerID
;