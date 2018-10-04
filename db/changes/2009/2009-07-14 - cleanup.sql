DROP TABLE [daySchedule]
GO

EXEC sp_rename '[dbo].[TblPO]', 'z_unused_TblPO', 'OBJECT'
GO
EXEC sp_rename '[dbo].[TblPoDetails]', 'z_unused_TblPoDetails', 'OBJECT'
GO
EXEC sp_rename '[dbo].[TblPOReceipts]', 'z_unused_TblPOReceipts', 'OBJECT'
GO
EXEC sp_rename '[dbo].[TblProduct_Inventory_Adj]', 'z_unused_TblProduct_Inventory_Adj', 'OBJECT'
GO


EXEC sp_rename '[dbo].[tb_ticket_email_template]', 'z_unused_tb_ticket_email_template', 'OBJECT'
GO
EXEC sp_rename '[dbo].[tb_ticket]', 'z_unused_tb_ticket', 'OBJECT'
GO
EXEC sp_rename '[dbo].[tb_ticket_email]', 'z_unused_tb_ticket_email', 'OBJECT'
GO
EXEC sp_rename '[dbo].[tb_ticket_status]', 'z_unused_tb_ticket_status', 'OBJECT'
GO
EXEC sp_rename '[dbo].[tb_ticket_type]', 'z_unused_tb_ticket_type', 'OBJECT'
GO
