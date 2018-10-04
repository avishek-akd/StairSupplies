ALTER TABLE `Customers`
	CHANGE COLUMN `FollowUp` `_unused_FollowUp` DATE NULL DEFAULT NULL AFTER `CustomerNotes`;

	
ALTER TABLE `Employees`
	CHANGE COLUMN `StartDate` `StartDate` DATE NULL DEFAULT NULL AFTER `vendor_id`;
ALTER TABLE `TblOrdersBOM`
	CHANGE COLUMN `DueDate` `DueDate` DATE NULL DEFAULT NULL AFTER `Email`,
	CHANGE COLUMN `DateFinal` `DateFinal` DATE NULL DEFAULT NULL AFTER `DueDate`,
	CHANGE COLUMN `ProductionDate` `ProductionDate` DATE NULL DEFAULT NULL AFTER `DateFinal`;

	
	
	
ALTER TABLE `TblRGARequest`
	CHANGE COLUMN `d_date_created` `d_record_created` DATETIME NULL DEFAULT NULL AFTER `d_is_archived`,
	CHANGE COLUMN `d_date_updated` `d_record_updated` DATETIME NULL DEFAULT NULL AFTER `d_record_created`;
ALTER TABLE `TblRGARequest`
	ALTER `d_record_created` DROP DEFAULT;
ALTER TABLE `TblRGARequest`
	CHANGE COLUMN `d_record_created` `d_record_created` DATETIME NOT NULL AFTER `d_is_archived`;

	

ALTER TABLE `TblRGAStatus`
	ALTER `d_date_created` DROP DEFAULT;
ALTER TABLE `TblRGAStatus`
	CHANGE COLUMN `d_date_created` `d_record_created` DATETIME NOT NULL AFTER `d_internal_notes`;

	
	
ALTER TABLE `tbl_wood_type`
	ALTER `d_date_created` DROP DEFAULT;
ALTER TABLE `tbl_wood_type`
	CHANGE COLUMN `d_date_created` `d_record_created` DATETIME NOT NULL AFTER `d_is_active`,
	CHANGE COLUMN `d_date_updated` `d_record_updated` DATETIME NULL DEFAULT NULL AFTER `d_record_created`;


	
ALTER TABLE `tbl_wood_type_lumber_type`
	ALTER `d_date_created` DROP DEFAULT;
ALTER TABLE `tbl_wood_type_lumber_type`
	CHANGE COLUMN `d_date_created` `d_record_created` DATETIME NOT NULL AFTER `d_lumber_rate`,
	CHANGE COLUMN `d_date_updated` `d_record_updated` DATETIME NULL DEFAULT NULL AFTER `d_record_created`;
