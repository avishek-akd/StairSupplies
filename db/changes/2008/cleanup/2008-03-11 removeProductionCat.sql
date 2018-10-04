--  Rename ProductionCat_id because it's no longer used
EXEC sp_rename '[dbo].[Products].[ProductionCat_ID]', 'zzUnused_ProductionCat_ID', 'COLUMN'
GO