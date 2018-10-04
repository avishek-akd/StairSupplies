ALTER TABLE `TblOrdersBOM_Exceptions`
	ADD COLUMN `idnew` INT(10) NOT NULL AUTO_INCREMENT AFTER `id`,
	ADD INDEX `idnew` (`idnew`);

	
	
ALTER TABLE `TblOrdersBOM_Items`
	DROP FOREIGN KEY `FK_TblOrdersBOM_Items_TblOrdersBOM_Exceptions`;
ALTER TABLE `TblOrdersBOM_Items`
	ADD CONSTRAINT `FK_TblOrdersBOM_Items_TblOrdersBOM_Exceptions` FOREIGN KEY (`ExceptionId`) REFERENCES `TblOrdersBOM_Exceptions` (`idnew`);

	
	
ALTER TABLE `TblOrdersBOM_Exceptions`
	DROP INDEX `idnew`,
	DROP PRIMARY KEY,
	ADD PRIMARY KEY (`idnew`);
ALTER TABLE `TblOrdersBOM_Exceptions`
	DROP COLUMN `id`;
ALTER TABLE `TblOrdersBOM_Exceptions`
	CHANGE COLUMN `idnew` `id` INT(10) NOT NULL AUTO_INCREMENT FIRST;

	
	
	
	
CREATE TABLE `TblOrdersBOM_Remakes` (
	`id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`d_name` VARCHAR(100) NOT NULL,
	`d_record_created` DATETIME NOT NULL,
	`d_record_updated` DATETIME NULL,
	PRIMARY KEY (`id`)
)
COMMENT='Reason for remake on an order'
COLLATE='utf8_unicode_ci'
ENGINE=InnoDB
;
CREATE TABLE `TblOrdersBOM_Faults` (
	`id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`d_name` VARCHAR(100) NOT NULL,
	`d_record_created` DATETIME NOT NULL,
	`d_record_updated` DATETIME NULL,
	PRIMARY KEY (`id`)
)
COMMENT='Fault reasons fow why something went wrong on an order'
COLLATE='utf8_unicode_ci'
ENGINE=InnoDB
;
