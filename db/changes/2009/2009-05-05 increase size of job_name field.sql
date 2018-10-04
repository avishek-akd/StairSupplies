DROP INDEX [dbo].[TblOrdersBOM].[IX_OrdersBOMJob_Name]
GO
ALTER TABLE [dbo].[TblOrdersBOM]
ALTER COLUMN [Job_Name] varchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS
GO
CREATE CLUSTERED INDEX [IX_OrdersBOMJob_Name] ON [dbo].[TblOrdersBOM]
  ([Job_Name])
WITH
  FILLFACTOR = 90
ON [PRIMARY]
GO

ALTER TABLE [dbo].[TblOrdersBOM_temp]
ALTER COLUMN [Job_Name] varchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS
GO