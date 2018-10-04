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
