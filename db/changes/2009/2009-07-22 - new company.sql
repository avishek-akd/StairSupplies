EXEC sp_rename '[dbo].[My_Company_information]', 'Company', 'OBJECT'
GO
EXEC sp_rename '[dbo].[Company].[SetupID]', 'CompanyID', 'COLUMN'
GO
EXEC sp_rename '[dbo].[Company].[SalesTaxRate]', 'z_unused_SalesTaxRate', 'COLUMN'
GO
EXEC sp_rename '[dbo].[Company].[DefaultPaymentTerms]', 'z_unused_DefaultPaymentTerms', 'COLUMN'
GO
EXEC sp_rename '[dbo].[Company].[DefaultInvoiceDescription]', 'z_unused_DefaultInvoiceDescription', 'COLUMN'
GO
EXEC sp_rename '[dbo].[Company].[Notes]', 'z_unused_Notes', 'COLUMN'
GO
EXEC sp_rename '[dbo].[Company].[emailordertext]', 'z_unused_emailordertext', 'COLUMN'
GO
EXEC sp_rename '[dbo].[Company].[emailshippingtext]', 'z_unused_emailshippingtext', 'COLUMN'
GO
EXEC sp_rename '[dbo].[Company].[creditcardTransFee]', 'z_unused_creditcardTransFee', 'COLUMN'
GO
EXEC sp_rename '[dbo].[Company].[CreditCardTransPercent]', 'z_unused_CreditCardTransPercent', 'COLUMN'
GO
EXEC sp_rename '[dbo].[Company].[dba]', 'z_unused_dba', 'COLUMN'
GO
EXEC sp_rename '[dbo].[Company].[emailorderhtmltext]', 'z_unused_emailorderhtmltext', 'COLUMN'
GO
SET IDENTITY_INSERT Company ON
GO
INSERT INTO Company
	(CompanyID, CompanyName, Address, City, StateOrProvince, PostalCode, Country, PhoneNumber, FaxNumber)
VALUES
	(2, 'Nu-Wood', '1722 N Eisenhower Dr.', 'Goshen', 'IN', '46526', 'USA', '574-534-1192', '')
GO
SET IDENTITY_INSERT Company OFF
GO


delete from Products where ProductName = '';
update Products set ProductName = lTrim(RTrim(ProductName)) where ProductName <> lTrim(RTrim(ProductName));


EXEC sp_rename '[dbo].[TblProductType].[AccountingProductCode]', 'z_unused_AccountingProductCode', 'COLUMN'
GO
EXEC sp_rename '[dbo].[TblProductType].[ProductTypeIDlist]', 'z_unused_ProductTypeIDlist', 'COLUMN'
GO


ALTER TABLE [dbo].[Products]
ADD [CompanyID] int NULL
GO
update Products set companyID = 1;
ALTER TABLE [dbo].[Products]
ALTER COLUMN [CompanyID] int NOT NULL
GO
ALTER TABLE [dbo].[Products]
ADD CONSTRAINT [Products_fk_company] FOREIGN KEY ([CompanyID]) 
  REFERENCES [dbo].[Company] ([CompanyID]) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
GO




-- Create a temporary table
IF EXISTS (SELECT o.object_id FROM sys.objects o INNER JOIN sys.schemas u ON o.schema_id = u.schema_id
    WHERE o.name = N'#Products4402' AND u.name = N'dbo')
BEGIN
  DROP TABLE [dbo].[#Products4402]
END
GO

CREATE TABLE [dbo].[#Products4402] (
  [ProductID] int NOT NULL,
  [Vendor_ID] int NOT NULL,
  [ProductType_id] int NOT NULL,
  [ProductName] nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Product_Descripton] nvarchar(500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [PUnitPrice] money NOT NULL,
  [Purchase_Price] money NOT NULL,
  [Inventory_Number] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Unit_of_Measure] varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
  [DateEntered] datetime NULL,
  [DateUpdated] datetime NULL,
  [In_House_Notes] text COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Customer_Notes] text COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Qty_On_Hand] int NOT NULL,
  [Qty_Reorder_Min] int NOT NULL,
  [Qty_On_Order] int NOT NULL,
  [Qty_Available] int NOT NULL,
  [Qty_to_reorder] int NOT NULL,
  [Qty_Allocated] int NOT NULL,
  [Qty_BackOrdered] int NOT NULL,
  [Bin] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Pcs_Per_box] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [UnitWeight] real NOT NULL,
  [PiecesPerCarton] varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [archived] bit NULL,
  [DropShip] bit NULL,
  [species] int NULL,
  [BoardFootage] decimal(7, 2) NULL,
  [CompanyID] int NOT NULL
)
GO

-- Copy the source table's data to the temporary table

INSERT INTO [dbo].[#Products4402] ([ProductID], [Vendor_ID], [ProductType_id], [ProductName], [Product_Descripton], [PUnitPrice], [Purchase_Price], [Inventory_Number], [Unit_of_Measure], [DateEntered], [DateUpdated], [In_House_Notes], [Customer_Notes], [Qty_On_Hand], [Qty_Reorder_Min], [Qty_On_Order], [Qty_Available], [Qty_to_reorder], [Qty_Allocated], [Qty_BackOrdered], [Bin], [Pcs_Per_box], [UnitWeight], [PiecesPerCarton], [archived], [DropShip], [species], [BoardFootage], [CompanyID])
SELECT [ProductID], [Vendor_ID], [ProductType_id], [ProductName], [Product_Descripton], [PUnitPrice], [Purchase_Price], [Inventory_Number], [Unit_of_Measure], [DateEntered], [DateUpdated], [In_House_Notes], [Customer_Notes], [Qty_On_Hand], [Qty_Reorder_Min], [Qty_On_Order], [Qty_Available], [Qty_to_reorder], [Qty_Allocated], [Qty_BackOrdered], [Bin], [Pcs_Per_box], [UnitWeight], [PiecesPerCarton], [archived], [DropShip], [species], [BoardFootage], [CompanyID] FROM [dbo].[Products]
GO

-- Delete objects that depends on the table

ALTER TABLE [dbo].[ProductPrice]
DROP CONSTRAINT [FK_ProductPrice_Products]
GO

ALTER TABLE [dbo].[TblOrdersBOM_Items]
DROP CONSTRAINT [FK_TblOrdersBOM_Items_Products]
GO

ALTER TABLE [dbo].[TblProductVendors]
DROP CONSTRAINT [FK_TblProductVendors_Products]
GO

ALTER TABLE [dbo].[z_unused_TblPoDetails]
DROP CONSTRAINT [FK_TblPoDetails_Products]
GO

-- Drop the source table

DROP TABLE [dbo].[Products]
GO

-- Create the destination table

CREATE TABLE [dbo].[Products] (
  [ProductID] int IDENTITY(1, 1) NOT NULL,
  [CompanyID] int NOT NULL,
  [Vendor_ID] int CONSTRAINT [DF_Products_Vendor_ID] DEFAULT 0 NOT NULL,
  [ProductType_id] int CONSTRAINT [DF_Products_ProductType_id] DEFAULT 1 NOT NULL,
  [ProductName] nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Product_Descripton] nvarchar(500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [PUnitPrice] money CONSTRAINT [DF_Products_PUnitPrice] DEFAULT 0 NOT NULL,
  [Purchase_Price] money CONSTRAINT [DF_Products_Purchase_Price] DEFAULT 0 NOT NULL,
  [Inventory_Number] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS CONSTRAINT [DF_Products_Inventory_Number] DEFAULT 0 NULL,
  [Unit_of_Measure] varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS CONSTRAINT [DF_Products_Unit_of_Measure] DEFAULT N'Each' NOT NULL,
  [DateEntered] datetime CONSTRAINT [DF_Products_DateEntered] DEFAULT convert(datetime,convert(varchar,getdate(),1)) NULL,
  [DateUpdated] datetime CONSTRAINT [DF_Products_DateUpdated] DEFAULT convert(datetime,convert(varchar,getdate(),1)) NULL,
  [In_House_Notes] text COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Customer_Notes] text COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Qty_On_Hand] int CONSTRAINT [DF_Products_Qty_on_hand] DEFAULT 0 NOT NULL,
  [Qty_Reorder_Min] int CONSTRAINT [DF_Products_Qty_Reorder_Min] DEFAULT 0 NOT NULL,
  [Qty_On_Order] int CONSTRAINT [DF_Products_Qty_On_Order] DEFAULT 0 NOT NULL,
  [Qty_Available] int CONSTRAINT [DF_Products_Qty_Available] DEFAULT 0 NOT NULL,
  [Qty_to_reorder] int CONSTRAINT [DF_Products_Qty_to_reorder] DEFAULT 0 NOT NULL,
  [Qty_Allocated] int CONSTRAINT [DF_Products_Qty_Allocated] DEFAULT 0 NOT NULL,
  [Qty_BackOrdered] int CONSTRAINT [DF_Products_Qty_BackOrdered] DEFAULT 0 NOT NULL,
  [Bin] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Pcs_Per_box] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [UnitWeight] real CONSTRAINT [DF_Products_Weight_Per_Piece] DEFAULT 0 NOT NULL,
  [PiecesPerCarton] varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [archived] bit CONSTRAINT [DF_Products_archived] DEFAULT 0 NULL,
  [DropShip] bit CONSTRAINT [DF_Products_DropShip] DEFAULT 0 NULL,
  [species] int NULL,
  [BoardFootage] decimal(7, 2) NULL,
  CONSTRAINT [PK_Products] PRIMARY KEY NONCLUSTERED ([ProductID]),
  CONSTRAINT [FK_Products_TBLVendor] FOREIGN KEY ([Vendor_ID]) 
  REFERENCES [dbo].[TBLVendor] ([Vendor_ID]) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION,
  CONSTRAINT [Products_fk_company] FOREIGN KEY ([CompanyID]) 
  REFERENCES [dbo].[Company] ([CompanyID]) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[Products]
NOCHECK CONSTRAINT [FK_Products_TBLVendor]
GO

ALTER TABLE [dbo].[Products]
NOCHECK CONSTRAINT [Products_fk_company]
GO

EXEC sp_addextendedproperty 'MS_Description', N'This is a foreign key into the tbl_lumber_species table.', 'schema', 'dbo', 'table', 'Products', 'column', 'species'
GO

CREATE NONCLUSTERED INDEX [idx_Products_ProductType_id] ON [dbo].[Products]
  ([ProductType_id])
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

CREATE NONCLUSTERED INDEX [IX_Product_Descripton] ON [dbo].[Products]
  ([Product_Descripton])
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

CREATE CLUSTERED INDEX [IX_ProductName] ON [dbo].[Products]
  ([ProductName])
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

CREATE NONCLUSTERED INDEX [IX_Vendor_ID] ON [dbo].[Products]
  ([Vendor_ID])
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

CREATE NONCLUSTERED INDEX [Products60] ON [dbo].[Products]
  ([ProductID], [Qty_On_Hand], [Qty_Allocated])
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

SET IDENTITY_INSERT [dbo].[Products] ON
GO

INSERT INTO [dbo].[Products] ([ProductID], [CompanyID], [Vendor_ID], [ProductType_id], [ProductName], [Product_Descripton], [PUnitPrice], [Purchase_Price], [Inventory_Number], [Unit_of_Measure], [DateEntered], [DateUpdated], [In_House_Notes], [Customer_Notes], [Qty_On_Hand], [Qty_Reorder_Min], [Qty_On_Order], [Qty_Available], [Qty_to_reorder], [Qty_Allocated], [Qty_BackOrdered], [Bin], [Pcs_Per_box], [UnitWeight], [PiecesPerCarton], [archived], [DropShip], [species], [BoardFootage])
SELECT [ProductID], [CompanyID], [Vendor_ID], [ProductType_id], [ProductName], [Product_Descripton], [PUnitPrice], [Purchase_Price], [Inventory_Number], [Unit_of_Measure], [DateEntered], [DateUpdated], [In_House_Notes], [Customer_Notes], [Qty_On_Hand], [Qty_Reorder_Min], [Qty_On_Order], [Qty_Available], [Qty_to_reorder], [Qty_Allocated], [Qty_BackOrdered], [Bin], [Pcs_Per_box], [UnitWeight], [PiecesPerCarton], [archived], [DropShip], [species], [BoardFootage] FROM [dbo].[#Products4402]
GO

SET IDENTITY_INSERT [dbo].[Products] OFF
GO

-- Enable disabled constraints

ALTER TABLE [dbo].[Products]
CHECK CONSTRAINT [FK_Products_TBLVendor]
GO

ALTER TABLE [dbo].[Products]
CHECK CONSTRAINT [Products_fk_company]
GO

-- Recreate objects that depends on the table
GO

ALTER TABLE [dbo].[ProductPrice]
ADD CONSTRAINT [FK_ProductPrice_Products] FOREIGN KEY ([ProductID]) 
  REFERENCES [dbo].[Products] ([ProductID]) 
  ON UPDATE NO ACTION
  ON DELETE CASCADE
GO

ALTER TABLE [dbo].[TblOrdersBOM_Items]
ADD CONSTRAINT [FK_TblOrdersBOM_Items_Products] FOREIGN KEY ([ProductID]) 
  REFERENCES [dbo].[Products] ([ProductID]) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
GO

ALTER TABLE [dbo].[TblProductVendors]
ADD CONSTRAINT [FK_TblProductVendors_Products] FOREIGN KEY ([ProductID]) 
  REFERENCES [dbo].[Products] ([ProductID]) 
  ON UPDATE NO ACTION
  ON DELETE CASCADE
GO

ALTER TABLE [dbo].[z_unused_TblPoDetails]
ADD CONSTRAINT [FK_TblPoDetails_Products] FOREIGN KEY ([ProductID]) 
  REFERENCES [dbo].[Products] ([ProductID]) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
GO



--
--  Product Type
--
-- CNC
update Products set ProductType_id = 4 where ProductID IN (22163, 22740, 22930, 23073, 23143, 43247);
-- Stock
update Products set ProductType_id = 1 where ProductID IN (23190, 23191, 36907);
-- Moulder
update Products set ProductType_id = 14 where ProductID IN (25283, 28564, 31509, 40708, 43947);
-- Newel
update Products set ProductType_id = 11 where ProductID IN (27761, 35154);
ALTER TABLE [dbo].[Products]
ADD CONSTRAINT [Products_fk_ProductType] FOREIGN KEY ([ProductType_id]) 
  REFERENCES [dbo].[TblProductType] ([ProductType_id]) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
GO



--
--  Species
--
EXEC sp_rename '[dbo].[Products].[species]', 'SpeciesID', 'COLUMN'
GO
update Products set SpeciesID = NULL where SpeciesID = 0
GO
-- Species no longer exist
update Products set SpeciesID = NULL where ProductID IN (5040, 5628, 9476, 14476, 6932, 14724, 14484, 14723, 14493, 7320, 14731, 14730, 14540, 9991, 11764, 14155, 9494, 9475, 9166, 5443, 6233, 5444, 6234, 5445, 5446, 8495, 12011, 12012, 12013, 12014, 12008, 12009, 12010)
GO
ALTER TABLE [dbo].[Products]
ADD CONSTRAINT [Products_fk_Species] FOREIGN KEY ([SpeciesID]) 
  REFERENCES [dbo].[tbl_lumber_species] ([id]) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
GO
EXEC sp_rename '[dbo].[Products_temp].[species]', 'SpeciesID', 'COLUMN'
GO




ALTER TABLE [dbo].[TblOrdersBOM]
ADD [CompanyID] int NULL
GO
update tblOrdersBOM set companyID = 1
GO
ALTER TABLE [dbo].[TblOrdersBOM]
ALTER COLUMN [CompanyID] int NOT NULL
GO
ALTER TABLE [dbo].[TblOrdersBOM]
ADD CONSTRAINT [TblOrdersBOM_fk_Company] FOREIGN KEY ([CompanyID]) 
  REFERENCES [dbo].[Company] ([CompanyID]) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
GO


TRUNCATE TABLE [dbo].[TblOrdersBOM_temp]
GO
ALTER TABLE [dbo].[TblOrdersBOM_temp]
ADD [CompanyID] int NULL
GO
ALTER TABLE [dbo].[TblOrdersBOM_temp]
ALTER COLUMN [CompanyID] int NOT NULL
GO
ALTER TABLE [dbo].[TblOrdersBOM_temp]
ADD CONSTRAINT [TblOrdersBOM_temp_fk_Company] FOREIGN KEY ([CompanyID]) 
  REFERENCES [dbo].[Company] ([CompanyID]) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
GO


TRUNCATE TABLE [dbo].[Products_temp]
GO
ALTER TABLE [dbo].[Products_temp]
ADD [CompanyID] int NULL
GO
ALTER TABLE [dbo].[Products_temp]
ALTER COLUMN [CompanyID] int NOT NULL
GO



ALTER TABLE [dbo].[TblOrdersBOM_Shipping]
ALTER COLUMN [Job_Name] varchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS
GO



insert into tblProductType(ProductType, Description) values('Urethane 1', 'Urethane 1');
insert into tblProductType(ProductType, Description) values('Urethane 2', 'Urethane 2');
insert into tblProductType(ProductType, Description) values('Custom Assembly 1', 'Custom Assembly 1');
insert into tblProductType(ProductType, Description) values('Custom Assembly 2', 'Custom Assembly 2');
insert into tblProductType(ProductType, Description) values('Custom Assembly 1 and 2', 'Custom Assembly 1 and 2');
insert into tblProductType(ProductType, Description) values('Urethane 1 CNC', 'Urethane 1 CNC');
insert into tblProductType(ProductType, Description) values('Urethane 2 CNC', 'Urethane 2 CNC');
insert into tblProductType(ProductType, Description) values('Board and Batten Shutter', 'Board and Batten Shutter');
insert into tblProductType(ProductType, Description) values('NW Stock', 'NW Stock');


insert into tblProductTypeInclude (parentTypeId, childTypeId) values (15, 15);-- Urethane 1
insert into tblProductTypeInclude (parentTypeId, childTypeId) values (15, 17);-- Custom Assembly 1
insert into tblProductTypeInclude (parentTypeId, childTypeId) values (15, 20);-- Urethane 1 CNC
insert into tblProductTypeInclude (parentTypeId, childTypeId) values (15, 19);-- Custom Assembly 1 and 2
insert into tblProductTypeInclude (parentTypeId, childTypeId) values (15, 22);-- Board and Batten

insert into tblProductTypeInclude (parentTypeId, childTypeId) values (16, 16);-- Urethane 2
insert into tblProductTypeInclude (parentTypeId, childTypeId) values (16, 18);-- Custom Assembly 2
insert into tblProductTypeInclude (parentTypeId, childTypeId) values (16, 21);-- Urethane 2 CNC
insert into tblProductTypeInclude (parentTypeId, childTypeId) values (16, 19);-- Custom Assembly 1 and 2

insert into tblProductTypeInclude (parentTypeId, childTypeId) values (17, 17);-- Custom Assembly 1

insert into tblProductTypeInclude (parentTypeId, childTypeId) values (18, 18);-- Custom Assembly 2

insert into tblProductTypeInclude (parentTypeId, childTypeId) values (19, 19);-- Custom Assembly 1 and 2
insert into tblProductTypeInclude (parentTypeId, childTypeId) values (19, 17);-- Custom Assembly 1
insert into tblProductTypeInclude (parentTypeId, childTypeId) values (19, 18);-- Custom Assembly 2

insert into tblProductTypeInclude (parentTypeId, childTypeId) values (20, 20);-- Urethane 1 CNC

insert into tblProductTypeInclude (parentTypeId, childTypeId) values (21, 21);-- Urethane 2 CNC

insert into tblProductTypeInclude (parentTypeId, childTypeId) values (22, 22);-- Board and Batten

insert into tblProductTypeInclude (parentTypeId, childTypeId) values (23, 23);-- NW Stock

insert into tblProductTypeInclude (parentTypeId, childTypeId) values (4, 20);-- Urethane 1 CNC
insert into tblProductTypeInclude (parentTypeId, childTypeId) values (4, 21);-- Urethane 2 CNC

--  Add all except NW Stock to Production
insert into tblProductTypeInclude (parentTypeId, childTypeId) values (2, 15);
insert into tblProductTypeInclude (parentTypeId, childTypeId) values (2, 16);
insert into tblProductTypeInclude (parentTypeId, childTypeId) values (2, 17);
insert into tblProductTypeInclude (parentTypeId, childTypeId) values (2, 18);
insert into tblProductTypeInclude (parentTypeId, childTypeId) values (2, 19);
insert into tblProductTypeInclude (parentTypeId, childTypeId) values (2, 20);
insert into tblProductTypeInclude (parentTypeId, childTypeId) values (2, 21);
insert into tblProductTypeInclude (parentTypeId, childTypeId) values (2, 22);

ALTER TABLE [dbo].[Company]
ADD [FileSuffix] varchar(10) NULL
GO

EXEC sp_addextendedproperty 'MS_Description', N'Suffix applied to files (logos, etc). For example the suffix stairs will be applied to the logo: logo_stairs.jpg', 'schema', 'dbo', 'table', 'Company', 'column', 'FileSuffix'
GO