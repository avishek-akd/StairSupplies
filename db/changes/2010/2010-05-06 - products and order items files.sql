DELETE
FROM TblSpecialOrders_files
WHERE specialorder_id not in (select orderItemsID from TblOrdersBOM_Items);


--  Create a copy of the current files table
CREATE TABLE `z_unused_TblSpecialOrders_files`
	( PRIMARY KEY (`files_id`))
	COLLATE utf8_general_ci ENGINE=InnoDB COMMENT=''
	SELECT * FROM `TblSpecialOrders_files`;
ALTER TABLE `z_unused_TblSpecialOrders_files`
	CHANGE `files_id` `files_id` int(10)  auto_increment;


RENAME TABLE `TblSpecialOrders_files` TO `Products_OrderItems_Files`;

ALTER TABLE `Products_OrderItems_Files`
	CHANGE COLUMN `files_id` `id` INT(10) NOT NULL AUTO_INCREMENT FIRST,
	ADD COLUMN `productID` INT(10) NULL DEFAULT NULL AFTER `id`,
	CHANGE COLUMN `specialorder_id` `orderItemsID` INT(10) NULL DEFAULT NULL AFTER `productID`,
	ADD COLUMN `record_created` DATETIME NULL AFTER `date`;

UPDATE Products_OrderItems_Files SET record_created = str_to_date(trim(date), "%m/%d/%Y");

ALTER TABLE `Products_OrderItems_Files`
	DROP COLUMN `date`,
	ADD INDEX `Index 2` (`productID`),
	ADD INDEX `Index 3` (`orderItemsID`),
	ADD CONSTRAINT `FK_Products_OrderItems_Files_Products` FOREIGN KEY (`productID`)
			REFERENCES `Products` (`ProductID`) ON UPDATE NO ACTION ON DELETE NO ACTION,
	ADD CONSTRAINT `FK_Products_OrderItems_Files_TblOrdersBOM_Items` FOREIGN KEY (`orderItemsID`)
			REFERENCES `TblOrdersBOM_Items` (`OrderItemsID`) ON UPDATE NO ACTION ON DELETE NO ACTION;