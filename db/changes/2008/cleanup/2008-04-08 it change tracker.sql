--  Remove IT Change Tracker
EXEC sp_rename '[dbo].[tblChange]', 'zzUnused_tblChange', 'OBJECT'
GO
EXEC sp_rename '[dbo].[tblChangeType]', 'zzUnused_tblChangeType', 'OBJECT'
GO