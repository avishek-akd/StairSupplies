CREATE TABLE [tbl_lumber_species] (
  [id] int IDENTITY(1, 1) NOT NULL,
  [d_name] varchar(100) NOT NULL,
  [d_is_active] bit NOT NULL,
  [d_date_created] datetime NOT NULL,
  [d_date_updated] datetime NULL,
  PRIMARY KEY CLUSTERED ([id])
)
GO


CREATE TABLE [tbl_lumber_longest] (
  [id] int IDENTITY(1, 1) NOT NULL,
  [d_name] varchar(50) NOT NULL,
  [d_sort_field] INT NULL
  PRIMARY KEY CLUSTERED ([id])
)
GO
INSERT INTO tbl_lumber_longest (d_name, d_sort_field) VALUES ('No stock', 1);
INSERT INTO tbl_lumber_longest (d_name, d_sort_field) VALUES ('Unavailable', 2);
INSERT INTO tbl_lumber_longest (d_name, d_sort_field) VALUES ('7', 3);
INSERT INTO tbl_lumber_longest (d_name, d_sort_field) VALUES ('8', 4);
INSERT INTO tbl_lumber_longest (d_name, d_sort_field) VALUES ('9', 5);
INSERT INTO tbl_lumber_longest (d_name, d_sort_field) VALUES ('10', 6);
INSERT INTO tbl_lumber_longest (d_name, d_sort_field) VALUES ('11', 7);
INSERT INTO tbl_lumber_longest (d_name, d_sort_field) VALUES ('12', 8);
INSERT INTO tbl_lumber_longest (d_name, d_sort_field) VALUES ('13', 9);
INSERT INTO tbl_lumber_longest (d_name, d_sort_field) VALUES ('14', 10);
INSERT INTO tbl_lumber_longest (d_name, d_sort_field) VALUES ('15', 11);
INSERT INTO tbl_lumber_longest (d_name, d_sort_field) VALUES ('16', 12);


CREATE TABLE [tbl_lumber_availability] (
  [id] int IDENTITY(1, 1) NOT NULL,
  [d_species_id] int NOT NULL,
  [d_vendor_id] int NOT NULL,
  [d_5_4] bit NOT NULL,
  [d_4_4_longest_id] int NOT NULL,
  [d_date_available] varchar(200) NULL,
  [d_notes] varchar(200) NULL,
  [d_updated_by] int NULL,
  [d_updated_on] datetime NULL,
  PRIMARY KEY CLUSTERED ([id])
)
GO