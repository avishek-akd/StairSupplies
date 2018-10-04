CREATE TABLE `tbl_lumber_type` (
	`id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
	`d_name` VARCHAR(100) NOT NULL COLLATE 'utf8_unicode_ci',
	`d_sort_field` TINYINT NOT NULL,
	PRIMARY KEY (`id`)
)
COMMENT='4/4 Under 15\'\r\n4/4 Over 15\'\r\n5/4\r\n6/4\r\n8/4\r\n10/4'
COLLATE='utf8_unicode_ci'
ENGINE=InnoDB;
INSERT INTO `tbl_lumber_type` (`d_name`, `d_sort_field`) VALUES ('4/4 Under 15\'', 1);
INSERT INTO `tbl_lumber_type` (`d_name`, `d_sort_field`) VALUES ('4/4 Over 15\'', 2);
INSERT INTO `tbl_lumber_type` (`d_name`, `d_sort_field`) VALUES ('5/4', 3);
INSERT INTO `tbl_lumber_type` (`d_name`, `d_sort_field`) VALUES ('6/4', 4);
INSERT INTO `tbl_lumber_type` (`d_name`, `d_sort_field`) VALUES ('8/4', 5);
INSERT INTO `tbl_lumber_type` (`d_name`, `d_sort_field`) VALUES ('10/4', 6);



CREATE TABLE `tbl_lumber_species_type` (
	`id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
	`d_lumber_species_id` INT(10) NOT NULL,
	`d_lumber_type_id` INT(10) UNSIGNED NOT NULL,
	`d_lumber_rate` DECIMAL(10,2) NOT NULL COMMENT 'cost per board feet of lumber (in $). This needs to be multiplied by BoardFootage in order to get the value for 1 item',
	`d_date_created` DATETIME NOT NULL,
	`d_date_updated` DATETIME NULL DEFAULT NULL,
	PRIMARY KEY (`id`),
	INDEX `d_lumber_species_id` (`d_lumber_type_id`, `d_lumber_species_id`),
	INDEX `FK__tbl_lumber_species` (`d_lumber_species_id`),
	CONSTRAINT `FK__tbl_lumber_species` FOREIGN KEY (`d_lumber_species_id`) REFERENCES `tbl_lumber_species` (`id`) ON DELETE CASCADE,
	CONSTRAINT `FK__tbl_lumber_type` FOREIGN KEY (`d_lumber_type_id`) REFERENCES `tbl_lumber_type` (`id`) ON DELETE CASCADE
)
COMMENT='A species has all the lumber types with prices.'
COLLATE='utf8_unicode_ci'
ENGINE=InnoDB;



ALTER TABLE `tbl_lumber_species`
	DROP COLUMN `d_lumber_rate`;
	
	
ALTER TABLE `Products`
	ADD COLUMN `LumberTypeID` INT(10) UNSIGNED NULL DEFAULT NULL AFTER `SpeciesID`,
	ADD INDEX `LumberTypeID` (`LumberTypeID`),
	ADD CONSTRAINT `FK_Products_tbl_lumber_type` FOREIGN KEY (`LumberTypeID`) REFERENCES `tbl_lumber_type` (`id`);
ALTER TABLE `Products`
	CHANGE COLUMN `LumberTypeID` `LumberTypeID` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT 'If the species is set this also must be set so we know the lumber rate' AFTER `SpeciesID`;