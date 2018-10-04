--  DateEntered must be before DateUpdated
ALTER TABLE `CustomerContact`
	CHANGE COLUMN `DateEntered` `DateEntered` DATETIME NULL DEFAULT NULL AFTER `PosibleDuplicates`;

	
/*  defaultCompanyID is first created allowing NULL, we set the data and after that we set it NOT NULL  */	
ALTER TABLE `Customers`
	ADD COLUMN `defaultCompanyID` INT(10) NULL AFTER `CustomerID`;
ALTER TABLE `Customers`
	ADD CONSTRAINT `FK_Customers_Company` FOREIGN KEY (`defaultCompanyID`) REFERENCES `Company` (`CompanyID`);



--  Customers with no contacts
DELETE FROM `Customers` WHERE  `CustomerID`=29695;
DELETE FROM `Customers` WHERE  `CustomerID`=29696;
DELETE FROM `Customers` WHERE  `CustomerID`=30716;
DELETE FROM `Customers` WHERE  `CustomerID`=30788;
DELETE FROM `Customers` WHERE  `CustomerID`=31555;
DELETE FROM `Customers` WHERE  `CustomerID`=33793;
DELETE FROM `Customers` WHERE  `CustomerID`=34602;
DELETE FROM `Customers` WHERE  `CustomerID`=34708;
DELETE FROM `Customers` WHERE  `CustomerID`=37511;
DELETE FROM `Customers` WHERE  `CustomerID`=39079;
DELETE FROM `Customers` WHERE  `CustomerID`=39081;
DELETE FROM `Customers` WHERE  `CustomerID`=39087;
DELETE FROM `Customers` WHERE  `CustomerID`=39088;
DELETE FROM `Customers` WHERE  `CustomerID`=39089;
DELETE FROM `Customers` WHERE  `CustomerID`=39090;
DELETE FROM `Customers` WHERE  `CustomerID`=39229;
DELETE FROM `Customers` WHERE  `CustomerID`=39358;
DELETE FROM `Customers` WHERE  `CustomerID`=39360;
DELETE FROM `Customers` WHERE  `CustomerID`=39548;
DELETE FROM `Customers` WHERE  `CustomerID`=39550;
DELETE FROM `Customers` WHERE  `CustomerID`=40480;
DELETE FROM `Customers` WHERE  `CustomerID`=40481;
DELETE FROM `Customers` WHERE  `CustomerID`=40774;
DELETE FROM `Customers` WHERE  `CustomerID`=40843;
DELETE FROM `Customers` WHERE  `CustomerID`=40856;
DELETE FROM `Customers` WHERE  `CustomerID`=41899;
DELETE FROM `Customers` WHERE  `CustomerID`=42216;
DELETE FROM `Customers` WHERE  `CustomerID`=42318;
DELETE FROM `Customers` WHERE  `CustomerID`=43000;
DELETE FROM `Customers` WHERE  `CustomerID`=43173;
DELETE FROM `Customers` WHERE  `CustomerID`=30721;
DELETE FROM `Customers` WHERE  `CustomerID`=32326;



UPDATE Customers
SET defaultCompanyID = NULL;
-- 
--  Build a temporary table with the Customer ID and the CompanyID that has the most orders
-- 
DROP TABLE IF EXISTS tmpCustomers;
CREATE TEMPORARY TABLE IF NOT EXISTS tmpCustomers ( INDEX(CustomerID) ) ENGINE=MEMORY AS
	(
		SELECT CustomerID, (
							SELECT CompanyID
							FROM Customers
								LEFT JOIN CustomerContact ON CustomerContact.CustomerID = Customers.CustomerID
								LEFT JOIN TblOrdersBOM    ON TblOrdersBOM.customerContactID = CustomerContact.CustomerContactID
							WHERE Customers.CustomerID = C.CustomerID
							GROUP BY Customers.CustomerID, CompanyID
							ORDER BY Count(*) DESC
							LIMIT 0, 1
							) AS defaultCompany
		FROM Customers AS C
	);
--  NULL values will be assigned here but it's ok because we handle them in the next query
UPDATE Customers
SET
	defaultCompanyID = (SELECT defaultCompany FROM tmpCustomers WHERE Customers.CustomerID = tmpCustomers.CustomerID);
--  No orders for these custoemrs (defaultCompany is NULL). Default company to StairSupplies and archive the customer
UPDATE Customers
SET
	defaultCompanyID = 1,
	Archived = 1
WHERE CustomerID = (SELECT CustomerID FROM tmpCustomers WHERE defaultCompany IS NULL AND tmpCustomers.CustomerID = Customers.CustomerID);
DROP TABLE IF EXISTS tmpCustomers;




/*  defaultCompanyID is Required so make it NOT NULL  */
ALTER TABLE `Customers`
	ALTER `defaultCompanyID` DROP DEFAULT;
ALTER TABLE `Customers`
	CHANGE COLUMN `defaultCompanyID` `defaultCompanyID` INT(10) NOT NULL AFTER `CustomerID`;









	
	
	
	
	
	
	
	
	
	
	
	
	
	
	



--  No orders. Default company to StairSupplies and archive the customer
UPDATE Customers
SET
	defaultCompanyID = 1,
	Archived = 1
WHERE 1 = (
				SELECT 1
				FROM CustomerContact
					LEFT JOIN TblOrdersBOM ON TblOrdersBOM.customerContactID = CustomerContact.CustomerContactID
				WHERE CustomerContact.CustomerID = Customers.CustomerID
				GROUP BY Customers.CustomerID
				HAVING Count(DISTINCT companyID) = 0
				);




--  Exactly 1 company across all orders
UPDATE Customers
SET
	defaultCompanyID = (
						SELECT CompanyID
						FROM CustomerContact
							INNER JOIN TblOrdersBOM ON TblOrdersBOM.customerContactID = CustomerContact.CustomerContactID
						WHERE CustomerContact.CustomerID = Customers.CustomerID
						GROUP BY Customers.CustomerID
						HAVING Count(DISTINCT companyID) = 1
						);
UPDATE Customers
SET
	defaultCompanyID = (
						SELECT CompanyID
						FROM CustomerContact
							INNER JOIN TblOrdersBOM ON TblOrdersBOM.customerContactID = CustomerContact.CustomerContactID
						WHERE CustomerContact.CustomerID = Customers.CustomerID
						GROUP BY Customers.CustomerID
						HAVING Count(DISTINCT companyID) = 1
						);


						
						
						
SELECT CustomerID, 
						(
						SELECT (SELECT )
						FROM CustomerContact
							INNER JOIN TblOrdersBOM ON TblOrdersBOM.customerContactID = CustomerContact.CustomerContactID
						WHERE CustomerContact.CustomerID = Customers.CustomerID
						GROUP BY Customers.CustomerID
						HAVING Count(DISTINCT companyID) = 2
						) AS Comp,
						(
						SELECT Count(DISTINCT companyID)
						FROM CustomerContact
							LEFT JOIN TblOrdersBOM ON TblOrdersBOM.customerContactID = CustomerContact.CustomerContactID
						WHERE CustomerContact.CustomerID = Customers.CustomerID
						GROUP BY Customers.CustomerID
						) AS count
FROM Customers
HAVING count = 2







SELECT CustomerID, BillCompanyName, BillFirstName, BillLastName, 
						(
						SELECT Count(*)
						FROM CustomerContact
							LEFT JOIN TblOrdersBOM ON TblOrdersBOM.customerContactID = CustomerContact.CustomerContactID
						WHERE CustomerContact.CustomerID = Customers.CustomerID
						GROUP BY Customers.CustomerID
						) AS ordersCount,
						(
						SELECT Count(DISTINCT companyID)
						FROM CustomerContact
							LEFT JOIN TblOrdersBOM ON TblOrdersBOM.customerContactID = CustomerContact.CustomerContactID
						WHERE CustomerContact.CustomerID = Customers.CustomerID
						GROUP BY Customers.CustomerID
						) AS companiesCount
FROM Customers
HAVING companiesCount > 1;