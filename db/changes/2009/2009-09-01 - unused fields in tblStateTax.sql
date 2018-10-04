delete from tblStateTax where id = 48;


EXEC sp_rename '[dbo].[TblStateTax].[StartDate]', 'z_unused_StartDate', 'COLUMN'
GO
EXEC sp_rename '[dbo].[TblStateTax].[EndDate]', 'z_unused_EndDate', 'COLUMN'
GO


ALTER TABLE [dbo].[TblStateTax]
ADD CONSTRAINT [TblStateTax_uq] 
UNIQUE NONCLUSTERED ([State])
WITH (
  PAD_INDEX = OFF,
  IGNORE_DUP_KEY = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
GO