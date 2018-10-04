ALTER TABLE `TblOrdersBOM_Version`
	ALTER `Description` DROP DEFAULT
;
ALTER TABLE `TblOrdersBOM_Version`
	CHANGE COLUMN `Description` `VersionName` VARCHAR(50) NOT NULL
;