ALTER TABLE [dbo].[Products]
ADD [copied_to_bom]bit DEFAULT 0 NULL
GO
UPDATE [dbo].[Products]
SET [copied_to_bom] = 1
GO