ALTER TABLE [dbo].[TblOrdersBOM]
DROP COLUMN [z_unused_timestamp]
GO
ALTER TABLE [dbo].[TblOrdersBOM]
DROP COLUMN [z_unused_color]
GO
ALTER TABLE [dbo].[TblOrdersBOM]
DROP COLUMN [z_unused_actual_shipping_cost]
GO
--  MySQL Migration toolkit chokes on the "date" type
ALTER TABLE [dbo].[TblOrdersBOM_Shipments]
ALTER COLUMN [InvoiceDate] datetime
GO

delete from Tbl_SpecialOrder_new
where sp_id = 0
GO
delete from survey WHERE cust_id = 0;
GO
delete from Tblspecialorders_files WHERE files_id = 0;
GO


declare @custID INT

insert into Customers (
ContactCompanyName,
ContactFirstName,
ContactLastName,
ContactAddress1,
ContactAddress2,
ContactAddress3,
ContactAddress4,
ContactCity,
StateOrProvince_old,
ContactPostalCode,
Country_old,
ContactTitle,
ContactPhoneNumber,
ContactFaxNumber,
ContactCellPhone,
Email,
Password,
Terms,
TaxID_Number,
TaxExempt,
DateUpdated,
DateEntered,
ShipCompanyName,
ShipFirstName,
ShipLastName,
ShipAddress1,
ShipAddress2,
ShipAddress3,
ShipAddress4,
ShipCity,
ShipState_old,
ShipPostalCode,
BillCompanyName,
BillFirstName,
BillLastName,
BillAddress1,
BillAddress2,
BillAddress3,
BillAddress4,
BillCity,
BillState_old,
BillPostalCode,
CustomerType,
Annual_Sales_Forcast,
YTD_Sales,
Last_years_Sales,
LastSale,
CustomerNotes,
CanLogin,
FollowUp,
SalesPerson,
FollowUpPerson,
LeadType,
CreditHold,
ContactCountryId,
Country_new,
ContactState,
ContactStateOther,
ShipState,
ShipStateOther,
ShipCountryId,
BillState,
BillStateOther,
BillCountryId,
ContactState_new,
ShipState_new,
BillState_new,
BillingEmails
)
select 

ContactCompanyName,
ContactFirstName,
ContactLastName,
ContactAddress1,
ContactAddress2,
ContactAddress3,
ContactAddress4,
ContactCity,
StateOrProvince_old,
ContactPostalCode,
Country_old,
ContactTitle,
ContactPhoneNumber,
ContactFaxNumber,
ContactCellPhone,
Email,
Password,
Terms,
TaxID_Number,
TaxExempt,
DateUpdated,
DateEntered,
ShipCompanyName,
ShipFirstName,
ShipLastName,
ShipAddress1,
ShipAddress2,
ShipAddress3,
ShipAddress4,
ShipCity,
ShipState_old,
ShipPostalCode,
BillCompanyName,
BillFirstName,
BillLastName,
BillAddress1,
BillAddress2,
BillAddress3,
BillAddress4,
BillCity,
BillState_old,
BillPostalCode,
CustomerType,
Annual_Sales_Forcast,
YTD_Sales,
Last_years_Sales,
LastSale,
CustomerNotes,
CanLogin,
FollowUp,
SalesPerson,
FollowUpPerson,
LeadType,
CreditHold,
ContactCountryId,
Country_new,
ContactState,
ContactStateOther,
ShipState,
ShipStateOther,
ShipCountryId,
BillState,
BillStateOther,
BillCountryId,
ContactState_new,
ShipState_new,
BillState_new,
BillingEmails
from customers
where customerID = 0;

select @custID = max(customerID) from customers
select * from customers where customerID in (@custID,0)
update TblOrdersBOM set customerID = @custID where customerID = 0
delete from Customers WHERE CustomerID = 0
GO
