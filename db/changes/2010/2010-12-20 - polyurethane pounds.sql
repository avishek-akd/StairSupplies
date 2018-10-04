ALTER TABLE `Products`
	ADD COLUMN `PoundsOfPolyurethane` DECIMAL(4,2) DEFAULT NULL COMMENT 'Pounds of polyurethane that is needed for the mold on the Urethane machines.' AFTER `SpeciesID`;

	
CREATE TABLE `tbl_settings1` (
  `id` INTEGER(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `conversion_factor_machine1` DECIMAL(5,2) DEFAULT NULL,
  `conversion_factor_machine2` DECIMAL(5,2) DEFAULT NULL
)ENGINE=InnoDB
CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';


INSERT INTO `tbl_settings1` (`conversion_factor_machine1`, `conversion_factor_machine2`)
VALUES (1, 1);