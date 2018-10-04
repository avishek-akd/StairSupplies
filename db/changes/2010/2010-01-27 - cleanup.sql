EXEC sp_rename '[dbo].[Products_temp]', 'z_unused_Products_temp', 'OBJECT'
GO
EXEC sp_rename '[dbo].[TblStateTax].[servicetax]', 'z_unused_servicetax', 'COLUMN'
GO
EXEC sp_rename '[dbo].[TblStateTax].[salestax]', 'SalesTax', 'COLUMN'
GO
ALTER TABLE [dbo].[TblStateTax]
ALTER COLUMN [SalesTax] decimal(10, 4) NOT NULL
GO
ALTER TABLE [dbo].[TblStateTax]
DROP CONSTRAINT [PK_TblStateTax]
GO
ALTER TABLE [dbo].[TblStateTax]
DROP COLUMN [StateTaxID]
GO
ALTER TABLE [dbo].[TblStateTax]
ADD CONSTRAINT [TblStateTax_pk] PRIMARY KEY ([State])
GO
ALTER TABLE [dbo].[TblState]
ADD [SalesTax] decimal(10, 4) NULL
GO
update TblState
set SalesTax = 0
GO
EXEC sp_rename '[dbo].[TblStateTax]', 'z_unused_TblStateTax', 'OBJECT'
GO
ALTER TABLE [dbo].[TblOrdersBOM]
DROP CONSTRAINT [DF_TblOrdersBOM_SalesTaxRate]
GO
ALTER TABLE [dbo].[TblOrdersBOM]
ALTER COLUMN [SalesTaxRate] decimal(10, 4)
GO
ALTER TABLE [dbo].[TblOrdersBOM]
ADD CONSTRAINT [DF_TblOrdersBOM_SalesTaxRate] DEFAULT 0 FOR [SalesTaxRate]
GO
ALTER TABLE [dbo].[TblOrdersBOM_ShipmentsItems]
ALTER COLUMN [QuantityShipped] decimal(10, 2) NOT NULL
GO
ALTER TABLE [dbo].[Products]
DROP CONSTRAINT [DF_Products_Weight_Per_Piece]
GO
ALTER TABLE [dbo].[Products]
ALTER COLUMN [UnitWeight] decimal(10, 2) NOT NULL
GO
ALTER TABLE [dbo].[Products]
ADD CONSTRAINT [DF_Products_Weight_Per_Piece] DEFAULT 0 FOR [UnitWeight]
GO
ALTER TABLE [dbo].[TblOrdersBOM]
DROP CONSTRAINT [DF_TblOrdersBOM_OrderWeight]
GO
ALTER TABLE [dbo].[TblOrdersBOM]
ALTER COLUMN [OrderWeight] decimal(10, 2)
GO
ALTER TABLE [dbo].[TblOrdersBOM]
ADD CONSTRAINT [DF_TblOrdersBOM_OrderWeight] DEFAULT 0 FOR [OrderWeight]
GO
EXEC sp_rename '[dbo].[TblOrdersBOM_Details]', 'z_unused_TblOrdersBOM_Details', 'OBJECT'
GO
EXEC sp_rename '[dbo].[tblOrdersBOM_Update]', 'TblOrdersBOM_Update', 'OBJECT'
GO
EXEC sp_rename '[dbo].[tblOrdersBOM_UpdateDetails]', 'TblOrdersBOM_UpdateDetails', 'OBJECT'
GO
EXEC sp_rename '[dbo].[tblProductTypeInclude]', 'TblProductTypeInclude', 'OBJECT'
GO
EXEC sp_rename '[dbo].[Tblordersbom_exceptions]', 'TblOrdersBOM_Exceptions', 'OBJECT'
GO
UPDATE tblOrdersBOM SET SalesTaxRate = 0 WHERE SalesTaxRate IS NULL
GO
EXEC sp_addextendedproperty 'MS_Description', N'The sales tax is a number smaller then 1 (for example 0.05 for 5% tax, 0.0261 for 2.61%).', 'schema', 'dbo', 'table', 'TblState', 'column', 'SalesTax'
GO


UPDATE Customers
SET email = NULL
WHERE email = 'none@none.com'
GO
UPDATE Customers
SET email = NULL
WHERE email = 'none'
GO
UPDATE Customers
SET email = NULL
WHERE email like '%@none.com'
GO
UPDATE Customers
SET email = NULL
WHERE email = 'none right now' or email = 'none at this time' or email = 'none@none.co'
GO



EXEC sp_rename '[dbo].[TblOrdersBOM].[BackOrderCreated]', 'z_unused_BackOrderCreated', 'COLUMN'
GO