--  Columns must be not NULL
ALTER TABLE [dbo].[Access_rights]
ALTER COLUMN [User_type_Id] int NOT NULL;
ALTER TABLE [dbo].[Access_rights]
ALTER COLUMN [Module_id] int NOT NULL;

--  Remove left-over modules id's
DELETE
FROM Access_rights
WHERE Module_id not in (select module_id from Module);


--  Add foreign keys to both columns
ALTER TABLE [dbo].[Access_rights]
ADD CONSTRAINT [FK_Access_rights_User_types] FOREIGN KEY ([User_type_Id]) 
  REFERENCES [dbo].[User_types] ([User_type_id]) 
  ON UPDATE NO ACTION
  ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Access_rights]
ADD CONSTRAINT [FK_Access_rights_Module] FOREIGN KEY ([Module_id]) 
  REFERENCES [dbo].[Module] ([Module_id]) 
  ON UPDATE NO ACTION
  ON DELETE CASCADE
GO


--  Add indexes to both columns
CREATE NONCLUSTERED INDEX [idx_Access_rights_user_type] ON [dbo].[Access_rights]
  ([User_type_Id])
GO
CREATE NONCLUSTERED INDEX [idx_Access_rights_module] ON [dbo].[Access_rights]
  ([Module_id])
GO

--  Maintenance is not used anymore
DELETE FROM Module WHERE Module_id = 9;