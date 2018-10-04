DELETE FROM TblOrdersBOM_ShipmentsItems WHERE orderItemsID IN (SELECT orderItemsID FROM TblOrdersBOM_Items INNER JOIN TblOrdersBOM ON TblOrdersBOM.orderID = TblOrdersBOM_Items.orderID WHERE companyID <> 2);

DELETE FROM TblFile WHERE orderShipmentID IN (SELECT orderShipmentID FROM TblOrdersBOM_Shipments INNER JOIN TblOrdersBOM ON TblOrdersBOM.OrderID = TblOrdersBOM_Shipments.OrderID WHERE CompanyID <> 2);
DELETE FROM TblOrdersBOM_Shipments WHERE OrderID IN (SELECT OrderID from TblOrdersBOM WHERE CompanyID <> 2);

DELETE FROM TblFile WHERE orderItemsID IN (SELECT orderItemsID FROM TblOrdersBOM_Items INNER JOIN TblOrdersBOM ON TblOrdersBOM.orderID = TblOrdersBOM_Items.orderID WHERE companyID <> 2);
DELETE FROM TblOrdersBOM_Items WHERE OrderID IN (SELECT OrderID from TblOrdersBOM WHERE CompanyID <> 2);

--  There are some products that have a different company than the order that they're on
-- so first delete all products on orders for Nu-Wood and then delete products directly attached to Nu-Wood 
DELETE FROM TblFile WHERE ProductID IN (SELECT ProductID FROM TblOrdersBOM_Items WHERE OrderID IN (SELECT OrderID from TblOrdersBOM WHERE CompanyID <> 2));
DELETE FROM Products WHERE ProductID IN (SELECT ProductID FROM TblOrdersBOM_Items WHERE OrderID IN (SELECT OrderID from TblOrdersBOM WHERE CompanyID <> 2));

DELETE FROM TblFile WHERE ProductID IN (SELECT ProductId FROM Products WHERE CompanyID <> 2);
DELETE FROM Products WHERE CompanyID <> 2;

DELETE FROM TblFile WHERE OrderID IN (SELECT OrderID from TblOrdersBOM WHERE CompanyID <> 2);
DELETE FROM TblOrdersBOM WHERE CompanyID <> 2;

ALTER TABLE `TblOrdersBOM`
	DROP COLUMN `old_CustomerID`,
	DROP FOREIGN KEY `FK_TblOrdersBOM_Customers`;


--  At the point we have only Nu-wood orders so we can remove customers that don't have at least 1 order
DELETE FROM TblFile WHERE customerContactID NOT IN (SELECT CustomerContactID from TblOrdersBOM);
DELETE FROM CustomerContact WHERE CustomerContactID NOT IN (SELECT CustomerContactID from TblOrdersBOM);
DELETE FROM TblFile WHERE CustomerID NOT IN (SELECT CustomerID from CustomerContact);
DELETE FROM Customers WHERE CustomerID NOT IN (SELECT CustomerID from CustomerContact);

DELETE FROM tbl_settings WHERE d_company_id <> 2;

DELETE FROM Company WHERE CompanyID <> 2;



ALTER TABLE `tblRGAStatus`
	DROP FOREIGN KEY `FK_tblRGAStatus_tblRGARequest`;
ALTER TABLE `tblRGAStatus`
	ADD CONSTRAINT `FK_tblRGAStatus_tblRGARequest` FOREIGN KEY (`d_rga_request_id`) REFERENCES `tblRGARequest` (`id`) ON UPDATE NO ACTION ON DELETE CASCADE;
DELETE FROM tblRGARequest;
DELETE FROM tblRGAProduct;
DELETE FROM tblRGAStatus;
