--  dba is not used anymore
EXEC sp_rename '[dbo].[Employees].[dba]', 'zzUnused_dba', 'COLUMN';
EXEC sp_rename '[dbo].[TBLVendor].[dba]', 'zzUnused_dba', 'COLUMN';
