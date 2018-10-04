ALTER TABLE `TblCompanyLocation`
	ADD COLUMN `CompanyName` VARCHAR(50) NOT NULL DEFAULT '' AFTER `CompanyID`
;
UPDATE TblCompanyLocation
SET CompanyName = 'Stair Supplies'
;
UPDATE TblCompanyLocation
SET CompanyName = 'Viewrail / Stair Supplies'
WHERE Address = '1755 Ardmore Court'
;
ALTER TABLE `TblCompanyLocation`
	CHANGE COLUMN `CompanyName` `CompanyName` VARCHAR(50) NOT NULL
;
