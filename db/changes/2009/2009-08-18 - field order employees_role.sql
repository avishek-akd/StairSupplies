-- Create a temporary table

IF EXISTS (SELECT o.object_id FROM sys.objects o INNER JOIN sys.schemas u ON o.schema_id = u.schema_id
    WHERE o.name = N'#Employees_role3207' AND u.name = N'dbo')
BEGIN
  DROP TABLE [dbo].[#Employees_role3207]
END
GO

CREATE TABLE [dbo].[#Employees_role3207] (
  [role_name] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [role_id] int NOT NULL
)
GO

-- Copy the source table's data to the temporary table

INSERT INTO [dbo].[#Employees_role3207] ([role_name], [role_id])
SELECT [role_name], [role_id] FROM [dbo].[Employees_role]
GO

-- Delete objects that depends on the table

ALTER TABLE [dbo].[Employees]
DROP CONSTRAINT [FK_Employees_Role]
GO

ALTER TABLE [dbo].[Employees_role_access]
DROP CONSTRAINT [FK_Employees_role_access_role]
GO

-- Drop the source table

DROP TABLE [dbo].[Employees_role]
GO

-- Create the destination table

CREATE TABLE [dbo].[Employees_role] (
  [role_id] int IDENTITY(1, 1) NOT NULL,
  [role_name] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  CONSTRAINT [PK_Employees_role] PRIMARY KEY CLUSTERED ([role_id])
)
ON [PRIMARY]
GO

-- Copy the temporary table's data to the destination table

SET IDENTITY_INSERT [dbo].[Employees_role] ON
GO

INSERT INTO [dbo].[Employees_role] ([role_id], [role_name])
SELECT [role_id], [role_name] FROM [dbo].[#Employees_role3207]
GO

SET IDENTITY_INSERT [dbo].[Employees_role] OFF
GO

-- Recreate objects that depends on the table
GO

ALTER TABLE [dbo].[Employees]
ADD CONSTRAINT [FK_Employees_Role] FOREIGN KEY ([Role_id]) 
  REFERENCES [dbo].[Employees_role] ([role_id]) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
GO

ALTER TABLE [dbo].[Employees_role_access]
ADD CONSTRAINT [FK_Employees_role_access_role] FOREIGN KEY ([role_id]) 
  REFERENCES [dbo].[Employees_role] ([role_id]) 
  ON UPDATE NO ACTION
  ON DELETE CASCADE
GO