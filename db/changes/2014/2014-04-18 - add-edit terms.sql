ALTER TABLE `Tbl_Terms`
	ADD COLUMN `id` INT NOT NULL AUTO_INCREMENT FIRST,
	DROP PRIMARY KEY,
	ADD PRIMARY KEY (`id`);

	
	
ALTER TABLE `TblOrdersBOM`
	CHANGE COLUMN `Terms` `_unused_Terms` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `Production_In_House_Notes`,
	ADD COLUMN `TermsID` INT NULL DEFAULT NULL AFTER `_unused_Terms`,
	ADD CONSTRAINT `FK_TblOrdersBOM_Tbl_Terms` FOREIGN KEY (`TermsID`) REFERENCES `Tbl_Terms` (`id`);

UPDATE TblOrdersBOM SET TermsID = (SELECT id FROM Tbl_Terms where Tbl_Terms.Terms = TblOrdersBOM._unused_Terms);
UPDATE TblOrdersBOM SET TermsID = 4 WHERE _unused_Terms = 'COD';
UPDATE TblOrdersBOM SET TermsID = 8 WHERE _unused_Terms = 'creditcard';
UPDATE TblOrdersBOM SET TermsID = 6 WHERE _unused_Terms = 'money order';
UPDATE TblOrdersBOM SET TermsID = 1 WHERE _unused_Terms = '2% 10 Net 30';



ALTER TABLE `Customers`
	CHANGE COLUMN `Terms` `_unused_Terms` VARCHAR(50) NULL DEFAULT 'Credit Card' COLLATE 'utf8_unicode_ci' AFTER `ShipCountryID`,
	ADD COLUMN `TermsID` INT NULL AFTER `_unused_Terms`,
	ADD CONSTRAINT `FK_Customers_Tbl_Terms` FOREIGN KEY (`TermsID`) REFERENCES `Tbl_Terms` (`id`);

UPDATE Customers SET TermsID = (SELECT id FROM Tbl_Terms where Tbl_Terms.Terms = Customers._unused_Terms);
UPDATE Customers SET TermsID = 4 WHERE _unused_Terms = 'COD';
UPDATE Customers SET TermsID = 8 WHERE _unused_Terms = 'creditcard';
UPDATE Customers SET TermsID = 6 WHERE _unused_Terms = 'money order';
UPDATE Customers SET TermsID = 1 WHERE _unused_Terms = '2% 10 Net 30';
