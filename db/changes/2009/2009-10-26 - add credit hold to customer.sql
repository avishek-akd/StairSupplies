ALTER TABLE [dbo].[Customers]
ADD [CreditHold] bit DEFAULT 0 NULL
GO

EXEC sp_addextendedproperty 'MS_Description', N'If this is true then the sales department needs to be contacted before shipping or doing production work for this customer.', 'schema', 'dbo', 'table', 'Customers', 'column', 'CreditHold'
GO

UPDATE Customers SET CreditHold = 0
GO