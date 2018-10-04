ALTER TABLE `TblOrdersBOM`
	ADD COLUMN `requireDiscountPhotoAgreement` TINYINT NOT NULL DEFAULT '0' AFTER `Cable_Rail_Production_Date`,
	ADD COLUMN `requireCodeExceptionDisclaimer` TINYINT NOT NULL DEFAULT '0' AFTER `requireDiscountPhotoAgreement`;
