--  Remove old users
EXEC sp_revokedbaccess 'Kostya'
GO
EXEC sp_revokedbaccess 'Shahriar'
GO


--  Stored procedures need to be owned by dbo
EXEC sp_changeobjectowner 'ibproduction.sp_get_customerInfo', 'dbo'
GO
EXEC sp_changeobjectowner 'ibproduction.sp_select_product', 'dbo'
GO
EXEC sp_changeobjectowner 'ibproduction.sp_select_special_product', 'dbo'
GO
EXEC sp_changeobjectowner 'ibproduction.sp_status_shipping_add', 'dbo'
GO
EXEC sp_changeobjectowner 'ibproduction.sp_status_shipping_edit', 'dbo'
GO
EXEC sp_changeobjectowner 'ibproduction.sp_test', 'dbo'
GO


EXEC sp_rename '[dbo].[sp_Buildbom]', 'zzUnused_sp_Buildbom', 'OBJECT'
GO
/****** Object:  Stored Procedure dbo.sp_Buildbom    Script Date: 10/23/2003 8:26:37 AM ******/
ALTER PROCEDURE [dbo].[zzUnused_sp_Buildbom] 
	@property varchar(30),
	@value varchar(255)
as
	set nocount on
	if (@property is null) or (@property = '')
	begin
		raiserror('Must specify a property name.',-1,-1)
		return (1)
	end
	if (@value is null)
		select objectid id from dbo.dtproperties
			where property=@property
	else
		select objectid id from dbo.dtproperties
			where property=@property and value=@value
GO


EXEC sp_rename '[dbo].[sp_test]', 'zzUnused_sp_test', 'OBJECT'
GO
ALTER PROCEDURE [dbo].[zzUnused_sp_test] 

@prod_id int
AS

Select sum(POD.Quantity) As On_Purchase_Order
from TblPo PO,TblPoDetails POD,Products P
where PO.PO_ID=POD.PO_ID
	AND PO.Ordered=1
	AND PO.Received=0
	AND P.ProductID=POD.ProductID
	and P.ProductID = @prod_id

GO


EXEC sp_rename '[dbo].[spcProcessTblPOReceipt]', 'zzUnused_spcProcessTblPOReceipt', 'OBJECT'
GO

/* Stored Procedure for POReceipts */
ALTER PROCEDURE dbo.zzUnused_spcProcessTblPOReceipt 
-- Input parms
   @PO_ID int, 
   @PODet_ID int,
   @ProductID int, 
   @NewQty float,    -- Quantity received via Receiving form user entry
   @DetailsQty float -- Quantity ordered from TblPoDetails record
AS
   /* All changes to TblPOReceipts, TblPoDetails and TblPO must be valid */
   BEGIN TRANSACTION
   DECLARE @Err int,
           @DetailsCount int, 
           @DetailsComplete int,
           @TotalReceiptsQty float 
   /* Create a new record in TblPOReceipts */
   INSERT INTO dbo.TblPOReceipts (PO_ID, PODet_ID, Quantity) 
                          VALUES (@PO_ID, @PODet_ID, @NewQty)
   SET @Err = @@ERROR
   IF @Err <> 0 BEGIN
      ROLLBACK TRANSACTION
      RETURN(@Err)
   END
   /* Update quantity fields in Products table */
   UPDATE dbo.Products
-- SET DateUpdated = getdate(), -- Per Len Morris, system changes should NOT update
   SET Qty_On_Hand = Qty_On_Hand + @NewQty,
       Qty_On_Order = Qty_On_Order - @NewQty
   WHERE Products.ProductID = @ProductID
   SET @Err = @@ERROR
   IF @Err <> 0 BEGIN
      ROLLBACK TRANSACTION
      RETURN(@Err)
   END
   /* Could be 1 record if received complete or multiple partial records */
   SET @TotalReceiptsQty = (SELECT SUM(Quantity) FROM dbo.TblPOReceipts
			    WHERE dbo.TblPOReceipts.PODet_ID = @PODet_ID)
   SET @Err = @@ERROR
   IF @Err <> 0 BEGIN
      ROLLBACK TRANSACTION
      RETURN(@Err)
   END
   /* Flag complete if details order qty has been met or exceeded */ 
   IF @TotalReceiptsQty >= @DetailsQty BEGIN
      /* Flag details record as complete */
      UPDATE dbo.TblPoDetails	
      SET ReceivedComplete = 1
      WHERE dbo.TblPoDetails.PODet_ID = @PODet_ID
      SET @Err = @@ERROR
      IF @Err <> 0 BEGIN
         ROLLBACK TRANSACTION
         RETURN(@Err)
      END
      /* Count number of detail records for this PO */
      SET @DetailsCount = (SELECT Count(*) FROM dbo.TblPoDetails 
		           WHERE dbo.TblPoDetails.PO_ID = @PO_ID)
      SET @Err = @@ERROR
      IF @Err <> 0 BEGIN
         ROLLBACK TRANSACTION
         RETURN(@Err)
      END
      /* Count number of completed detail records for this PO */
      SET @DetailsComplete = (SELECT Count(*) FROM dbo.TblPoDetails PD 
		              WHERE PD.PO_ID = @PO_ID AND PD.ReceivedComplete = 1)
      SET @Err = @@ERROR
      IF @Err <> 0 BEGIN
         ROLLBACK TRANSACTION
         RETURN(@Err)
      END
      /* If all details records are complete then this PO is complete */
      IF @DetailsCount = @DetailsComplete BEGIN
         UPDATE dbo.TblPO
         SET ReceivedComplete = 1
         WHERE dbo.TblPO.PO_ID = @PO_ID
      END
      SET @Err = @@ERROR
      IF @Err <> 0 BEGIN
         ROLLBACK TRANSACTION
         RETURN(@Err)
      END
   END
   ELSE BEGIN -- New receipts qty is less than details ordered qty 
      /* Update TblPoDetails ReceivedPartial flag */
      UPDATE dbo.TblPoDetails	
      SET ReceivedPartial = 1
      WHERE dbo.TblPoDetails.PODet_ID = @PODet_ID
      SET @Err = @@ERROR
      IF @Err <> 0 BEGIN
         ROLLBACK TRANSACTION
         RETURN(@Err)
      END
      /* Update TblPO ReceivedPartial flag */
      UPDATE dbo.TblPO
      SET ReceivedPartial = 1
      WHERE dbo.TblPO.PO_ID = @PO_ID
      SET @Err = @@ERROR
      IF @Err <> 0 BEGIN
         ROLLBACK TRANSACTION
         RETURN(@Err)
      END
   END
   /* Everything worked OK */
   COMMIT TRANSACTION
GO




EXEC sp_rename '[dbo].[Qry_BomOrderDetails_total_results]', 'zzUnused_Qry_BomOrderDetails_total_results', 'OBJECT'
GO

/****** Object:  View dbo.Qry_BomOrderDetails_total_results    Script Date: 10/23/2003 8:26:36 AM ******/
ALTER VIEW dbo.zzUnused_Qry_BomOrderDetails_total_results
AS
SELECT     OrderItemsID, SUM(cost) AS SumOfcost, SUM(saleprice) AS SumOfsaleprice
FROM         dbo.Qry_BomOrderDetails_totals
GROUP BY OrderItemsID
GO


EXEC sp_rename '[dbo].[Qry_BomOrderDetails_totals]', 'zzUnused_Qry_BomOrderDetails_totals', 'OBJECT'
GO

/****** Object:  View dbo.Qry_BomOrderDetails_totals    Script Date: 10/23/2003 8:26:36 AM ******/
ALTER VIEW dbo.zzUnused_Qry_BomOrderDetails_totals
AS
SELECT     OrderDetailID, OrderItemsID, Quantity, UnitPrice, Purchase_Price, Purchase_Price * Quantity AS cost, (Quantity * UnitPrice) * (1 - Discount) 
                      * 100 / 100 AS saleprice
FROM         dbo.TblOrdersBOM_Details
GO



--  All tables need to be owned by dbo
EXEC sp_changeobjectowner 'ibproduction.derek_shipping', 'dbo'
GO
EXEC sp_changeobjectowner 'ibproduction.TblStateTax_tempbk', 'dbo'
GO
EXEC sp_changeobjectowner 'ibproduction.tblProductTypeInclude', 'dbo'
GO
EXEC sp_changeobjectowner 'ibproduction.TblOrdersBOM_temp', 'dbo'
GO
EXEC sp_changeobjectowner 'ibproduction.TblOrdersBOM_status', 'dbo'
GO


--  Drop and recreate Products_temp because it has the same constraints as the Products table (DF_Products_Vendor_ID, etc)
DROP TABLE [ibproduction].[Products_temp]
GO
CREATE TABLE [dbo].[Products_temp] (
  [ProductID] int IDENTITY(1, 1) NOT NULL,
  [Vendor_ID] int CONSTRAINT [DF_Products_temp_Vendor_ID] DEFAULT 0 NOT NULL,
  [Cat_ID] int CONSTRAINT [DF_Products_temp_Cat_ID] DEFAULT 10 NULL,
  [Style_Id] int CONSTRAINT [DF_Products_temp_Style_Id] DEFAULT 0 NULL,
  [Coating_ID] int CONSTRAINT [DF_Products_temp_Coating_ID] DEFAULT 0 NULL,
  [Option_ID] int CONSTRAINT [DF_Products_temp_Option_ID] DEFAULT 0 NULL,
  [ProductionCat_ID] int CONSTRAINT [DF_Products_temp_ProductionCat_ID] DEFAULT 4 NULL,
  [ProductType_id] int CONSTRAINT [DF_Products_temp_ProductType_id] DEFAULT 1 NULL,
  [ProductName] nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Product_Descripton] nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [PUnitPrice] money CONSTRAINT [DF_Products_temp_PUnitPrice] DEFAULT 0 NOT NULL,
  [Vendor] nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Purchase_Price] money CONSTRAINT [DF_Products_temp_Purchase_Price] DEFAULT 0 NOT NULL,
  [Inventory_Number] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS CONSTRAINT [DF_Products_temp_Inventory_Number] DEFAULT 0 NULL,
  [Unit_of_Measure] varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS CONSTRAINT [DF_Products_temp_Unit_of_Measure] DEFAULT N'Each' NOT NULL,
  [DateEntered] datetime CONSTRAINT [DF_Products_temp_DateEntered] DEFAULT convert(datetime,convert(varchar,getdate(),1)) NULL,
  [DateUpdated] datetime CONSTRAINT [DF_Products_temp_DateUpdated] DEFAULT convert(datetime,convert(varchar,getdate(),1)) NULL,
  [In_House_Notes] text COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Customer_Notes] text COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Vendor_Notes] text COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Assembly] bit CONSTRAINT [DF_Products_temp_ASM] DEFAULT 0 NULL,
  [Qty_On_Hand] int CONSTRAINT [DF_Products_temp_Qty_on_hand] DEFAULT 0 NOT NULL,
  [Qty_Reorder_Min] int CONSTRAINT [DF_Products_temp_Qty_Reorder_Min] DEFAULT 0 NOT NULL,
  [Qty_On_Order] int CONSTRAINT [DF_Products_temp_Qty_On_Order] DEFAULT 0 NOT NULL,
  [Qty_Available] int CONSTRAINT [DF_Products_temp_Qty_Available] DEFAULT 0 NOT NULL,
  [Qty_to_reorder] int CONSTRAINT [DF_Products_temp_Qty_to_reorder] DEFAULT 0 NOT NULL,
  [Qty_Allocated] int CONSTRAINT [DF_Products_temp_Qty_Allocated] DEFAULT 0 NOT NULL,
  [Qty_BackOrdered] int CONSTRAINT [DF_Products_temp_Qty_BackOrdered] DEFAULT 0 NOT NULL,
  [Bin] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Warehouse] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Vendor_Part_Number] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Pcs_Per_box] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [UnitWeight] real CONSTRAINT [DF_Products_temp_Weight_Per_Piece] DEFAULT 0 NOT NULL,
  [image1] text COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [image2] text COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [image3] text COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [image4] text COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [image5] text COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Desc_Long] text COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Desc_Short] varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [PiecesPerCarton] varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [leadtime] int CONSTRAINT [DF_Products_temp_leadtime] DEFAULT 7 NULL,
  [archived] bit CONSTRAINT [DF_Products_temp_archived] DEFAULT 0 NULL,
  [mfg_item] bit CONSTRAINT [DF_Products_temp_mfg_item] DEFAULT 0 NULL,
  [DropShip] bit CONSTRAINT [DF_Products_temp_DropShip] DEFAULT 0 NULL,
  [Vendor_Qty_on_hand] int CONSTRAINT [DF_Products_temp_Vendor_Qty_on_hand] DEFAULT 0 NULL,
  [blueprint] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Points] numeric(18, 0) NULL,
  [species] int NULL,
  [BoardFootage] int NULL
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]
GO


--  Recreate TblOrdersBOM_Items_temp
DROP TABLE [ibproduction].[TblOrdersBOM_Items_temp]
GO
CREATE TABLE [dbo].[TblOrdersBOM_Items_temp] (
  [OrderItemsID] int IDENTITY(1, 1) NOT NULL,
  [OrderID] numeric(10, 0) NULL,
  [BOM_ID] int NULL,
  [Quantity] float CONSTRAINT [DF_TblOrdersBOM_Items_temp_Quantity] DEFAULT 0 NULL,
  [QuantityShipped] float CONSTRAINT [DF_TblOrdersBOM_Items_temp_QuantityShipped] DEFAULT 0 NULL,
  [Unit_of_Measure] varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [UnitPrice] money CONSTRAINT [DF_TblOrdersBOM_Items_temp_UnitPrice] DEFAULT 0 NULL,
  [Discount] float CONSTRAINT [DF_TblOrdersBOM_Items_temp_Discount] DEFAULT 0 NULL,
  [Status] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Special_Instructions] varchar(150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [In_House_Notes] text COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Customer_Notes] text COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [BackOrderCreated] bit CONSTRAINT [DF_TblOrdersBOM_Items_temp_BackOrderCreated] DEFAULT 0 NULL,
  [ProductName] varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Product_Descripton] varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Temp_ProductID] int NULL,
  [Purchase_Price] money CONSTRAINT [DF_TblOrdersBOM_Items_temp_Purchase_Price] DEFAULT 0 NULL,
  [OldorderID] int NULL,
  [OldOrderItemsID] int NULL,
  [OldQuoteItemsID] int NULL,
  [OldQuoteID] int CONSTRAINT [DF_TblOrdersBOM_Items_temp_QuoteID] DEFAULT 0 NULL,
  [UnitWeight] real CONSTRAINT [DF_TblOrdersBOM_Items_temp_Weight] DEFAULT 0 NULL,
  [timestamp] timestamp NULL,
  [ReadytoShip] bit CONSTRAINT [DF_TblOrdersBOM_Items_temp_ReadytoShip] DEFAULT 0 NULL,
  [Prod_BoardFeet] numeric(18, 0) CONSTRAINT [DF_TblOrdersBOM_Items_temp_BoardFeet] DEFAULT 0 NULL,
  [Prod_RipOperator] int CONSTRAINT [DF_TblOrdersBOM_Items_temp_Prod_RipOperator] DEFAULT 0 NULL,
  [Prod_Vendor] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Delivered] bit CONSTRAINT [DF_TblOrdersBOM_Items_temp_Delivered] DEFAULT 0 NULL,
  [DeliveredDate] datetime NULL,
  [DropShipItem] bit CONSTRAINT [DF_TblOrdersBOM_Items_temp_DropShipItem] DEFAULT 0 NULL,
  [lumber_pack] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [PRC] bit CONSTRAINT [DF_TblOrdersBOM_Items_temp_PRC] DEFAULT 0 NULL,
  [Glue] bit CONSTRAINT [DF_TblOrdersBOM_Items_temp_Glue] DEFAULT 0 NULL,
  [Final] bit CONSTRAINT [DF_TblOrdersBOM_Items_temp_Final] DEFAULT 0 NULL,
  [PRC_Initials] text COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Glue_Initials] text COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Final_Initials] text COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [PRC_Date] datetime NULL,
  [Glue_Date] datetime NULL,
  [Final_Date] datetime NULL,
  [ExceptionOpened] bit CONSTRAINT [DF_TblOrdersBOM_Items_temp_Exception] DEFAULT 0 NULL,
  [ExceptonDateCreated] datetime NULL,
  [ExceptionDateClosed] datetime NULL,
  [ExceptionCreateInitials] text COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ExceptionClosed] bit CONSTRAINT [DF_TblOrdersBOM_Items_temp_ExceptionClosed] DEFAULT 0 NULL,
  [ExceptionClosedInitials] text COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ExceptionDesription] text COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Outsource] bit NULL,
  [OutsourceDate] datetime NULL,
  [OutsourceInitials] text COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [PRC_EmployeeID] bigint NULL,
  [Glue_EmployeeID] bigint NULL,
  [Final_EmployeeID] bigint NULL,
  [exceptionOpened_EmployeeID] bigint NULL,
  [ExceptionClosed_EmployeeID] bigint NULL,
  [outsource_EmployeeID] bigint NULL,
  [ExceptionId] bigint NULL,
  [sort] bigint NULL,
  CONSTRAINT [PK_TblOrdersBOM_Items_temp] PRIMARY KEY CLUSTERED ([OrderItemsID]),
  CONSTRAINT [FK_TblOrdersBOM_Items_temp_Tbl_BOM1] FOREIGN KEY ([BOM_ID]) 
  REFERENCES [dbo].[Tbl_BOM] ([BOM_ID]) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION,
  CONSTRAINT [FK_TblOrdersBOM_Items_temp_TblOrdersBOM] FOREIGN KEY ([OrderID]) 
  REFERENCES [dbo].[TblOrdersBOM] ([OrderID]) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]
GO


--
--  sp_status_shipping_add
--
ALTER  PROC sp_status_shipping_add
@OrderID int 

AS

set nocount off

SELECT BOM.*
FROM TblOrdersBOM_temp BOM
WHERE BOM.orderId=@OrderID

SELECT EmployeeId,salesMan_id,customerService_id
FROM TBLordersBOM_temp
WHERE orderId=@OrderID

SELECT Employees.EmployeeID,EmployeeCode, [LastName] + ','+ [FirstName] AS name 
FROM Employees 
WHERE (((Employees.Archive)=0)) 
ORDER BY [LastName] + ',' + [FirstName]

SELECT ShippingMethodId,ShippingMethod
FROM Shipping_methods 
WHERE active <>0

SELECT terms from Tbl_Terms

SELECT *
FROM TBLOrdersBOM_status
WHERE orderId = @OrderID

select  d_name,id
from tbl_lumber_species
GO


--  Rename unused tables
EXEC sp_rename '[dbo].[CDATA]', 'zzUnused_CDATA', 'OBJECT'
GO
EXEC sp_rename '[dbo].[CGLOBAL]', 'zzUnused_CGLOBAL', 'OBJECT'
GO
EXEC sp_rename '[dbo].[Area]', 'zzUnused_Area', 'OBJECT'
GO
EXEC sp_rename '[dbo].[Asset]', 'zzUnused_Asset', 'OBJECT'
GO
EXEC sp_rename '[dbo].[Contact_lookup]', 'zzUnused_Contact_lookup', 'OBJECT'
GO
EXEC sp_rename '[dbo].[derek_shipping]', 'zzUnused_derek_shipping', 'OBJECT'
GO
EXEC sp_rename '[dbo].[EventCalendar]', 'zzUnused_EventCalendar', 'OBJECT'
GO
EXEC sp_rename '[dbo].[Events]', 'zzUnused_Events', 'OBJECT'
GO
EXEC sp_rename '[dbo].[Exception]', 'zzUnused_Exception', 'OBJECT'
GO
EXEC sp_rename '[dbo].[Frequency]', 'zzUnused_Frequency', 'OBJECT'
GO
EXEC sp_rename '[dbo].[Issues]', 'zzUnused_Issues', 'OBJECT'
GO
EXEC sp_rename '[dbo].[NoteType]', 'zzUnused_NoteType', 'OBJECT'
GO
EXEC sp_rename '[dbo].[Old_Order_Details]', 'zzUnused_Old_Order_Details', 'OBJECT'
GO
EXEC sp_rename '[dbo].[old_Orders]', 'zzUnused_old_Orders', 'OBJECT'
GO
EXEC sp_rename '[dbo].[OLD_Tbl_Products]', 'zzUnused_OLD_Tbl_Products', 'OBJECT'
GO
EXEC sp_rename '[dbo].[Payment_Methods]', 'zzUnused_Payment_Methods', 'OBJECT'
GO
EXEC sp_rename '[dbo].[Payments]', 'zzUnused_Payments', 'OBJECT'
GO
EXEC sp_rename '[dbo].[Performed]', 'zzUnused_Performed', 'OBJECT'
GO
EXEC sp_rename '[dbo].[PM_Items]', 'zzUnused_PM_Items', 'OBJECT'
GO
EXEC sp_rename '[dbo].[ProspectiveCustomers]', 'zzUnused_ProspectiveCustomers', 'OBJECT'
GO
EXEC sp_rename '[dbo].[ProcedureModule]', 'zzUnused_ProcedureModule', 'OBJECT'
GO
EXEC sp_rename '[dbo].[Purchase_Details]', 'zzUnused_Purchase_Details', 'OBJECT'
GO
EXEC sp_rename '[dbo].[Steps]', 'zzUnused_Steps', 'OBJECT'
GO
EXEC sp_rename '[dbo].[surveymtest]', 'zzUnused_surveymtest', 'OBJECT'
GO
EXEC sp_rename '[dbo].[Tbl_ASP]', 'zzUnused_Tbl_ASP', 'OBJECT'
GO
EXEC sp_rename '[dbo].[Tbl_BaseProducts]', 'zzUnused_Tbl_BaseProducts', 'OBJECT'
GO
EXEC sp_rename '[dbo].[Tbl_BOMCat]', 'zzUnused_Tbl_BOMCat', 'OBJECT'
GO
EXEC sp_rename '[dbo].[Tbl_BOMRoutings]', 'zzUnused_Tbl_BOMRoutings', 'OBJECT'
GO
EXEC sp_rename '[dbo].[Tbl_calendar]', 'zzUnused_Tbl_calendar', 'OBJECT'
GO
EXEC sp_rename '[dbo].[Tbl_calendar_eventtypes]', 'zzUnused_Tbl_calendar_eventtypes', 'OBJECT'
GO
EXEC sp_rename '[dbo].[Tbl_calendar_locations]', 'zzUnused_Tbl_calendar_locations', 'OBJECT'
GO
EXEC sp_rename '[dbo].[Tbl_calendar_recurid]', 'zzUnused_Tbl_calendar_recurid', 'OBJECT'
GO
EXEC sp_rename '[dbo].[Tbl_calendar_schemes]', 'zzUnused_Tbl_calendar_schemes', 'OBJECT'
GO
EXEC sp_rename '[dbo].[Tbl_calendar_signups]', 'zzUnused_Tbl_calendar_signups', 'OBJECT'
GO
EXEC sp_rename '[dbo].[Tbl_Cat]', 'zzUnused_Tbl_Cat', 'OBJECT'
GO
EXEC sp_rename '[dbo].[Tbl_Coating]', 'zzUnused_Tbl_Coating', 'OBJECT'
GO
EXEC sp_rename '[dbo].[Tbl_Company]', 'zzUnused_Tbl_Company', 'OBJECT'
GO
EXEC sp_rename '[dbo].[Tbl_Contacts]', 'zzUnused_Tbl_Contacts', 'OBJECT'
GO
EXEC sp_rename '[dbo].[Tbl_ContactsType]', 'zzUnused_Tbl_ContactsType', 'OBJECT'
GO
EXEC sp_rename '[dbo].[Tbl_Content]', 'zzUnused_Tbl_Content', 'OBJECT'
GO
EXEC sp_rename '[dbo].[Tbl_Content_Interest]', 'zzUnused_Tbl_Content_Interest', 'OBJECT'
GO
EXEC sp_rename '[dbo].[Tbl_ContentDetails]', 'zzUnused_Tbl_ContentDetails', 'OBJECT'
GO
EXEC sp_rename '[dbo].[Tbl_ContentLinks]', 'zzUnused_Tbl_ContentLinks', 'OBJECT'
GO
EXEC sp_rename '[dbo].[Tbl_Country]', 'zzUnused_Tbl_Country', 'OBJECT'
GO
EXEC sp_rename '[dbo].[Tbl_Dba]', 'zzUnused_Tbl_Dba', 'OBJECT'
GO
EXEC sp_rename '[dbo].[Tbl_News]', 'zzUnused_Tbl_News', 'OBJECT'
GO
EXEC sp_rename '[dbo].[Tbl_Option]', 'zzUnused_Tbl_Option', 'OBJECT'
GO
EXEC sp_rename '[dbo].[Tbl_PageCounter]', 'zzUnused_Tbl_PageCounter', 'OBJECT'
GO
EXEC sp_rename '[dbo].[Tbl_PageCounterDetail]', 'zzUnused_Tbl_PageCounterDetail', 'OBJECT'
GO
EXEC sp_rename '[dbo].[Tbl_PageCounterIP]', 'zzUnused_Tbl_PageCounterIP', 'OBJECT'
GO
EXEC sp_rename '[dbo].[Tbl_product_packages]', 'zzUnused_Tbl_product_packages', 'OBJECT'
GO
EXEC sp_rename '[dbo].[Tbl_ProductionCat]', 'zzUnused_Tbl_ProductionCat', 'OBJECT'
GO
EXEC sp_rename '[dbo].[Tbl_Reports]', 'zzUnused_Tbl_Reports', 'OBJECT'
GO
EXEC sp_rename '[dbo].[Tbl_ReportsDetail]', 'zzUnused_Tbl_ReportsDetail', 'OBJECT'
GO
EXEC sp_rename '[dbo].[Tbl_Search]', 'zzUnused_Tbl_Search', 'OBJECT'
GO
EXEC sp_rename '[dbo].[Tbl_Status]', 'zzUnused_Tbl_Status', 'OBJECT'
GO
EXEC sp_rename '[dbo].[Tbl_Style]', 'zzUnused_Tbl_Style', 'OBJECT'
GO
EXEC sp_rename '[dbo].[Tbl_Users]', 'zzUnused_Tbl_Users', 'OBJECT'
GO
EXEC sp_rename '[dbo].[Tbl_Warehouse]', 'zzUnused_Tbl_Warehouse', 'OBJECT'
GO
EXEC sp_rename '[dbo].[TblASP]', 'zzUnused_TblASP', 'OBJECT'
GO
EXEC sp_rename '[dbo].[TblAttchments]', 'zzUnused_TblAttchments', 'OBJECT'
GO
EXEC sp_rename '[dbo].[TblClickstreamLog]', 'zzUnused_TblClickstreamLog', 'OBJECT'
GO
EXEC sp_rename '[dbo].[TblCompany]', 'zzUnused_TblCompany', 'OBJECT'
GO
EXEC sp_rename '[dbo].[TblOrdersBOM_20060215]', 'zzUnused_TblOrdersBOM_20060215', 'OBJECT'
GO
EXEC sp_rename '[dbo].[TblOrdersBOM_back0217]', 'zzUnused_TblOrdersBOM_back0217', 'OBJECT'
GO
EXEC sp_rename '[dbo].[TblOrdersBOM_Details_Temp]', 'zzUnused_TblOrdersBOM_Details_Temp', 'OBJECT'
GO
EXEC sp_rename '[dbo].[TblOrdersBOM_Shipments.old]', 'zzUnused_TblOrdersBOM_Shipments.old', 'OBJECT'
GO
EXEC sp_rename '[dbo].[TblOrdersBOM_UPSDetails]', 'zzUnused_TblOrdersBOM_UPSDetails', 'OBJECT'
GO
EXEC sp_rename '[dbo].[TblOrdersBOM2]', 'zzUnused_TblOrdersBOM2', 'OBJECT'
GO
EXEC sp_rename '[dbo].[TblPageCounter]', 'zzUnused_TblPageCounter', 'OBJECT'
GO
EXEC sp_rename '[dbo].[TblProduct_Operations]', 'zzUnused_TblProduct_Operations', 'OBJECT'
GO
EXEC sp_rename '[dbo].[TblProduct_whs]', 'zzUnused_TblProduct_whs', 'OBJECT'
GO
EXEC sp_rename '[dbo].[TblQuotesBOM]', 'zzUnused_TblQuotesBOM', 'OBJECT'
GO
EXEC sp_rename '[dbo].[TblQuotesBOM_Details]', 'zzUnused_TblQuotesBOM_Details', 'OBJECT'
GO
EXEC sp_rename '[dbo].[TblQuotesBOM_Items]', 'zzUnused_TblQuotesBOM_Items', 'OBJECT'
GO
EXEC sp_rename '[dbo].[TblQuotesBOM_Notes]', 'zzUnused_TblQuotesBOM_Notes', 'OBJECT'
GO
EXEC sp_rename '[dbo].[TblStateTax_tempbk]', 'zzUnused_TblStateTax_tempbk', 'OBJECT'
GO
EXEC sp_rename '[dbo].[TblTemp]', 'zzUnused_TblTemp', 'OBJECT'
GO
EXEC sp_rename '[dbo].[TBLVendorPartsList]', 'zzUnused_TBLVendorPartsList', 'OBJECT'
GO
EXEC sp_rename '[dbo].[test_table]', 'zzUnused_test_table', 'OBJECT'
GO
EXEC sp_rename '[dbo].[test1]', 'zzUnused_test1', 'OBJECT'
GO
EXEC sp_rename '[dbo].[test2]', 'zzUnused_test2', 'OBJECT'
GO
EXEC sp_rename '[dbo].[Vendors]', 'zzUnused_Vendors', 'OBJECT'
GO
EXEC sp_rename '[dbo].[WebSiteStatus]', 'zzUnused_WebSiteStatus', 'OBJECT'
GO