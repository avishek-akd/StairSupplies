ALTER TABLE [dbo].[TblOrdersBOM]
ADD [InvoicedBy] varchar(50) NULL
GO


ALTER TABLE [dbo].[TblOrdersBOM_status]
ADD [invoiced_date] datetime NULL
GO
ALTER TABLE [dbo].[TblOrdersBOM_status]
ADD [invoiced_UserId] int NULL
GO
ALTER TABLE [dbo].[TblOrdersBOM_status]
ADD [invoiced_UserLastName] varchar(50) NULL
GO