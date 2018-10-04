EXEC sp_rename '[dbo].[TblOrdersBOM_Items].[Glue]', 'zzUnused_Glue', 'COLUMN'
GO
EXEC sp_rename '[dbo].[TblOrdersBOM_Items].[Glue_Initials]', 'zzUnused_Glue_Initials', 'COLUMN'
GO
EXEC sp_rename '[dbo].[TblOrdersBOM_Items].[Glue_Date]', 'zzUnused_Glue_Date', 'COLUMN'
GO
EXEC sp_rename '[dbo].[TblOrdersBOM_Items].[Glue_EmployeeID]', 'zzUnused_Glue_EmployeeID', 'COLUMN'
GO



ALTER TABLE [dbo].[TblOrdersBOM_Items]
ADD [Prefinishing_Complete] bit DEFAULT 0 NULL
GO
ALTER TABLE [dbo].[TblOrdersBOM_Items]
ADD [Prefinishing_Complete_Initials] text NULL
GO
ALTER TABLE [dbo].[TblOrdersBOM_Items]
ADD [Prefinishing_Complete_Date] datetime NULL
GO
ALTER TABLE [dbo].[TblOrdersBOM_Items]
ADD [Prefinishing_Complete_EmployeeID] bigint NULL
GO












-- Create a temporary table

IF EXISTS (SELECT o.id FROM sysobjects o INNER JOIN sysusers u ON o.uid = u.uid
    WHERE o.name = N'#TblOrdersBOM_Items4302' AND u.name = N'dbo')
BEGIN
  DROP TABLE [dbo].[#TblOrdersBOM_Items4302]
END
GO

CREATE TABLE [dbo].[#TblOrdersBOM_Items4302] (
  [OrderItemsID] int NOT NULL,
  [OrderID] numeric(10, 0) NULL,
  [zzUnused_BOM_ID] int NULL,
  [Quantity] float NULL,
  [QuantityShipped] float NULL,
  [Unit_of_Measure] varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [UnitPrice] money NULL,
  [Discount] float NULL,
  [Status] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Special_Instructions] varchar(150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [In_House_Notes] text COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Customer_Notes] text COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [BackOrderCreated] bit NULL,
  [ProductName] varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Product_Descripton] varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Temp_ProductID] int NULL,
  [Purchase_Price] money NULL,
  [zzUnused_OldorderID] int NULL,
  [zzUnused_OldOrderItemsID] int NULL,
  [zzUnused_OldQuoteItemsID] int NULL,
  [zzUnused_OldQuoteID] int NULL,
  [UnitWeight] real NULL,
  [ReadytoShip] bit NULL,
  [Prod_BoardFeet] numeric(18, 0) NULL,
  [Prod_RipOperator] int NULL,
  [Prod_Vendor] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Delivered] bit NULL,
  [DeliveredDate] datetime NULL,
  [DropShipItem] bit NULL,
  [zzUnused_lumber_pack] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [PRC] bit NULL,
  [zzUnused_Glue] bit NULL,
  [Final] bit NULL,
  [PRC_Initials] text COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [zzUnused_Glue_Initials] text COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Final_Initials] text COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [PRC_Date] datetime NULL,
  [zzUnused_Glue_Date] datetime NULL,
  [Final_Date] datetime NULL,
  [ExceptionOpened] bit NULL,
  [ExceptonDateCreated] datetime NULL,
  [ExceptionDateClosed] datetime NULL,
  [ExceptionCreateInitials] text COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ExceptionClosed] bit NULL,
  [ExceptionClosedInitials] text COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ExceptionDesription] text COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Outsource] bit NULL,
  [OutsourceDate] datetime NULL,
  [OutsourceInitials] text COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [PRC_EmployeeID] bigint NULL,
  [zzUnused_Glue_EmployeeID] bigint NULL,
  [Final_EmployeeID] bigint NULL,
  [exceptionOpened_EmployeeID] bigint NULL,
  [ExceptionClosed_EmployeeID] bigint NULL,
  [outsource_EmployeeID] bigint NULL,
  [ExceptionId] bigint NULL,
  [sort] bigint NULL,
  [ProductID] int NULL,
  [Prefinishing_Complete] bit NULL,
  [Prefinishing_Complete_Initials] text COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Prefinishing_Complete_Date] datetime NULL,
  [Prefinishing_Complete_EmployeeID] bigint NULL
)
GO

-- Copy the source table's data to the temporary table

INSERT INTO [dbo].[#TblOrdersBOM_Items4302] ([OrderItemsID], [OrderID], [zzUnused_BOM_ID], [Quantity], [QuantityShipped], [Unit_of_Measure], [UnitPrice], [Discount], [Status], [Special_Instructions], [In_House_Notes], [Customer_Notes], [BackOrderCreated], [ProductName], [Product_Descripton], [Temp_ProductID], [Purchase_Price], [zzUnused_OldorderID], [zzUnused_OldOrderItemsID], [zzUnused_OldQuoteItemsID], [zzUnused_OldQuoteID], [UnitWeight], [ReadytoShip], [Prod_BoardFeet], [Prod_RipOperator], [Prod_Vendor], [Delivered], [DeliveredDate], [DropShipItem], [zzUnused_lumber_pack], [PRC], [zzUnused_Glue], [Final], [PRC_Initials], [zzUnused_Glue_Initials], [Final_Initials], [PRC_Date], [zzUnused_Glue_Date], [Final_Date], [ExceptionOpened], [ExceptonDateCreated], [ExceptionDateClosed], [ExceptionCreateInitials], [ExceptionClosed], [ExceptionClosedInitials], [ExceptionDesription], [Outsource], [OutsourceDate], [OutsourceInitials], [PRC_EmployeeID], [zzUnused_Glue_EmployeeID], [Final_EmployeeID], [exceptionOpened_EmployeeID], [ExceptionClosed_EmployeeID], [outsource_EmployeeID], [ExceptionId], [sort], [ProductID], [Prefinishing_Complete], [Prefinishing_Complete_Initials], [Prefinishing_Complete_Date], [Prefinishing_Complete_EmployeeID])
SELECT [OrderItemsID], [OrderID], [zzUnused_BOM_ID], [Quantity], [QuantityShipped], [Unit_of_Measure], [UnitPrice], [Discount], [Status], [Special_Instructions], [In_House_Notes], [Customer_Notes], [BackOrderCreated], [ProductName], [Product_Descripton], [Temp_ProductID], [Purchase_Price], [zzUnused_OldorderID], [zzUnused_OldOrderItemsID], [zzUnused_OldQuoteItemsID], [zzUnused_OldQuoteID], [UnitWeight], [ReadytoShip], [Prod_BoardFeet], [Prod_RipOperator], [Prod_Vendor], [Delivered], [DeliveredDate], [DropShipItem], [zzUnused_lumber_pack], [PRC], [zzUnused_Glue], [Final], [PRC_Initials], [zzUnused_Glue_Initials], [Final_Initials], [PRC_Date], [zzUnused_Glue_Date], [Final_Date], [ExceptionOpened], [ExceptonDateCreated], [ExceptionDateClosed], [ExceptionCreateInitials], [ExceptionClosed], [ExceptionClosedInitials], [ExceptionDesription], [Outsource], [OutsourceDate], [OutsourceInitials], [PRC_EmployeeID], [zzUnused_Glue_EmployeeID], [Final_EmployeeID], [exceptionOpened_EmployeeID], [ExceptionClosed_EmployeeID], [outsource_EmployeeID], [ExceptionId], [sort], [ProductID], [Prefinishing_Complete], [Prefinishing_Complete_Initials], [Prefinishing_Complete_Date], [Prefinishing_Complete_EmployeeID] FROM [dbo].[TblOrdersBOM_Items]
GO

-- Drop the source table

DROP TABLE [dbo].[TblOrdersBOM_Items]
GO

-- Create the destination table

CREATE TABLE [dbo].[TblOrdersBOM_Items] (
  [OrderItemsID] int IDENTITY(1, 1) NOT NULL,
  [OrderID] numeric(10, 0) NULL,
  [ProductID] int NULL,
  [zzUnused_BOM_ID] int NULL,
  [Quantity] float CONSTRAINT [DF_TblOrdersBOM_Items_Quantity] DEFAULT 0 NULL,
  [QuantityShipped] float CONSTRAINT [DF_TblOrdersBOM_Items_QuantityShipped] DEFAULT 0 NULL,
  [Unit_of_Measure] varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [UnitPrice] money CONSTRAINT [DF_TblOrdersBOM_Items_UnitPrice] DEFAULT 0 NULL,
  [Discount] float CONSTRAINT [DF_TblOrdersBOM_Items_Discount] DEFAULT 0 NULL,
  [Status] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Special_Instructions] varchar(150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [In_House_Notes] text COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Customer_Notes] text COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [BackOrderCreated] bit CONSTRAINT [DF_TblOrdersBOM_Items_BackOrderCreated] DEFAULT 0 NULL,
  [ProductName] varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Product_Descripton] varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Temp_ProductID] int NULL,
  [Purchase_Price] money CONSTRAINT [DF_TblOrdersBOM_Items_Purchase_Price] DEFAULT 0 NULL,
  [zzUnused_OldorderID] int NULL,
  [zzUnused_OldOrderItemsID] int NULL,
  [zzUnused_OldQuoteItemsID] int NULL,
  [zzUnused_OldQuoteID] int CONSTRAINT [DF_TblOrdersBOM_Items_QuoteID] DEFAULT 0 NULL,
  [UnitWeight] real CONSTRAINT [DF_TblOrdersBOM_Items_Weight] DEFAULT 0 NULL,
  [timestamp] timestamp NULL,
  [ReadytoShip] bit CONSTRAINT [DF_TblOrdersBOM_Items_ReadytoShip] DEFAULT 0 NULL,
  [Prod_BoardFeet] numeric(18, 0) CONSTRAINT [DF_TblOrdersBOM_Items_BoardFeet] DEFAULT 0 NULL,
  [Prod_RipOperator] int CONSTRAINT [DF_TblOrdersBOM_Items_Prod_RipOperator] DEFAULT 0 NULL,
  [Prod_Vendor] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Delivered] bit CONSTRAINT [DF_TblOrdersBOM_Items_Delivered] DEFAULT 0 NULL,
  [DeliveredDate] datetime NULL,
  [DropShipItem] bit CONSTRAINT [DF_TblOrdersBOM_Items_DropShipItem] DEFAULT 0 NULL,
  [zzUnused_lumber_pack] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [PRC] bit CONSTRAINT [DF_TblOrdersBOM_Items_PRC] DEFAULT 0 NULL,
  [zzUnused_Glue] bit CONSTRAINT [DF_TblOrdersBOM_Items_Glue] DEFAULT 0 NULL,
  [Final] bit CONSTRAINT [DF_TblOrdersBOM_Items_Final] DEFAULT 0 NULL,
  [Prefinishing_Complete] bit CONSTRAINT [DF__TblOrders__Prefi__605D434C] DEFAULT 0 NULL,
  [PRC_Initials] text COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [zzUnused_Glue_Initials] text COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Final_Initials] text COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Prefinishing_Complete_Initials] text COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [PRC_Date] datetime NULL,
  [zzUnused_Glue_Date] datetime NULL,
  [Final_Date] datetime NULL,
  [Prefinishing_Complete_Date] datetime NULL,
  [PRC_EmployeeID] bigint NULL,
  [zzUnused_Glue_EmployeeID] bigint NULL,
  [Final_EmployeeID] bigint NULL,
  [Prefinishing_Complete_EmployeeID] bigint NULL,
  [ExceptionOpened] bit CONSTRAINT [DF_TblOrdersBOM_Items_Exception] DEFAULT 0 NULL,
  [ExceptonDateCreated] datetime NULL,
  [ExceptionDateClosed] datetime NULL,
  [ExceptionCreateInitials] text COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ExceptionClosed] bit CONSTRAINT [DF_TblOrdersBOM_Items_ExceptionClosed] DEFAULT 0 NULL,
  [ExceptionClosedInitials] text COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ExceptionDesription] text COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Outsource] bit NULL,
  [OutsourceDate] datetime NULL,
  [OutsourceInitials] text COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [exceptionOpened_EmployeeID] bigint NULL,
  [ExceptionClosed_EmployeeID] bigint NULL,
  [outsource_EmployeeID] bigint NULL,
  [ExceptionId] bigint NULL,
  [sort] bigint NULL,
  CONSTRAINT [PK_OrderBOM_Details] PRIMARY KEY CLUSTERED ([OrderItemsID]),
  CONSTRAINT [FK_TblOrdersBOM_Items_Products] FOREIGN KEY ([ProductID]) 
  REFERENCES [dbo].[Products] ([ProductID]) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION,
  CONSTRAINT [FK_TblOrdersBOM_Items_Tbl_BOM1] FOREIGN KEY ([zzUnused_BOM_ID]) 
  REFERENCES [dbo].[zzUnused_Tbl_BOM] ([BOM_ID]) 
  ON UPDATE NO ACTION
  ON DELETE CASCADE,
  CONSTRAINT [FK_TblOrdersBOM_Items_TblOrdersBOM] FOREIGN KEY ([OrderID]) 
  REFERENCES [dbo].[TblOrdersBOM] ([OrderID]) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[TblOrdersBOM_Items]
NOCHECK CONSTRAINT [FK_TblOrdersBOM_Items_Products]
GO

ALTER TABLE [dbo].[TblOrdersBOM_Items]
NOCHECK CONSTRAINT [FK_TblOrdersBOM_Items_Tbl_BOM1]
GO

ALTER TABLE [dbo].[TblOrdersBOM_Items]
NOCHECK CONSTRAINT [FK_TblOrdersBOM_Items_TblOrdersBOM]
GO

CREATE NONCLUSTERED INDEX [idx_TblOrdersBOM_Items_ProductID] ON [dbo].[TblOrdersBOM_Items]
  ([ProductID])
ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [IX_BOM_ID] ON [dbo].[TblOrdersBOM_Items]
  ([zzUnused_BOM_ID])
WITH
  FILLFACTOR = 90
ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [IX_OrderID] ON [dbo].[TblOrdersBOM_Items]
  ([OrderID])
WITH
  FILLFACTOR = 90
ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [TblOrdersBOM_Items19] ON [dbo].[TblOrdersBOM_Items]
  ([OrderID], [OrderItemsID], [Quantity], [QuantityShipped], [Unit_of_Measure], [Special_Instructions], [ProductName], [Product_Descripton])
ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [TblOrdersBOM_Items49] ON [dbo].[TblOrdersBOM_Items]
  ([OrderItemsID], [OrderID], [Quantity])
ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [TblOrdersBOM_Items54] ON [dbo].[TblOrdersBOM_Items]
  ([zzUnused_OldOrderItemsID], [OrderID])
ON [PRIMARY]
GO

-- Copy the temporary table's data to the destination table

SET IDENTITY_INSERT [dbo].[TblOrdersBOM_Items] ON
GO

INSERT INTO [dbo].[TblOrdersBOM_Items] ([OrderItemsID], [OrderID], [ProductID], [zzUnused_BOM_ID], [Quantity], [QuantityShipped], [Unit_of_Measure], [UnitPrice], [Discount], [Status], [Special_Instructions], [In_House_Notes], [Customer_Notes], [BackOrderCreated], [ProductName], [Product_Descripton], [Temp_ProductID], [Purchase_Price], [zzUnused_OldorderID], [zzUnused_OldOrderItemsID], [zzUnused_OldQuoteItemsID], [zzUnused_OldQuoteID], [UnitWeight], [ReadytoShip], [Prod_BoardFeet], [Prod_RipOperator], [Prod_Vendor], [Delivered], [DeliveredDate], [DropShipItem], [zzUnused_lumber_pack], [PRC], [zzUnused_Glue], [Final], [Prefinishing_Complete], [PRC_Initials], [zzUnused_Glue_Initials], [Final_Initials], [Prefinishing_Complete_Initials], [PRC_Date], [zzUnused_Glue_Date], [Final_Date], [Prefinishing_Complete_Date], [PRC_EmployeeID], [zzUnused_Glue_EmployeeID], [Final_EmployeeID], [Prefinishing_Complete_EmployeeID], [ExceptionOpened], [ExceptonDateCreated], [ExceptionDateClosed], [ExceptionCreateInitials], [ExceptionClosed], [ExceptionClosedInitials], [ExceptionDesription], [Outsource], [OutsourceDate], [OutsourceInitials], [exceptionOpened_EmployeeID], [ExceptionClosed_EmployeeID], [outsource_EmployeeID], [ExceptionId], [sort])
SELECT [OrderItemsID], [OrderID], [ProductID], [zzUnused_BOM_ID], [Quantity], [QuantityShipped], [Unit_of_Measure], [UnitPrice], [Discount], [Status], [Special_Instructions], [In_House_Notes], [Customer_Notes], [BackOrderCreated], [ProductName], [Product_Descripton], [Temp_ProductID], [Purchase_Price], [zzUnused_OldorderID], [zzUnused_OldOrderItemsID], [zzUnused_OldQuoteItemsID], [zzUnused_OldQuoteID], [UnitWeight], [ReadytoShip], [Prod_BoardFeet], [Prod_RipOperator], [Prod_Vendor], [Delivered], [DeliveredDate], [DropShipItem], [zzUnused_lumber_pack], [PRC], [zzUnused_Glue], [Final], [Prefinishing_Complete], [PRC_Initials], [zzUnused_Glue_Initials], [Final_Initials], [Prefinishing_Complete_Initials], [PRC_Date], [zzUnused_Glue_Date], [Final_Date], [Prefinishing_Complete_Date], [PRC_EmployeeID], [zzUnused_Glue_EmployeeID], [Final_EmployeeID], [Prefinishing_Complete_EmployeeID], [ExceptionOpened], [ExceptonDateCreated], [ExceptionDateClosed], [ExceptionCreateInitials], [ExceptionClosed], [ExceptionClosedInitials], [ExceptionDesription], [Outsource], [OutsourceDate], [OutsourceInitials], [exceptionOpened_EmployeeID], [ExceptionClosed_EmployeeID], [outsource_EmployeeID], [ExceptionId], [sort] FROM [dbo].[#TblOrdersBOM_Items4302]
GO

SET IDENTITY_INSERT [dbo].[TblOrdersBOM_Items] OFF
GO

-- Enable disabled constraints

ALTER TABLE [dbo].[TblOrdersBOM_Items]
CHECK CONSTRAINT [FK_TblOrdersBOM_Items_Products]
GO

ALTER TABLE [dbo].[TblOrdersBOM_Items]
CHECK CONSTRAINT [FK_TblOrdersBOM_Items_Tbl_BOM1]
GO

ALTER TABLE [dbo].[TblOrdersBOM_Items]
CHECK CONSTRAINT [FK_TblOrdersBOM_Items_TblOrdersBOM]
GO