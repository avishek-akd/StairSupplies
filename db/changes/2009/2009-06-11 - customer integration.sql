ALTER TABLE [dbo].[Customers]
ADD [FrontEndCustomerID] int NULL
GO

EXEC sp_addextendedproperty 'MS_Description', N'Customer ID in the front end part of the site (www.stairsupplies.com). We receive this ID via the integration script and need to store it for future requests.', 'user', 'dbo', 'table', 'Customers', 'column', 'FrontEndCustomerID'
GO