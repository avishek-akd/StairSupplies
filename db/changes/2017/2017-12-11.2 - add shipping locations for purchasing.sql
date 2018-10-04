CREATE TABLE `TblCompanyLocation` (
	`LocationID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`CompanyID` INT NOT NULL,
	`Address` VARCHAR(255) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci',
	`City` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci',
	`StateOrProvince` VARCHAR(20) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci',
	`PostalCode` VARCHAR(20) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci',
	`Country` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci',
	`PhoneNumber` VARCHAR(30) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci',
	`FaxNumber` VARCHAR(30) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci',
	`Highlight` TINYINT NOT NULL DEFAULT 0 COMMENT '=1 if this location is highlighted',
	PRIMARY KEY (`LocationID`),
	INDEX `idxCompanyID` (`CompanyID`),
	CONSTRAINT `FK_TblCompanyLocation_TblCompany` FOREIGN KEY (`CompanyID`) REFERENCES `TblCompany` (`CompanyID`) ON UPDATE NO ACTION ON DELETE NO ACTION
)
;


INSERT INTO TblCompanyLocation
	(CompanyID, Address, City, StateOrProvince, PostalCode, Country, PhoneNumber, FaxNumber, Highlight)
SELECT
	1, Address, City, StateOrProvince, PostalCode, Country, PhoneNumber, FaxNumber, 0
FROM TblCompany
WHERE CompanyID = 1
;
INSERT INTO TblCompanyLocation
	(CompanyID, Address, City, StateOrProvince, PostalCode, Country, PhoneNumber, FaxNumber, Highlight)
SELECT
	1, '1755 Ardmore Court', 'Goshen', 'IN', 46526, 'USA', '866-226-6536', '509-463-4227', 1
;



ALTER TABLE `TblPurchaseOrder`
	ADD COLUMN `ShippingLocationID` INT UNSIGNED NOT NULL DEFAULT 1 AFTER `RequestedByEmployeeID`,
	ADD INDEX `idxShippingLocationID` (`ShippingLocationID`),
	ADD CONSTRAINT `FK_TblPurchaseOrder_TblCompanyLocation` FOREIGN KEY (`ShippingLocationID`) REFERENCES `TblCompanyLocation` (`LocationID`) ON UPDATE NO ACTION ON DELETE NO ACTION
;
ALTER TABLE `TblPurchaseOrder`
	ALTER `ShippingLocationID` DROP DEFAULT
;
