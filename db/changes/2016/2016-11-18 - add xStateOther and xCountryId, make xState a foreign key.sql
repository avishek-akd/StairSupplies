ALTER TABLE `CustomerContact`
	CHANGE COLUMN `ContactAddress1` `ContactAddress1` VARCHAR(200) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `ContactLastName`,
	CHANGE COLUMN `ContactAddress2` `ContactAddress2` VARCHAR(200) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `ContactAddress1`,
	CHANGE COLUMN `ContactAddress3` `ContactAddress3` VARCHAR(200) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `ContactAddress2`,
	CHANGE COLUMN `ContactStateOther` `ContactStateOther` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `ContactState`;


ALTER TABLE `TblOrdersBOM`
	CHANGE COLUMN `ShipCompanyName` `ShipCompanyName` VARCHAR(100) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `_unused_ShipName`,
	CHANGE COLUMN `ShipAddress1` `ShipAddress1` VARCHAR(200) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `ShipContactLastName`,
	CHANGE COLUMN `ShipAddress2` `ShipAddress2` VARCHAR(200) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `ShipAddress1`,
	CHANGE COLUMN `ShipAddress3` `ShipAddress3` VARCHAR(200) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `ShipAddress2`,

	CHANGE COLUMN `BillCompanyName` `BillCompanyName` VARCHAR(100) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `_unused_ShipPhoneNumber`,
	CHANGE COLUMN `BillAddress1` `BillAddress1` VARCHAR(200) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `BillContactLastName`,
	CHANGE COLUMN `BillAddress2` `BillAddress2` VARCHAR(200) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `BillAddress1`,
	CHANGE COLUMN `BillAddress3` `BillAddress3` VARCHAR(200) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `BillAddress2`;

ALTER TABLE `TblOrdersBOM`
	ADD COLUMN `ShipStateOther` VARCHAR(50) NULL DEFAULT NULL AFTER `ShipState`,
	ADD COLUMN `ShipCountryId` INT NULL DEFAULT NULL AFTER `ShipPostalCode`,
	ADD COLUMN `BillStateOther` VARCHAR(50) NULL DEFAULT NULL AFTER `BillState`,
	ADD COLUMN `BillCountryId` INT NULL DEFAULT NULL AFTER `BillPostalCode`,
	ADD CONSTRAINT `FK_TblOrdersBOM_TblCountry` FOREIGN KEY (`ShipCountryId`) REFERENCES `TblCountry` (`id`),
	ADD CONSTRAINT `FK_TblOrdersBOM_TblCountry_2` FOREIGN KEY (`BillCountryId`) REFERENCES `TblCountry` (`id`);




--
--  Convert BillState into a 2-char field that is a foreign key into TblState
--
UPDATE TblOrdersBOM SET BillCountryId = 1;


UPDATE TblOrdersBOM
SET BillState = NULL
WHERE BillState='' OR BillState='x' OR BillState='xx' OR BillState = 'xxxxxx' OR BillState LIKE 'xxx%' OR BillState = 'N/A' OR BillState = 'NA' OR BillState LIKE 'None%'
;
UPDATE TblOrdersBOM
SET BillCountryId = (SELECT CountryId FROM TblState WHERE BillState = StateFull)
WHERE BillState IN (select StateFull from TblState)
;
UPDATE TblOrdersBOM
SET BillState = (SELECT State FROM TblState WHERE BillState = StateFull)
WHERE BillState IN (select StateFull from TblState)
;
UPDATE TblOrdersBOM SET BillState = Replace(BillState, '.', '') WHERE BillState REGEXP '^[a-z][a-z]\.$'
;
UPDATE TblOrdersBOM SET BillState = Replace(BillState, ' ', '') WHERE BillState REGEXP '^[a-z][a-z] $' OR BillState REGEXP '^ [a-z][a-z]$'
;



UPDATE TblOrdersBOM SET BillState = 'CA' WHERE BillState LIKE 'Cali%';
UPDATE TblOrdersBOM SET BillState = 'CT' WHERE BillState LIKE 'Conn%';
UPDATE TblOrdersBOM SET BillState = 'MA' WHERE BillState LIKE 'Mass%';
UPDATE TblOrdersBOM SET BillState = 'MN' WHERE BillState LIKE 'Minn%';
UPDATE TblOrdersBOM SET BillState = 'MS' WHERE BillState LIKE 'Miss%';
UPDATE TblOrdersBOM SET BillState = 'LA' WHERE BillState LIKE 'Lousi%' OR BillState LIKE 'Louis%';
UPDATE TblOrdersBOM SET BillState = 'IL' WHERE BillState='ILL' OR BillState='ILL.' OR BillState='Ilinois' OR BillState='IL 60647' OR BillState LIKE 'Illin%' OR BillState LIKE 'Illo%' OR BillState='Illionois' OR BillState='Illnois';
UPDATE TblOrdersBOM SET BillState = 'KS' WHERE BillState='Kansan';
UPDATE TblOrdersBOM SET BillState = 'TX' WHERE BillState='Texax';
UPDATE TblOrdersBOM SET BillState = 'TN' WHERE BillState='Tenessee' OR BillState='Tennesse';
UPDATE TblOrdersBOM SET BillState = 'NC' WHERE BillState='North Carlina' OR BillState='Nort Carolina';
UPDATE TblOrdersBOM SET BillState = 'SC' WHERE BillState='South  Carolina' OR BillState='South Catolina' OR BillState='Sout Carolina';
UPDATE TblOrdersBOM SET BillState = 'NJ' WHERE BillState='New Jerse';
UPDATE TblOrdersBOM SET BillState = 'FL' WHERE BillState='Flordia';


--  Canada
UPDATE TblOrdersBOM SET BillState = 'AB', BillCountryId = 2 WHERE BillState LIKE '%Alberta%' OR BillState='Alberts';
UPDATE TblOrdersBOM SET BillState = 'BC', BillCountryId = 2 WHERE BillState LIKE '%BC, Canada%' OR BillState LIKE '%BC Canada%' OR BillState LIKE '%Brisish Colombia, Ca%' OR BillState LIKE '%British Columbia, Ca%';
UPDATE TblOrdersBOM SET BillState = 'ON', BillCountryId = 2 WHERE BillState LIKE '%Ontario%' OR BillState LIKE '%Ontairo%' OR BillState LIKE '%Onterio%' OR BillState = 'ON, CANADA' OR BillState = 'ONT' OR BillState='ONT   CANADA';
UPDATE TblOrdersBOM SET BillState = 'ON', BillCountryId = 2, BillPostalCode='M3B265' WHERE BillState = 'ON M3B265';
UPDATE TblOrdersBOM SET BillState = 'MB', BillCountryId = 2 WHERE BillState LIKE '%Maitoba%' OR BillState LIKE '%Manitoba%';
UPDATE TblOrdersBOM SET BillState = 'NS', BillCountryId = 2 WHERE BillState LIKE '%Novascotia Canada%' OR BillState = 'Novs Scottia';
UPDATE TblOrdersBOM SET BillState = 'QC', BillCountryId = 2 WHERE BillState LIKE '%Quebec, Canada%' OR BillState = 'QB' OR BillState='PQ';
UPDATE TblOrdersBOM SET BillState = 'SK', BillCountryId = 2 WHERE BillState LIKE '%Saskatchawan, Canada%' OR BillState = 'Sask' OR BillState = 'Saskatchewan, Canada';


--  Countries
UPDATE TblOrdersBOM SET BillState = NULL, BillCountryId = 2 WHERE BillState = 'Canada';
UPDATE TblOrdersBOM SET BillState = NULL, BillCountryId = 3 WHERE BillState = 'UK' OR BillState = 'U.K.' OR BillState = 'United Kingdom';
UPDATE TblOrdersBOM SET BillState = NULL, BillCountryId = 20 WHERE BillState = 'Bahamas' OR BillState = 'Grand Bahama';
UPDATE TblOrdersBOM SET BillState = NULL, BillCountryId = 28 WHERE BillState = 'Bermuda' OR BillState = 'Burmuda';
UPDATE TblOrdersBOM SET BillState = NULL, BillCountryId = 43 WHERE BillState LIKE '%Caym%' OR BillState LIKE '%Camon%';


UPDATE TblOrdersBOM SET BillState = Upper(BillState);
UPDATE TblOrdersBOM SET BillState = NULL WHERE BillState NOT IN (SELECT State FROM TblState);






--
--  Convert BillState into a 2-char field that is a foreign key into TblState
--
UPDATE TblOrdersBOM SET ShipCountryId = 1;


UPDATE TblOrdersBOM
SET ShipState = NULL
WHERE ShipState='' OR ShipState='x' OR ShipState='xx' OR ShipState = 'xxxxxx' OR ShipState LIKE 'xxx%' OR ShipState = 'N/A' OR ShipState = 'NA' OR ShipState LIKE 'None%'
;
UPDATE TblOrdersBOM
SET ShipCountryId = (SELECT CountryId FROM TblState WHERE ShipState = StateFull)
WHERE ShipState IN (select StateFull from TblState)
;
UPDATE TblOrdersBOM
SET ShipState = (SELECT State FROM TblState WHERE ShipState = StateFull)
WHERE ShipState IN (select StateFull from TblState)
;
UPDATE TblOrdersBOM SET ShipState = Replace(ShipState, '.', '') WHERE ShipState REGEXP '^[a-z][a-z]\.$'
;
UPDATE TblOrdersBOM SET ShipState = Replace(ShipState, ' ', '') WHERE ShipState REGEXP '^[a-z][a-z] $' OR ShipState REGEXP '^ [a-z][a-z]$'
;



UPDATE TblOrdersBOM SET ShipState = 'CA' WHERE ShipState LIKE 'Cali%';
UPDATE TblOrdersBOM SET ShipState = 'CT' WHERE ShipState LIKE 'Conn%';
UPDATE TblOrdersBOM SET ShipState = 'MA' WHERE ShipState LIKE 'Mass%';
UPDATE TblOrdersBOM SET ShipState = 'MN' WHERE ShipState LIKE 'Minn%';
UPDATE TblOrdersBOM SET ShipState = 'MS' WHERE ShipState LIKE 'Miss%';
UPDATE TblOrdersBOM SET ShipState = 'LA' WHERE ShipState LIKE 'Lousi%' OR ShipState LIKE 'Louis%';
UPDATE TblOrdersBOM SET ShipState = 'IL' WHERE ShipState='ILL' OR ShipState='ILL.' OR ShipState='Ilinois' OR ShipState='IL 60647' OR ShipState LIKE 'Illin%' OR ShipState LIKE 'Illo%' OR ShipState='Illionois' OR ShipState='Illnois';
UPDATE TblOrdersBOM SET ShipState = 'KS' WHERE ShipState='Kansan';
UPDATE TblOrdersBOM SET ShipState = 'TX' WHERE ShipState='Texax';
UPDATE TblOrdersBOM SET ShipState = 'TN' WHERE ShipState='Tenessee' OR ShipState='Tennesse';
UPDATE TblOrdersBOM SET ShipState = 'NC' WHERE ShipState='North Carlina' OR ShipState='Nort Carolina';
UPDATE TblOrdersBOM SET ShipState = 'SC' WHERE ShipState='South  Carolina' OR ShipState='South Catolina' OR ShipState='Sout Carolina';
UPDATE TblOrdersBOM SET ShipState = 'NJ' WHERE ShipState='New Jerse';
UPDATE TblOrdersBOM SET ShipState = 'FL' WHERE ShipState='Flordia';




--  Canada
UPDATE TblOrdersBOM SET ShipState = 'AB', ShipCountryId = 2 WHERE ShipState LIKE '%Alberta%' OR ShipState='Alberts';
UPDATE TblOrdersBOM SET ShipState = 'BC', ShipCountryId = 2 WHERE ShipState LIKE '%BC, Canada%' OR ShipState LIKE '%BC Canada%' OR ShipState LIKE '%Brisish Colombia, Ca%' OR ShipState LIKE '%British Columbia, Ca%';
UPDATE TblOrdersBOM SET ShipState = 'ON', ShipCountryId = 2 WHERE ShipState LIKE '%Ontario%' OR ShipState LIKE '%Ontairo%' OR ShipState LIKE '%Onterio%' OR ShipState = 'ON, CANADA' OR ShipState = 'ONT' OR ShipState='ONT   CANADA';
UPDATE TblOrdersBOM SET ShipState = 'ON', ShipCountryId = 2, ShipPostalCode='M3B265' WHERE ShipState = 'ON M3B265';
UPDATE TblOrdersBOM SET ShipState = 'MB', ShipCountryId = 2 WHERE ShipState LIKE '%Maitoba%' OR ShipState LIKE '%Manitoba%';
UPDATE TblOrdersBOM SET ShipState = 'NS', ShipCountryId = 2 WHERE ShipState LIKE '%Novascotia Canada%' OR ShipState = 'Novs Scottia';
UPDATE TblOrdersBOM SET ShipState = 'QC', ShipCountryId = 2 WHERE ShipState LIKE '%Quebec, Canada%' OR ShipState = 'QB' OR ShipState='PQ';
UPDATE TblOrdersBOM SET ShipState = 'SK', ShipCountryId = 2 WHERE ShipState LIKE '%Saskatchawan, Canada%' OR ShipState = 'Sask' OR ShipState = 'Saskatchewan, Canada';


--  Countries
UPDATE TblOrdersBOM SET ShipState = NULL, ShipCountryId = 2 WHERE ShipState = 'Canada';
UPDATE TblOrdersBOM SET ShipState = NULL, ShipCountryId = 3 WHERE ShipState = 'UK' OR ShipState = 'U.K.' OR ShipState = 'United Kingdom';
UPDATE TblOrdersBOM SET ShipState = NULL, ShipCountryId = 20 WHERE ShipState = 'Bahamas' OR ShipState = 'Grand Bahama';
UPDATE TblOrdersBOM SET ShipState = NULL, ShipCountryId = 28 WHERE ShipState = 'Bermuda' OR ShipState = 'Burmuda';
UPDATE TblOrdersBOM SET ShipState = NULL, ShipCountryId = 43 WHERE ShipState LIKE '%Caym%' OR ShipState LIKE '%Camon%';


UPDATE TblOrdersBOM SET ShipState = Upper(ShipState);
UPDATE TblOrdersBOM SET ShipState = NULL WHERE ShipState NOT IN (SELECT State FROM TblState);







--  Convert to Varchar(2) and add Foreign Key constrains 
ALTER TABLE `TblOrdersBOM`
	CHANGE COLUMN `ShipState` `ShipState` VARCHAR(2) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `ShipCity`,
	CHANGE COLUMN `BillState` `BillState` VARCHAR(2) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `BillCity`,
	ADD CONSTRAINT `FK_TblOrdersBOM_billState` FOREIGN KEY (`BillState`) REFERENCES `TblState` (`State`),
	ADD CONSTRAINT `FK_TblOrdersBOM_shipState` FOREIGN KEY (`ShipState`) REFERENCES `TblState` (`State`);
