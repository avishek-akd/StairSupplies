-- 
-- tbl_wood_type_availability is not actually used outside this module so we can remove it
-- 
RENAME TABLE `tbl_wood_type_availability` TO `_unused_tbl_wood_type_availability`;
ALTER TABLE `Employees`
	CHANGE COLUMN `vendor_id` `_unused_vendor_id` INT(10) NULL DEFAULT NULL COMMENT 'The employee can be a vendor that needs access to parts of the application so this is his id.' AFTER `allowed_ips_list_id`;
DELETE FROM `stairs5_intranet`.`Employees_module` WHERE  `Module_id`=13;