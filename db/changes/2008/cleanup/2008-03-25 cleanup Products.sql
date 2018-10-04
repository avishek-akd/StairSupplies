--  Rename unused columns in Products table
EXEC sp_rename '[dbo].[Products].[Cat_id]', 'zzUnused_Cat_id', 'COLUMN'
GO
EXEC sp_rename '[dbo].[Products].[Style_id]', 'zzUnused_Style_id', 'COLUMN'
GO
EXEC sp_rename '[dbo].[Products].[Coating_ID]', 'zzUnused_Coating_ID', 'COLUMN'
GO
EXEC sp_rename '[dbo].[Products].[Option_ID]', 'zzUnused_Option_ID', 'COLUMN'
GO
EXEC sp_rename '[dbo].[Products].[Vendor]', 'zzUnused_Vendor', 'COLUMN'
GO
EXEC sp_rename '[dbo].[Products].[Vendor_Notes]', 'zzUnused_Vendor_Notes', 'COLUMN'
GO
EXEC sp_rename '[dbo].[Products].[Assembly]', 'zzUnused_Assembly', 'COLUMN'
GO
EXEC sp_rename '[dbo].[Products].[Warehouse]', 'zzUnused_Warehouse', 'COLUMN'
GO
EXEC sp_rename '[dbo].[Products].[Vendor_Part_Number]', 'zzUnused_Vendor_Part_Number', 'COLUMN'
GO
EXEC sp_rename '[dbo].[Products].[image1]', 'zzUnused_image1', 'COLUMN'
GO
EXEC sp_rename '[dbo].[Products].[image2]', 'zzUnused_image2', 'COLUMN'
GO
EXEC sp_rename '[dbo].[Products].[image3]', 'zzUnused_image3', 'COLUMN'
GO
EXEC sp_rename '[dbo].[Products].[image4]', 'zzUnused_image4', 'COLUMN'
GO
EXEC sp_rename '[dbo].[Products].[image5]', 'zzUnused_image5', 'COLUMN'
GO
EXEC sp_rename '[dbo].[Products].[Desc_Long]', 'zzUnused_Desc_Long', 'COLUMN'
GO
EXEC sp_rename '[dbo].[Products].[Desc_Short]', 'zzUnused_Desc_Short', 'COLUMN'
GO
EXEC sp_rename '[dbo].[Products].[leadtime]', 'zzUnused_leadtime', 'COLUMN'
GO
EXEC sp_rename '[dbo].[Products].[mfg_item]', 'zzUnused_mfg_item', 'COLUMN'
GO
EXEC sp_rename '[dbo].[Products].[Vendor_Qty_on_hand]', 'zzUnused_Vendor_Qty_on_hand', 'COLUMN'
GO
EXEC sp_rename '[dbo].[Products].[blueprint]', 'zzUnused_blueprint', 'COLUMN'
GO
EXEC sp_rename '[dbo].[Products].[Points]', 'zzUnused_Points', 'COLUMN'
GO


--  ProductType_id shouldn't be NULL
delete from products where productid = 4012;
EXEC sp_rename '[dbo].[Products].[Products59]', 'idx_Products_ProductType_id', 'INDEX'
GO
DROP INDEX [dbo].[Products].[idx_Products_ProductType_id]
GO
ALTER TABLE [dbo].[Products]
DROP CONSTRAINT [DF_Products_ProductType_id]
GO
ALTER TABLE [dbo].[Products]
ALTER COLUMN [ProductType_id] int NOT NULL
GO
ALTER TABLE [dbo].[Products]
ADD CONSTRAINT [DF_Products_ProductType_id] DEFAULT 1 FOR [ProductType_id]
GO
CREATE NONCLUSTERED INDEX [idx_Products_ProductType_id] ON [dbo].[Products]
  ([ProductType_id])
WITH
  FILLFACTOR = 90
ON [PRIMARY]
GO


-- TblProductVendors:
--  - rename unused columns
--  - this table is completely dependant on the Vendors and Products tables
EXEC sp_rename '[dbo].[TblProductVendors].[VendorParts_id]', 'zzUnused_VendorParts_id', 'COLUMN'
GO
EXEC sp_rename '[dbo].[TblProductVendors].[Vendor_Qty_on_hand]', 'zzUnused_Vendor_Qty_on_hand', 'COLUMN'
GO
ALTER TABLE [dbo].[TblProductVendors]
DROP CONSTRAINT [FK_TblProductVendors_TBLVendor]
GO

ALTER TABLE [dbo].[TblProductVendors]
ADD CONSTRAINT [FK_TblProductVendors_TBLVendor] FOREIGN KEY ([Vendor_ID]) 
  REFERENCES [dbo].[TBLVendor] ([Vendor_ID]) 
  ON UPDATE NO ACTION
  ON DELETE CASCADE
GO
ALTER TABLE [dbo].[TblProductVendors]
DROP CONSTRAINT [FK_TblProductVendors_Products]
GO

ALTER TABLE [dbo].[TblProductVendors]
ADD CONSTRAINT [FK_TblProductVendors_Products] FOREIGN KEY ([ProductID]) 
  REFERENCES [dbo].[Products] ([ProductID]) 
  ON UPDATE NO ACTION
  ON DELETE CASCADE
GO


-- ProductPrice:
--  - this table is completely dependant on the Products tables
ALTER TABLE [dbo].[ProductPrice]
DROP CONSTRAINT [FK_ProductPrice_Products]
GO

ALTER TABLE [dbo].[ProductPrice]
ADD CONSTRAINT [FK_ProductPrice_Products] FOREIGN KEY ([ProductID]) 
  REFERENCES [dbo].[Products] ([ProductID]) 
  ON UPDATE NO ACTION
  ON DELETE CASCADE
GO


-- Tbl_BOMDetails:
ALTER TABLE [dbo].[Tbl_BOMDetails]
DROP CONSTRAINT [FK_Tbl_BOMDetails_Products]
GO

ALTER TABLE [dbo].[Tbl_BOMDetails]
ADD CONSTRAINT [FK_Tbl_BOMDetails_Products] FOREIGN KEY ([ProductID]) 
  REFERENCES [dbo].[Products] ([ProductID]) 
  ON UPDATE NO ACTION
  ON DELETE CASCADE
GO


DELETE FROM Products WHERE ProductName is NULL;


-- EXEC sp_rename '[dbo].[Products].[Product_Descripton]', 'Product_Description', 'COLUMN'
-- GO