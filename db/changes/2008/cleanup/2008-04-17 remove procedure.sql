EXEC sp_rename '[dbo].[position]', 'zzUnused_position', 'OBJECT'
GO

--  Remove Procedure from the available modules
DELETE FROM Module WHERE Module_id = 10;