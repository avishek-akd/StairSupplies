ALTER TABLE `tbl_settings_per_company`
	ADD COLUMN `SalePriceEnabled` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '=1 if UnitSalePrice is filled in it\'s used then UnitPrice. =0 UnitPrice is used' AFTER `d_company_id`
;


ALTER TABLE TblProducts
	CHANGE COLUMN `UnitPriceViewrail` `UnitPriceDistributor` DECIMAL(19,2) NULL DEFAULT '0.00' COMMENT 'Price used for customer type Distributor',
	CHANGE COLUMN `UnitPriceNAC` `UnitPriceNAC` DECIMAL(19,2) NULL DEFAULT '0.00' COMMENT 'Price used for customer type North Atlantic Corp',
	CHANGE COLUMN `UnitSalePrice` `UnitSalePrice` DECIMAL(19,2) NULL DEFAULT NULL COMMENT 'Sale price. If this is filled in it takes precedence over UnitPrice'
;


-- 3 - I think this somewhat eliminates the need for the "StairSupplies Pricing" customer type. You can eliminate this type, and reassign then all to "Unknown".
UPDATE TblCustomer
SET CustomerTypeID = 3
WHERE CustomerTypeID = 16
;
DELETE
FROM TblCustomerType
WHERE id = 16
;






CREATE OR REPLACE SQL SECURITY INVOKER VIEW `vOrderItemProductUnitPrice` AS
/*
 * This view is used when retrieving the product (list) price for order items in the database.
 * NOTE: When adding a product to the database we don't have that line item saved yet so we use the function
 * fGetProductUnitPrice to get the per unit product price.
 *
 * CustomerTypeID = 14 -> North Atlantic Corp
 * CustomerTypeID = 2  -> Distributor
 */
SELECT orderItemsId,
		IF(CustomerTypeID = 14,
			UnitPriceNAC,
			IF(CustomerTypeID = 2,
				UnitPriceDistributor,
				IF(SalePriceEnabled = 1 AND UnitSalePrice IS NOT NULL, UnitSalePrice, UnitPrice)
			)
		) AS productUnitPrice
FROM TblOrdersBOM_Items
	INNER JOIN TblProducts              ON TblProducts.productID = TblOrdersBOM_Items.productID
	INNER JOIN TblOrdersBOM_Version     ON TblOrdersBOM_Version.OrderVersionID = TblOrdersBOM_Items.OrderVersionID
	INNER JOIN TblOrdersBOM             ON TblOrdersBOM.orderID = TblOrdersBOM_Version.OrderID
	INNER JOIN TblCustomerContact       ON TblCustomerContact.CustomerContactID = TblOrdersBOM.CustomerContactID
	INNER JOIN TblCustomer              ON TblCustomer.CustomerID = TblCustomerContact.CustomerID
	INNER JOIN tbl_settings_per_company ON tbl_settings_per_company.id = TblOrdersBOM.CompanyID
;





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