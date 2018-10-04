CREATE OR REPLACE SQL SECURITY INVOKER VIEW `vShipmentsShipped` AS
SELECT
	OrderShipment_id, ShipmentNumber, OrderID, ShippingMethodID,
	pulled_by_id, packaged_by_id,processed_by_id,
	TrackingNumber, EstimatedArrivalDate, Paid, Invoiced, InvoiceDate,
	actualShippingCosts, isShipped, ShippedDate, isDelivered,
	RecordCreated, RecordUpdated
FROM
	TblOrdersBOM_Shipments
WHERE
	isShipped = 1
;