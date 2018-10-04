if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblChange_fk3]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[zzUnused_tblChange] DROP CONSTRAINT tblChange_fk3
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_ProductPrice_CustomerPrice]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[ProductPrice] DROP CONSTRAINT FK_ProductPrice_CustomerPrice
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_ProductPrice_bk_CustomerPrice]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[ProductPrice_bk] DROP CONSTRAINT FK_ProductPrice_bk_CustomerPrice
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_Payments_Payment_Methods]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[zzUnused_Payments] DROP CONSTRAINT FK_Payments_Payment_Methods
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_TblCompany_TblASP]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[zzUnused_TblCompany] DROP CONSTRAINT FK_TblCompany_TblASP
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_TblQuotesBOM_Items_TblQuotesBOM]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[zzUnused_TblQuotesBOM_Items] DROP CONSTRAINT FK_TblQuotesBOM_Items_TblQuotesBOM
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_TblQuotesBOM_Notes_TblQuotesBOM]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[zzUnused_TblQuotesBOM_Notes] DROP CONSTRAINT FK_TblQuotesBOM_Notes_TblQuotesBOM
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_TblQuotesBOM_Details_TblQuotesBOM_Items]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[zzUnused_TblQuotesBOM_Details] DROP CONSTRAINT FK_TblQuotesBOM_Details_TblQuotesBOM_Items
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_TblOrdersBOM_Items_Tbl_BOM1]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[TblOrdersBOM_Items] DROP CONSTRAINT FK_TblOrdersBOM_Items_Tbl_BOM1
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_TblOrdersBOM_Items_temp_Tbl_BOM1]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[TblOrdersBOM_Items_temp] DROP CONSTRAINT FK_TblOrdersBOM_Items_temp_Tbl_BOM1
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_Tbl_BOMDetails_Tbl_BOM]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[zzUnused_Tbl_BOMDetails] DROP CONSTRAINT FK_Tbl_BOMDetails_Tbl_BOM
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_TblQuotesBOM_Items_Tbl_BOM]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[zzUnused_TblQuotesBOM_Items] DROP CONSTRAINT FK_TblQuotesBOM_Items_Tbl_BOM
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_TblQuotesBOM_Items_Tbl_BOM1]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[zzUnused_TblQuotesBOM_Items] DROP CONSTRAINT FK_TblQuotesBOM_Items_Tbl_BOM1
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_Tbl_BOM_Tbl_BOMCat]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[zzUnused_Tbl_BOM] DROP CONSTRAINT FK_Tbl_BOM_Tbl_BOMCat
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_Tbl_Dba_Tbl_Company]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[zzUnused_Tbl_Dba] DROP CONSTRAINT FK_Tbl_Dba_Tbl_Company
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_Tbl_Users_Tbl_Company]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[zzUnused_Tbl_Users] DROP CONSTRAINT FK_Tbl_Users_Tbl_Company
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_Tbl_Content_Interest_Tbl_Content]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[zzUnused_Tbl_Content_Interest] DROP CONSTRAINT FK_Tbl_Content_Interest_Tbl_Content
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_Tbl_ContentDetails_Tbl_Content]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[zzUnused_Tbl_ContentDetails] DROP CONSTRAINT FK_Tbl_ContentDetails_Tbl_Content
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_Tbl_calendar_Tbl_Dba]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[zzUnused_Tbl_calendar] DROP CONSTRAINT FK_Tbl_calendar_Tbl_Dba
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_Tbl_calendar_eventtypes_Tbl_Dba]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[zzUnused_Tbl_calendar_eventtypes] DROP CONSTRAINT FK_Tbl_calendar_eventtypes_Tbl_Dba
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_Tbl_calendar_locations_Tbl_Dba]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[zzUnused_Tbl_calendar_locations] DROP CONSTRAINT FK_Tbl_calendar_locations_Tbl_Dba
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_Tbl_calendar_schemes_Tbl_Dba]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[zzUnused_Tbl_calendar_schemes] DROP CONSTRAINT FK_Tbl_calendar_schemes_Tbl_Dba
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_Tbl_calendar_signups_Tbl_Dba]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[zzUnused_Tbl_calendar_signups] DROP CONSTRAINT FK_Tbl_calendar_signups_Tbl_Dba
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_Tbl_Contacts_Tbl_Dba]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[zzUnused_Tbl_Contacts] DROP CONSTRAINT FK_Tbl_Contacts_Tbl_Dba
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_Tbl_Content_Tbl_Dba]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[zzUnused_Tbl_Content] DROP CONSTRAINT FK_Tbl_Content_Tbl_Dba
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_Tbl_News_Tbl_Dba]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[zzUnused_Tbl_News] DROP CONSTRAINT FK_Tbl_News_Tbl_Dba
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_Tbl_Users_Tbl_Dba]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[zzUnused_Tbl_Users] DROP CONSTRAINT FK_Tbl_Users_Tbl_Dba
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_Tbl_ReportsDetail_Tbl_Reports]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[zzUnused_Tbl_ReportsDetail] DROP CONSTRAINT FK_Tbl_ReportsDetail_Tbl_Reports
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_Tbl_calendar_signups_Tbl_calendar]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[zzUnused_Tbl_calendar_signups] DROP CONSTRAINT FK_Tbl_calendar_signups_Tbl_calendar
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_Order_Details_Orders]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[zzUnused_Old_Order_Details] DROP CONSTRAINT FK_Order_Details_Orders
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_Payments_Orders]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[zzUnused_Payments] DROP CONSTRAINT FK_Payments_Orders
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblChange_fk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[zzUnused_tblChange] DROP CONSTRAINT tblChange_fk
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzUnused_Area]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzUnused_Area]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzUnused_Asset]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzUnused_Asset]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzUnused_CDATA]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzUnused_CDATA]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzUnused_CGLOBAL]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzUnused_CGLOBAL]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzUnused_Contact_lookup]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzUnused_Contact_lookup]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzUnused_CustomerPrice]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzUnused_CustomerPrice]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzUnused_EventCalendar]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzUnused_EventCalendar]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzUnused_Events]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzUnused_Events]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzUnused_Exception]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzUnused_Exception]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzUnused_Frequency]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzUnused_Frequency]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzUnused_Issues]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzUnused_Issues]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzUnused_NoteType]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzUnused_NoteType]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzUnused_OLD_Tbl_Products]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzUnused_OLD_Tbl_Products]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzUnused_Old_Order_Details]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzUnused_Old_Order_Details]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzUnused_PM_Items]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzUnused_PM_Items]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzUnused_Payment_Methods]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzUnused_Payment_Methods]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzUnused_Payments]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzUnused_Payments]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzUnused_Performed]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzUnused_Performed]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzUnused_ProcedureModule]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzUnused_ProcedureModule]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzUnused_ProspectiveCustomers]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzUnused_ProspectiveCustomers]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzUnused_Purchase_Details]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzUnused_Purchase_Details]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzUnused_Steps]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzUnused_Steps]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzUnused_TBLVendorPartsList]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzUnused_TBLVendorPartsList]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzUnused_TblASP]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzUnused_TblASP]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzUnused_TblAttchments]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzUnused_TblAttchments]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzUnused_TblClickstreamLog]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzUnused_TblClickstreamLog]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzUnused_TblCompany]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzUnused_TblCompany]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzUnused_TblOrdersBOM2]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzUnused_TblOrdersBOM2]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzUnused_TblOrdersBOM_20060215]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzUnused_TblOrdersBOM_20060215]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzUnused_TblOrdersBOM_Details_Temp]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzUnused_TblOrdersBOM_Details_Temp]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzUnused_TblOrdersBOM_Shipments.old]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzUnused_TblOrdersBOM_Shipments.old]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzUnused_TblOrdersBOM_UPSDetails]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzUnused_TblOrdersBOM_UPSDetails]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzUnused_TblOrdersBOM_back0217]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzUnused_TblOrdersBOM_back0217]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzUnused_TblPageCounter]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzUnused_TblPageCounter]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzUnused_TblProduct_Operations]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzUnused_TblProduct_Operations]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzUnused_TblProduct_whs]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzUnused_TblProduct_whs]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzUnused_TblQuotesBOM]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzUnused_TblQuotesBOM]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzUnused_TblQuotesBOM_Details]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzUnused_TblQuotesBOM_Details]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzUnused_TblQuotesBOM_Items]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzUnused_TblQuotesBOM_Items]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzUnused_TblQuotesBOM_Notes]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzUnused_TblQuotesBOM_Notes]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzUnused_TblStateTax_tempbk]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzUnused_TblStateTax_tempbk]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzUnused_TblTemp]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzUnused_TblTemp]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzUnused_Tbl_ASP]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzUnused_Tbl_ASP]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzUnused_Tbl_BOM]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzUnused_Tbl_BOM]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzUnused_Tbl_BOMCat]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzUnused_Tbl_BOMCat]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzUnused_Tbl_BOMDetails]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzUnused_Tbl_BOMDetails]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzUnused_Tbl_BOMRoutings]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzUnused_Tbl_BOMRoutings]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzUnused_Tbl_BaseProducts]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzUnused_Tbl_BaseProducts]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzUnused_Tbl_Cat]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzUnused_Tbl_Cat]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzUnused_Tbl_Coating]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzUnused_Tbl_Coating]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzUnused_Tbl_Company]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzUnused_Tbl_Company]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzUnused_Tbl_Contacts]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzUnused_Tbl_Contacts]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzUnused_Tbl_ContactsType]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzUnused_Tbl_ContactsType]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzUnused_Tbl_Content]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzUnused_Tbl_Content]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzUnused_Tbl_ContentDetails]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzUnused_Tbl_ContentDetails]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzUnused_Tbl_ContentLinks]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzUnused_Tbl_ContentLinks]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzUnused_Tbl_Content_Interest]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzUnused_Tbl_Content_Interest]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzUnused_Tbl_Country]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzUnused_Tbl_Country]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzUnused_Tbl_Dba]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzUnused_Tbl_Dba]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzUnused_Tbl_News]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzUnused_Tbl_News]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzUnused_Tbl_Option]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzUnused_Tbl_Option]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzUnused_Tbl_PageCounter]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzUnused_Tbl_PageCounter]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzUnused_Tbl_PageCounterDetail]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzUnused_Tbl_PageCounterDetail]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzUnused_Tbl_PageCounterIP]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzUnused_Tbl_PageCounterIP]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzUnused_Tbl_ProductionCat]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzUnused_Tbl_ProductionCat]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzUnused_Tbl_Reports]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzUnused_Tbl_Reports]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzUnused_Tbl_ReportsDetail]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzUnused_Tbl_ReportsDetail]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzUnused_Tbl_Search]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzUnused_Tbl_Search]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzUnused_Tbl_Status]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzUnused_Tbl_Status]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzUnused_Tbl_Style]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzUnused_Tbl_Style]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzUnused_Tbl_Users]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzUnused_Tbl_Users]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzUnused_Tbl_Warehouse]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzUnused_Tbl_Warehouse]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzUnused_Tbl_calendar]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzUnused_Tbl_calendar]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzUnused_Tbl_calendar_eventtypes]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzUnused_Tbl_calendar_eventtypes]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzUnused_Tbl_calendar_locations]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzUnused_Tbl_calendar_locations]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzUnused_Tbl_calendar_recurid]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzUnused_Tbl_calendar_recurid]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzUnused_Tbl_calendar_schemes]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzUnused_Tbl_calendar_schemes]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzUnused_Tbl_calendar_signups]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzUnused_Tbl_calendar_signups]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzUnused_Tbl_product_packages]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzUnused_Tbl_product_packages]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzUnused_Vendors]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzUnused_Vendors]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzUnused_WebSiteStatus]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzUnused_WebSiteStatus]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzUnused_derek_shipping]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzUnused_derek_shipping]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzUnused_old_Orders]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzUnused_old_Orders]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzUnused_position]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzUnused_position]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzUnused_surveymtest]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzUnused_surveymtest]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzUnused_tblChange]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzUnused_tblChange]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzUnused_tblChangeType]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzUnused_tblChangeType]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzUnused_test1]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzUnused_test1]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzUnused_test2]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzUnused_test2]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzUnused_test_table]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzUnused_test_table]
GO



DROP TABLE [dbo].[ProductPrice_bk]
GO
DROP TABLE [dbo].[Tbl_TEMP_Products]
GO


DROP INDEX [dbo].[Customers].[IX_CustomerPriceID]
GO
DROP INDEX [dbo].[Customers].[Customers58]
GO
ALTER TABLE [dbo].[Customers]
DROP CONSTRAINT [DF_Customers_CustomerPriceID]
GO
ALTER TABLE [dbo].[Customers]
DROP COLUMN [zzUnused_CustomerPriceID]
GO


ALTER TABLE [dbo].[Employees]
DROP CONSTRAINT [DF_Employees_AccountingCode]
GO
ALTER TABLE [dbo].[Employees]
DROP COLUMN [zzUnused_AccountingCode]
GO
ALTER TABLE [dbo].[Employees]
DROP COLUMN [zzUnused_CostCode]
GO
ALTER TABLE [dbo].[Employees]
DROP COLUMN [zzUnused_UserLevel]
GO
ALTER TABLE [dbo].[Employees]
DROP CONSTRAINT [DF_Employees_dba]
GO
ALTER TABLE [dbo].[Employees]
DROP COLUMN [zzUnused_dba]
GO


DROP INDEX [dbo].[ProductPrice].[ProductPrice24]
GO
ALTER TABLE [dbo].[ProductPrice]
DROP CONSTRAINT [DF__ProductPr__zzUnu__3E082B48]
GO
ALTER TABLE [dbo].[ProductPrice]
DROP COLUMN [zzUnused_CustomerPriceID]
GO


DROP INDEX [dbo].[Products].[IX_Vendor]
GO
ALTER TABLE [dbo].[Products]
DROP CONSTRAINT [DF_Products_ASM]
GO
ALTER TABLE [dbo].[Products]
DROP COLUMN [zzUnused_Assembly]
GO
ALTER TABLE [dbo].[Products]
DROP CONSTRAINT [DF_Products_Cat_ID]
GO
ALTER TABLE [dbo].[Products]
DROP COLUMN [zzUnused_Cat_id]
GO
ALTER TABLE [dbo].[Products]
DROP CONSTRAINT [DF_Products_Coating_ID]
GO
ALTER TABLE [dbo].[Products]
DROP COLUMN [zzUnused_Coating_ID]
GO
ALTER TABLE [dbo].[Products]
DROP COLUMN [zzUnused_Desc_Long]
GO
ALTER TABLE [dbo].[Products]
DROP COLUMN [zzUnused_Desc_Short]
GO
ALTER TABLE [dbo].[Products]
DROP CONSTRAINT [DF_Products_Option_ID]
GO
ALTER TABLE [dbo].[Products]
DROP COLUMN [zzUnused_Option_ID]
GO
ALTER TABLE [dbo].[Products]
DROP COLUMN [zzUnused_Points]
GO
ALTER TABLE [dbo].[Products]
DROP CONSTRAINT [DF_Products_ProductionCat_ID]
GO
ALTER TABLE [dbo].[Products]
DROP COLUMN [zzUnused_ProductionCat_ID]
GO
ALTER TABLE [dbo].[Products]
DROP CONSTRAINT [DF_Products_Style_Id]
GO
ALTER TABLE [dbo].[Products]
DROP COLUMN [zzUnused_Style_id]
GO
ALTER TABLE [dbo].[Products]
DROP COLUMN [zzUnused_Vendor]
GO
ALTER TABLE [dbo].[Products]
DROP COLUMN [zzUnused_Vendor_Notes]
GO
ALTER TABLE [dbo].[Products]
DROP COLUMN [zzUnused_Vendor_Part_Number]
GO
ALTER TABLE [dbo].[Products]
DROP CONSTRAINT [DF_Products_Vendor_Qty_on_hand]
GO
ALTER TABLE [dbo].[Products]
DROP COLUMN [zzUnused_Vendor_Qty_on_hand]
GO
ALTER TABLE [dbo].[Products]
DROP COLUMN [zzUnused_Warehouse]
GO
ALTER TABLE [dbo].[Products]
DROP COLUMN [zzUnused_blueprint]
GO
ALTER TABLE [dbo].[Products]
DROP CONSTRAINT [DF__Products__copied__6418C597]
GO
ALTER TABLE [dbo].[Products]
DROP COLUMN [zzUnused_copied_to_bom]
GO
ALTER TABLE [dbo].[Products]
DROP COLUMN [zzUnused_image1]
GO
ALTER TABLE [dbo].[Products]
DROP COLUMN [zzUnused_image2]
GO
ALTER TABLE [dbo].[Products]
DROP COLUMN [zzUnused_image3]
GO
ALTER TABLE [dbo].[Products]
DROP COLUMN [zzUnused_image4]
GO
ALTER TABLE [dbo].[Products]
DROP COLUMN [zzUnused_image5]
GO
ALTER TABLE [dbo].[Products]
DROP CONSTRAINT [DF_Products_leadtime]
GO
ALTER TABLE [dbo].[Products]
DROP COLUMN [zzUnused_leadtime]
GO
ALTER TABLE [dbo].[Products]
DROP CONSTRAINT [DF_Products_mfg_item]
GO
ALTER TABLE [dbo].[Products]
DROP COLUMN [zzUnused_mfg_item]
GO


ALTER TABLE [dbo].[Products_temp]
DROP CONSTRAINT [DF_Products_temp_ASM]
GO
ALTER TABLE [dbo].[Products_temp]
DROP COLUMN [Assembly]
GO
ALTER TABLE [dbo].[Products_temp]
DROP COLUMN [image1]
GO
ALTER TABLE [dbo].[Products_temp]
DROP COLUMN [image2]
GO
ALTER TABLE [dbo].[Products_temp]
DROP COLUMN [image3]
GO
ALTER TABLE [dbo].[Products_temp]
DROP COLUMN [image4]
GO
ALTER TABLE [dbo].[Products_temp]
DROP COLUMN [image5]
GO
ALTER TABLE [dbo].[Products_temp]
DROP CONSTRAINT [DF_Products_temp_leadtime]
GO
ALTER TABLE [dbo].[Products_temp]
DROP COLUMN [leadtime]
GO
ALTER TABLE [dbo].[Products_temp]
DROP CONSTRAINT [DF_Products_temp_mfg_item]
GO
ALTER TABLE [dbo].[Products_temp]
DROP COLUMN [mfg_item]
GO
ALTER TABLE [dbo].[Products_temp]
DROP CONSTRAINT [DF_Products_temp_Cat_ID]
GO
ALTER TABLE [dbo].[Products_temp]
DROP COLUMN [Cat_ID]
GO
ALTER TABLE [dbo].[Products_temp]
DROP CONSTRAINT [DF_Products_temp_Coating_ID]
GO
ALTER TABLE [dbo].[Products_temp]
DROP COLUMN [Coating_ID]
GO
ALTER TABLE [dbo].[Products_temp]
DROP CONSTRAINT [DF_Products_temp_Option_ID]
GO
ALTER TABLE [dbo].[Products_temp]
DROP COLUMN [Option_ID]
GO
ALTER TABLE [dbo].[Products_temp]
DROP COLUMN [Desc_Long]
GO
ALTER TABLE [dbo].[Products_temp]
DROP COLUMN [Desc_Short]
GO
ALTER TABLE [dbo].[Products_temp]
DROP COLUMN [Points]
GO
ALTER TABLE [dbo].[Products_temp]
DROP CONSTRAINT [DF_Products_temp_ProductionCat_ID]
GO
ALTER TABLE [dbo].[Products_temp]
DROP COLUMN [ProductionCat_ID]
GO
ALTER TABLE [dbo].[Products_temp]
DROP CONSTRAINT [DF_Products_temp_Style_Id]
GO
ALTER TABLE [dbo].[Products_temp]
DROP COLUMN [Style_Id]
GO
ALTER TABLE [dbo].[Products_temp]
DROP COLUMN [Vendor]
GO
ALTER TABLE [dbo].[Products_temp]
DROP COLUMN [Vendor_Notes]
GO
ALTER TABLE [dbo].[Products_temp]
DROP COLUMN [Vendor_Part_Number]
GO
ALTER TABLE [dbo].[Products_temp]
DROP CONSTRAINT [DF_Products_temp_Vendor_Qty_on_hand]
GO
ALTER TABLE [dbo].[Products_temp]
DROP COLUMN [Vendor_Qty_on_hand]
GO
ALTER TABLE [dbo].[Products_temp]
DROP COLUMN [Warehouse]
GO
ALTER TABLE [dbo].[Products_temp]
DROP COLUMN [blueprint]
GO


ALTER TABLE [dbo].[TblOrdersBOM_Details]
DROP COLUMN [zzUnused_ProductID]
GO


DROP INDEX [dbo].[TblOrdersBOM_Items].[IX_BOM_ID]
GO
DROP INDEX [dbo].[TblOrdersBOM_Items].[TblOrdersBOM_Items54]
GO
ALTER TABLE [dbo].[TblOrdersBOM_Items]
DROP COLUMN [zzUnused_lumber_pack]
GO
ALTER TABLE [dbo].[TblOrdersBOM_Items]
DROP COLUMN [zzUnused_OldorderID]
GO
ALTER TABLE [dbo].[TblOrdersBOM_Items]
DROP COLUMN [zzUnused_OldQuoteItemsID]
GO
ALTER TABLE [dbo].[TblOrdersBOM_Items]
DROP CONSTRAINT [DF_TblOrdersBOM_Items_QuoteID]
GO
ALTER TABLE [dbo].[TblOrdersBOM_Items]
DROP COLUMN [zzUnused_OldQuoteID]
GO
ALTER TABLE [dbo].[TblOrdersBOM_Items]
DROP COLUMN [zzUnused_BOM_ID]
GO
ALTER TABLE [dbo].[TblOrdersBOM_Items]
DROP CONSTRAINT [DF_TblOrdersBOM_Items_Glue]
GO
ALTER TABLE [dbo].[TblOrdersBOM_Items]
DROP COLUMN [zzUnused_Glue]
GO
ALTER TABLE [dbo].[TblOrdersBOM_Items]
DROP COLUMN [zzUnused_Glue_Date]
GO
ALTER TABLE [dbo].[TblOrdersBOM_Items]
DROP COLUMN [zzUnused_Glue_EmployeeID]
GO
ALTER TABLE [dbo].[TblOrdersBOM_Items]
DROP COLUMN [zzUnused_Glue_Initials]
GO
ALTER TABLE [dbo].[TblOrdersBOM_Items]
DROP COLUMN [zzUnused_OldOrderItemsID]
GO


ALTER TABLE [dbo].[TblOrdersBOM_Items_temp]
DROP COLUMN [zzUnused_BOM_ID]
GO
ALTER TABLE [dbo].[TblOrdersBOM_Items_temp]
DROP COLUMN [lumber_pack]
GO
ALTER TABLE [dbo].[TblOrdersBOM_Items_temp]
DROP COLUMN [OldOrderItemsID]
GO
ALTER TABLE [dbo].[TblOrdersBOM_Items_temp]
DROP CONSTRAINT [DF_TblOrdersBOM_Items_temp_QuoteID]
GO
ALTER TABLE [dbo].[TblOrdersBOM_Items_temp]
DROP COLUMN [OldQuoteID]
GO
ALTER TABLE [dbo].[TblOrdersBOM_Items_temp]
DROP COLUMN [OldQuoteItemsID]
GO
ALTER TABLE [dbo].[TblOrdersBOM_Items_temp]
DROP COLUMN [OldorderID]
GO
ALTER TABLE [dbo].[TblOrdersBOM_Items_temp]
DROP CONSTRAINT [DF_TblOrdersBOM_Items_temp_Glue]
GO
ALTER TABLE [dbo].[TblOrdersBOM_Items_temp]
DROP COLUMN [Glue]
GO
ALTER TABLE [dbo].[TblOrdersBOM_Items_temp]
DROP COLUMN [Glue_Date]
GO
ALTER TABLE [dbo].[TblOrdersBOM_Items_temp]
DROP COLUMN [Glue_EmployeeID]
GO
ALTER TABLE [dbo].[TblOrdersBOM_Items_temp]
DROP COLUMN [Glue_Initials]
GO


ALTER TABLE [dbo].[TblOrdersBOM_OrderShipments]
DROP COLUMN [TrackingNumber.old]
GO


ALTER TABLE [dbo].[TblProductVendors]
DROP COLUMN [zzUnused_VendorParts_id]
GO
ALTER TABLE [dbo].[TblProductVendors]
DROP CONSTRAINT [DF_TblProductVendors_Vendor_Qty_on_hand]
GO
ALTER TABLE [dbo].[TblProductVendors]
DROP COLUMN [zzUnused_Vendor_Qty_on_hand]
GO


ALTER TABLE [dbo].[TBLVendor]
DROP COLUMN [zzUnused_dba]
GO



DROP VIEW [dbo].[zzUnused_Qry_BomOrderDetails_total_results]
GO
DROP VIEW [dbo].[zzUnused_Qry_BomOrderDetails_totals]
GO



DROP PROCEDURE [dbo].[zzUnused_sp_Buildbom]
GO
DROP PROCEDURE [dbo].[zzUnused_sp_test]
GO
DROP PROCEDURE [dbo].[zzUnused_spcProcessTblPOReceipt]
GO