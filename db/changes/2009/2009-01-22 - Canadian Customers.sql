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


SELECT [Lead type] AS LeadType, *, Coalesce(tax.salesTax, 0)
FROM Customers
	LEFT JOIN TblstateTax tax ON customers.StateorProvince = tax.state
WHERE Customerid = @customerId;
GO