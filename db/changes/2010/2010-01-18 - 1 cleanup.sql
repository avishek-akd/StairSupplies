
--
-- View used for the shipping software WorldShip. Notes:
--  * WorldShip software formats OrderID as a number (15000 becomes 15,000.00)
--  * Assume the service type is UPS Ground (GND)
--
ALTER VIEW dbo.View_BOMOrders
AS
SELECT     Cast(dbo.TblOrdersBOM.OrderID AS VARCHAR) AS OrderID,
           'GND' AS ServiceType,
           ShipContactFirstName + ' ' + ShipContactLastName AS ATTN, ShipName, ShipAddress, ShipPhoneNumber, ShipAddress1, ShipAddress2,
                      ShipAddress3, ShipAddress4, CustomerID, EmployeeID, TblOrdersBOM.ShippingMethodID, OrderDate, Job_Name, OrderTotal, FreightCharge,
                      ActFreightCharge, SalesTaxRate, Status, Notes, In_House_Notes, Duedate, DateCreated, DateUpdated, PONumber, Terms, BackOrderCreated, 
                      Paid, PaidDate, PaidUser, Estimate, EstimateDate, EstimateUser, Ordered, OrderedDate, OrderedUser, Archived, ArchivedDate, 
                      Released, ReleasedDate, ReleasedUser, ReadytoShip, ReadytoShipDate, ReadytoShipUser, 
                      CustomerAcknowledgement, CustomerAcknowledgementDate, ProductionDate, EmailAck, 
                      EmailAckDate, EmailAckUser, EmailShipAck, EmailShipAckDate, EmailShipAckUser, FinishShop, FinishShopDate,
                      Invoiced, InvoicedDate, Updated, UpdatedDate, UpdatedBy, statustext, ShippingDirections, 
                      OrderWeight, color, [timestamp], CreditCardCharged, CreditCardChargeddate, Cancelled, CancelledDate, 
                      BackOrderID, ShippedBy_Id, SalesMan_Id, CustomerService_id, ShipCompanyName, 
                      ShipContactFirstName, ShipContactLastName, ShipCity, ShipState, ShipPostalCode, BillCompanyName, BillContactFirstName, BillContactLastName, 
                      BillAddress1, BillAddress2, BillAddress3, BillAddress4, BillCity, BillState, BillPostalCode, PhoneNumber, FaxNumber, CellPhone, Email,
                      Backorder
FROM         dbo.TblOrdersBOM
       LEFT JOIN Shipping_Methods ON Shipping_Methods.ShippingMethodID = TblOrdersBOM.ShippingMethodID
GO



DROP PROCEDURE [dbo].[sp_get_customerInfo]
GO
DROP PROCEDURE [dbo].[sp_status_shipping_add]
GO
DROP PROCEDURE [dbo].[sp_status_shipping_edit]
GO
DROP PROCEDURE [dbo].[sp_select_special_product]
GO
DROP PROCEDURE [dbo].[sp_select_product]
GO
DROP TABLE [dbo].[ProductPrice_bk_before_1_price_per_product]
GO
EXEC sp_rename '[dbo].[TblOrdersBOM].[dropship]', 'z_unused_dropship', 'COLUMN'
GO
EXEC sp_rename '[dbo].[TblOrdersBOM_Details].[dropship]', 'z_unused_dropship', 'COLUMN'
GO
EXEC sp_rename '[dbo].[TblOrdersBOM_Items_fixed]', 'z_unused_TblOrdersBOM_Items_fixed', 'OBJECT'
GO
EXEC sp_rename '[dbo].[TblOrdersBOM].[ShipDate]', 'z_unused_ShipDate', 'COLUMN'
GO
EXEC sp_rename '[dbo].[TblOrdersBOM_Items_temp]', 'z_unused_TblOrdersBOM_Items_temp', 'OBJECT'
GO
EXEC sp_rename '[dbo].[TblOrdersBOM_temp]', 'z_unused_TblOrdersBOM_temp', 'OBJECT'
GO

EXEC sp_rename '[dbo].[TblOrdersBOM_OrderShipments]', 'TblOrdersBOM_Shipments', 'OBJECT'
GO
EXEC sp_rename '[dbo].[TblOrdersBOM_OrderShipmentsDetails]', 'TblOrdersBOM_ShipmentsItems', 'OBJECT'
GO
EXEC sp_rename '[dbo].[TblOrdersBOM_Shipments].[PickedBy_Id]', 'z_unused_PickedBy_Id', 'COLUMN'
GO
EXEC sp_rename '[dbo].[TblOrdersBOM_Shipments].[PackedBy_Id]', 'z_unused_PackedBy_Id', 'COLUMN'
GO



-- 
--  ShippedBy_id in TblOrdersBOM_Shipments
--
update TblOrdersBOM_Shipments set ShippedBy_id = NULL
where ShippedBy_id not in (select employeeID from Employees)
GO
ALTER TABLE [dbo].[TblOrdersBOM_Shipments]
DROP CONSTRAINT [DF_TblOrdersBOM_OrderShipments_ShippedBy_Id]
GO
ALTER TABLE [dbo].[TblOrdersBOM_Shipments]
ADD CONSTRAINT [TblOrdersBOM_Shipments_fk] FOREIGN KEY ([ShippedBy_Id]) 
  REFERENCES [dbo].[Employees] ([EmployeeID]) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
GO
CREATE NONCLUSTERED INDEX [TblOrdersBOM_Shipments_idx] ON [dbo].[TblOrdersBOM_Shipments]
  ([ShippedBy_Id])
WITH (
  PAD_INDEX = OFF,
  DROP_EXISTING = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  SORT_IN_TEMPDB = OFF,
  ONLINE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
GO






ALTER TABLE [dbo].[TblOrdersBOM_ShipmentsItems]
ALTER COLUMN [OrderShipment_id] int NOT NULL
;
DELETE 
from TblOrdersBOM_ShipmentsItems
where OrderShipment_id not in (select OrderShipment_id from TblOrdersBOM_Shipments)
;
ALTER TABLE [dbo].[TblOrdersBOM_ShipmentsItems]
ADD CONSTRAINT [TblOrdersBOM_ShipmentsItems_fk] FOREIGN KEY ([OrderShipment_id]) 
  REFERENCES [dbo].[TblOrdersBOM_Shipments] ([OrderShipment_id]) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
;
CREATE NONCLUSTERED INDEX [TblOrdersBOM_ShipmentsItems_idx] ON [dbo].[TblOrdersBOM_ShipmentsItems]
  ([OrderShipment_id])
WITH (
  PAD_INDEX = OFF,
  DROP_EXISTING = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  SORT_IN_TEMPDB = OFF,
  ONLINE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
;
DELETE 
from TblOrdersBOM_ShipmentsItems
where OrderItemsID not in (select OrderItemsID from TblOrdersBOM_Items)
;
ALTER TABLE [dbo].[TblOrdersBOM_ShipmentsItems]
ADD CONSTRAINT [TblOrdersBOM_ShipmentsItems_fk2] FOREIGN KEY ([OrderItemsID]) 
  REFERENCES [dbo].[TblOrdersBOM_Items] ([OrderItemsID]) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
;
CREATE NONCLUSTERED INDEX [TblOrdersBOM_ShipmentsItems_idx2] ON [dbo].[TblOrdersBOM_ShipmentsItems]
  ([OrderItemsID])
WITH (
  PAD_INDEX = OFF,
  DROP_EXISTING = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  SORT_IN_TEMPDB = OFF,
  ONLINE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
 ;
ALTER TABLE [dbo].[TblOrdersBOM_ShipmentsItems]
DROP CONSTRAINT [PK_TblOrdersBOM_OrderShipmentsDetails]
GO
ALTER TABLE [dbo].[TblOrdersBOM_ShipmentsItems]
ALTER COLUMN [OrderShipmentDetails_ID] int NOT NULL
GO
ALTER TABLE [dbo].[TblOrdersBOM_ShipmentsItems]
ADD CONSTRAINT [PK_TblOrdersBOM_OrderShipmentsDetails] 
PRIMARY KEY CLUSTERED ([OrderShipmentDetails_ID])
WITH (
  PAD_INDEX = OFF,
  IGNORE_DUP_KEY = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO
ALTER TABLE [dbo].[TblOrdersBOM_ShipmentsItems]
DROP CONSTRAINT [DF_TblOrdersBOM_OrderShipmentsDetails_OrderItemsID]
GO
ALTER TABLE [dbo].[TblOrdersBOM_ShipmentsItems]
DROP CONSTRAINT [DF_TblOrdersBOM_OrderShipmentsDetails_QuantityShipped]
GO