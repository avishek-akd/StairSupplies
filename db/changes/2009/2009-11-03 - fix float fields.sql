ALTER TABLE [dbo].[TblOrdersBOM_Items]
DROP CONSTRAINT [DF_TblOrdersBOM_Items_Quantity]
GO

DROP INDEX [TblOrdersBOM_Items19] ON [dbo].[TblOrdersBOM_Items]
GO

DROP INDEX [TblOrdersBOM_Items49] ON [dbo].[TblOrdersBOM_Items]
GO

ALTER TABLE [dbo].[TblOrdersBOM_Items]
ALTER COLUMN [Quantity] numeric(10, 2)
GO

ALTER TABLE [dbo].[TblOrdersBOM_Items]
ADD CONSTRAINT [DF_TblOrdersBOM_Items_Quantity] DEFAULT 0 FOR [Quantity]
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
DROP CONSTRAINT [DF_TblOrdersBOM_Items_QuantityShipped]
GO

DROP INDEX [TblOrdersBOM_Items19] ON [dbo].[TblOrdersBOM_Items]
GO

ALTER TABLE [dbo].[TblOrdersBOM_Items]
ALTER COLUMN [QuantityShipped] numeric(10, 2)
GO

ALTER TABLE [dbo].[TblOrdersBOM_Items]
ADD CONSTRAINT [DF_TblOrdersBOM_Items_QuantityShipped] DEFAULT 0 FOR [QuantityShipped]
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



ALTER TABLE [dbo].[TblOrdersBOM_Items]
DROP CONSTRAINT [DF_TblOrdersBOM_Items_Discount]
GO

ALTER TABLE [dbo].[TblOrdersBOM_Items]
ALTER COLUMN [Discount] numeric(10, 2)
GO

ALTER TABLE [dbo].[TblOrdersBOM_Items]
ADD CONSTRAINT [DF_TblOrdersBOM_Items_Discount] DEFAULT 0 FOR [Discount]
GO



ALTER TABLE [dbo].[TblOrdersBOM_Items]
DROP CONSTRAINT [DF_TblOrdersBOM_Items_Weight]
GO

ALTER TABLE [dbo].[TblOrdersBOM_Items]
ALTER COLUMN [UnitWeight] numeric(10, 2)
GO

ALTER TABLE [dbo].[TblOrdersBOM_Items]
ADD CONSTRAINT [DF_TblOrdersBOM_Items_Weight] DEFAULT 0 FOR [UnitWeight]
GO









ALTER TABLE [dbo].[Products]
DROP CONSTRAINT [DF_Products_Weight_Per_Piece]
GO

ALTER TABLE [dbo].[Products]
ALTER COLUMN [UnitWeight] numeric(10, 2) NOT NULL
GO

ALTER TABLE [dbo].[Products]
ADD CONSTRAINT [DF_Products_Weight_Per_Piece] DEFAULT 0 FOR [UnitWeight]
GO
ALTER TABLE [dbo].[TblOrdersBOM]
DROP CONSTRAINT [DF_TblOrdersBOM_SalesTaxRate]
GO

ALTER TABLE [dbo].[TblOrdersBOM]
ALTER COLUMN [SalesTaxRate] numeric(10, 2)
GO

ALTER TABLE [dbo].[TblOrdersBOM]
ADD CONSTRAINT [DF_TblOrdersBOM_SalesTaxRate] DEFAULT 0 FOR [SalesTaxRate]
GO
ALTER TABLE [dbo].[TblOrdersBOM]
DROP CONSTRAINT [DF_TblOrdersBOM_OrderWeight]
GO

ALTER TABLE [dbo].[TblOrdersBOM]
ALTER COLUMN [OrderWeight] numeric(10, 2)
GO

ALTER TABLE [dbo].[TblOrdersBOM]
ADD CONSTRAINT [DF_TblOrdersBOM_OrderWeight] DEFAULT 0 FOR [OrderWeight]
GO

ALTER TABLE [dbo].[TblOrdersBOM_Details]
ALTER COLUMN [Quantity] numeric(10, 2)
GO

ALTER TABLE [dbo].[TblOrdersBOM_Details]
DROP CONSTRAINT [DF_TblOrdersBOM_Details_UnitWeight]
GO

ALTER TABLE [dbo].[TblOrdersBOM_Details]
ALTER COLUMN [UnitWeight] numeric(10, 2)
GO

ALTER TABLE [dbo].[TblOrdersBOM_Details]
ADD CONSTRAINT [DF_TblOrdersBOM_Details_UnitWeight] DEFAULT 0 FOR [UnitWeight]
GO
ALTER TABLE [dbo].[TblOrdersBOM_Details]
DROP CONSTRAINT [DF_TblOrdersBOM_Details_Discount]
GO

ALTER TABLE [dbo].[TblOrdersBOM_Details]
ALTER COLUMN [Discount] numeric(10, 2)
GO

ALTER TABLE [dbo].[TblOrdersBOM_Details]
ADD CONSTRAINT [DF_TblOrdersBOM_Details_Discount] DEFAULT 0 FOR [Discount]
GO
ALTER TABLE [dbo].[TblOrdersBOM_Shipping_Details]
ALTER COLUMN [SalesTaxRate] numeric(10, 2)
GO
ALTER TABLE [dbo].[TblOrdersBOM_Shipping_Details]
ALTER COLUMN [OrderWeight] numeric(10, 2)
GO
ALTER TABLE [dbo].[TblOrdersBOM_OrderShipmentsDetails]
DROP CONSTRAINT [DF_TblOrdersBOM_OrderShipmentsDetails_QuantityShipped]
GO

ALTER TABLE [dbo].[TblOrdersBOM_OrderShipmentsDetails]
ALTER COLUMN [QuantityShipped] numeric(10, 2) NOT NULL
GO

ALTER TABLE [dbo].[TblOrdersBOM_OrderShipmentsDetails]
ADD CONSTRAINT [DF_TblOrdersBOM_OrderShipmentsDetails_QuantityShipped] DEFAULT 0 FOR [QuantityShipped]
GO
ALTER TABLE [dbo].[TblOrdersBOM_Shipping]
ALTER COLUMN [SalesTaxRate] numeric(10, 2)
GO
ALTER TABLE [dbo].[TblOrdersBOM_Shipping]
ALTER COLUMN [OrderWeight] numeric(10, 2)
GO