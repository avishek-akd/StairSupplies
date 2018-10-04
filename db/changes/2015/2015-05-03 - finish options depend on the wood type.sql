CREATE TABLE `tbl_wood_type_finishes` (
	`d_wood_type_id` INT(11) NOT NULL,
	`FinishOptionID` INT(10) UNSIGNED NOT NULL,
	PRIMARY KEY (`d_wood_type_id`, `FinishOptionID`),
	INDEX `d_wood_type_id` (`FinishOptionID`),
	INDEX `FinishOptionID` (`d_wood_type_id`),
	CONSTRAINT `FK_tbl_wood_type_finishes_FinishOption` FOREIGN KEY (`FinishOptionID`) REFERENCES `FinishOption` (`id`),
	CONSTRAINT `FK_tbl_wood_type_finishes_tbl_wood_type` FOREIGN KEY (`d_wood_type_id`) REFERENCES `tbl_wood_type` (`id`)
)
COLLATE='utf8_unicode_ci'
ENGINE=InnoDB
;
