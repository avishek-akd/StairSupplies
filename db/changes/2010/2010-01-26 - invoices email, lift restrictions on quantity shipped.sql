 -- 
 -- add invoice emails to customer
 -- 
ALTER TABLE [dbo].[Customers]
ADD [InvoiceEmails] varchar(255) NULL
GO
EXEC sp_addextendedproperty 'MS_Description', N'The invoice from the invoicing module ise sent to this emails.', 'schema', 'dbo', 'table', 'Customers', 'column', 'InvoiceEmails'
GO
update customers
set InvoiceEmails = email
GO



-- 
-- Increase the accuracy of the fields because we need better accuracy than 1 minute 
-- 
ALTER TABLE [dbo].[TblOrdersBOM_Shipments]
DROP CONSTRAINT [DF_TblOrdersBOM_OrderShipments_DateAdded]
GO
ALTER TABLE [dbo].[TblOrdersBOM_Shipments]
ALTER COLUMN [DateAdded] datetime
GO
ALTER TABLE [dbo].[TblOrdersBOM_Shipments]
ADD CONSTRAINT [DF_TblOrdersBOM_OrderShipments_DateAdded] DEFAULT convert(datetime,convert(varchar,getdate())) FOR [DateAdded]
GO
EXEC sp_addextendedproperty 'MS_Description', N'We need datetime instead of smalldatetime because we prevent duplicate shipments by not allowing 2 shipments to be created for the same order less than 1 minute apart (smalldatetime has 1 minute accuracy).', 'schema', 'dbo', 'table', 'TblOrdersBOM_Shipments', 'column', 'DateAdded'
GO
ALTER TABLE [dbo].[TblOrdersBOM_Shipments]
DROP CONSTRAINT [DF_TblOrdersBOM_OrderShipments_DateUpdated]
GO
ALTER TABLE [dbo].[TblOrdersBOM_Shipments]
ALTER COLUMN [DateUpdated] datetime
GO
ALTER TABLE [dbo].[TblOrdersBOM_Shipments]
ADD CONSTRAINT [DF_TblOrdersBOM_OrderShipments_DateUpdated] DEFAULT convert(datetime,convert(varchar,getdate())) FOR [DateUpdated]
GO
ALTER TABLE [dbo].[TblOrdersBOM_Shipments]
DROP CONSTRAINT [DF_TblOrdersBOM_OrderShipments_DateAdded]
GO
ALTER TABLE [dbo].[TblOrdersBOM_Shipments]
ADD CONSTRAINT [DF_TblOrdersBOM_OrderShipments_DateAdded] DEFAULT getdate() FOR [DateAdded]
GO
ALTER TABLE [dbo].[TblOrdersBOM_Shipments]
DROP CONSTRAINT [DF_TblOrdersBOM_OrderShipments_DateUpdated]
GO
ALTER TABLE [dbo].[TblOrdersBOM_Shipments]
ADD CONSTRAINT [DF_TblOrdersBOM_OrderShipments_DateUpdated] DEFAULT getdate() FOR [DateUpdated]
GO