EXEC sp_rename '[dbo].[CustomerPrice]', 'zzUnused_CustomerPrice', 'OBJECT'
GO
EXEC sp_rename '[dbo].[Customers].[CustomerPriceID]', 'zzUnused_CustomerPriceID', 'COLUMN'
GO
EXEC sp_rename '[dbo].[ProductPrice].[CustomerPriceID]', 'zzUnused_CustomerPriceID', 'COLUMN'
GO


ALTER PROC sp_get_customerInfo
@customerId int

AS

set nocount off

SELECT Employees.EmployeeID, Employees.LastName, Employees.Archive 
FROM Employees 
WHERE (((Employees.Archive)=0)) 
ORDER BY Employees.LastName; 

SELECT Tbl_Terms.Terms 
FROM Tbl_Terms 

SELECT [Lead type] AS LeadType,*,tax.salesTax 
FROM Customers, TblstateTax tax
WHERE Customerid=@customerId
AND   customers.StateorProvince=tax.state
GO


ALTER PROC sp_select_product
@productID int

AS

set nocount on

SELECT pp.punitPrice, Products.productName, Products.ProductID,
	Products.product_descripton, Products.in_house_notes,
    products.unitweight
FROM products
	LEFT outer join productPrice pp ON products.productid = pp.productid 
where products.ProductID = @productID;
GO

ALTER  PROC [sp_select_special_product]
@productID int

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






--  Remove not-null constraing on CustomerPriceID, default is 3
DROP INDEX [dbo].[ProductPrice].[ProductPrice24]
GO
ALTER TABLE [dbo].[ProductPrice]
ALTER COLUMN [zzUnused_CustomerPriceID] int
GO
CREATE NONCLUSTERED INDEX [ProductPrice24] ON [dbo].[ProductPrice]
  ([ProductID], [zzUnused_CustomerPriceID])
ON [PRIMARY]
GO
ALTER TABLE [dbo].[ProductPrice]
ADD DEFAULT 3 FOR [zzUnused_CustomerPriceID]
GO


--  Bk the current ProductPrice table
SET NOCOUNT ON
GO

CREATE TABLE [ProductPrice_bk] (
  [ProductPriceID] int IDENTITY(1, 1) NOT NULL,
  [ProductID] int NOT NULL,
  [PUnitPrice] money CONSTRAINT [DF_ProductPrice_bk_PUnitPrice] DEFAULT 0 NOT NULL,
  [zzUnused_CustomerPriceID] int NOT NULL
)
ON [PRIMARY]
GO

ALTER TABLE [ProductPrice_bk]
ADD CONSTRAINT [FK_ProductPrice_bk_CustomerPrice]  FOREIGN KEY ([zzUnused_CustomerPriceID]) 
  REFERENCES [dbo].[zzUnused_CustomerPrice] ([CustomerPriceID]) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
GO

ALTER TABLE [ProductPrice_bk]
ADD CONSTRAINT [FK_ProductPrice_bk_Products]  FOREIGN KEY ([ProductID]) 
  REFERENCES [dbo].[Products] ([ProductID]) 
  ON UPDATE NO ACTION
  ON DELETE CASCADE
GO

CREATE NONCLUSTERED INDEX [IX_ProductPrice_bkProductID]  ON [ProductPrice_bk]
  ([ProductID])
WITH
  FILLFACTOR = 90
ON [PRIMARY]
GO

ALTER TABLE [ProductPrice_bk]
ADD CONSTRAINT [PK_ProductPrice_bk]  
PRIMARY KEY CLUSTERED ([ProductPriceID])
WITH FILLFACTOR = 90
ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [ProductPrice_bk24]  ON [ProductPrice_bk]
  ([ProductID], [zzUnused_CustomerPriceID])
ON [PRIMARY]
GO

SET IDENTITY_INSERT [ProductPrice_bk] ON
GO

INSERT INTO [ProductPrice_bk] ([ProductPriceID], [ProductID], [PUnitPrice], [zzUnused_CustomerPriceID])
SELECT [ProductPriceID], [ProductID], [PUnitPrice], [zzUnused_CustomerPriceID] FROM [dbo].[ProductPrice]
GO

SET IDENTITY_INSERT [ProductPrice_bk] OFF
GO


--  Delete all product prices other then "Standard Price"
DELETE
FROM ProductPrice
WHERE zzUnused_CustomerPriceID <> 3;