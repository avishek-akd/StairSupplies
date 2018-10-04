ALTER TABLE `TblOrdersBOM`
	CHANGE COLUMN `HighProbability` `HighProbability` TINYINT(4) NOT NULL DEFAULT '0' AFTER `FinalFollowUp`,
	CHANGE COLUMN `HighProbability_date` `HighProbability_date` DATETIME NULL DEFAULT NULL AFTER `FinalFollowUp_userId`,
	CHANGE COLUMN `HighProbability_userId` `HighProbability_userId` INT(11) NULL DEFAULT NULL AFTER `HighProbability_date`;
