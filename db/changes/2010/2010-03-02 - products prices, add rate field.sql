--  Backup the old PUnitPrice column from the Products table
EXEC sp_rename '[dbo].[Products].[PUnitPrice]', 'PUnitPrice_old', 'COLUMN'
GO
ALTER TABLE [dbo].[Products]
ADD [PUnitPrice] money DEFAULT 0 NOT NULL
GO


--  Delete double prices
delete
from ProductPrice
where productPriceID IN (
	select productPriceID
    from productPrice as t
    where productPriceID <> (select max(productPriceID) from productPrice where productID = t.productID
    )
)
GO
update Products
SET PUnitPrice = (select PUnitPrice FROM productPrice WHERE ProductID = Products.ProductID)
GO
update Products
SET PUnitPrice = 0
WHERE PUnitPrice IS NULL
GO



EXEC sp_rename '[dbo].[ProductPrice]', 'z_unused_ProductPrice', 'OBJECT'
GO
EXEC sp_addextendedproperty 'MS_Description', N'Standard selling price, per unit', 'schema', 'dbo', 'table', 'Products', 'column', 'PUnitPrice'
GO



ALTER TABLE [dbo].[Products]
ADD [EmployeeRate] decimal(10, 4) DEFAULT 0 NOT NULL
GO
EXEC sp_addextendedproperty 'MS_Description', N'$ payed to the employees for finishing this prouct', 'schema', 'dbo', 'table', 'Products', 'column', 'EmployeeRate'
GO
update Products
SET EmployeeRate = 0
GO