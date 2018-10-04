CREATE TABLE [dbo].[tblChange] (
  [id] int IDENTITY(1, 1) NOT NULL,
  [d_employee_id] int NOT NULL,
  [d_change_type_id] int NOT NULL,
  [d_hw_asset_id] int NULL,
  [d_create_ip_address] varchar(15) NOT NULL,
  [d_change_date] smalldatetime NULL,
  [d_description] varchar(1000) NULL,
  [d_created_on] datetime NULL,
  PRIMARY KEY CLUSTERED ([id])
)
GO


ALTER TABLE [dbo].[tblChange]
ADD CONSTRAINT [tblChange_fk2] FOREIGN KEY ([d_employee_id]) 
  REFERENCES [dbo].[Employees] ([EmployeeID]) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
GO


ALTER TABLE [dbo].[tblChange]
ADD CONSTRAINT [tblChange_fk] FOREIGN KEY ([d_change_type_id]) 
  REFERENCES [dbo].[tblChangeType] ([id]) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
GO


ALTER TABLE [dbo].[tblChange]
ADD CONSTRAINT [tblChange_fk3] FOREIGN KEY ([d_hw_asset_id]) 
  REFERENCES [dbo].[Asset] ([AssetID]) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
GO



EXEC sp_addextendedproperty 'MS_Description', N'Employee who made the change', 'user', 'dbo', 'table', 'tblChange', 'column', 'd_employee_id'
GO

EXEC sp_addextendedproperty 'MS_Description', N'Type of change', 'user', 'dbo', 'table', 'tblChange', 'column', 'd_change_type_id'
GO

EXEC sp_addextendedproperty 'MS_Description', N'IP address of the person who created the change', 'user', 'dbo', 'table', 'tblChange', 'column', 'd_create_ip_address'
GO

EXEC sp_addextendedproperty 'MS_Description', N'Id of the hardware changed (when the changed asset is hardware)', 'user', 'dbo', 'table', 'tblChange', 'column', 'd_hw_asset_id'
GO

EXEC sp_addextendedproperty 'MS_Description', N'Description of the change', 'user', 'dbo', 'table', 'tblChange', 'column', 'd_description'
GO

EXEC sp_addextendedproperty 'MS_Description', N'When was this entry inserted into the db.', 'user', 'dbo', 'table', 'tblChange', 'column', 'd_created_on'
GO

EXEC sp_addextendedproperty 'MS_Description', N'Time when the change was made', 'user', 'dbo', 'table', 'tblChange', 'column', 'd_change_date'
GO
