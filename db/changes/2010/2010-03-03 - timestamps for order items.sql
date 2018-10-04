ALTER TABLE [dbo].[TblOrdersBOM_Items]
ADD [RecordCreated] datetime DEFAULT GetDate() NULL
GO