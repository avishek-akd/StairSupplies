ALTER TABLE [dbo].[Products]
ADD [Production_Instructions] nvarchar(255) NULL
GO


CREATE TABLE [dbo].[tblProductTypeCompany] (
  [ProductTypeId] int NOT NULL,
  [CompanyID] int NOT NULL
)
GO
ALTER TABLE [dbo].[tblProductTypeCompany]
ADD CONSTRAINT [tblProductTypeCompany_fk] FOREIGN KEY ([ProductTypeId]) 
  REFERENCES [dbo].[TblProductType] ([ProductType_id]) 
  ON UPDATE NO ACTION
  ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblProductTypeCompany]
ADD CONSTRAINT [tblProductTypeCompany_fk2] FOREIGN KEY ([CompanyID]) 
  REFERENCES [dbo].[Company] ([CompanyID]) 
  ON UPDATE NO ACTION
  ON DELETE CASCADE
GO
CREATE NONCLUSTERED INDEX [tblProductTypeCompany_idx] ON [dbo].[tblProductTypeCompany]
  ([ProductTypeId])
WITH (
  PAD_INDEX = OFF,
  DROP_EXISTING = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  SORT_IN_TEMPDB = OFF,
  ONLINE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
GO
CREATE NONCLUSTERED INDEX [tblProductTypeCompany_idx2] ON [dbo].[tblProductTypeCompany]
  ([CompanyID])
WITH (
  PAD_INDEX = OFF,
  DROP_EXISTING = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  SORT_IN_TEMPDB = OFF,
  ONLINE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
GO



INSERT INTO [tblProductTypeCompany] ([ProductTypeId], [CompanyID])
VALUES (1, 1)
GO
INSERT INTO [tblProductTypeCompany] ([ProductTypeId], [CompanyID])
VALUES (2, 1)
GO
INSERT INTO [tblProductTypeCompany] ([ProductTypeId], [CompanyID])
VALUES (4, 1)
GO
INSERT INTO [tblProductTypeCompany] ([ProductTypeId], [CompanyID])
VALUES (6, 1)
GO
INSERT INTO [tblProductTypeCompany] ([ProductTypeId], [CompanyID])
VALUES (7, 1)
GO
INSERT INTO [tblProductTypeCompany] ([ProductTypeId], [CompanyID])
VALUES (8, 1)
GO
INSERT INTO [tblProductTypeCompany] ([ProductTypeId], [CompanyID])
VALUES (11, 1)
GO
INSERT INTO [tblProductTypeCompany] ([ProductTypeId], [CompanyID])
VALUES (12, 1)
GO
INSERT INTO [tblProductTypeCompany] ([ProductTypeId], [CompanyID])
VALUES (13, 1)
GO
INSERT INTO [tblProductTypeCompany] ([ProductTypeId], [CompanyID])
VALUES (14, 1)
GO
INSERT INTO [tblProductTypeCompany] ([ProductTypeId], [CompanyID])
VALUES (15, 2)
GO
INSERT INTO [tblProductTypeCompany] ([ProductTypeId], [CompanyID])
VALUES (16, 2)
GO
INSERT INTO [tblProductTypeCompany] ([ProductTypeId], [CompanyID])
VALUES (17, 2)
GO
INSERT INTO [tblProductTypeCompany] ([ProductTypeId], [CompanyID])
VALUES (18, 2)
GO
INSERT INTO [tblProductTypeCompany] ([ProductTypeId], [CompanyID])
VALUES (19, 2)
GO
INSERT INTO [tblProductTypeCompany] ([ProductTypeId], [CompanyID])
VALUES (20, 2)
GO
INSERT INTO [tblProductTypeCompany] ([ProductTypeId], [CompanyID])
VALUES (21, 2)
GO
INSERT INTO [tblProductTypeCompany] ([ProductTypeId], [CompanyID])
VALUES (22, 2)
GO
INSERT INTO [tblProductTypeCompany] ([ProductTypeId], [CompanyID])
VALUES (23, 2)
GO
