ALTER TABLE [dbo].[TblOrdersBOM]
ADD [CustomerAcknowledgementSignature] varchar(100) NULL
GO

EXEC sp_addextendedproperty 'MS_Description', N'File name containing the signature for this quotation/order.', 'schema', 'dbo', 'table', 'TblOrdersBOM', 'column', 'CustomerAcknowledgementSignature'
GO