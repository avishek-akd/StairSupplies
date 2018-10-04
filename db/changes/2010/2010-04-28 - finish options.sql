CREATE TABLE `FinishOption` (
	`id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
	`title` VARCHAR(100) NOT NULL,
	`description` VARCHAR(300) NULL,
	`archive` TINYINT(1) UNSIGNED NOT NULL DEFAULT '0',
	`record_created` DATETIME NOT NULL,
	`record_updated` DATETIME NULL,
	PRIMARY KEY (`id`)
)
COLLATE='utf8_general_ci'
ENGINE=InnoDB
ROW_FORMAT=DEFAULT;

ALTER TABLE `TblOrdersBOM_Items`
	ADD COLUMN `FinishOptionID` INT UNSIGNED NULL AFTER `RecordCreated`,
	ADD CONSTRAINT `FK_TblOrdersBOM_Items_FinishOption` FOREIGN KEY (`FinishOptionID`) REFERENCES `FinishOption` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION;
