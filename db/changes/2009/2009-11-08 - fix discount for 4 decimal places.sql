ALTER TABLE [dbo].[TblOrdersBOM_Items]
DROP CONSTRAINT [DF_TblOrdersBOM_Items_Discount]
GO

ALTER TABLE [dbo].[TblOrdersBOM_Items]
ALTER COLUMN [Discount] numeric(10, 4)
GO

ALTER TABLE [dbo].[TblOrdersBOM_Items]
ADD CONSTRAINT [DF_TblOrdersBOM_Items_Discount] DEFAULT 0 FOR [Discount]
GO


ALTER TABLE [dbo].[TblOrdersBOM_Details]
DROP CONSTRAINT [DF_TblOrdersBOM_Details_Discount]
GO

ALTER TABLE [dbo].[TblOrdersBOM_Details]
ALTER COLUMN [Discount] numeric(10, 4)
GO

ALTER TABLE [dbo].[TblOrdersBOM_Details]
ADD CONSTRAINT [DF_TblOrdersBOM_Details_Discount] DEFAULT 0 FOR [Discount]
GO
