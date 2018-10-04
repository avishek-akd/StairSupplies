-- 
--  Run this file after sql-update-customer-states.cfm has been executed
--


-- 
-- If the state is filled then fill in the country
-- 
UPDATE customers
SET ContactCountryId = (SELECT CountryId FROM tblState WHERE State = customers.ContactState)
WHERE ContactState IS NOT NULL AND ContactCountryId IS NULL
GO
UPDATE customers
SET ShipCountryId = (SELECT CountryId FROM tblState WHERE State = customers.ShipState)
WHERE ShipState IS NOT NULL AND ShipCountryId IS NULL
GO
UPDATE customers
SET BillCountryId = (SELECT CountryId FROM tblState WHERE State = customers.BillState)
WHERE BillState IS NOT NULL AND BillCountryId IS NULL
GO


delete from Customers where CustomerID = 25361;


CREATE NONCLUSTERED INDEX [CustomerLogins_idx] ON [dbo].[CustomerLogins]
  ([customerID])
WITH (
  PAD_INDEX = OFF,
  DROP_EXISTING = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  SORT_IN_TEMPDB = OFF,
  ONLINE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
GO
CREATE NONCLUSTERED INDEX [CustomerLogins_idx2] ON [dbo].[CustomerLogins]
  ([siteID])
WITH (
  PAD_INDEX = OFF,
  DROP_EXISTING = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  SORT_IN_TEMPDB = OFF,
  ONLINE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
GO