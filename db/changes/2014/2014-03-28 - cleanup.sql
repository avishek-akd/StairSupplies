ALTER TABLE `Products`
	DROP COLUMN `_unused_EmployeeRateFinal`,
	DROP COLUMN `_unused_Bin`,
	DROP COLUMN `_unused_inboundFreightCost`;
ALTER TABLE `TblOrdersBOM_Items`
	DROP COLUMN `_unused_RecordCreated`;

	
ALTER TABLE `TblOrdersBOM_Items`
	CHANGE COLUMN `PRC_Initials` `_unused_PRC_Initials` VARCHAR(15) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `PRC`,
	CHANGE COLUMN `Final_Initials` `_unused_Final_Initials` VARCHAR(15) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `Final`,
	CHANGE COLUMN `Prefinishing_Complete_Initials` `_unused_Prefinishing_Complete_Initials` VARCHAR(15) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `Prefinishing_Complete`;
