ALTER TABLE [dbo].[Employees]
ADD [CellPhone] varchar(50) NULL
GO
ALTER TABLE [dbo].[Employees]
ADD [HomePhone] varchar(50) NULL
GO
ALTER TABLE [dbo].[Employees]
ADD [EmergencyContactName] varchar(100) NULL
GO
ALTER TABLE [dbo].[Employees]
ADD [EmergencyContactNumber] varchar(50) NULL
GO
ALTER TABLE [dbo].[Employees]
ADD [Address] varchar(100) NULL
GO
ALTER TABLE [dbo].[Employees]
ADD [City] varchar(50) NULL
GO
ALTER TABLE [dbo].[Employees]
ADD [State] varchar(50) NULL
GO
ALTER TABLE [dbo].[Employees]
ADD [Zip] varchar(10) NULL
GO


ALTER TABLE [dbo].[Employees]
ADD [StartDate] smalldatetime NULL
GO
ALTER TABLE [dbo].[Employees]
ADD [ReceivedAccessHandbook] bit DEFAULT 0 NULL
GO
ALTER TABLE [dbo].[Employees]
ADD [TrainingForkliftComplete] bit DEFAULT 0 NULL
GO
ALTER TABLE [dbo].[Employees]
ADD [TrainingHazComComplete] bit DEFAULT 0 NULL
GO
ALTER TABLE [dbo].[Employees]
ADD [TrainingConfinedSpaceComplete] bit DEFAULT 0 NULL
GO
ALTER TABLE [dbo].[Employees]
ADD [ChauffersLicenseLogged] bit DEFAULT 0 NULL
GO