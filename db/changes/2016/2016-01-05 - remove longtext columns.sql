ALTER TABLE `TblOrdersBOM`
	CHANGE COLUMN `In_House_Notes` `In_House_Notes` VARCHAR(4000) NULL AFTER `FreightChargeTaxRate`,
	CHANGE COLUMN `Notes_From_Customer` `Notes_From_Customer` VARCHAR(4000) NULL AFTER `In_House_Notes`,
	CHANGE COLUMN `ShippingDirections` `ShippingDirections` VARCHAR(2000) NULL AFTER `CustomerQuotationPONumber`;
ALTER TABLE `TblRGARequest`
	CHANGE COLUMN `d_details` `d_details` VARCHAR(2000) NULL AFTER `d_return_reason_id`,
	CHANGE COLUMN `d_notes_internal` `d_notes_internal` VARCHAR(500) NULL AFTER `d_details`;
ALTER TABLE `tbl_settings_per_company`
	ALTER `id` DROP DEFAULT;
ALTER TABLE `tbl_settings_per_company`
	CHANGE COLUMN `id` `id` TINYINT NOT NULL FIRST;
