--  Return conditions changed but we need to preserve conditions for previous RGA's so we add a new row with the new conditions and disable the old one
ALTER TABLE `TblRGAReturnReason`
	ADD COLUMN `d_is_active` TINYINT(1) NOT NULL DEFAULT '1' AFTER `d_name`;

INSERT INTO `TblRGAReturnReason` (`d_name`, `d_sort_field`) VALUES ('Return for Credit -15% Restocking Fee', '1');
UPDATE `TblRGAReturnReason` SET `d_is_active`='0' WHERE  `id`=1;
