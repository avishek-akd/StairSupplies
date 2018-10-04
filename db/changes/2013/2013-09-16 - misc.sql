--  Only comments are changed
ALTER TABLE `TblOrdersBOM`
	CHANGE COLUMN `Canonical_Job_Name` `Canonical_Job_Name` VARCHAR(200) NULL DEFAULT NULL COMMENT 'Processed job name that allows us to find the right entry quicker' AFTER `Job_Name`,
	CHANGE COLUMN `OrderTotal` `OrderTotal` DECIMAL(19,4) NULL DEFAULT '0.0000' COMMENT 'Pre-calculated order total used in the Customer module ' AFTER `Canonical_Job_Name`
;

	
UPDATE TblOrdersBOM_Items
SET
	quantity = 0
WHERE quantity is null
;
UPDATE TblOrdersBOM
SET
	FreightCharge = 0
WHERE FreightCharge is null
;