ALTER TABLE [dbo].[TblProductType]
ADD [archived] bit DEFAULT 0 NULL
GO

-- Create a temporary table

IF EXISTS (SELECT o.object_id FROM sys.objects o INNER JOIN sys.schemas u ON o.schema_id = u.schema_id
    WHERE o.name = N'#TblProductType0901' AND u.name = N'dbo')
BEGIN
  DROP TABLE [dbo].[#TblProductType0901]
END
GO

CREATE TABLE [dbo].[#TblProductType0901] (
  [ProductType_id] int NOT NULL,
  [ProductType] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [description] varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [z_unused_AccountingProductCode] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [z_unused_ProductTypeIDlist] text COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [archived] bit NULL
)
GO

-- Copy the source table's data to the temporary table

INSERT INTO [dbo].[#TblProductType0901] ([ProductType_id], [ProductType], [description], [z_unused_AccountingProductCode], [z_unused_ProductTypeIDlist], [archived])
SELECT [ProductType_id], [ProductType], [description], [z_unused_AccountingProductCode], [z_unused_ProductTypeIDlist], [archived] FROM [dbo].[TblProductType]
GO

-- Delete objects that depends on the table

ALTER TABLE [dbo].[Products]
DROP CONSTRAINT [Products_fk_ProductType]
GO

ALTER TABLE [dbo].[z_unused_tblProductTypeCompany]
DROP CONSTRAINT [tblProductTypeCompany_fk]
GO

-- Drop the source table

DROP TABLE [dbo].[TblProductType]
GO

-- Create the destination table

CREATE TABLE [dbo].[TblProductType] (
  [ProductType_id] int IDENTITY(1, 1) NOT NULL,
  [ProductType] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [description] varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [archived] bit CONSTRAINT [DF__TblProduc__archi__35B2DC69] DEFAULT 0 NULL,
  [z_unused_AccountingProductCode] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [z_unused_ProductTypeIDlist] text COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  CONSTRAINT [PK_Tbl_ProductType] PRIMARY KEY CLUSTERED ([ProductType_id])
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]
GO

-- Copy the temporary table's data to the destination table

SET IDENTITY_INSERT [dbo].[TblProductType] ON
GO

INSERT INTO [dbo].[TblProductType] ([ProductType_id], [ProductType], [description], [archived], [z_unused_AccountingProductCode], [z_unused_ProductTypeIDlist])
SELECT [ProductType_id], [ProductType], [description], [archived], [z_unused_AccountingProductCode], [z_unused_ProductTypeIDlist] FROM [dbo].[#TblProductType0901]
GO

SET IDENTITY_INSERT [dbo].[TblProductType] OFF
GO

-- Recreate objects that depends on the table
GO

ALTER TABLE [dbo].[Products]
ADD CONSTRAINT [Products_fk_ProductType] FOREIGN KEY ([ProductType_id]) 
  REFERENCES [dbo].[TblProductType] ([ProductType_id]) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
GO

ALTER TABLE [dbo].[z_unused_tblProductTypeCompany]
ADD CONSTRAINT [tblProductTypeCompany_fk] FOREIGN KEY ([ProductTypeId]) 
  REFERENCES [dbo].[TblProductType] ([ProductType_id]) 
  ON UPDATE NO ACTION
  ON DELETE CASCADE
GO

update TblProductType
set archived = 0
GO


ALTER TABLE [dbo].[TblProductType]
DROP CONSTRAINT [DF__TblProduc__archi__35B2DC69]
GO

ALTER TABLE [dbo].[TblProductType]
ALTER COLUMN [archived] bit NOT NULL
GO

ALTER TABLE [dbo].[TblProductType]
ADD CONSTRAINT [DF__TblProduc__archi__35B2DC69] DEFAULT 0 FOR [archived]
GO