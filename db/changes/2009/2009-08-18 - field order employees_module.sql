-- Create a temporary table

IF EXISTS (SELECT o.object_id FROM sys.objects o INNER JOIN sys.schemas u ON o.schema_id = u.schema_id
    WHERE o.name = N'#Employees_module3006' AND u.name = N'dbo')
BEGIN
  DROP TABLE [dbo].[#Employees_module3006]
END
GO

CREATE TABLE [dbo].[#Employees_module3006] (
  [Module_name] varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Module_id] int NOT NULL,
  [Module_directory] varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO

-- Copy the source table's data to the temporary table

INSERT INTO [dbo].[#Employees_module3006] ([Module_name], [Module_id], [Module_directory])
SELECT [Module_name], [Module_id], [Module_directory] FROM [dbo].[Employees_module]
GO

-- Delete objects that depends on the table

ALTER TABLE [dbo].[Employees_role_access]
DROP CONSTRAINT [FK_Employees_role_access_module]
GO

-- Drop the source table

DROP TABLE [dbo].[Employees_module]
GO

-- Create the destination table

CREATE TABLE [dbo].[Employees_module] (
  [Module_id] int NOT NULL,
  [Module_name] varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Module_directory] varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  CONSTRAINT [PK_Module] PRIMARY KEY CLUSTERED ([Module_id])
)
ON [PRIMARY]
GO

EXEC sp_addextendedproperty 'MS_Description', N'Directory (relative to ironbaluster/ root) under which the module resides. Examples: "CustomerService", "purchasing/lumber_availability", etc', 'schema', 'dbo', 'table', 'Employees_module', 'column', 'Module_directory'
GO

-- Copy the temporary table's data to the destination table

INSERT INTO [dbo].[Employees_module] ([Module_id], [Module_name], [Module_directory])
SELECT [Module_id], [Module_name], [Module_directory] FROM [dbo].[#Employees_module3006]
GO

-- Recreate objects that depends on the table
GO

ALTER TABLE [dbo].[Employees_role_access]
ADD CONSTRAINT [FK_Employees_role_access_module] FOREIGN KEY ([Module_id]) 
  REFERENCES [dbo].[Employees_module] ([Module_id]) 
  ON UPDATE NO ACTION
  ON DELETE CASCADE
GO