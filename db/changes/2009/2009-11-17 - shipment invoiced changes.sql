--    Delete bad shipments some others have a lot of bogus shipments associated with them,
--  for example 28574 has 619 shipments and 27375 has 125 shipments). No reason why 28574 and 27375 are
--  deleted separately
delete from TblOrdersBOM_OrderShipments where orderID = 0;
delete from TblOrdersBOM_OrderShipments where orderID = 99999;
delete from TblOrdersBOM_OrderShipments where orderID = 28574 and ShippingMethodID = 3;
delete from TblOrdersBOM_OrderShipments where orderID = 27375 and ShippingMethodID = 3;
DELETE FROM TblOrdersBOM_OrderShipments
WHERE orderID IN(
	select orderid
	from TblOrdersBOM_OrderShipments
	group by orderid
	having count(*) > 15
    ) and (ShippingMethodID = 3 OR (ShippingMethodID IS NULL and ShippingMethodUPS IS NOT NULL));



ALTER TABLE [dbo].[TblOrdersBOM_OrderShipments]
ADD [Paid] bit DEFAULT 0 NULL
GO

EXEC sp_addextendedproperty 'MS_Description', N'Is this shipment paid ?', 'schema', 'dbo', 'table', 'TblOrdersBOM_OrderShipments', 'column', 'Paid'
GO

ALTER TABLE [dbo].[TblOrdersBOM_OrderShipments]
ADD [Invoiced] bit DEFAULT 0 NULL
GO

EXEC sp_addextendedproperty 'MS_Description', N'Shipment is invoiced ?', 'schema', 'dbo', 'table', 'TblOrdersBOM_OrderShipments', 'column', 'Invoiced'
GO


--  Update the Paid and Invoiced fields on the existing
update tblOrdersBOM_OrderShipments set Paid = 0;
update tblOrdersBOM_OrderShipments set Paid = 1
where (select tblOrdersBOM.Paid from tblOrdersBOM WHERE orderID = tblOrdersBOM_OrderShipments.orderID) = 1;

update tblOrdersBOM_OrderShipments set Invoiced = 0;
update tblOrdersBOM_OrderShipments set Invoiced = 1
where (select tblOrdersBOM.Invoiced from tblOrdersBOM WHERE orderID = tblOrdersBOM_OrderShipments.orderID) = 1;


--  Shipment number
ALTER TABLE [dbo].[TblOrdersBOM_OrderShipments]
ADD [ShipmentNumber] varchar(10) NULL
GO

EXEC sp_addextendedproperty 'MS_Description', N'Shipment Number is the order number plus the shipment index as a letter. For example for order 28000 we will have shipments: 28000-A, 28000-B, 28000-C, 28000-D, etc', 'schema', 'dbo', 'table', 'TblOrdersBOM_OrderShipments', 'column', 'ShipmentNumber'
GO



ALTER TABLE [dbo].[TblOrdersBOM_OrderShipments]
DROP CONSTRAINT [DF_TblOrdersBOM_OrderShipments_OrderID]
GO
ALTER TABLE [dbo].[TblOrdersBOM_OrderShipments]
ALTER COLUMN [OrderID] int NOT NULL
GO
ALTER TABLE [dbo].[TblOrdersBOM_OrderShipments]
ADD CONSTRAINT [DF_TblOrdersBOM_OrderShipments_OrderID] DEFAULT 0 FOR [OrderID]
GO


ALTER TABLE [dbo].[TblOrdersBOM_OrderShipments]
DROP CONSTRAINT [PK_TblOrdersBOM_OrderShipments]
GO
ALTER TABLE [dbo].[TblOrdersBOM_OrderShipments]
ALTER COLUMN [OrderShipment_id] int NOT NULL
GO
ALTER TABLE [dbo].[TblOrdersBOM_OrderShipments]
ADD CONSTRAINT [PK_TblOrdersBOM_OrderShipments] 
PRIMARY KEY CLUSTERED ([OrderShipment_id])
WITH (
  PAD_INDEX = OFF,
  IGNORE_DUP_KEY = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO


--  Foreign key and index on OrderID. First delete shipments with a messed up orderID
DELETE FROM tblOrdersBOM_OrderShipments WHERE orderId NOT IN (SELECT orderID FROM tblOrdersBOM);
ALTER TABLE [dbo].[TblOrdersBOM_OrderShipments]
ADD CONSTRAINT [TblOrdersBOM_OrderShipments_fk] FOREIGN KEY ([OrderID]) 
  REFERENCES [dbo].[TblOrdersBOM] ([OrderID]) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
GO
CREATE NONCLUSTERED INDEX [TblOrdersBOM_OrderShipments_idx] ON [dbo].[TblOrdersBOM_OrderShipments]
  ([OrderID])
WITH (
  PAD_INDEX = OFF,
  DROP_EXISTING = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  SORT_IN_TEMPDB = OFF,
  ONLINE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
GO
ALTER TABLE [dbo].[TblOrdersBOM_OrderShipments]
DROP CONSTRAINT [DF_TblOrdersBOM_OrderShipments_OrderID]
GO


-- 
--   For all the existing shipments in the database assign
-- them the shipment number which is the order number
-- followed by the letter
-- 
declare @orderID integer
declare @currentOrderID integer
declare @orderShipmentIndex integer


declare c cursor scroll for
select orderId
from tblOrdersBOM_OrderShipments
order by orderID ASC;

open c;

fetch next from c into @orderID;
set @currentOrderID = @orderID
set @orderShipmentIndex = 0

while @@FETCH_STATUS = 0
begin
	--  65 is the ASCII code for 'A'
	update tblOrdersBOM_OrderShipments
    set ShipmentNumber = Cast(orderID AS VARCHAR) + '-' + Char(65 + @orderShipmentIndex)
    WHERE CURRENT OF c;
    
    fetch next from c into @orderID;
    
    if( @orderID <> @currentOrderID)
    begin
    	set @currentOrderID = @orderID;
        set @orderShipmentIndex = 0;
    end
    else
    begin
        set @orderShipmentIndex = @orderShipmentIndex + 1;
    end
end

close c;
deallocate c;


--  Unique key on ShipmentNumber
ALTER TABLE [dbo].[TblOrdersBOM_OrderShipments]
ADD CONSTRAINT [TblOrdersBOM_OrderShipments_uq] 
UNIQUE NONCLUSTERED ([ShipmentNumber])
WITH (
  PAD_INDEX = OFF,
  IGNORE_DUP_KEY = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
GO
ALTER TABLE [dbo].[TblOrdersBOM_OrderShipments]
DROP CONSTRAINT [TblOrdersBOM_OrderShipments_uq]
GO

ALTER TABLE [dbo].[TblOrdersBOM_OrderShipments]
ALTER COLUMN [ShipmentNumber] varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
GO

ALTER TABLE [dbo].[TblOrdersBOM_OrderShipments]
ADD CONSTRAINT [TblOrdersBOM_OrderShipments_uq] 
UNIQUE NONCLUSTERED ([ShipmentNumber])
WITH (
  PAD_INDEX = OFF,
  IGNORE_DUP_KEY = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO



--  Add InvoicedDate
ALTER TABLE [dbo].[TblOrdersBOM_OrderShipments]
ADD [InvoiceDate] date
GO
UPDATE dbo.TblOrdersBOM_OrderShipments
SET InvoiceDate = DateAdded
GO


ALTER TABLE [dbo].[tbl_settings]
ADD [d_email_subject_invoice_shipment] varchar(100) NULL
GO




--  Foreign key on the ShippingMethod
update TblOrdersBOM_OrderShipments set shippingMethodID = NULL where shippingMethodID = 0;
ALTER TABLE [dbo].[TblOrdersBOM_OrderShipments]
ADD CONSTRAINT [TblOrdersBOM_OrderShipments_fk2] FOREIGN KEY ([ShippingMethodID]) 
  REFERENCES [dbo].[Shipping_Methods] ([ShippingMethodID]) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
GO
CREATE NONCLUSTERED INDEX [TblOrdersBOM_OrderShipments_idx2] ON [dbo].[TblOrdersBOM_OrderShipments]
  ([ShippingMethodID])
WITH (
  PAD_INDEX = OFF,
  DROP_EXISTING = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  SORT_IN_TEMPDB = OFF,
  ONLINE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
GO



--  Fix some of the UPS wrong codes
update TblOrdersBOM_OrderShipments set ShippingMethodUPS = 'GND' where ShippingMethodUPS = 'Ground';
update TblOrdersBOM_OrderShipments set ShippingMethodUPS = '3DS' where ShippingMethodUPS = '3 Day Select';
update TblOrdersBOM_OrderShipments set ShippingMethodUPS = '1DA' where ShippingMethodUPS = 'Next Day Air';
update TblOrdersBOM_OrderShipments set ShippingMethodUPS = '2DA' where ShippingMethodUPS = '2nd Day Air';
update TblOrdersBOM_OrderShipments set ShippingMethodUPS = '1DA' where ShippingMethodUPS = 'Next Day Air';

UPDATE TblOrdersBOM_OrderShipments
SET
	ShippingMethodID = (SELECT ShippingMethodID FROM Shipping_Methods WHERE ups_service_type = TblOrdersBOM_OrderShipments.ShippingMethodUPS)
WHERE ShippingMethodID IS NULL
	AND ShippingMethodUPS IS NOT NULL
GO


UPDATE tbl_settings SET d_email_subject_invoice_shipment = 'Your StairSupplies Invoice #shipment.ShipmentNumber#' WHERE id = 1;
UPDATE tbl_settings SET d_email_subject_invoice_shipment = 'Your Nu-Wood Invoice #shipment.ShipmentNumber#' WHERE id = 2;
UPDATE tbl_settings SET d_email_subject_invoice_shipment = 'Your WildWood Invoice #shipment.ShipmentNumber#' WHERE id = 3;
