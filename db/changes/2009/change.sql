ALTER TABLE [dbo].[tbl_lumber_availability]
DROP COLUMN [d_5_4]
GO
ALTER TABLE [dbo].[tbl_lumber_availability]
DROP COLUMN [d_4_4_longest_id]
GO
ALTER TABLE [dbo].[tbl_lumber_availability]
DROP COLUMN [d_date_available]
GO
DROP TABLE [dbo].[tbl_lumber_longest]
GO

ALTER TABLE [dbo].[tbl_lumber_availability]
ADD [d_date_4_4]varchar(200) NULL
GO
ALTER TABLE [dbo].[tbl_lumber_availability]
ADD [d_date_5_4]varchar(200) NULL
GO
ALTER TABLE [dbo].[tbl_lumber_availability]
ADD [d_date_8_4]varchar(200) NULL
GO
ALTER TABLE [dbo].[tbl_lumber_availability]
ADD [d_date_other]varchar(200) NULL
GO
