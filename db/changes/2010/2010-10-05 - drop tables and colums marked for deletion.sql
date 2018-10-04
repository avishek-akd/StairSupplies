DROP TABLE `z_unused_Products_OrderItems_Files`;
DROP TABLE `z_unused_Tbl_SpecialOrder_new`;
DROP TABLE `z_unused_TblSpecialOrders_files`;
DROP TABLE `z_unused_TblOrdersBOM_status`;
DROP TABLE `z_unused_TblOrdersBOM_Files`;
DROP TABLE `z_unused_TblOrdersBOMmemos`;

DROP TABLE `survey`;
DROP TABLE `surveymail`;
DROP TABLE `surveymail2`;

ALTER TABLE `Customers`  DROP FOREIGN KEY `Customers_fk2`;
ALTER TABLE `Customers`  DROP INDEX `Customers_idx2`;


ALTER TABLE `Customers`  DROP COLUMN `z_unused_YTD_Sales`,  DROP COLUMN `z_unused_Last_years_Sales`,  DROP COLUMN `z_unused_LastSale`,  DROP COLUMN `z_unused_ShipState_old`,  DROP COLUMN `z_unused_BillState_old`,  DROP COLUMN `z_unused_Country_old`,  DROP COLUMN `z_unused_StateOrProvince_old`,  DROP COLUMN `z_unused_FollowUpPerson`,  DROP COLUMN `z_unused_Country_new`,  DROP COLUMN `z_unused_ContactState_new`,  DROP COLUMN `z_unused_ShipState_new`,  DROP COLUMN `z_unused_BillState_new`;
ALTER TABLE `Products`  DROP COLUMN `z_unused_PUnitPrice_old`,  DROP COLUMN `z_unused_DropShip`,  DROP COLUMN `z_unused_Inventory_Number`,  DROP COLUMN `z_unused_Qty_Reorder_Min`,  DROP COLUMN `z_unused_Qty_On_Order`,  DROP COLUMN `z_unused_Qty_Available`,  DROP COLUMN `z_unused_Qty_to_reorder`,  DROP COLUMN `z_unused_Qty_Allocated`,  DROP COLUMN `z_unused_Qty_BackOrdered`;
ALTER TABLE `TblOrdersBOM`  DROP COLUMN `z_unused_Notes`,  DROP COLUMN `z_unused_EstimateDate`,  DROP COLUMN `z_unused_PONumber`,  DROP COLUMN `z_unused_OrderDate`,  DROP COLUMN `z_unused_ReadytoShipUser`,  DROP COLUMN `z_unused_ShippedUser`,  DROP COLUMN `z_unused_ShippedPartialDate`,  DROP COLUMN `z_unused_orderedDate`,  DROP COLUMN `z_unused_Archived`,  DROP COLUMN `z_unused_OrderedUser`,  DROP COLUMN `z_unused_ArchivedDate`,  DROP COLUMN `z_unused_OrderSubTotal`,  DROP COLUMN `z_unused_ShippedPartial`,  DROP COLUMN `z_unused_ReleasedUser`,  DROP COLUMN `z_unused_Status`,  DROP COLUMN `z_unused_PaidDate`,  DROP COLUMN `z_unused_releasedDate`,  DROP COLUMN `z_unused_EstimateUser`,  DROP COLUMN `z_unused_ActFreightCharge`,  DROP COLUMN `z_unused_PaidUser`,  DROP COLUMN `z_unused_EmailAck`,  DROP COLUMN `z_unused_EmailAckDate`,  DROP COLUMN `z_unused_EmailAckUser`,  DROP COLUMN `z_unused_EmailShipAck`,  DROP COLUMN `z_unused_EmailShipAckDate`,  DROP COLUMN `z_unused_EmailShipAckUser`,  DROP COLUMN `z_unused_FinishShop`,  DROP COLUMN `z_unused_FinishShopDate`,  DROP COLUMN `z_unused_invoicedDate`,  DROP COLUMN `z_unused_Updated`,  DROP COLUMN `z_unused_CreditCardChargeddate`,  DROP COLUMN `z_unused_UpdatedDate`,  DROP COLUMN `z_unused_UpdatedBy`,  DROP COLUMN `z_unused_cancelledDate`,  DROP COLUMN `z_unused_BackOrderID`,  DROP COLUMN `z_unused_ShippedBy_Id`,  DROP COLUMN `z_unused_PickedBy_Id`,  DROP COLUMN `z_unused_PackedBy_Id`,  DROP COLUMN `z_unused_ShipAddress`,  DROP COLUMN `z_unused_Backorder`,  DROP COLUMN `z_unused_Production`,  DROP COLUMN `z_unused_ProductName`,  DROP COLUMN `z_old_ReadytoShipDate`,  DROP COLUMN `z_unused_InvoicedBy`;
ALTER TABLE `TblOrdersBOM_Items`  DROP COLUMN `z_unused_Purchase_Price`,  DROP COLUMN `z_unused_Outsource`,  DROP COLUMN `z_unused_OutsourceDate`,  DROP COLUMN `z_unused_OutsourceInitials`,  DROP COLUMN `z_unused_outsource_EmployeeID`,  DROP COLUMN `z_unused_ReadytoShip`,  DROP COLUMN `z_unused_Status`;
ALTER TABLE `TblOrdersBOM_Shipments`  DROP COLUMN `z_unused_ShipmentImage`;
ALTER TABLE `TBLVendor`  DROP COLUMN `z_unused_Logo`;