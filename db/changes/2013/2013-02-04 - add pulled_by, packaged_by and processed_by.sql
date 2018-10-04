ALTER TABLE `TblOrdersBOM_Shipments`
	ADD COLUMN `pulled_by_id` INT(11) NULL DEFAULT NULL AFTER `ShippedBy_Id`,
	ADD COLUMN `packaged_by_id` INT(11) NULL DEFAULT NULL AFTER `pulled_by_id`,
	ADD COLUMN `processed_by_id` INT(11) NULL DEFAULT NULL AFTER `packaged_by_id`;
ALTER TABLE `TblOrdersBOM_Shipments`
	ADD INDEX `idx_pulled_by_id` (`pulled_by_id`),
	ADD INDEX `idx_packaged_by_id` (`packaged_by_id`),
	ADD INDEX `idx_processed_by_id` (`processed_by_id`);
ALTER TABLE `TblOrdersBOM_Shipments`
	ADD CONSTRAINT `FK_TblOrdersBOM_Shipments_Employees` FOREIGN KEY (`pulled_by_id`) REFERENCES `Employees` (`EmployeeID`),
	ADD CONSTRAINT `FK_TblOrdersBOM_Shipments_Employees_2` FOREIGN KEY (`packaged_by_id`) REFERENCES `Employees` (`EmployeeID`),
	ADD CONSTRAINT `FK_TblOrdersBOM_Shipments_Employees_3` FOREIGN KEY (`processed_by_id`) REFERENCES `Employees` (`EmployeeID`);

	
ALTER TABLE `TblOrdersBOM_Shipments`
	DROP FOREIGN KEY `TblOrdersBOM_Shipments_fk`;
ALTER TABLE `TblOrdersBOM_Shipments`
	CHANGE COLUMN `ShippedBy_Id` `_z_unused_ShippedBy_Id` INT(11) NULL DEFAULT NULL AFTER `ShippingMethodID`,
	ADD CONSTRAINT `TblOrdersBOM_Shipments_fk` FOREIGN KEY (`_z_unused_ShippedBy_Id`) REFERENCES `Employees` (`EmployeeID`) ON UPDATE NO ACTION ON DELETE NO ACTION;