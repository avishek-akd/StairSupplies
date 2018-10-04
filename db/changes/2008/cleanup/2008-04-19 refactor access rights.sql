--
--  User_types -> Employees_role
--
EXEC sp_rename '[dbo].[User_types]', 'Employees_role', 'OBJECT'
GO
EXEC sp_rename '[dbo].[Employees_role].[User_type_id]', 'role_id', 'COLUMN'
GO
EXEC sp_rename '[dbo].[Employees_role].[User_type_name]', 'role_name', 'COLUMN'
GO
INSERT INTO Employees_role(role_name) VALUES('Vendor (for lumber availability)')
GO


--
--  Access_rights -> Employees_role_access
--
EXEC sp_rename '[dbo].[Access_rights]', 'Employees_role_access', 'OBJECT'
GO
EXEC sp_rename '[dbo].[Employees_role_access].[User_type_Id]', 'role_id', 'COLUMN'
GO


--
--  Module -> Employees_module
--
EXEC sp_rename '[dbo].[Module]', 'Employees_module', 'OBJECT'
GO


--
--  Rename the primary key in Employees_role_access
--
BEGIN TRANSACTION
ALTER TABLE dbo.Employees_role_access
	DROP CONSTRAINT FK_Access_rights_User_types
GO
ALTER TABLE dbo.Employees_role
	DROP CONSTRAINT PK_User_types
GO
ALTER TABLE dbo.Employees_role ADD CONSTRAINT
	PK_Employees_role PRIMARY KEY CLUSTERED 
	(
	role_id
	) ON [PRIMARY]

GO
COMMIT
BEGIN TRANSACTION
ALTER TABLE dbo.Employees_role_access WITH NOCHECK ADD CONSTRAINT
	FK_Access_rights_User_types FOREIGN KEY
	(
	role_id
	) REFERENCES dbo.Employees_role
	(
	role_id
	) ON DELETE CASCADE
	
GO
COMMIT


--  (Employees_role_access) Rename the indexes and FK
EXEC sp_rename '[dbo].[FK_Access_rights_Module]', 'FK_Employees_role_access_module', 'OBJECT'
GO
EXEC sp_rename '[dbo].[FK_Access_rights_User_types]', 'FK_Employees_role_access_role', 'OBJECT'
GO

EXEC sp_rename '[dbo].[Employees_role_access].[idx_Access_rights_module]', 'idx_Employees_role_access_module', 'INDEX'
GO
DROP INDEX [dbo].[Employees_role_access].[idx_Employees_role_access_module]
GO
CREATE NONCLUSTERED INDEX [idx_Employees_role_access_module] ON [dbo].[Employees_role_access]
  ([Module_id])
ON [PRIMARY]
GO

EXEC sp_rename '[dbo].[Employees_role_access].[idx_Access_rights_user_type]', 'idx_Employees_role_access_role', 'INDEX'
GO
DROP INDEX [dbo].[Employees_role_access].[idx_Employees_role_access_role]
GO
CREATE NONCLUSTERED INDEX [idx_Employees_role_access_role] ON [dbo].[Employees_role_access]
  ([role_id])
ON [PRIMARY]
GO


EXEC sp_addextendedproperty 'MS_Description', N'Store the assigned rights (access rights) that a Role has to a module.
This is an n:m table relation between Employees_role and Employees_module.', 'user', 'dbo', 'table', 'Employees_role_access'
GO


--
--  Employees_module
--
ALTER TABLE [dbo].[Employees_module]
ADD [Module_directory] varchar(100) NULL
GO
EXEC sp_addextendedproperty 'MS_Description', N'Directory (relative to ironbaluster/ root) under which the module resides. Examples: "CustomerService", "purchasing/lumber_availability", etc', 'user', 'dbo', 'table', 'Employees_module', 'column', 'Module_directory'
GO
ALTER TABLE [dbo].[Employees_module]
ALTER COLUMN [Module_name] varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS
GO
UPDATE Employees_module SET Module_directory = '/Admin/' WHERE Module_id = 1;
UPDATE Employees_module SET Module_directory = '/Shipping/' WHERE Module_id = 2;
UPDATE Employees_module SET Module_directory = '/production/' WHERE Module_id = 3;
UPDATE Employees_module SET Module_directory = '/purchasing/' WHERE Module_id = 4;
UPDATE Employees_module SET Module_directory = '/sales/' WHERE Module_id = 5;
UPDATE Employees_module SET Module_directory = '/CustomerService/' WHERE Module_id = 6;
UPDATE Employees_module SET Module_directory = '/Accounting/' WHERE Module_id = 7;
UPDATE Employees_module SET Module_directory = '/products/' WHERE Module_id = 8;
UPDATE Employees_module SET Module_directory = '/receiving/' WHERE Module_id = 11;
UPDATE Employees_module SET Module_directory = '/teaminfo/' WHERE Module_id = 12;
INSERT INTO  Employees_module(Module_id, Module_name, Module_directory) VALUES (13, 'Purchasing / Lumber Availability (Vendor access only)', '/purchasing/lumber_availability/');


--
--  Employees
--
EXEC sp_rename '[dbo].[Employees].[UserLevel]', 'zzUnused_UserLevel', 'COLUMN'
GO
EXEC sp_rename '[dbo].[Employees].[User_type_ID]', 'Role_id', 'COLUMN'
GO
EXEC sp_addextendedproperty 'MS_Description', N'Employee role in the application.', 'user', 'dbo', 'table', 'Employees', 'column', 'Role_id'
GO
EXEC sp_addextendedproperty 'MS_Description', N'The employee can be a vendor that needs access to parts of the application so this is his id.
If this is NULL then it''s a regular employee, otherwise it''s a vendor.
When the vendor is deleted so is the Employee.', 'user', 'dbo', 'table', 'Employees', 'column', 'vendor_id'
GO
UPDATE Employees SET vendor_id = NULL where vendor_id = 0;


UPDATE Employees SET Role_id = NULL WHERE Role_id = 0;
ALTER TABLE [dbo].[Employees]
ADD CONSTRAINT [FK_Employees_Role] FOREIGN KEY ([Role_id]) 
  REFERENCES [dbo].[Employees_role] ([role_id]) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
GO
ALTER TABLE [dbo].[Employees]
ADD CONSTRAINT [FK_Employees_Vendor] FOREIGN KEY ([vendor_id]) 
  REFERENCES [dbo].[TBLVendor] ([Vendor_ID]) 
  ON UPDATE NO ACTION
  ON DELETE CASCADE
GO
CREATE NONCLUSTERED INDEX [idx_Employees_role] ON [dbo].[Employees]
  ([Role_id])
GO
CREATE NONCLUSTERED INDEX [idx_Employees_Vendor] ON [dbo].[Employees]
  ([vendor_id])
GO
UPDATE Employees SET role_id = 5 WHERE EmployeeID = 122
GO