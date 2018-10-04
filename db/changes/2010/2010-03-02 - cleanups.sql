CREATE NONCLUSTERED INDEX [tblRGAProduct_idx] ON [dbo].[tblRGAProduct]
  ([d_rga_request_id])
WITH (
  PAD_INDEX = OFF,
  DROP_EXISTING = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  SORT_IN_TEMPDB = OFF,
  ONLINE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
GO
CREATE NONCLUSTERED INDEX [tblRGARequest_idx] ON [dbo].[tblRGARequest]
  ([d_return_reason_id])
WITH (
  PAD_INDEX = OFF,
  DROP_EXISTING = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  SORT_IN_TEMPDB = OFF,
  ONLINE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
GO
ALTER TABLE [dbo].[Employees]
DROP CONSTRAINT [DF_Employees_email]
GO
ALTER TABLE [dbo].[Employees]
ALTER COLUMN [email] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS
GO


DROP VIEW [dbo].[View_BOMOrders]
GO


update Customers
SET email = NULL
WHERE email = '' OR email like 'no email%' or email = '`' or email like 'XXXXX%'
	OR (email NOT LIKE '%@%')
GO
update Employees
SET email = NULL
WHERE email = '' OR email like 'no email%' or email = '`' or email like 'XXXXX%'
	OR (email NOT LIKE '%@%') OR email LIKE 'none@none.com' OR email LIKE 'none@stairsupplies.com'
    OR (email = 'len@stairsupplies.com' and EmployeeID <> 1)
    OR email like '1234@1234.com' or email = '1@none.com' or email = 'none@none.no'
GO
EXEC sp_rename '[dbo].[TblOrdersBOM_Items].[timestamp]', 'z_unused_timestamp', 'COLUMN'
GO
EXEC sp_rename '[dbo].[TblOrdersBOM_Items].[Temp_ProductID]', 'z_unused_Temp_ProductID', 'COLUMN'
GO
EXEC sp_rename '[dbo].[TblOrdersBOM_Items].[BackOrderCreated]', 'z_unused_BackOrderCreated', 'COLUMN'
GO
EXEC sp_rename '[dbo].[TblOrdersBOM_Items].[DropShipItem]', 'z_unused_DropShipItem', 'COLUMN'
GO
EXEC sp_rename '[dbo].[TblOrdersBOM_Items].[ExceptionDesription]', 'z_unused_ExceptionDesription', 'COLUMN'
GO
EXEC sp_rename '[dbo].[TblOrdersBOM_Items].[ExceptionCreateInitials]', 'z_unused_ExceptionCreateInitials', 'COLUMN'
GO
EXEC sp_rename '[dbo].[TblOrdersBOM_Items].[ExceptionClosedInitials]', 'z_unused_ExceptionClosedInitials', 'COLUMN'
GO
EXEC sp_rename '[dbo].[TblOrdersBOM_Items].[Prod_RipOperator]', 'z_unused_Prod_RipOperator', 'COLUMN'
GO
EXEC sp_rename '[dbo].[TblOrdersBOM_Items].[Prod_Vendor]', 'z_unused_Prod_Vendor', 'COLUMN'
GO
EXEC sp_rename '[dbo].[TblOrdersBOM_Items].[sort]', 'z_unused_sort', 'COLUMN'
GO