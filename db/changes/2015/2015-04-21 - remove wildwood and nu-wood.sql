UPDATE `Company` SET `isActive`=0 WHERE  `CompanyID`=2;
UPDATE `Company` SET `isActive`=0 WHERE  `CompanyID`=3;


SET @companiesToKeep = '1,4';


delete
from TblFile
where orderShipmentID IN (select OrderShipment_id from TblOrdersBOM_Shipments where orderID IN (select orderID from TblOrdersBOM where FIND_IN_SET(companyID, @companiesToKeep) = 0))
;
delete
from TblOrdersBOM_Shipments
where orderID IN (select orderID from TblOrdersBOM where FIND_IN_SET(companyID, @companiesToKeep) = 0)
;



delete
from TblFile
where orderItemsID IN (select orderItemsID from TblOrdersBOM_Items where orderID IN (select orderID from TblOrdersBOM where FIND_IN_SET(companyID, @companiesToKeep) = 0))
;
delete
from TblOrdersBOM_Items
where orderID IN (select orderID from TblOrdersBOM where FIND_IN_SET(companyID, @companiesToKeep) = 0)
;



delete
from TblFile
where orderID IN (select orderID from TblOrdersBOM where FIND_IN_SET(companyID, @companiesToKeep) = 0)
;
delete
from TblFile
where orderCustomerVisibleID IN (select orderID from TblOrdersBOM where FIND_IN_SET(companyID, @companiesToKeep) = 0)
;
DELETE
FROM TblOrdersBOM
WHERE FIND_IN_SET(companyID, @companiesToKeep) = 0
;




-- 
--  Order is important here, deleting from Products must happen *after* deleting from Orders because they both "depend" on the company
delete
from TblFile
where ProductID IN (select ProductID from Products where FIND_IN_SET(companyID, @companiesToKeep) = 0 and ProductID NOT IN (select productID from TblOrdersBOM_Items))
;
DELETE 
FROM Products
WHERE FIND_IN_SET(companyID, @companiesToKeep) = 0
	and ProductID NOT IN (select productID from TblOrdersBOM_Items)
;
update Products
set companyID = 1
where FIND_IN_SET(companyID, @companiesToKeep) = 0
;



--  First delete the contacts that don't have orders anymore
delete
from TblFile
where customerContactID NOT IN (select customerContactID from TblOrdersBOM)
;
delete
from CustomerContact
where CustomerContactID NOT IN (select customerContactID from TblOrdersBOM)
;




--  Then delete "contactless" customers (customers with no associated contact) 
delete
from TblFile
where customerID NOT IN (select customerId from CustomerContact)
;
--  Customers with no contacts are useless because Contacts are the ones with orders
delete
from Customers
where customerID not in (select customerId from CustomerContact)
;
--  For cross-customers set the default company to StairSupplies
update Customers
set defaultCompanyID = 1
where FIND_IN_SET(defaultCompanyID, @companiesToKeep) = 0
;



--  Delete audit entries
delete
from TblAudit
where d_table_name = 'TblOrdersBOM' and d_item_id not in (select orderid from TblOrdersBOM)
;
delete
from TblAudit
where d_table_name = 'Customers' and d_item_id not in (select customerID from Customers)
;




delete
from tbl_settings_per_company
where FIND_IN_SET(d_company_id, @companiesToKeep) = 0
;



delete
from Company
where FIND_IN_SET(CompanyID, @companiesToKeep) = 0
;
