ALTER TABLE [dbo].[Customers]
ALTER COLUMN [YTD_Sales] numeric(10, 2)
GO
ALTER TABLE [dbo].[Customers]
ALTER COLUMN [Last_years_Sales] numeric(10, 2)
GO
ALTER TABLE [dbo].[Customers]
ALTER COLUMN [SalesPerson] int
GO


UPDATE customers 
set salesPerson = null
where salesPerson not in (select employeeID from Employees)
GO
ALTER TABLE [dbo].[Customers]
ADD CONSTRAINT [Customers_fk] FOREIGN KEY ([SalesPerson]) 
  REFERENCES [dbo].[Employees] ([EmployeeID]) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
GO
CREATE NONCLUSTERED INDEX [Customers_idx] ON [dbo].[Customers]
  ([SalesPerson])
WITH (
  PAD_INDEX = OFF,
  DROP_EXISTING = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  SORT_IN_TEMPDB = OFF,
  ONLINE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
GO

ALTER TABLE [dbo].[Customers]
ALTER COLUMN [YTD_Sales] money
GO
ALTER TABLE [dbo].[Customers]
ALTER COLUMN [Last_years_Sales] money
GO

ALTER TABLE [dbo].[Customers]
ALTER COLUMN [FollowUpPerson] int
GO
CREATE NONCLUSTERED INDEX [Customers_idx2] ON [dbo].[Customers]
  ([FollowUpPerson])
WITH (
  PAD_INDEX = OFF,
  DROP_EXISTING = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  SORT_IN_TEMPDB = OFF,
  ONLINE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
GO
ALTER TABLE [dbo].[Customers]
ADD CONSTRAINT [Customers_fk2] FOREIGN KEY ([FollowUpPerson]) 
  REFERENCES [dbo].[Employees] ([EmployeeID]) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
GO


UPDATE customers 
set customerType = null
where customerType in ('-1', '0', '3');
UPDATE customers 
set customerType = 'Distributor'
where customerType = 'distribuitor';
UPDATE customers 
set customerType = 'Wood Sample Pack'
where customerType = 'wood Samla pack';


ALTER TABLE [dbo].[Customers]
ALTER COLUMN [CustomerNotes] nvarchar(1000) COLLATE SQL_Latin1_General_CP1_CI_AS
GO

ALTER TABLE [dbo].[Customers]
ALTER COLUMN [Lead Type] varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS
GO