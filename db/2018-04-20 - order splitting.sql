ALTER TABLE TblOrdersBOM
	ADD COLUMN `OrderNumber` VARCHAR(10) NULL DEFAULT NULL COMMENT 'Same as OrderID for normal orders, this has the base order + a suffix for orders split from another order.' AFTER `OrderID`
;
UPDATE TblOrdersBOM
SET OrderNumber = OrderID
;
ALTER TABLE TblOrdersBOM
	CHANGE COLUMN `OrderNumber` `OrderNumber` VARCHAR(10) NOT NULL,
	ADD UNIQUE INDEX `unq_OrderNumber`(`OrderNumber`)
;



ALTER TABLE `TblOrdersBOM_Shipments`
	ALTER `ShipmentNumber` DROP DEFAULT;
ALTER TABLE `TblOrdersBOM_Shipments`
	CHANGE COLUMN `ShipmentNumber` `ShipmentNumber` VARCHAR(11) NOT NULL COMMENT 'Shipment Number is the order number plus the shipment index as a letter. For example for order 28000 we will have shipments: 28000-A, 28000-B, 28000-C, 28000-D, etc'
;



UPDATE tbl_settings_per_company
SET d_email_shipped_partial_subject = 'Order [OrderNumber] Partially Shipped'
;
UPDATE tbl_settings_per_company
SET d_email_shipped_partial_complete_subject = 'Balance of Order [OrderNumber] Shipped'
;
UPDATE tbl_settings_per_company
SET d_email_shipped_complete_subject = 'Balance of Order [OrderNumber] Shipped'
;



UPDATE tbl_settings_per_company
SET d_email_subject_ack = 'Your Stair Supplies Order Acknowledgement #orderDetails.OrderNumber#'
WHERE id = 1
;
UPDATE tbl_settings_per_company
SET d_email_subject_ack = 'Your Viewrail Order Acknowledgement #orderDetails.OrderNumber#'
WHERE id = 4
;



UPDATE tbl_settings_per_company
SET d_email_subject_quotation = 'Your Stair Supplies Order Quotation #orderDetails.OrderNumber#'
WHERE id = 1
;
UPDATE tbl_settings_per_company
SET d_email_subject_quotation = 'Your Viewrail Order Quotation #orderDetails.OrderNumber#'
WHERE id = 4
;


UPDATE tbl_settings_per_company
SET d_email_subject_invoice = 'Your Stair Supplies Invoice #orderDetails.OrderNumber#'
WHERE id = 1
;
UPDATE tbl_settings_per_company
SET d_email_subject_invoice = 'Your Viewrail Invoice #orderDetails.OrderNumber#'
WHERE id = 1
;