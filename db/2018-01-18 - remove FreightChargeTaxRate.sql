ALTER TABLE `TblState`
	ALTER `FreightTaxRate` DROP DEFAULT
;


ALTER TABLE `TblState`
	CHANGE COLUMN `FreightTaxRate` `_unused_FreightTaxRate` DECIMAL(10,4) NOT NULL COMMENT 'Tax rate applied to Freight charge' AFTER `SalesTax`
;


ALTER TABLE TblOrdersBOM
	CHANGE COLUMN `FreightChargeTaxRate` `_unused_FreightChargeTaxRate` DECIMAL(10,4) NOT NULL DEFAULT '0.0000' COMMENT 'Tax rate that is applied to Freight Charge',
	ADD COLUMN `SalesTaxRateBackupFCTaxRate` DECIMAL(10,4) NULL DEFAULT NULL AFTER `SalesTaxRate`
;


CREATE TEMPORARY TABLE `tmpNewSalesRate` AS
SELECT
		(SELECT Sum(OrderItemPricePerUnit * (1 - DiscountPercent) * QuantityOrdered) FROM TblOrdersBOM_Items WHERE TblOrdersBOM_Items.OrderID = TblOrdersBOM.OrderID) AS OrderSubtotal,
		SalesTaxRate,
		Round(((SELECT OrderSubtotal)*SalesTaxRate + FreightCharge*_unused_FreightChargeTaxRate)/ ((SELECT OrderSubtotal)+FreightCharge), 4) AS NEW_SalesTaxRate,
		OrderID
FROM TblOrdersBOM
WHERE (SELECT Sum(OrderItemPricePerUnit * (1 - DiscountPercent) * QuantityOrdered) FROM TblOrdersBOM_Items WHERE TblOrdersBOM_Items.OrderID = TblOrdersBOM.OrderID) > 0
HAVING SalesTaxRate <> NEW_SalesTaxRate
;


UPDATE TblOrdersBOM
	INNER JOIN tmpNewSalesRate ON tmpNewSalesRate.OrderID = TblOrdersBOM.OrderID
SET
	TblOrdersBOM.SalesTaxRateBackupFCTaxRate = TblOrdersBOM.SalesTaxRate,
	TblOrdersBOM.SalesTaxRate = NEW_SalesTaxRate
;


DROP TABLE tmpNewSalesRate;
