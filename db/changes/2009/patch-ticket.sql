CREATE TABLE [tb_ticket_email_template] (
  [id] bigint IDENTITY(1, 1) NOT NULL,
  [d_name] varchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS,
  [d_subject] varchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS,
  [d_content] varchar(2000) COLLATE SQL_Latin1_General_CP1_CI_AS,
  [d_date_created] datetime,
  [d_date_updated] datetime,
  CONSTRAINT [PK__tb_ticket_email___17835B04] PRIMARY KEY ([id]),
  CONSTRAINT [UQ__tb_ticket_email___18777F3D] UNIQUE ([id])
)
ON [PRIMARY]
GO


ALTER TABLE [dbo].[tbl_settings]
ADD [d_email_support] varchar(200)
GO

ALTER TABLE [dbo].[tb_ticket_status]
ADD [d_css_class] char(20)
GO