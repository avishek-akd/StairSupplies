ALTER TABLE TblAudit
	CHANGE COLUMN d_item_id `_unused_d_item_id` INT NULL DEFAULT NULL,
	ADD COLUMN OrderID INT NULL DEFAULT NULL AFTER `_unused_d_item_id`,
	ADD COLUMN CustomerID INT NULL DEFAULT NULL AFTER `OrderID`,
	ADD CONSTRAINT `FK_TblAudit_OrderID` FOREIGN KEY (`OrderID`) REFERENCES TblOrdersBOM(`OrderID`),
	ADD CONSTRAINT `FK_TblAudit_Customers` FOREIGN KEY (`CustomerID`) REFERENCES Customers(`CustomerID`)
;


UPDATE TblAudit
SET
	OrderID = _unused_d_item_id
WHERE d_table_name = 'TblOrdersBOM';
UPDATE TblAudit
SET
	CustomerID = _unused_d_item_id
WHERE d_table_name = 'Customers';