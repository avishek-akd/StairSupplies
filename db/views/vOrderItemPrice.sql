CREATE OR REPLACE SQL SECURITY INVOKER VIEW `vOrderItemPrice` AS
SELECT
	OrderItemsID,
	(OrderItemPricePerUnit * (1 - DiscountPercent)) AS unitPriceDiscounted,
	(OrderItemPricePerUnit * DiscountPercent) AS unitDiscountAmount
FROM TblOrdersBOM_Items
;