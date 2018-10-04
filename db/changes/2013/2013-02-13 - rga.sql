UPDATE `tblRGAStage` SET `d_send_email_customer`=1 WHERE  `id`=2 LIMIT 1;
UPDATE `tblRGAStage` SET `d_has_internal_notes`=1 WHERE  `id`=4 LIMIT 1;
ALTER TABLE `tblRGAStage`
	ADD COLUMN `d_internal_notes_required` TINYINT(4) NULL DEFAULT NULL AFTER `d_has_internal_notes`;

	
UPDATE `tblRGAStage` SET `d_internal_notes_required`=0 WHERE  `id`=1 LIMIT 1;
UPDATE `tblRGAStage` SET `d_internal_notes_required`=0 WHERE  `id`=2 LIMIT 1;
UPDATE `tblRGAStage` SET `d_internal_notes_required`=0 WHERE  `id`=3 LIMIT 1;
UPDATE `tblRGAStage` SET `d_internal_notes_required`=1 WHERE  `id`=4 LIMIT 1;
UPDATE `tblRGAStage` SET `d_internal_notes_required`=0 WHERE  `id`=5 LIMIT 1;


ALTER TABLE `tblRGAStage`
	ADD COLUMN `d_has_image_upload` TINYINT(4) NULL DEFAULT NULL AFTER `d_internal_notes_required`;
UPDATE `tblRGAStage` SET `d_has_image_upload`=0 WHERE  `id`=1 LIMIT 1;
UPDATE `tblRGAStage` SET `d_has_image_upload`=0 WHERE  `id`=2 LIMIT 1;
UPDATE `tblRGAStage` SET `d_has_image_upload`=0 WHERE  `id`=3 LIMIT 1;
UPDATE `tblRGAStage` SET `d_has_image_upload`=1 WHERE  `id`=4 LIMIT 1;
UPDATE `tblRGAStage` SET `d_has_image_upload`=0 WHERE  `id`=5 LIMIT 1;

ALTER TABLE `tblRGARequest`
	CHANGE COLUMN `d_notes_customer` `_z_unused_d_notes_customer` LONGTEXT NULL AFTER `d_notes_internal`;


ALTER TABLE `TblFile`
	ADD COLUMN `rgaRequestStatusID` INT(10) NULL DEFAULT NULL AFTER `customerContactID`,
	ADD INDEX `Index 8` (`rgaRequestStatusID`),
	ADD CONSTRAINT `FK_TblFile_tblRGAStatus` FOREIGN KEY (`rgaRequestStatusID`) REFERENCES `tblRGAStatus` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION;

	

INSERT INTO `tblRGAReturnReason` (`d_name`) VALUES ('Cable Rail Tool Kit Return');
UPDATE `tblRGAReturnReason` SET `d_name`='Return for Credit -30% Restocking Charge' WHERE  `id`=1 LIMIT 1;
ALTER TABLE `tblRGAReturnReason`
	ADD COLUMN `d_sort_field` TINYINT(4) NOT NULL AFTER `d_name`;
UPDATE `tblRGAReturnReason` SET `d_sort_field`=1 WHERE  `id`=1 LIMIT 1;
UPDATE `tblRGAReturnReason` SET `d_sort_field`=2 WHERE  `id`=5 LIMIT 1;
UPDATE `tblRGAReturnReason` SET `d_sort_field`=3 WHERE  `id`=2 LIMIT 1;
UPDATE `tblRGAReturnReason` SET `d_sort_field`=4 WHERE  `id`=3 LIMIT 1;
UPDATE `tblRGAReturnReason` SET `d_sort_field`=5 WHERE  `id`=4 LIMIT 1;