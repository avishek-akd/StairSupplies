ALTER TABLE [dbo].[TblOrdersBOM_Shipments]
ADD [signature_file] varchar(100) NULL
GO
EXEC sp_addextendedproperty 'MS_Description', N'File name for the customer signature.', 'schema', 'dbo', 'table', 'TblOrdersBOM_Shipments', 'column', 'signature_file'
GO
ALTER TABLE [dbo].[TblOrdersBOM_Shipments]
ADD [signature_date] datetime NULL
GO
EXEC sp_addextendedproperty 'MS_Description', N'Date/time when the signature was taken', 'schema', 'dbo', 'table', 'TblOrdersBOM_Shipments', 'column', 'signature_date'
GO
ALTER TABLE [dbo].[TblOrdersBOM_Shipments]
ADD [delivered] bit NULL
GO
EXEC sp_addextendedproperty 'MS_Description', N'=1 if the shipment was delivered, =0 otherwise. This is used for the iPhone application to avoid displaying shipments that are delivered.', 'schema', 'dbo', 'table', 'TblOrdersBOM_Shipments', 'column', 'delivered'
GO
update TblOrdersBOM_Shipments
set delivered = 1
GO
ALTER TABLE [dbo].[TblOrdersBOM_Shipments]
ADD DEFAULT 0 FOR [delivered]
GO
ALTER TABLE [dbo].[TblOrdersBOM_Shipments]
DROP CONSTRAINT [DF__TblOrders__deliv__5CCCA98A]
GO
ALTER TABLE [dbo].[TblOrdersBOM_Shipments]
ALTER COLUMN [delivered] bit NOT NULL
GO
ALTER TABLE [dbo].[TblOrdersBOM_Shipments]
ADD CONSTRAINT [DF__TblOrders__deliv__5CCCA98A] DEFAULT 0 FOR [delivered]
GO