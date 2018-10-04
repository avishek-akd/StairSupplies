-- 
-- Country and ContactCountryId
-- 
EXEC sp_rename '[dbo].[Customers].[Country]', 'Country_old', 'COLUMN'
GO
ALTER TABLE [dbo].[Customers]
ADD [ContactCountryId] int NULL
GO
ALTER TABLE [dbo].[Customers]
ADD CONSTRAINT [Customers_fk4] FOREIGN KEY ([ContactCountryId]) 
  REFERENCES [dbo].[Country] ([id]) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
GO
CREATE NONCLUSTERED INDEX [Customers_idx8] ON [dbo].[Customers]
  ([ContactCountryId])
WITH (
  PAD_INDEX = OFF,
  DROP_EXISTING = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  SORT_IN_TEMPDB = OFF,
  ONLINE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
GO
-- 
-- Country data conversion
-- 
ALTER TABLE [dbo].[Customers]
ADD [Country_new] varchar(255) NULL
GO
UPDATE Customers SET Country_new = Country_old
GO
update customers set Country_new = NULL
where (Country_new = '' OR Country_new = 'xxx' OR Country_new = 'interested in buying containers 2nd largst in Dall' OR Country_new = 'asdasd'
OR Country_new = 'Country')
GO
update customers set Country_new = 'United States'
where (Country_new = 'USA' OR Country_new = 'US' OR Country_new = 'U.S.A.' OR Country_new = '"US"' OR Country_new = 'USA`' OR Country_new = 'untied states'
OR Country_new = 'US Virgin Islands' OR Country_new = 'usaq'
OR Country_new = 'VA' OR Country_new = 'usaq')
GO
update customers set Country_new = 'Canada'
where (Country_new = 'CA' OR Country_new = 'Cananda' OR Country_new LIKE '%Canada%'
OR Country_new LIKE 'Nova Scotia%')
GO
update customers set Country_new = 'England'
where (Country_new = 'UK' OR Country_new = 'U.K.')
GO
update customers set Country_new = 'France'
where (Country_new = 'FR')
GO
UPDATE customers SET Country_new = NULL WHERE Country_new NOT IN (select Name from Country)
GO
UPDATE customers SET ContactCountryId = (SELECT id FROM Country WHERE Name = Country_new)
GO



-- 
-- Terms
-- 
ALTER TABLE [dbo].[Customers]
DROP CONSTRAINT [DF_Customers_Terms]
GO
ALTER TABLE [dbo].[Customers]
ADD CONSTRAINT [DF_Customers_Terms] DEFAULT 'Credit Card' FOR [Terms]
GO
UPDATE customers SET Terms = 'C.O.D.' WHERE Terms = 'COD';
UPDATE customers SET Terms = 'Credit Card' WHERE Terms = 'creditcard';
UPDATE customers SET Terms = '1% 10 Net 30' WHERE Terms = '2% 10 Net 30';
UPDATE tbl_terms SET Terms = '1% 10 Net 15' WHERE Terms = '1%10N15';
ALTER TABLE [dbo].[Customers]
ADD CONSTRAINT [Customers_fk3] FOREIGN KEY ([Terms]) 
  REFERENCES [dbo].[Tbl_Terms] ([Terms]) 
  ON UPDATE CASCADE
  ON DELETE NO ACTION
GO
EXEC sp_rename '[dbo].[Tbl_Terms].[EmailAccounting]', 'z_unused_EmailAccounting', 'COLUMN'
GO
EXEC sp_rename '[dbo].[Tbl_Terms].[Description]', 'z_unused_Description', 'COLUMN'
GO



-- 
-- ContactState
-- 
EXEC sp_rename '[dbo].[Customers].[StateOrProvince]', 'StateOrProvince_old', 'COLUMN'
GO
ALTER TABLE [dbo].[Customers]
ADD [ContactState] varchar(2) COLLATE SQL_Latin1_General_CP1_CI_AS
GO
ALTER TABLE [dbo].[Customers]
ADD [ContactStateOther] nvarchar(100) NULL
GO
EXEC sp_addextendedproperty 'MS_Description', N'If the country is USA or Canada then ContactState is a foreign key into the tblState table. Otherwise the ContactStateOther field must be filled in.', 'schema', 'dbo', 'table', 'Customers', 'column', 'ContactState'
GO
ALTER TABLE [dbo].[Customers]
ADD CONSTRAINT [Customers_fk5] FOREIGN KEY ([ContactState]) 
  REFERENCES [dbo].[TblState] ([State]) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
GO
CREATE NONCLUSTERED INDEX [Customers_idx3] ON [dbo].[Customers]
  ([ContactState])
WITH (
  PAD_INDEX = OFF,
  DROP_EXISTING = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  SORT_IN_TEMPDB = OFF,
  ONLINE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
GO



-- 
-- ShipState and ShipCountryId
-- 
EXEC sp_rename '[dbo].[Customers].[ShipState]', 'ShipState_old', 'COLUMN'
GO
ALTER TABLE [dbo].[Customers]
ADD [ShipState] varchar(2) NULL
GO
ALTER TABLE [dbo].[Customers]
ADD [ShipStateOther] nvarchar(100) NULL
GO
ALTER TABLE [dbo].[Customers]
ADD CONSTRAINT [Customers_fk3] FOREIGN KEY ([ShipState]) 
  REFERENCES [dbo].[TblState] ([State]) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
GO
CREATE NONCLUSTERED INDEX [Customers_idx4] ON [dbo].[Customers]
  ([ShipState])
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
ADD [ShipCountryId] int NULL
GO
ALTER TABLE [dbo].[Customers]
ADD CONSTRAINT [Customers_fk6] FOREIGN KEY ([ShipCountryId]) 
  REFERENCES [dbo].[Country] ([id]) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
GO
CREATE NONCLUSTERED INDEX [Customers_idx5] ON [dbo].[Customers]
  ([ShipCountryId])
WITH (
  PAD_INDEX = OFF,
  DROP_EXISTING = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  SORT_IN_TEMPDB = OFF,
  ONLINE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
GO



-- 
-- BillState and BillCountryId
-- 
EXEC sp_rename '[dbo].[Customers].[BillState]', 'BillState_old', 'COLUMN'
GO
ALTER TABLE [dbo].[Customers]
ADD [BillState] varchar(2) NULL
GO
ALTER TABLE [dbo].[Customers]
ADD [BillStateOther] nvarchar(100) NULL
GO
ALTER TABLE [dbo].[Customers]
ADD CONSTRAINT [Customers_fk7] FOREIGN KEY ([BillState]) 
  REFERENCES [dbo].[TblState] ([State]) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
GO
CREATE NONCLUSTERED INDEX [Customers_idx6] ON [dbo].[Customers]
  ([BillState])
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
ADD [BillCountryId] int NULL
GO
ALTER TABLE [dbo].[Customers]
ADD CONSTRAINT [Customers_fk8] FOREIGN KEY ([BillCountryId]) 
  REFERENCES [dbo].[Country] ([id]) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
GO
CREATE NONCLUSTERED INDEX [Customers_idx7] ON [dbo].[Customers]
  ([BillCountryId])
WITH (
  PAD_INDEX = OFF,
  DROP_EXISTING = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  SORT_IN_TEMPDB = OFF,
  ONLINE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
GO



-- 
-- Misc
-- 
EXEC sp_rename '[dbo].[Customers].[FrontEndCustomerID]', 'z_unused_FrontEndCustomerID', 'COLUMN'
GO
EXEC sp_rename '[dbo].[Customers].[CompanyName]', 'ContactCompanyName', 'COLUMN'
GO
EXEC sp_rename '[dbo].[Customers].[BillingAddress]', 'ContactAddress1', 'COLUMN'
GO
EXEC sp_rename '[dbo].[Customers].[BillingAddress1]', 'ContactAddress2', 'COLUMN'
GO
EXEC sp_rename '[dbo].[Customers].[BillingAddress2]', 'ContactAddress3', 'COLUMN'
GO
EXEC sp_rename '[dbo].[Customers].[BillingAddress3]', 'ContactAddress4', 'COLUMN'
GO
EXEC sp_rename '[dbo].[Customers].[City]', 'ContactCity', 'COLUMN'
GO
EXEC sp_rename '[dbo].[Customers].[PostalCode]', 'ContactPostalCode', 'COLUMN'
GO
EXEC sp_rename '[dbo].[Customers].[PhoneNumber]', 'ContactPhoneNumber', 'COLUMN'
GO
EXEC sp_rename '[dbo].[Customers].[FaxNumber]', 'ContactFaxNumber', 'COLUMN'
GO
EXEC sp_rename '[dbo].[Customers].[CellPhone]', 'ContactCellPhone', 'COLUMN'
GO
EXEC sp_rename '[dbo].[Customers].[ShipContactFirstName]', 'ShipFirstName', 'COLUMN'
GO
EXEC sp_rename '[dbo].[Customers].[ShipContactLastName]', 'ShipLastName', 'COLUMN'
GO
EXEC sp_rename '[dbo].[Customers].[BillContactFirstName]', 'BillFirstName', 'COLUMN'
GO
EXEC sp_rename '[dbo].[Customers].[BillContactLastName]', 'BillLastName', 'COLUMN'
GO
EXEC sp_rename '[dbo].[Customers].[Lead Type]', 'LeadType', 'COLUMN'
GO
ALTER TABLE [dbo].[Customers]
ADD DEFAULT 'InBound' FOR [LeadType]
GO
ALTER TABLE [dbo].[Customers]
ALTER COLUMN [Password] varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS
GO
ALTER TABLE [dbo].[Customers]
ALTER COLUMN [ContactFirstName] nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS
GO
ALTER TABLE [dbo].[Customers]
ALTER COLUMN [ShipAddress1] varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS
GO
ALTER TABLE [dbo].[Customers]
ALTER COLUMN [ShipAddress2] varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS
GO
ALTER TABLE [dbo].[Customers]
ALTER COLUMN [ShipAddress3] varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS
GO
ALTER TABLE [dbo].[Customers]
ALTER COLUMN [ShipAddress4] varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS
GO
ALTER TABLE [dbo].[Customers]
ALTER COLUMN [BillAddress1] varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS
GO
ALTER TABLE [dbo].[Customers]
ALTER COLUMN [BillAddress2] varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS
GO
ALTER TABLE [dbo].[Customers]
ALTER COLUMN [BillAddress3] varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS
GO
ALTER TABLE [dbo].[Customers]
ALTER COLUMN [BillAddress4] varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS
GO
