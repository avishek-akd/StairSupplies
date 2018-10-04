ALTER TABLE [dbo].[Products]
ADD [species]int NULL,
ADD [BoardFootage]int NULL
GO

EXEC sp_addextendedproperty 'MS_Description', N'This is a foreign key into the tbl_lumber_species table.', 'user', 'dbo', 'table', 'Products', 'column', 'species'
GO