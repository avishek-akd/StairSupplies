CREATE OR REPLACE SQL SECURITY INVOKER VIEW `vPurchaseOrderTotals` AS
SELECT TblPurchaseOrder.id AS PurchaseOrderID,
	Sum(PurchasePrice * QuantityRequested) AS PartsTotalAmount,
	(Sum(PurchasePrice * QuantityRequested) + Sum(PurchasePrice * QuantityRequested) * TaxPercent + ShippingAmount) AS TotalAmount
FROM TblPurchaseOrder
	INNER JOIN TblPurchaseOrderItem ON TblPurchaseOrderItem.PurchaseOrderID = TblPurchaseOrder.id
GROUP BY TblPurchaseOrder.id, TaxPercent, ShippingAmount
;