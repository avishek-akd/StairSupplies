ALTER TABLE `TblState`
	ADD COLUMN `FreightTaxRate` DECIMAL(10,4) NULL DEFAULT NULL COMMENT 'Tax rate applied to Freight charge' AFTER `SalesTax`;

UPDATE TblState
SET FreightTaxRate = 0;
UPDATE TblState
SET FreightTaxRate = 0.0700
WHERE State = 'IN';

ALTER TABLE `TblState`
	ALTER `CountryId` DROP DEFAULT,
	ALTER `SalesTax` DROP DEFAULT;
ALTER TABLE `TblState`
	CHANGE COLUMN `CountryId` `CountryId` INT(10) NOT NULL AFTER `StateFull`,
	CHANGE COLUMN `SalesTax` `SalesTax` DECIMAL(10,4) NOT NULL AFTER `CountryId`,
	CHANGE COLUMN `FreightTaxRate` `FreightTaxRate` DECIMAL(10,4) NOT NULL COMMENT 'Tax rate applied to Freight charge' AFTER `SalesTax`;


ALTER TABLE `TblOrdersBOM`
	ADD COLUMN `FreightChargeTaxRate` DECIMAL(10,4) NULL DEFAULT '0' COMMENT 'Tax rate that is applied to Freight Charge' AFTER `SalesTaxRate`;
