ALTER TABLE [dbo].[TblOrdersBOM_OrderShipmentsDetails]
ADD [PalletNumber] int NULL
GO


-- Create a temporary table
IF EXISTS (SELECT o.id FROM sysobjects o INNER JOIN sysusers u ON o.uid = u.uid
    WHERE o.name = N'#TblOrdersBOM_OrderShipmentsDetails2933' AND u.name = N'dbo')
BEGIN
  DROP TABLE [dbo].[#TblOrdersBOM_OrderShipmentsDetails2933]
END
GO

CREATE TABLE [dbo].[#TblOrdersBOM_OrderShipmentsDetails2933] (
  [OrderShipmentDetails_ID] numeric(10, 0) NOT NULL,
  [OrderShipment_id] numeric(10, 0) NULL,
  [OrderItemsID] int NOT NULL,
  [QuantityShipped] float NOT NULL,
  [DateAdded] smalldatetime NULL,
  [DateUpdated] smalldatetime NULL,
  [PalletNumber] int NULL
)
GO

-- Copy the source table's data to the temporary table

INSERT INTO [dbo].[#TblOrdersBOM_OrderShipmentsDetails2933] ([OrderShipmentDetails_ID], [OrderShipment_id], [OrderItemsID], [QuantityShipped], [DateAdded], [DateUpdated], [PalletNumber])
SELECT [OrderShipmentDetails_ID], [OrderShipment_id], [OrderItemsID], [QuantityShipped], [DateAdded], [DateUpdated], [PalletNumber] FROM [dbo].[TblOrdersBOM_OrderShipmentsDetails]
GO

-- Drop the source table

DROP TABLE [dbo].[TblOrdersBOM_OrderShipmentsDetails]
GO

-- Create the destination table

CREATE TABLE [dbo].[TblOrdersBOM_OrderShipmentsDetails] (
  [OrderShipmentDetails_ID] numeric(10, 0) IDENTITY(1, 1) NOT NULL,
  [OrderShipment_id] numeric(10, 0) NULL,
  [OrderItemsID] int CONSTRAINT [DF_TblOrdersBOM_OrderShipmentsDetails_OrderItemsID] DEFAULT 0 NOT NULL,
  [QuantityShipped] float CONSTRAINT [DF_TblOrdersBOM_OrderShipmentsDetails_QuantityShipped] DEFAULT 0 NOT NULL,
  [PalletNumber] int NULL,
  [DateAdded] smalldatetime CONSTRAINT [DF_TblOrdersBOM_OrderShipmentsDetails_DateAdded] DEFAULT convert(datetime,convert(varchar,getdate())) NULL,
  [DateUpdated] smalldatetime CONSTRAINT [DF_TblOrdersBOM_OrderShipmentsDetails_DateUpdated] DEFAULT convert(datetime,convert(varchar,getdate())) NULL,
  CONSTRAINT [PK_TblOrdersBOM_OrderShipmentsDetails] PRIMARY KEY CLUSTERED ([OrderShipmentDetails_ID])
)
ON [PRIMARY]
GO

-- Copy the temporary table's data to the destination table

SET IDENTITY_INSERT [dbo].[TblOrdersBOM_OrderShipmentsDetails] ON
GO

INSERT INTO [dbo].[TblOrdersBOM_OrderShipmentsDetails] ([OrderShipmentDetails_ID], [OrderShipment_id], [OrderItemsID], [QuantityShipped], [PalletNumber], [DateAdded], [DateUpdated])
SELECT [OrderShipmentDetails_ID], [OrderShipment_id], [OrderItemsID], [QuantityShipped], [PalletNumber], [DateAdded], [DateUpdated] FROM [dbo].[#TblOrdersBOM_OrderShipmentsDetails2933]
GO

SET IDENTITY_INSERT [dbo].[TblOrdersBOM_OrderShipmentsDetails] OFF
GO





ALTER TABLE [dbo].[TblOrdersBOM]
ADD [estimated_shipping_cost] decimal(10, 2) NULL
GO
ALTER TABLE [dbo].[TblOrdersBOM]
ADD [actual_shipping_cost] decimal(10, 2) NULL
GO



EXEC sp_rename '[dbo].[TblOrdersBOM_OrderShipmentsDetails].[PalletNumber]', 'BoxNumber', 'COLUMN'
GO


EXEC sp_rename '[dbo].[TblOrdersBOM_OrderShipmentsDetails].[BoxNumber]', 'BoxSkidNumber', 'COLUMN'
GO

ALTER TABLE [dbo].[TblOrdersBOM_OrderShipmentsDetails]
ALTER COLUMN [BoxSkidNumber] varchar(10)
GO