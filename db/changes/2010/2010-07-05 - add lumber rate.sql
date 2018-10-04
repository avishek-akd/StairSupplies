ALTER TABLE `tbl_lumber_species`
	ADD COLUMN `d_lumber_rate` DECIMAL(10,2) NOT NULL COMMENT 'cost per board feet of lumber (in $). This needs to be multiplied by BoardFootage in order to get the value for 1 item' AFTER `d_name`;
