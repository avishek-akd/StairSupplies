EXEC sp_rename '[dbo].[TblOrdersBOM_Items].[Signed]', 'z_unused_Signed', 'COLUMN'
GO
EXEC sp_rename '[dbo].[TblOrdersBOM_Items].[Signed_Date]', 'z_unused_Signed_Date', 'COLUMN'
GO
EXEC sp_rename '[dbo].[TblOrdersBOM_Items].[Signed_EmployeeID]', 'z_unused_Signed_EmployeeID', 'COLUMN'
GO
EXEC sp_rename '[dbo].[TblOrdersBOM_Items].[Signed_Initials]', 'z_unused_Signed_Initials', 'COLUMN'
GO