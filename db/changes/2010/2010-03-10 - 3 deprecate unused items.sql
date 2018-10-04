EXEC sp_rename '[dbo].[TblOrdersBOM].[color]', 'z_unused_color', 'COLUMN'
GO
EXEC sp_rename '[dbo].[TblOrdersBOM].[timestamp]', 'z_unused_timestamp', 'COLUMN'
GO
EXEC sp_rename '[dbo].[TblOrdersBOM].[actual_shipping_cost]', 'z_unused_actual_shipping_cost', 'COLUMN'
GO