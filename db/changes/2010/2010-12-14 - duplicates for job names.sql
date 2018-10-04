ALTER TABLE `TblOrdersBOM`
	ADD COLUMN `Canonical_Job_Name` VARCHAR(200) NULL DEFAULT NULL COMMENT 'Processed job name that allows us to find the ring entry quicker' AFTER `Job_Name`;
