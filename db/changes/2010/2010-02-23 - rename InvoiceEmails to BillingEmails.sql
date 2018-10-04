EXEC sp_rename '[dbo].[Customers].[InvoiceEmails]', 'BillingEmails', 'COLUMN'
GO

EXEC sp_updateextendedproperty 'MS_Description', N'The invoice from the invoicing module is sent to these emails.', 'schema', 'dbo', 'table', 'Customers', 'column', 'BillingEmails'
GO