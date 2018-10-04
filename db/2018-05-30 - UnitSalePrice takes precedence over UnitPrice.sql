ALTER TABLE `TblProducts`
	CHANGE COLUMN `UnitSalePrice` `UnitSalePrice` DECIMAL(19,2) NULL DEFAULT NULL COMMENT 'Sale price. If this is filled in it takes precedence over UnitPrice for StairSupplies'
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
		`UnitPrice` DECIMAL(19,2),
		`UnitSalePrice` DECIMAL(19,2),
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
				/*  If UnitSalePrice is filled in it has priority over UnitPrice  */
				RETURN Coalesce(UnitSalePrice, UnitPrice);
			ELSE
				BEGIN
					IF ( companyID = COMPANY_VIEWRAIL ) THEN
						RETURN unitPriceViewrail;
					ELSE
						/*  If UnitSalePrice is filled in it has priority over UnitPrice  */
						RETURN Coalesce(UnitSalePrice, UnitPrice);
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
		IF(CustomerTypeID = 14,
			UnitPriceNAC,
			IF(CustomerTypeID = 16,
				Coalesce(UnitSalePrice, UnitPrice),
				IF(TblOrdersBOM.CompanyID = 4, UnitPriceViewrail, Coalesce(UnitSalePrice, UnitPrice))
			)
		) AS productUnitPrice
FROM TblOrdersBOM_Items
	INNER JOIN TblProducts          ON TblProducts.productID = TblOrdersBOM_Items.productID
	INNER JOIN TblOrdersBOM_Version ON TblOrdersBOM_Version.OrderVersionID = TblOrdersBOM_Items.OrderVersionID
	INNER JOIN TblOrdersBOM         ON TblOrdersBOM.orderID = TblOrdersBOM_Version.OrderID
	INNER JOIN TblCustomerContact   ON TblCustomerContact.CustomerContactID = TblOrdersBOM.CustomerContactID
	INNER JOIN TblCustomer          ON TblCustomer.CustomerID = TblCustomerContact.CustomerID
;