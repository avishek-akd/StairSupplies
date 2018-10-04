--  Rename Salesman to Sales
ALTER TABLE `TblOrdersBOM`
	DROP FOREIGN KEY `FK_TblOrdersBOM_SalesmanEmployeeID`;
ALTER TABLE `TblOrdersBOM`
	CHANGE COLUMN `SalesmanEmployeeID` `SalesEmployeeID` INT(10) NULL DEFAULT NULL AFTER `EnteredByEmployeeID`,
	DROP INDEX `idxFK_SalesmanEmployeeID`,
	ADD INDEX `idxFK_SalesEmployeeID` (`SalesEmployeeID`),
	ADD CONSTRAINT `FK_TblOrdersBOM_SalesEmployeeID` FOREIGN KEY (`SalesEmployeeID`) REFERENCES `TblEmployee` (`EmployeeID`) ON UPDATE NO ACTION ON DELETE NO ACTION
;




CREATE OR REPLACE SQL SECURITY INVOKER VIEW `vOrderItemCosts` AS
SELECT orderItemsId,
		IF(costsAreFrozen = 1,
			OBOMI.costPurchase,
			TblProducts.Purchase_price
			) AS costPurchase,
		IF(costsAreFrozen = 1,
			OBOMI.costPurchaseIncludedProducts,
			TblProducts.PurchasePriceOfIncludedProducts
			) AS costPurchaseIncludedProducts,
		IF(costsAreFrozen = 1,
			IF(OBOMI.costPurchase IS NULL, OBOMI.costPurchaseIncludedProducts, OBOMI.costPurchase),
			IF(TblProducts.Purchase_price IS NULL, TblProducts.PurchasePriceOfIncludedProducts, TblProducts.Purchase_price)
			) AS costOfPurchase,
		IF(costsAreFrozen = 1,
			OBOMI.costOfLabor,
			TblProducts.LaborCost
			) + Coalesce(costOfFeaturesAndCustomizations, 0)
 			AS costOfLabor,
		IF(costsAreFrozen = 1,
			OBOMI.costPreFinish,
			TblProducts.PreFinishCost
			) AS costPreFinish,
		IF(costsAreFrozen = 1,
			OBOMI.costFinishOptionMultiplier,
			TblFinishOption.FinishPriceMultiplier
			) AS costFinishOptionMultiplier,
		IF(costsAreFrozen = 1,
			IF(OBOMI.FinishOptionID IS NULL, 0, Coalesce(OBOMI.costPreFinish * OBOMI.costFinishOptionMultiplier, 0)),
			IF(OBOMI.FinishOptionID IS NULL, 0, Coalesce(TblProducts.PreFinishCost * TblFinishOption.FinishPriceMultiplier, 0))
			) AS costOfPreFinish,
		IF(costsAreFrozen = 1,
			OBOMI.costLumberRate,
			TblMaterialSizeLink.d_lumber_rate
			) AS costLumberRate,
		IF(costsAreFrozen = 1,
			OBOMI.costBoardFootage,
			Coalesce(TblProducts.boardFootage, 0)
			) AS costBoardFootage,
		IF(costsAreFrozen = 1,
			Coalesce(OBOMI.costLumberRate * OBOMI.costBoardFootage, 0),
			Coalesce(TblMaterialSizeLink.d_lumber_rate * Coalesce(TblProducts.boardFootage, 0), 0)
			) AS costOfBoardFootage,
	    OBOMI.OrderItemPricePerUnit * (1 - OBOMI.DiscountPercent) * Coalesce(TblEmployee.SalesCommission, 0) AS costOfSalesCommision,
	    Coalesce(costGeneral, 0) AS costGeneral,

		IF(costsAreFrozen = 1,
			IF(OBOMI.costPurchase IS NULL, OBOMI.costPurchaseIncludedProducts, OBOMI.costPurchase)
			+ OBOMI.costOfLabor
			+ Coalesce(OBOMI.costPreFinish * OBOMI.costFinishOptionMultiplier, 0)
			+ Coalesce(OBOMI.costLumberRate * OBOMI.costBoardFootage, 0)
			,
			IF(TblProducts.Purchase_price IS NULL, TblProducts.PurchasePriceOfIncludedProducts, TblProducts.Purchase_price)
			+ TblProducts.LaborCost
			+ Coalesce(TblProducts.PreFinishCost * TblFinishOption.FinishPriceMultiplier, 0)
			+ Coalesce(TblMaterialSizeLink.d_lumber_rate * Coalesce(TblProducts.boardFootage, 0), 0)
			)
		+ OBOMI.OrderItemPricePerUnit * (1 - OBOMI.DiscountPercent) * Coalesce(TblEmployee.SalesCommission, 0)
		+ Coalesce(costGeneral, 0)
		AS costPerUnit
FROM TblOrdersBOM_Items AS OBOMI
	INNER JOIN TblOrdersBOM_Version ON TblOrdersBOM_Version.OrderVersionID = OBOMI.OrderVersionID
	INNER JOIN TblOrdersBOM         ON TblOrdersBOM.OrderID = TblOrdersBOM_Version.OrderID
	LEFT JOIN TblEmployee           ON TblEmployee.EmployeeID = TblOrdersBOM.SalesEmployeeID
	INNER JOIN TblProducts          ON TblProducts.productID = OBOMI.productID
	LEFT JOIN TblFinishOption       ON TblFinishOption.id = OBOMI.FinishOptionID
	LEFT JOIN TblMaterial           ON TblMaterial.id = TblProducts.MaterialID
	LEFT JOIN TblMaterialSizeLink   ON (TblMaterialSizeLink.d_material_id = TblProducts.MaterialID
											AND TblMaterialSizeLink.d_material_size_id = TblProducts.MaterialSizeID)
;


ALTER TABLE TblOrdersBOM
	ADD COLUMN `SalesSupportEmployeeID` INT(10) NULL DEFAULT NULL AFTER `CustomerServiceEmployeeID`,
	ADD INDEX `idxFK_SalesSupportEmployeeID` (`SalesSupportEmployeeID`),
	ADD CONSTRAINT `FK_TblOrdersBOM_SalesSupportEmployeeID` FOREIGN KEY (`SalesSupportEmployeeID`) REFERENCES `TblEmployee` (`EmployeeID`) ON UPDATE NO ACTION ON DELETE NO ACTION
;
ALTER TABLE TblEmployee
	ADD COLUMN `belongsToSalesSupport` TINYINT(1) NOT NULL DEFAULT '0' AFTER `belongsToCustomerService`
;






DELIMITER $$



DROP FUNCTION IF EXISTS `fGetEmployeeEmail`
$$
CREATE FUNCTION `fGetEmployeeEmail` (pCompanyID INT, EmailStairs VARCHAR(50), pEmailViewrail VARCHAR(50))
	RETURNS VARCHAR(50)
	DETERMINISTIC
	SQL SECURITY INVOKER
	COMMENT 'Each employee has 2 email addresses, one for StairSupplies and another one for Viewrail. Return the right address depending on the company.
	If the Viewrail address is not filled in the Stairsupplies one is returned'
BEGIN
	DECLARE COMPANY_VIEWRAIL INT DEFAULT 4;

	RETURN IF(pCompanyID = COMPANY_VIEWRAIL AND pEmailViewrail IS NOT NULL AND pEmailViewrail <> '', pEmailViewrail, EmailStairs);
END
$$



DELIMITER ;