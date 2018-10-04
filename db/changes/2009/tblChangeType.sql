CREATE TABLE [dbo].[tblChangeType] (
  [id] int IDENTITY(1, 1) NOT NULL,
  [d_name] varchar(100) NULL,
  PRIMARY KEY CLUSTERED ([id])
)
GO

INSERT INTO tblChangeType (d_name) VALUES ('Hardware');
INSERT INTO tblChangeType (d_name) VALUES ('Dev Server');
INSERT INTO tblChangeType (d_name) VALUES ('Live Server');
INSERT INTO tblChangeType (d_name) VALUES ('Ecommerce Server');
INSERT INTO tblChangeType (d_name) VALUES ('Phone System');
INSERT INTO tblChangeType (d_name) VALUES ('Security System');
INSERT INTO tblChangeType (d_name) VALUES ('Other');