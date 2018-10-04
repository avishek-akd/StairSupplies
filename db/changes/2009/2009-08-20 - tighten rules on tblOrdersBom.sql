CREATE NONCLUSTERED INDEX [TblOrdersBOM_idx] ON [dbo].[TblOrdersBOM]
  ([CustomerService_id])
WITH (
  PAD_INDEX = OFF,
  DROP_EXISTING = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  SORT_IN_TEMPDB = OFF,
  ONLINE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
GO
CREATE NONCLUSTERED INDEX [TblOrdersBOM_idx2] ON [dbo].[TblOrdersBOM]
  ([SalesMan_Id])
WITH (
  PAD_INDEX = OFF,
  DROP_EXISTING = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  SORT_IN_TEMPDB = OFF,
  ONLINE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
GO


update tblOrdersBOM
set salesman_id = null
where salesman_id = 0 or salesman_id not in (select employeeid from employees);
ALTER TABLE [dbo].[TblOrdersBOM]
ADD CONSTRAINT [TblOrdersBOM_fk] FOREIGN KEY ([SalesMan_Id]) 
  REFERENCES [dbo].[Employees] ([EmployeeID]) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
GO
ALTER TABLE [dbo].[TblOrdersBOM]
DROP CONSTRAINT [DF_TblOrdersBOM_SalesMan_Id_1]
GO


update tblOrdersBOM
set customerService_id = null
where customerService_id = 0 or customerService_id not in (select employeeid from employees);
ALTER TABLE [dbo].[TblOrdersBOM]
ADD CONSTRAINT [TblOrdersBOM_fk2] FOREIGN KEY ([CustomerService_id]) 
  REFERENCES [dbo].[Employees] ([EmployeeID]) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
GO
ALTER TABLE [dbo].[TblOrdersBOM]
DROP CONSTRAINT [DF_TblOrdersBOM_CustomerService_id]
GO


update tblOrdersBOM
set employeeID = null
where employeeID = 0 or employeeID not in (select employeeid from employees);
ALTER TABLE [dbo].[TblOrdersBOM]
ADD CONSTRAINT [TblOrdersBOM_fk3] FOREIGN KEY ([EmployeeID]) 
  REFERENCES [dbo].[Employees] ([EmployeeID]) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
GO


update tblOrdersBOM
set shippingMethodID = null
where shippingMethodID = 0
GO
ALTER TABLE [dbo].[TblOrdersBOM]
ADD CONSTRAINT [TblOrdersBOM_fk4] FOREIGN KEY ([ShippingMethodID]) 
  REFERENCES [dbo].[Shipping_Methods] ([ShippingMethodID]) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
GO


update tblOrdersBOM
set EmployeeIDReportedReadyToShip = null
where EmployeeIDReportedReadyToShip = 0 or EmployeeIDReportedReadyToShip not in (select employeeid from employees)
GO
ALTER TABLE [dbo].[TblOrdersBOM]
ADD CONSTRAINT [TblOrdersBOM_fk5] FOREIGN KEY ([EmployeeIDReportedReadyToShip]) 
  REFERENCES [dbo].[Employees] ([EmployeeID]) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
GO


update tblOrdersBOM_status
set orderid = null
where orderid = 0 or orderid not in (select orderid from tblOrdersBOM);


EXEC sp_rename '[dbo].[TblOrdersBOM].[OpenTicket1]', 'z_unused_OpenTicket1', 'COLUMN'
GO
EXEC sp_rename '[dbo].[TblOrdersBOM].[CloseTicket1]', 'z_unused_CloseTicket1', 'COLUMN'
GO
EXEC sp_rename '[dbo].[TblOrdersBOM].[OpenTicket2]', 'z_unused_OpenTicket2', 'COLUMN'
GO
EXEC sp_rename '[dbo].[TblOrdersBOM].[CloseTicket2]', 'z_unused_CloseTicket2', 'COLUMN'
GO
EXEC sp_rename '[dbo].[TblOrdersBOM].[OpenTicket3]', 'z_unused_OpenTicket3', 'COLUMN'
GO
EXEC sp_rename '[dbo].[TblOrdersBOM].[CloseTicket3]', 'z_unused_CloseTicket3', 'COLUMN'
GO
EXEC sp_rename '[dbo].[TblOrdersBOM].[OpenTicket4]', 'z_unused_OpenTicket4', 'COLUMN'
GO
EXEC sp_rename '[dbo].[TblOrdersBOM].[CloseTicket4]', 'z_unused_CloseTicket4', 'COLUMN'
GO
EXEC sp_rename '[dbo].[TblOrdersBOM].[OpenTicket5]', 'z_unused_OpenTicket5', 'COLUMN'
GO
EXEC sp_rename '[dbo].[TblOrdersBOM].[CloseTicket5]', 'z_unused_CloseTicket5', 'COLUMN'
GO
EXEC sp_rename '[dbo].[TblOrdersBOM].[OpenTicket6]', 'z_unused_OpenTicket6', 'COLUMN'
GO
EXEC sp_rename '[dbo].[TblOrdersBOM].[CloseTicket6]', 'z_unused_CloseTicket6', 'COLUMN'
GO
EXEC sp_rename '[dbo].[TblOrdersBOM].[ProductionDate Original]', 'z_unused_ProductionDate Original', 'COLUMN'
GO
EXEC sp_rename '[dbo].[TblOrdersBOM].[CostCode]', 'z_unused_CostCode', 'COLUMN'
GO
EXEC sp_rename '[dbo].[TblOrdersBOM].[OrderIssues]', 'z_unused_OrderIssues', 'COLUMN'
GO
EXEC sp_rename '[dbo].[TblOrdersBOM].[isRMA]', 'z_unused_isRMA', 'COLUMN'
GO
EXEC sp_rename '[dbo].[TblOrdersBOM].[OldQuoteID]', 'z_unused_OldQuoteID', 'COLUMN'
GO
EXEC sp_rename '[dbo].[TblOrdersBOM].[OriginalOrderID]', 'z_unused_OriginalOrderID', 'COLUMN'
GO
EXEC sp_rename '[dbo].[TblOrdersBOM].[acctmemo]', 'z_unused_acctmemo', 'COLUMN'
GO
EXEC sp_rename '[dbo].[TblOrdersBOM].[Open Issues]', 'z_unused_Open Issues', 'COLUMN'
GO
EXEC sp_rename '[dbo].[TblOrdersBOM].[LegalreadDate]', 'z_unused_LegalreadDate', 'COLUMN'
GO
EXEC sp_rename '[dbo].[TblOrdersBOM].[Legalread]', 'z_unused_Legalread', 'COLUMN'
GO
EXEC sp_rename '[dbo].[TblOrdersBOM].[trackingnum]', 'z_unused_trackingnum', 'COLUMN'
GO
EXEC sp_rename '[dbo].[TblOrdersBOM].[hardware_type]', 'z_unused_hardware_type', 'COLUMN'
GO
EXEC sp_rename '[dbo].[TblOrdersBOM].[OnOrder]', 'z_unused_OnOrder', 'COLUMN'
GO
EXEC sp_rename '[dbo].[TblOrdersBOM].[OnOrderDate]', 'z_unused_OnOrderDate', 'COLUMN'
GO

EXEC sp_rename '[dbo].[TblOrdersBOM].[POCreated]', 'z_unused_POCreated', 'COLUMN'
GO
EXEC sp_rename '[dbo].[TblOrdersBOM].[POCreatedDate]', 'z_unused_POCreatedDate', 'COLUMN'
GO
EXEC sp_rename '[dbo].[TblOrdersBOM].[MFGPOCreated]', 'z_unused_MFGPOCreated', 'COLUMN'
GO
EXEC sp_rename '[dbo].[TblOrdersBOM].[MFGPOCreatedDate]', 'z_unused_MFGPOCreatedDate', 'COLUMN'
GO

EXEC sp_rename '[dbo].[TblOrdersBOM].[WaitingForProduct]', 'z_unused_WaitingForProduct', 'COLUMN'
GO
EXEC sp_rename '[dbo].[TblOrdersBOM].[WaitingForProductDate]', 'z_unused_WaitingForProductDate', 'COLUMN'
GO
EXEC sp_rename '[dbo].[TblOrdersBOM].[WaitingForProductUser]', 'z_unused_MWaitingForProductUser', 'COLUMN'
GO

EXEC sp_rename '[dbo].[TblOrdersBOM].[PurchasingCheck]', 'z_unused_PurchasingCheck', 'COLUMN'
GO
EXEC sp_rename '[dbo].[TblOrdersBOM].[PurchasingCheckDate]', 'z_unused_PurchasingCheckDate', 'COLUMN'
GO
EXEC sp_rename '[dbo].[TblOrdersBOM].[PurchasingCheckUser]', 'z_unused_PurchasingCheckUser', 'COLUMN'
GO


EXEC sp_rename '[dbo].[TblOrdersBOM].[InventoryCheck]', 'z_unused_PInventoryCheck', 'COLUMN'
GO
EXEC sp_rename '[dbo].[TblOrdersBOM].[InventoryCheckDate]', 'z_unused_InventoryCheckDate', 'COLUMN'
GO
EXEC sp_rename '[dbo].[TblOrdersBOM].[InventoryCheckUser]', 'z_unused_InventoryCheckUser', 'COLUMN'
GO



-- 
-- Change the type of orderID from numeric(10,0) to Int
-- 
ALTER TABLE [dbo].[TblOrdersBOM_Items]
DROP CONSTRAINT [FK_TblOrdersBOM_Items_TblOrdersBOM]
GO
ALTER TABLE [dbo].[TblOrdersBOM_Items_temp]
DROP CONSTRAINT [FK_TblOrdersBOM_Items_temp_TblOrdersBOM]
GO
ALTER TABLE [dbo].[tblOrdersBOM_Update]
DROP CONSTRAINT [tblOrdersBOM_Update_fk]
GO
ALTER TABLE [dbo].[TblOrdersBOMmemos]
DROP CONSTRAINT [FK_TblOrdersBOMmemos_TblOrdersBOM]
GO


ALTER TABLE [dbo].[TblOrdersBOM]
DROP CONSTRAINT [PK_OrdersBOM]
GO
DROP INDEX [TblOrdersBOM23] ON [dbo].[TblOrdersBOM]
GO
ALTER TABLE [dbo].[TblOrdersBOM]
ALTER COLUMN [OrderID] int NOT NULL
GO
ALTER TABLE [dbo].[TblOrdersBOM]
ADD CONSTRAINT [PK_OrdersBOM] 
PRIMARY KEY NONCLUSTERED ([OrderID])
WITH (
  PAD_INDEX = OFF,
  FILLFACTOR = 90,
  IGNORE_DUP_KEY = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [TblOrdersBOM23] ON [dbo].[TblOrdersBOM]
  ([OrderID], [ShipCompanyName], [ShipContactFirstName], [ShipAddress1], [ShipAddress2], [ShipAddress3], [ShipCity], [ShipState], [ShipPostalCode], [PhoneNumber], [FaxNumber], [Email])
WITH (
  PAD_INDEX = OFF,
  DROP_EXISTING = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  SORT_IN_TEMPDB = OFF,
  ONLINE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO


DROP INDEX [IX_OrderID] ON [dbo].[TblOrdersBOM_Items]
GO
DROP INDEX [TblOrdersBOM_Items19] ON [dbo].[TblOrdersBOM_Items]
GO
DROP INDEX [TblOrdersBOM_Items49] ON [dbo].[TblOrdersBOM_Items]
GO
ALTER TABLE [dbo].[TblOrdersBOM_Items]
ALTER COLUMN [OrderID] int
GO
CREATE NONCLUSTERED INDEX [IX_OrderID] ON [dbo].[TblOrdersBOM_Items]
  ([OrderID])
WITH (
  PAD_INDEX = OFF,
  FILLFACTOR = 90,
  DROP_EXISTING = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  SORT_IN_TEMPDB = OFF,
  ONLINE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [TblOrdersBOM_Items19] ON [dbo].[TblOrdersBOM_Items]
  ([OrderID], [OrderItemsID], [Quantity], [QuantityShipped], [Unit_of_Measure], [Special_Instructions], [ProductName], [Product_Descripton])
WITH (
  PAD_INDEX = OFF,
  DROP_EXISTING = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  SORT_IN_TEMPDB = OFF,
  ONLINE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [TblOrdersBOM_Items49] ON [dbo].[TblOrdersBOM_Items]
  ([OrderItemsID], [OrderID], [Quantity])
WITH (
  PAD_INDEX = OFF,
  DROP_EXISTING = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  SORT_IN_TEMPDB = OFF,
  ONLINE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO
ALTER TABLE [dbo].[TblOrdersBOM_Items]
ADD CONSTRAINT [TblOrdersBOM_Items_fk] FOREIGN KEY ([OrderID]) 
  REFERENCES [dbo].[TblOrdersBOM] ([OrderID]) 
  ON UPDATE NO ACTION
  ON DELETE CASCADE
GO

ALTER TABLE [dbo].[TblOrdersBOM_Items_temp]
ALTER COLUMN [OrderID] int
GO
ALTER TABLE [dbo].[TblOrdersBOM_Items_temp]
ADD CONSTRAINT [TblOrdersBOM_Items_temp_fk] FOREIGN KEY ([OrderID]) 
  REFERENCES [dbo].[TblOrdersBOM] ([OrderID]) 
  ON UPDATE NO ACTION
  ON DELETE CASCADE
GO


DROP INDEX [tblOrdersBOM_Update_idx] ON [dbo].[tblOrdersBOM_Update]
GO
ALTER TABLE [dbo].[tblOrdersBOM_Update]
ALTER COLUMN [orderID] int
GO
CREATE NONCLUSTERED INDEX [tblOrdersBOM_Update_idx] ON [dbo].[tblOrdersBOM_Update]
  ([orderID])
WITH (
  PAD_INDEX = OFF,
  DROP_EXISTING = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  SORT_IN_TEMPDB = OFF,
  ONLINE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblOrdersBOM_Update]
ADD CONSTRAINT [tblOrdersBOM_Update_fk] FOREIGN KEY ([orderID]) 
  REFERENCES [dbo].[TblOrdersBOM] ([OrderID]) 
  ON UPDATE NO ACTION
  ON DELETE CASCADE
GO


DROP INDEX [TblOrdersBOMmemos28] ON [dbo].[TblOrdersBOMmemos]
GO
ALTER TABLE [dbo].[TblOrdersBOMmemos]
ALTER COLUMN [OrderID] int NOT NULL
GO
CREATE NONCLUSTERED INDEX [TblOrdersBOMmemos28] ON [dbo].[TblOrdersBOMmemos]
  ([OrderMemoID], [OrderID])
WITH (
  PAD_INDEX = OFF,
  DROP_EXISTING = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  SORT_IN_TEMPDB = OFF,
  ONLINE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO
ALTER TABLE [dbo].[TblOrdersBOMmemos]
ADD CONSTRAINT [TblOrdersBOMmemos_fk] FOREIGN KEY ([OrderID]) 
  REFERENCES [dbo].[TblOrdersBOM] ([OrderID]) 
  ON UPDATE NO ACTION
  ON DELETE CASCADE
GO



ALTER TABLE [dbo].[TblOrdersBOM_status]
ADD CONSTRAINT [TblOrdersBOM_status_fk] FOREIGN KEY ([orderid]) 
  REFERENCES [dbo].[TblOrdersBOM] ([OrderID]) 
  ON UPDATE NO ACTION
  ON DELETE CASCADE
GO
CREATE NONCLUSTERED INDEX [TblOrdersBOM_status_idx] ON [dbo].[TblOrdersBOM_status]
  ([orderid])
WITH (
  PAD_INDEX = OFF,
  DROP_EXISTING = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  SORT_IN_TEMPDB = OFF,
  ONLINE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
GO