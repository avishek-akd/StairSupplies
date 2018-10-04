DELIMITER $$



INSERT INTO CustomerType
	(TypeName)
VALUES
	('Do not contact'),
	('Phil Pudwell Customer')
$$


DROP FUNCTION IF EXISTS fGetProductUnitPrice
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
    CONTAINS SQL
    SQL SECURITY INVOKER
BEGIN
	/*  This function returns the proper per unit product price, depending on who the customer is
	 * and the company that we're adding this order for.  */

	DECLARE CUSTOMER_TYPE_NAC INT DEFAULT 14;
	DECLARE CUSTOMER_TYPE_PUDWELL INT DEFAULT 16;
    DECLARE COMPANY_VIEWRAIL INT DEFAULT 4;

	IF ( CustomerTypeID = CUSTOMER_TYPE_NAC ) THEN
		RETURN unitPriceNAC;
	ELSE
		BEGIN
			IF ( CustomerTypeID = CUSTOMER_TYPE_PUDWELL ) THEN
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


DROP VIEW IF EXISTS vOrderItemProductUnitPrice
$$
CREATE ALGORITHM=UNDEFINED SQL SECURITY INVOKER VIEW vOrderItemProductUnitPrice AS
/*
 * This view is used when retrieving the product (list) price for order items in the database.
 * NOTE: When adding a product to the database we don't have that line item saved yet so we use the function
 * fGetProductUnitPrice to get the per unit product price.
 */
SELECT orderItemsId,
		IF(`Customers`.`CustomerTypeID` = 14,
			`Products`.`UnitPriceNAC`,
			IF(`Customers`.`CustomerTypeID` = 16,
				`Products`.`UnitPrice`,
				IF(`TblOrdersBOM`.`CompanyID` = 4, `Products`.`UnitPriceViewrail`, `Products`.`UnitPrice`))
		) AS productUnitPrice
FROM TblOrdersBOM_Items
	INNER JOIN Products        ON Products.productID = TblOrdersBOM_Items.productID
	INNER JOIN TblOrdersBOM    ON TblOrdersBOM.orderID = TblOrdersBOM_Items.orderID
	INNER JOIN CustomerContact ON CustomerContact.CustomerContactID = TblOrdersBOM.CustomerContactID
	INNER JOIN Customers       ON Customers.CustomerID = CustomerContact.CustomerID
$$



DELIMITER ;