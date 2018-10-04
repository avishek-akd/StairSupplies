update CustomerNotes set [sales person]=NULL where [sales person] in (0, 89, 91, 98, 105)
GO

ALTER TABLE [dbo].[CustomerNotes]
ADD CONSTRAINT [CustomerNotes_fk] FOREIGN KEY ([Sales Person]) 
  REFERENCES [dbo].[Employees] ([EmployeeID]) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
GO
CREATE NONCLUSTERED INDEX [CustomerNotes_idx] ON [dbo].[CustomerNotes]
  ([Sales Person])
WITH (
  PAD_INDEX = OFF,
  DROP_EXISTING = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  SORT_IN_TEMPDB = OFF,
  ONLINE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
GO


ALTER TABLE [dbo].[CustomerNotes]
ALTER COLUMN [CustomerID] int
GO
update CustomerNotes
set CustomerID = NULL
where customerID IN (
		select distinct CustomerID
		from CustomerNotes
		where [CustomerID] not in (select CustomerID from Customers)
        )
GO
ALTER TABLE [dbo].[CustomerNotes]
ADD CONSTRAINT [CustomerNotes_fk2] FOREIGN KEY ([CustomerID]) 
  REFERENCES [dbo].[Customers] ([CustomerID]) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
GO
CREATE NONCLUSTERED INDEX [CustomerNotes_idx2] ON [dbo].[CustomerNotes]
  ([CustomerID])
WITH (
  PAD_INDEX = OFF,
  DROP_EXISTING = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  SORT_IN_TEMPDB = OFF,
  ONLINE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
GO


EXEC sp_rename '[dbo].[CustomerNotes].[NoteTypeOld]', 'z_unused_NoteTypeOld', 'COLUMN'
GO