EXEC sp_rename '[dbo].[Products].[copied_to_bom]', 'zzUnused_copied_to_bom', 'COLUMN'
GO
EXEC sp_rename '[dbo].[TblOrdersBOM_Details].[ProductID]', 'zzUnused_ProductID', 'COLUMN'
GO


--  ProductID will link directly to the Products table
ALTER TABLE [dbo].[TblOrdersBOM_Items]
ADD [ProductID] int NULL
GO
ALTER TABLE [dbo].[TblOrdersBOM_Items]
ADD CONSTRAINT [FK_TblOrdersBOM_Items_Products] FOREIGN KEY ([ProductID]) 
  REFERENCES [dbo].[Products] ([ProductID]) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
GO
CREATE NONCLUSTERED INDEX [idx_TblOrdersBOM_Items_ProductID] ON [dbo].[TblOrdersBOM_Items]
  ([ProductID])
GO


--  TODO: HACK: Fix the problem where there are BOM's with more then 1 entry in BOMDetails
delete from Tbl_BOMDetails
where bom_id in 
(
	select bom_id
	from Tbl_BOMDetails
	group by bom_id
	having count(*) > 1
);


--  Make the direct link to the products table
update TblOrdersBOM_Items
set ProductID =
	(SELECT ProductID
    	from Tbl_BOMDetails
        WHERE BOM_ID = TblOrdersBOM_Items.BOM_ID
    );


--  Rename unused columns and tables; add needed tables to temp tables
EXEC sp_rename '[dbo].[TblOrdersBOM_Items].[BOM_ID]', 'zzUnused_BOM_ID', 'COLUMN'
GO
EXEC sp_rename '[dbo].[Tbl_BOM]', 'zzUnused_Tbl_BOM', 'OBJECT'
GO
EXEC sp_rename '[dbo].[Tbl_BOMDetails]', 'zzUnused_Tbl_BOMDetails', 'OBJECT'
GO
EXEC sp_rename '[dbo].[TblOrdersBOM_Items_temp].[BOM_ID]', 'zzUnused_BOM_ID', 'COLUMN'
GO
EXEC sp_rename '[dbo].[TblOrdersBOM_Items].[OldOrderItemsID]', 'zzUnused_OldOrderItemsID', 'COLUMN'
GO
EXEC sp_rename '[dbo].[TblOrdersBOM_Items].[OldQuoteID]', 'zzUnused_OldQuoteID', 'COLUMN'
GO
EXEC sp_rename '[dbo].[TblOrdersBOM_Items].[OldQuoteItemsID]', 'zzUnused_OldQuoteItemsID', 'COLUMN'
GO
EXEC sp_rename '[dbo].[TblOrdersBOM_Items].[OldorderID]', 'zzUnused_OldorderID', 'COLUMN'
GO
EXEC sp_rename '[dbo].[TblOrdersBOM_Items].[lumber_pack]', 'zzUnused_lumber_pack', 'COLUMN'
GO
ALTER TABLE [dbo].[TblOrdersBOM_Items_temp]
ADD [ProductID] int NULL
GO



ALTER PROC sp_select_product

@productID int, 
@cutomerid int

AS

set nocount on

SELECT pp.punitPrice, Products.productName, Products.ProductID,
	Products.product_descripton, Products.in_house_notes,
    products.unitweight
FROM products
	LEFT outer join productPrice pp ON products.productid = pp. productid 
	LEFT outer join customers c     ON pp. CustomerPriceID = c.CustomerPriceID
where products.ProductID = @productID
	AND	c.customerId = @cutomerid;
GO


ALTER  PROC [sp_select_special_product]

@productID int, 
@cutomerid int

AS

set nocount on

select Products.productName, Products.ProductID,
		Products.product_descripton, Products.in_house_notes
from Products
where Products.ProductID = @productID;

SELECT producttype_id ,producttype  from tblproducttype;

SELECT unit_of_measure,dsp_order from Tbl_UnitOfMeasure;

SELECT specialorderid from tbl_specialorder;

SELECT id, d_name FROM tbl_lumber_species;
GO


--
-- View used for the shipping software WorldShip. Notes:
--  * WorldShip software formats OrderID as a number (15000 becomes 15,000.00)
--  * Assume the service type is UPS Ground (GND)
--
ALTER VIEW dbo.View_BOMOrders
AS
SELECT     Cast(dbo.TblOrdersBOM.OrderID AS VARCHAR) AS OrderID,
           'GND' AS ServiceType,
           ShipContactFirstName + ' ' + ShipContactLastName AS ATTN, ShipName, ShipAddress, ShipPhoneNumber, ShipAddress1, ShipAddress2,
                      ShipAddress3, ShipAddress4, CustomerID, EmployeeID, TblOrdersBOM.ShippingMethodID, OrderDate, Job_Name, ShipDate, OrderTotal, FreightCharge,
                      ActFreightCharge, SalesTaxRate, Status, Notes, In_House_Notes, Duedate, DateCreated, DateUpdated, PONumber, Terms, BackOrderCreated, 
                      hardware_type, Paid, PaidDate, PaidUser, Estimate, EstimateDate, EstimateUser, Ordered, OrderedDate, OrderedUser, Archived, ArchivedDate, 
                      Delivered, DeliveredDate, DeliveredUser, Released, ReleasedDate, ReleasedUser, ReadytoShip, ReadytoShipDate, ReadytoShipUser, 
                      CustomerAcknowledgement, CustomerAcknowledgementDate, InventoryCheck, InventoryCheckDate, InventoryCheckUser, PurchasingCheck, 
                      PurchasingCheckDate, PurchasingCheckUser, WaitingForProduct, WaitingForProductDate, WaitingForProductUser, ProductionDate, EmailAck, 
                      EmailAckDate, EmailAckUser, EmailShipAck, EmailShipAckDate, EmailShipAckUser, FinishShop, FinishShopDate, DeliveredPartial, 
                      DeliveredPartialDate, Invoiced, InvoicedDate, Updated, UpdatedDate, UpdatedBy, OnOrder, OnOrderDate, statustext, ShippingDirections, 
                      OrderWeight, dropship, acctmemo, color, trackingnum, [timestamp], CreditCardCharged, CreditCardChargeddate, Cancelled, CancelledDate, 
                      OriginalOrderID, BackOrderID, ShippedBy_Id, PickedBy_Id, PackedBy_Id, SalesMan_Id, CustomerService_id, ShipCompanyName, 
                      ShipContactFirstName, ShipContactLastName, ShipCity, ShipState, ShipPostalCode, BillCompanyName, BillContactFirstName, BillContactLastName, 
                      BillAddress1, BillAddress2, BillAddress3, BillAddress4, BillCity, BillState, BillPostalCode, PhoneNumber, FaxNumber, CellPhone, Email, isRMA, 
                      POCreated, POCreatedDate, MFGPOCreated, MFGPOCreatedDate, Backorder
FROM         dbo.TblOrdersBOM
       LEFT JOIN Shipping_Methods ON Shipping_Methods.ShippingMethodID = TblOrdersBOM.ShippingMethodID
GO