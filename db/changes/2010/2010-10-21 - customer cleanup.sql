ALTER TABLE `TblOrdersBOM_ShipmentsItems`
	DROP FOREIGN KEY `TblOrdersBOM_ShipmentsItems_fk`;
ALTER TABLE `TblOrdersBOM_ShipmentsItems`
	ADD CONSTRAINT `TblOrdersBOM_ShipmentsItems_fk` FOREIGN KEY (`OrderShipment_id`) REFERENCES `TblOrdersBOM_Shipments` (`OrderShipment_id`) ON UPDATE NO ACTION ON DELETE CASCADE;


--  No data
DELETE FROM Customers WHERE CustomerID = 89;
DELETE FROM Customers WHERE CustomerID = 222;
DELETE FROM Customers WHERE CustomerID = 11129;
DELETE FROM Customers WHERE CustomerID = 11259;
DELETE FROM Customers WHERE CustomerID = 21242;
DELETE FROM Customers WHERE CustomerID = 21243;
DELETE FROM Customers WHERE CustomerID = 23312;
DELETE FROM Customers WHERE CustomerID = 23313;
DELETE FROM Customers WHERE CustomerID = 23631;
DELETE FROM Customers WHERE CustomerID = 23841;
DELETE FROM Customers WHERE CustomerID = 24339;
DELETE FROM Customers WHERE CustomerID = 25368;
DELETE FROM Customers WHERE CustomerID = 25445;
DELETE FROM Customers WHERE CustomerID = 25447;
DELETE FROM Customers WHERE CustomerID = 29527;
DELETE FROM TblFile WHERE CustomerID = 29414;
DELETE FROM Customers WHERE CustomerID = 29414;


--  Delete all customers with empty data and no order
DELETE
from Customers
where (ContactCompanyName is null or ContactCompanyName = '')
	and (contactFirstName is null or contactFirstName = '')
	and  (ContactLastName is null or ContactLastName = '')
	and customerID NOT IN (select CustomerID FROM TblOrdersBOM);


--  Delete test customers with empty data and test orders
DELETE FROM TblOrdersBOM where customerID in (14729, 5020, 384);
DELETE FROM Customers WHERE customerID in (14729, 5020, 384);

--  Delete test orders
DELETE FROM TblOrdersBOM where orderID in (38219, 38138, 43275);



UPDATE Customers
SET ContactAddress1 = NULL
WHERE ContactAddress1 IN ('"test"', 'xxxxxxxx', 'xxxxx', 'xxxx', 'xxx', 'xx', 'x',
'test_billl', 'test_bill', 'test', 'TEST address1', 'synapse', 'sibbu@sibbu.com', '1');


--  Vision IT test customer
DELETE from TblOrdersBOM_Shipments where orderID IN(select orderID from TblOrdersBOM where CustomerID = 1);
DELETE from TblOrdersBOM where CustomerID = 1;
DELETE from Customers where CustomerID = 1;

--  sampatti.com test customers and orders
DELETE from TblOrdersBOM_Shipments where orderID IN (select orderID from TblOrdersBOM where CustomerID IN (SELECT CustomerID FROM Customers WHERE Email  like '%sampatti.com%'));
DELETE from TblOrdersBOM where CustomerID IN (SELECT CustomerID FROM Customers WHERE Email  like '%sampatti.com%');
DELETE FROM Customers WHERE Email like '%sampatti.com%';

DELETE from TblOrdersBOM_Shipments where orderID IN (select orderID from TblOrdersBOM where CustomerID IN (SELECT CustomerID FROM Customers WHERE Email  like '%test@test.com%'));
DELETE from TblOrdersBOM where CustomerID IN (SELECT CustomerID FROM Customers WHERE Email  like '%test@test.com%');
DELETE FROM Customers WHERE Email like '%test@test.com%';

--  Len testing
DELETE from TblOrdersBOM_Shipments where orderID IN (select orderID from TblOrdersBOM where CustomerID IN (SELECT CustomerID FROM Customers WHERE customerID in (2453, 2454, 2457, 2458)));
DELETE from TblOrdersBOM where CustomerID IN (SELECT CustomerID FROM Customers WHERE customerID in (2453, 2454, 2457, 2458));
DELETE FROM Customers WHERE customerID in (2453, 2454, 2457, 2458);

DELETE FROM Customers WHERE customerID IN (25234);

--  Synapse testing
DELETE FROM Customers WHERE customerID IN (25332, 25333, 25335, 26052, 26053, 26054);
DELETE FROM Customers WHERE Email like '%sibbu%';
DELETE FROM Customers WHERE Email like '%synapse%';