DROP INDEX [dbo].[Products].[IX_Product_Descripton]
GO

ALTER TABLE [dbo].[Products]
ALTER COLUMN [Product_Descripton] nvarchar(500) COLLATE SQL_Latin1_General_CP1_CI_AS
GO

CREATE NONCLUSTERED INDEX [IX_Product_Descripton] ON [dbo].[Products]
  ([Product_Descripton])
WITH
  FILLFACTOR = 90
ON [PRIMARY]
GO
ALTER TABLE [dbo].[Products_temp]
ALTER COLUMN [Product_Descripton] nvarchar(500) COLLATE SQL_Latin1_General_CP1_CI_AS
GO




DROP INDEX [dbo].[TblOrdersBOM_Items].[TblOrdersBOM_Items19]
GO

ALTER TABLE [dbo].[TblOrdersBOM_Items]
ALTER COLUMN [Product_Descripton] varchar(500) COLLATE SQL_Latin1_General_CP1_CI_AS
GO

CREATE NONCLUSTERED INDEX [TblOrdersBOM_Items19] ON [dbo].[TblOrdersBOM_Items]
  ([OrderID], [OrderItemsID], [Quantity], [QuantityShipped], [Unit_of_Measure], [Special_Instructions], [ProductName], [Product_Descripton])
ON [PRIMARY]
GO

ALTER TABLE [dbo].[TblOrdersBOM_Items_temp]
ALTER COLUMN [Product_Descripton] varchar(500) COLLATE SQL_Latin1_General_CP1_CI_AS
GO