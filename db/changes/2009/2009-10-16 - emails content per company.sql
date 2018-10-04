ALTER TABLE [dbo].[tbl_settings]
ADD [d_company_id] int NULL
GO


	-- Create a temporary table

IF EXISTS (SELECT o.object_id FROM sys.objects o INNER JOIN sys.schemas u ON o.schema_id = u.schema_id
    WHERE o.name = N'#tbl_settings4951' AND u.name = N'dbo')
BEGIN
  DROP TABLE [dbo].[#tbl_settings4951]
END
GO

CREATE TABLE [dbo].[#tbl_settings4951] (
  [id] bigint NULL,
  [d_order_policy] varchar(7000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [d_email_customer_service] varchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [d_email_accounting] varchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [d_email_support] varchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [d_company_id] int NULL
)
GO

-- Copy the source table's data to the temporary table

INSERT INTO [dbo].[#tbl_settings4951] ([id], [d_order_policy], [d_email_customer_service], [d_email_accounting], [d_email_support], [d_company_id])
SELECT [id], [d_order_policy], [d_email_customer_service], [d_email_accounting], [d_email_support], [d_company_id] FROM [dbo].[tbl_settings]
GO

-- Drop the source table

DROP TABLE [dbo].[tbl_settings]
GO

-- Create the destination table

CREATE TABLE [dbo].[tbl_settings] (
  [id] bigint NULL,
  [d_company_id] int NULL,
  [d_order_policy] varchar(7000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [d_email_customer_service] varchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [d_email_accounting] varchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [d_email_support] varchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
ON [PRIMARY]
GO

-- Copy the temporary table's data to the destination table

INSERT INTO [dbo].[tbl_settings] ([id], [d_company_id], [d_order_policy], [d_email_customer_service], [d_email_accounting], [d_email_support])
SELECT [id], [d_company_id], [d_order_policy], [d_email_customer_service], [d_email_accounting], [d_email_support] FROM [dbo].[#tbl_settings4951]
GO

ALTER TABLE [dbo].[tbl_settings]
ADD CONSTRAINT [tbl_settings_fk] FOREIGN KEY ([d_company_id]) 
  REFERENCES [dbo].[Company] ([CompanyID]) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
GO

UPDATE tbl_settings set d_company_id = 1;

ALTER TABLE [dbo].[tbl_settings]
ALTER COLUMN [d_company_id] int NOT NULL
GO



ALTER TABLE [dbo].[tbl_settings]
ADD [d_email_subject_ack] varchar(100) NULL
GO
ALTER TABLE [dbo].[tbl_settings]
ADD [d_email_subject_quotation] varchar(100) NULL
GO
ALTER TABLE [dbo].[tbl_settings]
ADD [d_email_subject_invoice] varchar(100) NULL
GO
ALTER TABLE [dbo].[tbl_settings]
ADD [d_email_sales] varchar(100) NULL
GO

-- Create a temporary table

IF EXISTS (SELECT o.object_id FROM sys.objects o INNER JOIN sys.schemas u ON o.schema_id = u.schema_id
    WHERE o.name = N'#tbl_settings4246' AND u.name = N'dbo')
BEGIN
  DROP TABLE [dbo].[#tbl_settings4246]
END
GO

CREATE TABLE [dbo].[#tbl_settings4246] (
  [id] bigint NULL,
  [d_company_id] int NOT NULL,
  [d_order_policy] varchar(7000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [d_email_customer_service] varchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [d_email_accounting] varchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [d_email_support] varchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [d_email_subject_ack] varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [d_email_subject_quotation] varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [d_email_subject_invoice] varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [d_email_sales] varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO

-- Copy the source table's data to the temporary table

INSERT INTO [dbo].[#tbl_settings4246] ([id], [d_company_id], [d_order_policy], [d_email_customer_service], [d_email_accounting], [d_email_support], [d_email_subject_ack], [d_email_subject_quotation], [d_email_subject_invoice], [d_email_sales])
SELECT [id], [d_company_id], [d_order_policy], [d_email_customer_service], [d_email_accounting], [d_email_support], [d_email_subject_ack], [d_email_subject_quotation], [d_email_subject_invoice], [d_email_sales] FROM [dbo].[tbl_settings]
GO

-- Drop the source table

DROP TABLE [dbo].[tbl_settings]
GO

-- Create the destination table

CREATE TABLE [dbo].[tbl_settings] (
  [id] bigint NULL,
  [d_company_id] int NOT NULL,
  [d_order_policy] varchar(7000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [d_email_customer_service] varchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [d_email_accounting] varchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [d_email_support] varchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [d_email_sales] varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [d_email_subject_ack] varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [d_email_subject_quotation] varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [d_email_subject_invoice] varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  CONSTRAINT [tbl_settings_fk] FOREIGN KEY ([d_company_id]) 
  REFERENCES [dbo].[Company] ([CompanyID]) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
)
ON [PRIMARY]
GO

ALTER TABLE [dbo].[tbl_settings]
NOCHECK CONSTRAINT [tbl_settings_fk]
GO

-- Copy the temporary table's data to the destination table

INSERT INTO [dbo].[tbl_settings] ([id], [d_company_id], [d_order_policy], [d_email_customer_service], [d_email_accounting], [d_email_support], [d_email_sales], [d_email_subject_ack], [d_email_subject_quotation], [d_email_subject_invoice])
SELECT [id], [d_company_id], [d_order_policy], [d_email_customer_service], [d_email_accounting], [d_email_support], [d_email_sales], [d_email_subject_ack], [d_email_subject_quotation], [d_email_subject_invoice] FROM [dbo].[#tbl_settings4246]
GO

-- Enable disabled constraints

ALTER TABLE [dbo].[tbl_settings]
CHECK CONSTRAINT [tbl_settings_fk]
GO


ALTER TABLE [dbo].[Company]
ADD [webAddress] varchar(100) NULL
GO