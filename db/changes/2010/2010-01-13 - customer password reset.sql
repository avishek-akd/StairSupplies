ALTER TABLE [dbo].[Customers]
ADD [Password] varchar(10) NULL
GO

-- Create a temporary table

IF EXISTS (SELECT o.object_id FROM sys.objects o INNER JOIN sys.schemas u ON o.schema_id = u.schema_id
    WHERE o.name = N'#Customers5712' AND u.name = N'dbo')
BEGIN
  DROP TABLE [dbo].[#Customers5712]
END
GO

CREATE TABLE [dbo].[#Customers5712] (
  [CustomerID] int NOT NULL,
  [CompanyName] nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ContactFirstName] nvarchar(30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ContactLastName] nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [BillingAddress] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [BillingAddress1] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [BillingAddress2] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [BillingAddress3] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [City] nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [StateOrProvince] varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [PostalCode] nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Country] nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ContactTitle] nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [PhoneNumber] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [FaxNumber] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [CellPhone] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Email] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Terms] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [TaxID_Number] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [TaxExempt] bit NULL,
  [DateUpdated] datetime NULL,
  [DateEntered] datetime NULL,
  [ShipCompanyName] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ShipContactFirstName] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ShipContactLastName] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ShipAddress1] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ShipAddress2] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ShipAddress3] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ShipAddress4] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ShipCity] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ShipState] varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ShipPostalCode] nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [BillCompanyName] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [BillContactFirstName] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [BillContactLastName] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [BillAddress1] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [BillAddress2] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [BillAddress3] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [BillAddress4] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [BillCity] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [BillState] varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [BillPostalCode] nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [CustomerType] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Annual_Sales_Forcast] money NULL,
  [YTD_Sales] money NULL,
  [Last_years_Sales] money NULL,
  [LastSale] char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [CustomerNotes] nvarchar(1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [FollowUp] datetime NULL,
  [SalesPerson] int NULL,
  [FollowUpPerson] int NULL,
  [Lead Type] varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [FrontEndCustomerID] int NULL,
  [CreditHold] bit NULL,
  [Password] varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO

-- Copy the source table's data to the temporary table

INSERT INTO [dbo].[#Customers5712] ([CustomerID], [CompanyName], [ContactFirstName], [ContactLastName], [BillingAddress], [BillingAddress1], [BillingAddress2], [BillingAddress3], [City], [StateOrProvince], [PostalCode], [Country], [ContactTitle], [PhoneNumber], [FaxNumber], [CellPhone], [Email], [Terms], [TaxID_Number], [TaxExempt], [DateUpdated], [DateEntered], [ShipCompanyName], [ShipContactFirstName], [ShipContactLastName], [ShipAddress1], [ShipAddress2], [ShipAddress3], [ShipAddress4], [ShipCity], [ShipState], [ShipPostalCode], [BillCompanyName], [BillContactFirstName], [BillContactLastName], [BillAddress1], [BillAddress2], [BillAddress3], [BillAddress4], [BillCity], [BillState], [BillPostalCode], [CustomerType], [Annual_Sales_Forcast], [YTD_Sales], [Last_years_Sales], [LastSale], [CustomerNotes], [FollowUp], [SalesPerson], [FollowUpPerson], [Lead Type], [FrontEndCustomerID], [CreditHold], [Password])
SELECT [CustomerID], [CompanyName], [ContactFirstName], [ContactLastName], [BillingAddress], [BillingAddress1], [BillingAddress2], [BillingAddress3], [City], [StateOrProvince], [PostalCode], [Country], [ContactTitle], [PhoneNumber], [FaxNumber], [CellPhone], [Email], [Terms], [TaxID_Number], [TaxExempt], [DateUpdated], [DateEntered], [ShipCompanyName], [ShipContactFirstName], [ShipContactLastName], [ShipAddress1], [ShipAddress2], [ShipAddress3], [ShipAddress4], [ShipCity], [ShipState], [ShipPostalCode], [BillCompanyName], [BillContactFirstName], [BillContactLastName], [BillAddress1], [BillAddress2], [BillAddress3], [BillAddress4], [BillCity], [BillState], [BillPostalCode], [CustomerType], [Annual_Sales_Forcast], [YTD_Sales], [Last_years_Sales], [LastSale], [CustomerNotes], [FollowUp], [SalesPerson], [FollowUpPerson], [Lead Type], [FrontEndCustomerID], [CreditHold], [Password] FROM [dbo].[Customers]
GO

-- Delete objects that depends on the table

ALTER TABLE [dbo].[CustomerNotes]
DROP CONSTRAINT [CustomerNotes_fk2]
GO

ALTER TABLE [dbo].[TblOrdersBOM]
DROP CONSTRAINT [FK_TblOrdersBOM_Customers]
GO

-- Drop the source table

DROP TABLE [dbo].[Customers]
GO

-- Create the destination table

CREATE TABLE [dbo].[Customers] (
  [CustomerID] int IDENTITY(1, 1) NOT NULL,
  [CompanyName] nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ContactFirstName] nvarchar(30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ContactLastName] nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [BillingAddress] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [BillingAddress1] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [BillingAddress2] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [BillingAddress3] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [City] nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [StateOrProvince] varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS CONSTRAINT [DF_Customers_StateOrProvince] DEFAULT N'IN' NULL,
  [PostalCode] nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Country] nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ContactTitle] nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [PhoneNumber] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [FaxNumber] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [CellPhone] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Email] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Password] varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Terms] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS CONSTRAINT [DF_Customers_Terms] DEFAULT 'Net 15' NULL,
  [TaxID_Number] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [TaxExempt] bit CONSTRAINT [DF_Customers_TaxExempt] DEFAULT 1 NULL,
  [DateUpdated] datetime CONSTRAINT [DF_Customers_DateUpdated] DEFAULT convert(datetime,convert(varchar,getdate(),1)) NULL,
  [DateEntered] datetime CONSTRAINT [DF_Customers_DateEntered] DEFAULT convert(datetime,convert(varchar,getdate(),1)) NULL,
  [ShipCompanyName] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ShipContactFirstName] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ShipContactLastName] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ShipAddress1] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ShipAddress2] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ShipAddress3] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ShipAddress4] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ShipCity] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ShipState] varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ShipPostalCode] nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [BillCompanyName] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [BillContactFirstName] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [BillContactLastName] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [BillAddress1] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [BillAddress2] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [BillAddress3] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [BillAddress4] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [BillCity] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [BillState] varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [BillPostalCode] nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [CustomerType] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Annual_Sales_Forcast] money CONSTRAINT [DF_Customers_Annual_Sales_Forcast] DEFAULT 0 NULL,
  [YTD_Sales] money NULL,
  [Last_years_Sales] money NULL,
  [LastSale] char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [CustomerNotes] nvarchar(1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [FollowUp] datetime NULL,
  [SalesPerson] int NULL,
  [FollowUpPerson] int NULL,
  [Lead Type] varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [FrontEndCustomerID] int NULL,
  [CreditHold] bit CONSTRAINT [DF__Customers__Credi__461E4E5C] DEFAULT 0 NULL,
  CONSTRAINT [PK_Customers] PRIMARY KEY NONCLUSTERED ([CustomerID]),
  CONSTRAINT [Customers_fk] FOREIGN KEY ([SalesPerson]) 
  REFERENCES [dbo].[Employees] ([EmployeeID]) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION,
  CONSTRAINT [Customers_fk2] FOREIGN KEY ([FollowUpPerson]) 
  REFERENCES [dbo].[Employees] ([EmployeeID]) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
)
ON [PRIMARY]
GO

ALTER TABLE [dbo].[Customers]
NOCHECK CONSTRAINT [Customers_fk]
GO

ALTER TABLE [dbo].[Customers]
NOCHECK CONSTRAINT [Customers_fk2]
GO

EXEC sp_addextendedproperty 'MS_Description', N'Customer ID in the front end part of the site (www.stairsupplies.com). We receive this ID via the integration script and need to store it for future requests.', 'schema', 'dbo', 'table', 'Customers', 'column', 'FrontEndCustomerID'
GO

EXEC sp_addextendedproperty 'MS_Description', N'If this is true then the sales department needs to be contacted before shipping or doing production work for this customer.', 'schema', 'dbo', 'table', 'Customers', 'column', 'CreditHold'
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
ON [PRIMARY]
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
ON [PRIMARY]
GO

CREATE CLUSTERED INDEX [IX_Customers] ON [dbo].[Customers]
  ([CompanyName])
WITH (
  PAD_INDEX = OFF,
  FILLFACTOR = 90,
  DROP_EXISTING = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  SORT_IN_TEMPDB = OFF,
  ONLINE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [IX_Terms] ON [dbo].[Customers]
  ([Terms])
WITH (
  PAD_INDEX = OFF,
  FILLFACTOR = 90,
  DROP_EXISTING = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  SORT_IN_TEMPDB = OFF,
  ONLINE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

-- Copy the temporary table's data to the destination table

SET IDENTITY_INSERT [dbo].[Customers] ON
GO

INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactFirstName], [ContactLastName], [BillingAddress], [BillingAddress1], [BillingAddress2], [BillingAddress3], [City], [StateOrProvince], [PostalCode], [Country], [ContactTitle], [PhoneNumber], [FaxNumber], [CellPhone], [Email], [Password], [Terms], [TaxID_Number], [TaxExempt], [DateUpdated], [DateEntered], [ShipCompanyName], [ShipContactFirstName], [ShipContactLastName], [ShipAddress1], [ShipAddress2], [ShipAddress3], [ShipAddress4], [ShipCity], [ShipState], [ShipPostalCode], [BillCompanyName], [BillContactFirstName], [BillContactLastName], [BillAddress1], [BillAddress2], [BillAddress3], [BillAddress4], [BillCity], [BillState], [BillPostalCode], [CustomerType], [Annual_Sales_Forcast], [YTD_Sales], [Last_years_Sales], [LastSale], [CustomerNotes], [FollowUp], [SalesPerson], [FollowUpPerson], [Lead Type], [FrontEndCustomerID], [CreditHold])
SELECT [CustomerID], [CompanyName], [ContactFirstName], [ContactLastName], [BillingAddress], [BillingAddress1], [BillingAddress2], [BillingAddress3], [City], [StateOrProvince], [PostalCode], [Country], [ContactTitle], [PhoneNumber], [FaxNumber], [CellPhone], [Email], [Password], [Terms], [TaxID_Number], [TaxExempt], [DateUpdated], [DateEntered], [ShipCompanyName], [ShipContactFirstName], [ShipContactLastName], [ShipAddress1], [ShipAddress2], [ShipAddress3], [ShipAddress4], [ShipCity], [ShipState], [ShipPostalCode], [BillCompanyName], [BillContactFirstName], [BillContactLastName], [BillAddress1], [BillAddress2], [BillAddress3], [BillAddress4], [BillCity], [BillState], [BillPostalCode], [CustomerType], [Annual_Sales_Forcast], [YTD_Sales], [Last_years_Sales], [LastSale], [CustomerNotes], [FollowUp], [SalesPerson], [FollowUpPerson], [Lead Type], [FrontEndCustomerID], [CreditHold] FROM [dbo].[#Customers5712]
GO

SET IDENTITY_INSERT [dbo].[Customers] OFF
GO

-- Enable disabled constraints

ALTER TABLE [dbo].[Customers]
CHECK CONSTRAINT [Customers_fk]
GO

ALTER TABLE [dbo].[Customers]
CHECK CONSTRAINT [Customers_fk2]
GO

-- Recreate objects that depends on the table
GO

ALTER TABLE [dbo].[CustomerNotes]
ADD CONSTRAINT [CustomerNotes_fk2] FOREIGN KEY ([CustomerID]) 
  REFERENCES [dbo].[Customers] ([CustomerID]) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
GO

ALTER TABLE [dbo].[TblOrdersBOM]
ADD CONSTRAINT [FK_TblOrdersBOM_Customers] FOREIGN KEY ([CustomerID]) 
  REFERENCES [dbo].[Customers] ([CustomerID]) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
GO

ALTER TABLE [dbo].[Customers]
ADD [CanLogin] bit DEFAULT 1 NULL
GO


-- Create a temporary table

IF EXISTS (SELECT o.object_id FROM sys.objects o INNER JOIN sys.schemas u ON o.schema_id = u.schema_id
    WHERE o.name = N'#Customers3906' AND u.name = N'dbo')
BEGIN
  DROP TABLE [dbo].[#Customers3906]
END
GO

CREATE TABLE [dbo].[#Customers3906] (
  [CustomerID] int NOT NULL,
  [CompanyName] nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ContactFirstName] nvarchar(30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ContactLastName] nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [BillingAddress] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [BillingAddress1] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [BillingAddress2] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [BillingAddress3] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [City] nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [StateOrProvince] varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [PostalCode] nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Country] nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ContactTitle] nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [PhoneNumber] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [FaxNumber] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [CellPhone] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Email] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Password] varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Terms] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [TaxID_Number] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [TaxExempt] bit NULL,
  [DateUpdated] datetime NULL,
  [DateEntered] datetime NULL,
  [ShipCompanyName] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ShipContactFirstName] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ShipContactLastName] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ShipAddress1] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ShipAddress2] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ShipAddress3] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ShipAddress4] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ShipCity] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ShipState] varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ShipPostalCode] nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [BillCompanyName] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [BillContactFirstName] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [BillContactLastName] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [BillAddress1] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [BillAddress2] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [BillAddress3] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [BillAddress4] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [BillCity] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [BillState] varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [BillPostalCode] nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [CustomerType] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Annual_Sales_Forcast] money NULL,
  [YTD_Sales] money NULL,
  [Last_years_Sales] money NULL,
  [LastSale] char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [CustomerNotes] nvarchar(1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [FollowUp] datetime NULL,
  [SalesPerson] int NULL,
  [FollowUpPerson] int NULL,
  [Lead Type] varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [FrontEndCustomerID] int NULL,
  [CreditHold] bit NULL,
  [CanLogin] bit NULL
)
GO

-- Copy the source table's data to the temporary table

INSERT INTO [dbo].[#Customers3906] ([CustomerID], [CompanyName], [ContactFirstName], [ContactLastName], [BillingAddress], [BillingAddress1], [BillingAddress2], [BillingAddress3], [City], [StateOrProvince], [PostalCode], [Country], [ContactTitle], [PhoneNumber], [FaxNumber], [CellPhone], [Email], [Password], [Terms], [TaxID_Number], [TaxExempt], [DateUpdated], [DateEntered], [ShipCompanyName], [ShipContactFirstName], [ShipContactLastName], [ShipAddress1], [ShipAddress2], [ShipAddress3], [ShipAddress4], [ShipCity], [ShipState], [ShipPostalCode], [BillCompanyName], [BillContactFirstName], [BillContactLastName], [BillAddress1], [BillAddress2], [BillAddress3], [BillAddress4], [BillCity], [BillState], [BillPostalCode], [CustomerType], [Annual_Sales_Forcast], [YTD_Sales], [Last_years_Sales], [LastSale], [CustomerNotes], [FollowUp], [SalesPerson], [FollowUpPerson], [Lead Type], [FrontEndCustomerID], [CreditHold], [CanLogin])
SELECT [CustomerID], [CompanyName], [ContactFirstName], [ContactLastName], [BillingAddress], [BillingAddress1], [BillingAddress2], [BillingAddress3], [City], [StateOrProvince], [PostalCode], [Country], [ContactTitle], [PhoneNumber], [FaxNumber], [CellPhone], [Email], [Password], [Terms], [TaxID_Number], [TaxExempt], [DateUpdated], [DateEntered], [ShipCompanyName], [ShipContactFirstName], [ShipContactLastName], [ShipAddress1], [ShipAddress2], [ShipAddress3], [ShipAddress4], [ShipCity], [ShipState], [ShipPostalCode], [BillCompanyName], [BillContactFirstName], [BillContactLastName], [BillAddress1], [BillAddress2], [BillAddress3], [BillAddress4], [BillCity], [BillState], [BillPostalCode], [CustomerType], [Annual_Sales_Forcast], [YTD_Sales], [Last_years_Sales], [LastSale], [CustomerNotes], [FollowUp], [SalesPerson], [FollowUpPerson], [Lead Type], [FrontEndCustomerID], [CreditHold], [CanLogin] FROM [dbo].[Customers]
GO

-- Delete objects that depends on the table

ALTER TABLE [dbo].[CustomerNotes]
DROP CONSTRAINT [CustomerNotes_fk2]
GO

ALTER TABLE [dbo].[TblOrdersBOM]
DROP CONSTRAINT [FK_TblOrdersBOM_Customers]
GO

-- Drop the source table

DROP TABLE [dbo].[Customers]
GO

-- Create the destination table

CREATE TABLE [dbo].[Customers] (
  [CustomerID] int IDENTITY(1, 1) NOT NULL,
  [CompanyName] nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ContactFirstName] nvarchar(30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ContactLastName] nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [BillingAddress] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [BillingAddress1] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [BillingAddress2] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [BillingAddress3] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [City] nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [StateOrProvince] varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS CONSTRAINT [DF_Customers_StateOrProvince] DEFAULT N'IN' NULL,
  [PostalCode] nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Country] nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ContactTitle] nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [PhoneNumber] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [FaxNumber] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [CellPhone] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Email] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Password] varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Terms] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS CONSTRAINT [DF_Customers_Terms] DEFAULT 'Net 15' NULL,
  [TaxID_Number] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [TaxExempt] bit CONSTRAINT [DF_Customers_TaxExempt] DEFAULT 1 NULL,
  [DateUpdated] datetime CONSTRAINT [DF_Customers_DateUpdated] DEFAULT CONVERT([datetime],CONVERT([varchar],getdate(),(1)),0) NULL,
  [DateEntered] datetime CONSTRAINT [DF_Customers_DateEntered] DEFAULT CONVERT([datetime],CONVERT([varchar],getdate(),(1)),0) NULL,
  [ShipCompanyName] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ShipContactFirstName] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ShipContactLastName] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ShipAddress1] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ShipAddress2] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ShipAddress3] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ShipAddress4] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ShipCity] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ShipState] varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ShipPostalCode] nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [BillCompanyName] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [BillContactFirstName] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [BillContactLastName] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [BillAddress1] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [BillAddress2] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [BillAddress3] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [BillAddress4] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [BillCity] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [BillState] varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [BillPostalCode] nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [CustomerType] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Annual_Sales_Forcast] money CONSTRAINT [DF_Customers_Annual_Sales_Forcast] DEFAULT 0 NULL,
  [YTD_Sales] money NULL,
  [Last_years_Sales] money NULL,
  [LastSale] char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [CustomerNotes] nvarchar(1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [CanLogin] bit CONSTRAINT [DF__Customers__CanLo__6C43F744] DEFAULT 1 NULL,
  [FollowUp] datetime NULL,
  [SalesPerson] int NULL,
  [FollowUpPerson] int NULL,
  [Lead Type] varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [FrontEndCustomerID] int NULL,
  [CreditHold] bit CONSTRAINT [DF__Customers__Credi__461E4E5C] DEFAULT 0 NULL,
  CONSTRAINT [PK_Customers] PRIMARY KEY NONCLUSTERED ([CustomerID]),
  CONSTRAINT [Customers_fk] FOREIGN KEY ([SalesPerson]) 
  REFERENCES [dbo].[Employees] ([EmployeeID]) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION,
  CONSTRAINT [Customers_fk2] FOREIGN KEY ([FollowUpPerson]) 
  REFERENCES [dbo].[Employees] ([EmployeeID]) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
)
ON [PRIMARY]
GO

ALTER TABLE [dbo].[Customers]
NOCHECK CONSTRAINT [Customers_fk]
GO

ALTER TABLE [dbo].[Customers]
NOCHECK CONSTRAINT [Customers_fk2]
GO

EXEC sp_addextendedproperty 'MS_Description', N'Customer ID in the front end part of the site (www.stairsupplies.com). We receive this ID via the integration script and need to store it for future requests.', 'schema', 'dbo', 'table', 'Customers', 'column', 'FrontEndCustomerID'
GO

EXEC sp_addextendedproperty 'MS_Description', N'If this is true then the sales department needs to be contacted before shipping or doing production work for this customer.', 'schema', 'dbo', 'table', 'Customers', 'column', 'CreditHold'
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
ON [PRIMARY]
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
ON [PRIMARY]
GO

CREATE CLUSTERED INDEX [IX_Customers] ON [dbo].[Customers]
  ([CompanyName])
WITH (
  PAD_INDEX = OFF,
  FILLFACTOR = 90,
  DROP_EXISTING = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  SORT_IN_TEMPDB = OFF,
  ONLINE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [IX_Terms] ON [dbo].[Customers]
  ([Terms])
WITH (
  PAD_INDEX = OFF,
  FILLFACTOR = 90,
  DROP_EXISTING = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  SORT_IN_TEMPDB = OFF,
  ONLINE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

-- Copy the temporary table's data to the destination table

SET IDENTITY_INSERT [dbo].[Customers] ON
GO

INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactFirstName], [ContactLastName], [BillingAddress], [BillingAddress1], [BillingAddress2], [BillingAddress3], [City], [StateOrProvince], [PostalCode], [Country], [ContactTitle], [PhoneNumber], [FaxNumber], [CellPhone], [Email], [Password], [Terms], [TaxID_Number], [TaxExempt], [DateUpdated], [DateEntered], [ShipCompanyName], [ShipContactFirstName], [ShipContactLastName], [ShipAddress1], [ShipAddress2], [ShipAddress3], [ShipAddress4], [ShipCity], [ShipState], [ShipPostalCode], [BillCompanyName], [BillContactFirstName], [BillContactLastName], [BillAddress1], [BillAddress2], [BillAddress3], [BillAddress4], [BillCity], [BillState], [BillPostalCode], [CustomerType], [Annual_Sales_Forcast], [YTD_Sales], [Last_years_Sales], [LastSale], [CustomerNotes], [CanLogin], [FollowUp], [SalesPerson], [FollowUpPerson], [Lead Type], [FrontEndCustomerID], [CreditHold])
SELECT [CustomerID], [CompanyName], [ContactFirstName], [ContactLastName], [BillingAddress], [BillingAddress1], [BillingAddress2], [BillingAddress3], [City], [StateOrProvince], [PostalCode], [Country], [ContactTitle], [PhoneNumber], [FaxNumber], [CellPhone], [Email], [Password], [Terms], [TaxID_Number], [TaxExempt], [DateUpdated], [DateEntered], [ShipCompanyName], [ShipContactFirstName], [ShipContactLastName], [ShipAddress1], [ShipAddress2], [ShipAddress3], [ShipAddress4], [ShipCity], [ShipState], [ShipPostalCode], [BillCompanyName], [BillContactFirstName], [BillContactLastName], [BillAddress1], [BillAddress2], [BillAddress3], [BillAddress4], [BillCity], [BillState], [BillPostalCode], [CustomerType], [Annual_Sales_Forcast], [YTD_Sales], [Last_years_Sales], [LastSale], [CustomerNotes], [CanLogin], [FollowUp], [SalesPerson], [FollowUpPerson], [Lead Type], [FrontEndCustomerID], [CreditHold] FROM [dbo].[#Customers3906]
GO

SET IDENTITY_INSERT [dbo].[Customers] OFF
GO

-- Enable disabled constraints

ALTER TABLE [dbo].[Customers]
CHECK CONSTRAINT [Customers_fk]
GO

ALTER TABLE [dbo].[Customers]
CHECK CONSTRAINT [Customers_fk2]
GO

-- Recreate objects that depends on the table
GO

ALTER TABLE [dbo].[CustomerNotes]
ADD CONSTRAINT [CustomerNotes_fk2] FOREIGN KEY ([CustomerID]) 
  REFERENCES [dbo].[Customers] ([CustomerID]) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
GO

ALTER TABLE [dbo].[TblOrdersBOM]
ADD CONSTRAINT [FK_TblOrdersBOM_Customers] FOREIGN KEY ([CustomerID]) 
  REFERENCES [dbo].[Customers] ([CustomerID]) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
GO

update customers set CanLogin = 0
GO
update customers set password = NULL
GO



CREATE TABLE [dbo].[Sites] (
  [id] int NOT NULL,
  [Name] varchar(50) NULL,
  PRIMARY KEY CLUSTERED ([id])
)
GO


CREATE TABLE [dbo].[CustomerLogins] (
  [id] int NOT NULL,
  [customerID] int NOT NULL,
  [siteID] int NOT NULL,
  [loginTime] datetime NULL,
  PRIMARY KEY CLUSTERED ([id])
)
GO

ALTER TABLE [dbo].[CustomerLogins]
ADD CONSTRAINT [CustomerLogins_fk] FOREIGN KEY ([customerID]) 
  REFERENCES [dbo].[Customers] ([CustomerID]) 
  ON UPDATE NO ACTION
  ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CustomerLogins]
ADD CONSTRAINT [CustomerLogins_fk2] FOREIGN KEY ([siteID]) 
  REFERENCES [dbo].[Sites] ([id]) 
  ON UPDATE NO ACTION
  ON DELETE CASCADE
GO