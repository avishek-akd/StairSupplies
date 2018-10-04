DROP TABLE [dbo].[z_unused_ProductPrice]
GO

DROP TABLE [dbo].[z_unused_Products_temp]
GO

DROP TABLE [dbo].[z_unused_tb_ticket]
GO

DROP TABLE [dbo].[z_unused_tb_ticket_email]
GO

DROP TABLE [dbo].[z_unused_tb_ticket_email_template]
GO

DROP TABLE [dbo].[z_unused_tb_ticket_status]
GO

DROP TABLE [dbo].[z_unused_tb_ticket_type]
GO

DROP TABLE [dbo].[z_unused_tblCustomerNoteResponse]
GO

DROP TABLE [dbo].[z_unused_tblCustomerNoteType]
GO

DROP TABLE [dbo].[z_unused_TblOrdersBOM_Details]
GO

DROP TABLE [dbo].[z_unused_TblOrdersBOM_Images]
GO

DROP TABLE [dbo].[z_unused_TblOrdersBOM_Items_fixed]
GO

DROP TABLE [dbo].[z_unused_TblOrdersBOM_Items_temp]
GO

DROP TABLE [dbo].[z_unused_TblOrdersBOM_Shipping]
GO

DROP TABLE [dbo].[z_unused_TblOrdersBOM_Shipping_Details]
GO

DROP TABLE [dbo].[z_unused_TblOrdersBOM_temp]
GO

DROP TABLE [dbo].[z_unused_TblProduct_Inventory_Adj]
GO

DROP TABLE [dbo].[z_unused_tblProductTypeCompany]
GO

DROP TABLE [dbo].[z_unused_TblStateTax]
GO

DROP TABLE [dbo].[z_unused_TblPOReceipts]
GO

DROP TABLE [dbo].[z_unused_TblPoDetails]
GO

DROP TABLE [dbo].[z_unused_TblPO]
GO
ALTER TABLE [dbo].[Tbl_Terms]
DROP CONSTRAINT [DF_Tbl_Terms_EmailAccounting]
GO

ALTER TABLE [dbo].[Tbl_Terms]
DROP COLUMN [z_unused_EmailAccounting]
GO
ALTER TABLE [dbo].[Tbl_Terms]
DROP COLUMN [z_unused_Description]
GO
ALTER TABLE [dbo].[TblOrdersBOM]
DROP CONSTRAINT [DF_TblOrdersBOM_BackOrderCreated]
GO

ALTER TABLE [dbo].[TblOrdersBOM]
DROP COLUMN [z_unused_BackOrderCreated]
GO
ALTER TABLE [dbo].[TblOrdersBOM]
DROP CONSTRAINT [DF_TblOrdersBOM_CloseTicket1]
GO

ALTER TABLE [dbo].[TblOrdersBOM]
DROP COLUMN [z_unused_CloseTicket1]
GO
ALTER TABLE [dbo].[TblOrdersBOM]
DROP CONSTRAINT [DF_TblOrdersBOM_CloseTicket2]
GO

ALTER TABLE [dbo].[TblOrdersBOM]
DROP COLUMN [z_unused_CloseTicket2]
GO
ALTER TABLE [dbo].[TblOrdersBOM]
DROP CONSTRAINT [DF_TblOrdersBOM_CloseTicket3]
GO

ALTER TABLE [dbo].[TblOrdersBOM]
DROP COLUMN [z_unused_CloseTicket3]
GO
ALTER TABLE [dbo].[TblOrdersBOM]
DROP COLUMN [z_unused_trackingnum]
GO
ALTER TABLE [dbo].[TblOrdersBOM]
DROP CONSTRAINT [DF_TblOrdersBOM_CloseTicket4]
GO

ALTER TABLE [dbo].[TblOrdersBOM]
DROP COLUMN [z_unused_CloseTicket4]
GO
ALTER TABLE [dbo].[TblOrdersBOM]
DROP CONSTRAINT [DF_TblOrdersBOM_isRMA]
GO

ALTER TABLE [dbo].[TblOrdersBOM]
DROP COLUMN [z_unused_isRMA]
GO
ALTER TABLE [dbo].[TblOrdersBOM]
DROP COLUMN [z_unused_hardware_type]
GO
ALTER TABLE [dbo].[TblOrdersBOM]
DROP CONSTRAINT [DF_TblOrdersBOM_dropship]
GO

ALTER TABLE [dbo].[TblOrdersBOM]
DROP COLUMN [z_unused_dropship]
GO
ALTER TABLE [dbo].[TblOrdersBOM]
DROP COLUMN [z_unused_acctmemo]
GO
ALTER TABLE [dbo].[TblOrdersBOM]
DROP COLUMN [z_unused_WaitingForProductDate]
GO
ALTER TABLE [dbo].[TblOrdersBOM]
DROP CONSTRAINT [DF_TblOrdersBOM_WaitingForProduct]
GO

ALTER TABLE [dbo].[TblOrdersBOM]
DROP COLUMN [z_unused_WaitingForProduct]
GO
ALTER TABLE [dbo].[TblOrdersBOM]
DROP COLUMN [z_unused_ShipDate]
GO
ALTER TABLE [dbo].[TblOrdersBOM]
DROP COLUMN [z_unused_PurchasingCheckUser]
GO
ALTER TABLE [dbo].[TblOrdersBOM]
DROP COLUMN [z_unused_PurchasingCheckDate]
GO
ALTER TABLE [dbo].[TblOrdersBOM]
DROP CONSTRAINT [DF_TblOrdersBOM_PurchasingCheck]
GO

ALTER TABLE [dbo].[TblOrdersBOM]
DROP COLUMN [z_unused_PurchasingCheck]
GO
ALTER TABLE [dbo].[TblOrdersBOM]
DROP COLUMN [z_unused_ProductionDate Original]
GO
ALTER TABLE [dbo].[TblOrdersBOM]
DROP COLUMN [z_unused_POCreatedDate]
GO
ALTER TABLE [dbo].[TblOrdersBOM]
DROP CONSTRAINT [DF_TblOrdersBOM_POCreated]
GO

ALTER TABLE [dbo].[TblOrdersBOM]
DROP COLUMN [z_unused_POCreated]
GO

ALTER TABLE [dbo].[TblOrdersBOM]
DROP CONSTRAINT [DF_TblOrdersBOM_InventoryCheck]
GO

ALTER TABLE [dbo].[TblOrdersBOM]
DROP COLUMN [z_unused_PInventoryCheck]
GO

ALTER TABLE [dbo].[TblOrdersBOM]
DROP CONSTRAINT [DF_TblOrdersBOM_OriginalOrderID]
GO

ALTER TABLE [dbo].[TblOrdersBOM]
DROP COLUMN [z_unused_OriginalOrderID]
GO

ALTER TABLE [dbo].[TblOrdersBOM]
DROP CONSTRAINT [DF_TblOrdersBOM_OrderIssues]
GO

ALTER TABLE [dbo].[TblOrdersBOM]
DROP COLUMN [z_unused_OrderIssues]
GO
ALTER TABLE [dbo].[TblOrdersBOM]
DROP CONSTRAINT [DF_TblOrdersBOM_OpenTicket6]
GO

ALTER TABLE [dbo].[TblOrdersBOM]
DROP COLUMN [z_unused_OpenTicket6]
GO

ALTER TABLE [dbo].[TblOrdersBOM]
DROP CONSTRAINT [DF_TblOrdersBOM_OpenTicket5]
GO

ALTER TABLE [dbo].[TblOrdersBOM]
DROP COLUMN [z_unused_OpenTicket5]
GO

ALTER TABLE [dbo].[TblOrdersBOM]
DROP CONSTRAINT [DF_TblOrdersBOM_OpenTicket4]
GO

ALTER TABLE [dbo].[TblOrdersBOM]
DROP COLUMN [z_unused_OpenTicket4]
GO

ALTER TABLE [dbo].[TblOrdersBOM]
DROP CONSTRAINT [DF_TblOrdersBOM_OpenTicket3]
GO

ALTER TABLE [dbo].[TblOrdersBOM]
DROP COLUMN [z_unused_OpenTicket3]
GO

ALTER TABLE [dbo].[TblOrdersBOM]
DROP CONSTRAINT [DF_TblOrdersBOM_OpenTicket2]
GO

ALTER TABLE [dbo].[TblOrdersBOM]
DROP COLUMN [z_unused_OpenTicket2]
GO

ALTER TABLE [dbo].[TblOrdersBOM]
DROP CONSTRAINT [DF_TblOrdersBOM_OpenTicket1]
GO

ALTER TABLE [dbo].[TblOrdersBOM]
DROP COLUMN [z_unused_OpenTicket1]
GO

ALTER TABLE [dbo].[TblOrdersBOM]
DROP COLUMN [z_unused_Open Issues]
GO

ALTER TABLE [dbo].[TblOrdersBOM]
DROP COLUMN [z_unused_OnOrderDate]
GO

ALTER TABLE [dbo].[TblOrdersBOM]
DROP CONSTRAINT [DF_TblOrdersBOM_OnOrder]
GO

ALTER TABLE [dbo].[TblOrdersBOM]
DROP COLUMN [z_unused_OnOrder]
GO

DROP INDEX [IX_TblOrdersBOMOldQuoteID] ON [dbo].[TblOrdersBOM]
GO
ALTER TABLE [dbo].[TblOrdersBOM]
DROP COLUMN [z_unused_OldQuoteID]
GO
ALTER TABLE [dbo].[TblOrdersBOM]
DROP COLUMN [z_unused_MWaitingForProductUser]
GO

ALTER TABLE [dbo].[TblOrdersBOM]
DROP COLUMN [z_unused_MFGPOCreatedDate]
GO

ALTER TABLE [dbo].[TblOrdersBOM]
DROP CONSTRAINT [DF_TblOrdersBOM_POCreated1]
GO

ALTER TABLE [dbo].[TblOrdersBOM]
DROP COLUMN [z_unused_MFGPOCreated]
GO

ALTER TABLE [dbo].[TblOrdersBOM]
DROP COLUMN [z_unused_LegalreadDate]
GO

ALTER TABLE [dbo].[TblOrdersBOM]
DROP CONSTRAINT [DF_TblOrdersBOM_Legalread]
GO

ALTER TABLE [dbo].[TblOrdersBOM]
DROP COLUMN [z_unused_Legalread]
GO

ALTER TABLE [dbo].[TblOrdersBOM]
DROP COLUMN [z_unused_InventoryCheckUser]
GO

ALTER TABLE [dbo].[TblOrdersBOM]
DROP COLUMN [z_unused_InventoryCheckDate]
GO

ALTER TABLE [dbo].[TblOrdersBOM]
DROP COLUMN [z_unused_CostCode]
GO

ALTER TABLE [dbo].[TblOrdersBOM]
DROP CONSTRAINT [DF_TblOrdersBOM_CloseTicket6]
GO

ALTER TABLE [dbo].[TblOrdersBOM]
DROP COLUMN [z_unused_CloseTicket6]
GO

ALTER TABLE [dbo].[TblOrdersBOM]
DROP CONSTRAINT [DF_TblOrdersBOM_CloseTicket5]
GO

ALTER TABLE [dbo].[TblOrdersBOM]
DROP COLUMN [z_unused_CloseTicket5]
GO

ALTER TABLE [dbo].[TblOrdersBOM_Shipments]
DROP CONSTRAINT [DF_TblOrdersBOM_OrderShipments_PickedBy_Id]
GO

ALTER TABLE [dbo].[TblOrdersBOM_Shipments]
DROP COLUMN [z_unused_PickedBy_Id]
GO

ALTER TABLE [dbo].[TblOrdersBOM_Shipments]
DROP CONSTRAINT [DF_TblOrdersBOM_OrderShipments_PackedBy_Id]
GO

ALTER TABLE [dbo].[TblOrdersBOM_Shipments]
DROP COLUMN [z_unused_PackedBy_Id]
GO

ALTER TABLE [dbo].[TblProductType]
DROP COLUMN [z_unused_AccountingProductCode]
GO

ALTER TABLE [dbo].[TblProductType]
DROP COLUMN [z_unused_ProductTypeIDlist]
GO

ALTER TABLE [dbo].[TblOrdersBOM_Items]
DROP COLUMN [z_unused_timestamp]
GO
ALTER TABLE [dbo].[TblOrdersBOM_Items]
DROP COLUMN [z_unused_sort]
GO
ALTER TABLE [dbo].[TblOrdersBOM_Items]
DROP COLUMN [z_unused_Temp_ProductID]
GO

ALTER TABLE [dbo].[TblOrdersBOM_Items]
DROP COLUMN [z_unused_Signed_Initials]
GO

ALTER TABLE [dbo].[TblOrdersBOM_Items]
DROP COLUMN [z_unused_Signed_EmployeeID]
GO

ALTER TABLE [dbo].[TblOrdersBOM_Items]
DROP COLUMN [z_unused_Signed_Date]
GO

ALTER TABLE [dbo].[TblOrdersBOM_Items]
DROP COLUMN [z_unused_Signed]
GO

ALTER TABLE [dbo].[TblOrdersBOM_Items]
DROP COLUMN [z_unused_Prod_Vendor]
GO

ALTER TABLE [dbo].[TblOrdersBOM_Items]
DROP CONSTRAINT [DF_TblOrdersBOM_Items_Prod_RipOperator]
GO

ALTER TABLE [dbo].[TblOrdersBOM_Items]
DROP COLUMN [z_unused_Prod_RipOperator]
GO

ALTER TABLE [dbo].[TblOrdersBOM_Items]
DROP COLUMN [z_unused_ExceptionDesription]
GO

ALTER TABLE [dbo].[TblOrdersBOM_Items]
DROP COLUMN [z_unused_ExceptionCreateInitials]
GO

ALTER TABLE [dbo].[TblOrdersBOM_Items]
DROP CONSTRAINT [DF_TblOrdersBOM_Items_DropShipItem]
GO

ALTER TABLE [dbo].[TblOrdersBOM_Items]
DROP COLUMN [z_unused_DropShipItem]
GO

ALTER TABLE [dbo].[TblOrdersBOM_Items]
DROP COLUMN [z_unused_ExceptionClosedInitials]
GO
ALTER TABLE [dbo].[TblOrdersBOM_Items]
DROP CONSTRAINT [DF_TblOrdersBOM_Items_BackOrderCreated]
GO

ALTER TABLE [dbo].[TblOrdersBOM_Items]
DROP COLUMN [z_unused_BackOrderCreated]
GO

ALTER TABLE [dbo].[Company]
DROP COLUMN [z_unused_DefaultPaymentTerms]
GO

ALTER TABLE [dbo].[Company]
DROP COLUMN [z_unused_DefaultInvoiceDescription]
GO

ALTER TABLE [dbo].[Company]
DROP COLUMN [z_unused_Notes]
GO

ALTER TABLE [dbo].[Company]
DROP COLUMN [z_unused_emailordertext]
GO

ALTER TABLE [dbo].[Company]
DROP COLUMN [z_unused_emailshippingtext]
GO

ALTER TABLE [dbo].[Company]
DROP COLUMN [z_unused_creditcardTransFee]
GO

ALTER TABLE [dbo].[Company]
DROP COLUMN [z_unused_CreditCardTransPercent]
GO

ALTER TABLE [dbo].[Company]
DROP COLUMN [z_unused_dba]
GO

ALTER TABLE [dbo].[Company]
DROP COLUMN [z_unused_emailorderhtmltext]
GO

ALTER TABLE [dbo].[Company]
DROP COLUMN [z_unused_SalesTaxRate]
GO

ALTER TABLE [dbo].[CustomerNotes]
DROP COLUMN [z_unused_NoteTypeOld]
GO

ALTER TABLE [dbo].[Customers]
DROP COLUMN [z_unused_FrontEndCustomerID]
GO