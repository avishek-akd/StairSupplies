RENAME TABLE `tbl_lumber_species` TO `tbl_wood_type`;
RENAME TABLE `tbl_lumber_species_type` TO `tbl_wood_type_lumber_type`;
RENAME TABLE `tbl_lumber_availability` TO `tbl_wood_type_availability`;



UPDATE `Employees_module`
SET `Module_name`='Purchasing / Wood Type Availability (Vendor access only)', `Module_directory`='/purchasing/wood_type/'
WHERE  `Module_id`=13 LIMIT 1;



DELETE FROM tbl_wood_type_availability WHERE d_species_id not in (select id from tbl_wood_type);

ALTER TABLE `tbl_wood_type_availability`
	ALTER `d_species_id` DROP DEFAULT;
ALTER TABLE `tbl_wood_type_availability`
	CHANGE COLUMN `d_species_id` `d_wood_type_id` INT(10) NOT NULL AFTER `id`;
ALTER TABLE `tbl_wood_type_availability`
	ADD INDEX `idx_WoodType` (`d_wood_type_id`),
	ADD CONSTRAINT `FK_tbl_wood_type_availability_tbl_wood_type` FOREIGN KEY (`d_wood_type_id`) REFERENCES `tbl_wood_type` (`id`),
	ADD CONSTRAINT `FK_tbl_wood_type_availability_TBLVendor` FOREIGN KEY (`d_vendor_id`) REFERENCES `TBLVendor` (`Vendor_ID`),
	ADD CONSTRAINT `FK_tbl_wood_type_availability_Employees` FOREIGN KEY (`d_updated_by`) REFERENCES `Employees` (`EmployeeID`);



ALTER TABLE `Products`
	DROP FOREIGN KEY `Products_fk_Species`;
ALTER TABLE `Products`
	CHANGE COLUMN `SpeciesID` `WoodTypeID` INT(10) NULL DEFAULT NULL AFTER `ProductType_id`,
	DROP INDEX `idx_SpeciesID`,
	ADD INDEX `idx_WoodTypeID` (`WoodTypeID`),
	ADD CONSTRAINT `Products_fk_WoodType` FOREIGN KEY (`WoodTypeID`) REFERENCES `tbl_wood_type` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `Products`
	CHANGE COLUMN `LumberTypeID` `LumberTypeID` INT(10) UNSIGNED NULL DEFAULT NULL AFTER `WoodTypeID`;



ALTER TABLE `tbl_wood_type_lumber_type`
	DROP FOREIGN KEY `FK__tbl_lumber_species`;
ALTER TABLE `tbl_wood_type_lumber_type`
	ALTER `d_lumber_species_id` DROP DEFAULT;
ALTER TABLE `tbl_wood_type_lumber_type`
	CHANGE COLUMN `d_lumber_species_id` `d_wood_type_id` INT(10) NOT NULL AFTER `id`,
	DROP INDEX `d_lumber_species_id`,
	ADD INDEX `idx_LumberWood` (`d_lumber_type_id`, `d_wood_type_id`),
	DROP INDEX `FK__tbl_lumber_species`,
	ADD INDEX `idx_WoodType` (`d_wood_type_id`),
	ADD CONSTRAINT `FK__tbl_wood_type` FOREIGN KEY (`d_wood_type_id`) REFERENCES `tbl_wood_type` (`id`) ON DELETE CASCADE;



ALTER TABLE `TblOrdersBOM`
	CHANGE COLUMN `WoodType` `z_unused_WoodType` VARCHAR(50) NULL DEFAULT NULL AFTER `ProductionDateSet`,
	ADD COLUMN `WoodTypeID` INT NULL DEFAULT NULL AFTER `z_unused_WoodType`,
	ADD INDEX `idx_WoodTypeID` (`WoodTypeID`),
	ADD CONSTRAINT `FK_TblOrdersBOM_tbl_wood_type` FOREIGN KEY (`WoodTypeID`) REFERENCES `tbl_wood_type` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION;


UPDATE TblOrdersBOM SET z_unused_WoodType = NULL where z_unused_WoodType = '-1';
UPDATE TblOrdersBOM SET z_unused_WoodType = 'Brazilian Cherry' where z_unused_WoodType = 'Brazilian';
UPDATE TblOrdersBOM SET z_unused_WoodType = 'Brazilian Cherry' where z_unused_WoodType = 'BCY';
UPDATE TblOrdersBOM SET z_unused_WoodType = 'Brazilian Cherry' where z_unused_WoodType = 'Jatoba/BCY';
UPDATE TblOrdersBOM SET z_unused_WoodType = 'Brazilian Cherry' where z_unused_WoodType = 'Bchy';
UPDATE TblOrdersBOM SET z_unused_WoodType = 'Brazilian Oak (Cerejeira)' where z_unused_WoodType = 'Brazilian Oak';
UPDATE TblOrdersBOM SET z_unused_WoodType = 'Lyptus (Red Grandis)' where z_unused_WoodType = 'Lyptus';
UPDATE TblOrdersBOM SET z_unused_WoodType = 'African Mahogany' where z_unused_WoodType = 'African Mah.';
UPDATE TblOrdersBOM SET z_unused_WoodType = 'Poplar - Stain Grade' where z_unused_WoodType = 'Poplar';
UPDATE TblOrdersBOM SET z_unused_WoodType = 'Ash' where z_unused_WoodType = 'Ash, White';
UPDATE TblOrdersBOM SET z_unused_WoodType = 'Red Oak' where z_unused_WoodType = 'RO';
UPDATE TblOrdersBOM SET z_unused_WoodType = 'Red Oak' where z_unused_WoodType = 'R. Oak';
UPDATE TblOrdersBOM SET z_unused_WoodType = 'Hard Maple' where z_unused_WoodType = 'maple';
UPDATE TblOrdersBOM SET z_unused_WoodType = 'Hard Maple' where z_unused_WoodType = 'HM';
UPDATE TblOrdersBOM SET z_unused_WoodType = 'Santos Mahogany' where z_unused_WoodType = 'Santos';
UPDATE TblOrdersBOM SET z_unused_WoodType = 'White Oak' where z_unused_WoodType = 'WO';
UPDATE TblOrdersBOM SET z_unused_WoodType = 'American Cherry' where z_unused_WoodType = 'Cherry';
UPDATE TblOrdersBOM SET z_unused_WoodType = 'American Cherry' where z_unused_WoodType = 'Am. Cherry';
UPDATE TblOrdersBOM SET z_unused_WoodType = 'Paint Grade' where z_unused_WoodType = 'primed';
UPDATE TblOrdersBOM SET z_unused_WoodType = 'Alder' where z_unused_WoodType = 'Alder, Superior';
UPDATE TblOrdersBOM SET z_unused_WoodType = 'Hickory' where z_unused_WoodType = 'Hick';
UPDATE TblOrdersBOM SET z_unused_WoodType = 'Mixed Species' where z_unused_WoodType = 'Mixed';



--  There are around 220 orders that don't have a correct Wood Type, but we ignore those (the subquery returns NULL)
UPDATE TblOrdersBOM
SET WoodTypeID = (SELECT id FROM tbl_wood_type WHERE d_name = z_unused_WoodType);





/*  view OrderItem */
select `TblOrdersBOM_Items`.`OrderItemsID` AS `orderItemsID`,
	`TblOrdersBOM_Items`.`OrderID` AS `orderID`,`TblOrdersBOM_Items`.`UnitPrice` AS `unitPrice`,
	`TblOrdersBOM_Items`.`ProductName` AS `ProductName`,`TblOrdersBOM_Items`.`ProductDescription` AS `ProductDescription`,
	`TblOrdersBOM_Items`.`In_House_Notes` AS `in_house_notes`,`TblOrdersBOM_Items`.`Quantity` AS `quantity`,
	`TblOrdersBOM_Items`.`QuantityShipped` AS `quantityShipped`,`TblOrdersBOM_Items`.`Customer_Notes` AS `Customer_Notes`,
	`TblOrdersBOM_Items`.`Discount` AS `discount`,`TblOrdersBOM_Items`.`Shipped` AS `shipped`,
	`TblOrdersBOM_Items`.`Special_Instructions` AS `Special_Instructions`,
	round((`TblOrdersBOM_Items`.`UnitPrice` * (1 - `TblOrdersBOM_Items`.`Discount`)),2) AS `discountedUnitPrice`,
	(round((`TblOrdersBOM_Items`.`UnitPrice` * (1 - `TblOrdersBOM_Items`.`Discount`)),2) * `TblOrdersBOM_Items`.`Quantity`) AS `itemPrice`,
	`tbl_wood_type`.`d_name` AS `woodTypeName`,`FinishOption`.`title` AS `finishOptionTitle`,`Products`.`Unit_of_Measure` AS `Unit_of_Measure`,
	`Products`.`ProductType_id` AS `ProductType_Id`
from (((`TblOrdersBOM_Items`
	left join `Products` on((`Products`.`ProductID` = `TblOrdersBOM_Items`.`ProductID`)))
	left join `tbl_wood_type` on((`tbl_wood_type`.`id` = `Products`.`WoodTypeID`)))
	left join `FinishOption` on((`FinishOption`.`id` = `TblOrdersBOM_Items`.`FinishOptionID`)))
order by `TblOrdersBOM_Items`.`OrderItemsID`

