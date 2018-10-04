ALTER TABLE `tbl_wood_type`
	ADD COLUMN `d_cable_rail_css_style` VARCHAR(100) NULL COMMENT 'Css style used for this wood type in the cable rail reports' AFTER `d_finish_image_standard`;
UPDATE `tbl_wood_type` SET `d_cable_rail_css_style`='background-color:PaleGreen;' WHERE  `id`=72;
UPDATE `tbl_wood_type` SET `d_cable_rail_css_style`='background-color:LightPink;' WHERE  `id`=73;
UPDATE `tbl_wood_type` SET `d_cable_rail_css_style`='background-color:Plum;' WHERE  `id`=71; -- some Purple
UPDATE `tbl_wood_type` SET `d_cable_rail_css_style`='background-color:#FFFF50;' WHERE  `id`=70;-- some Yellow


ALTER TABLE `FinishOption`
	ADD COLUMN `CableRailCssStyle` VARCHAR(100) NULL DEFAULT NULL COMMENT 'CSS style used in the cable rail reports' AFTER `ProductionTimeInDays`;
UPDATE `FinishOption` SET `CableRailCssStyle`='background-color:DarkOrange;';
UPDATE `FinishOption` SET `CableRailCssStyle`='background-color:silver;' WHERE  `id`=434;
UPDATE `FinishOption` SET `CableRailCssStyle`='background-color:DarkBlue; color:white;' WHERE  `id`=231;
UPDATE `FinishOption` SET `CableRailCssStyle`='background-color:LightBlue;' WHERE  `id`=333;



CREATE TABLE `TblCableRailProductionDay` (
	`id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`Day` DATE NOT NULL,
	`MaximumComplexityPoints` INT UNSIGNED NOT NULL,
	`AddedByEmployeeID` INT NULL,
	`RecordCreated` DATETIME NOT NULL,
	`RecordUpdated` DATETIME NULL,
	PRIMARY KEY (`id`),
	UNIQUE INDEX `Day` (`Day`),
	CONSTRAINT `FK__Employees` FOREIGN KEY (`AddedByEmployeeID`) REFERENCES `Employees` (`EmployeeID`)
)
COLLATE='utf8_unicode_ci'
ENGINE=InnoDB
;


ALTER TABLE `TblOrdersBOM_Items`
	ADD COLUMN `CableRailProgress` VARCHAR(50) NULL DEFAULT NULL AFTER `costBoardFootage`;
	

ALTER TABLE `TblOrdersBOM`
	ADD COLUMN `CableRailProductionDayID` INT UNSIGNED NULL AFTER `hiddenInProductionReport`,
	ADD CONSTRAINT `FK_TblOrdersBOM_TblCableRailProductionDay` FOREIGN KEY (`CableRailProductionDayID`) REFERENCES `TblCableRailProductionDay` (`id`);
