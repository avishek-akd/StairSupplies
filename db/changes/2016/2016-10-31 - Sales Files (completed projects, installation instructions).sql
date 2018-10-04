CREATE TABLE `TblSalesFileGroup` (
	`id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`name` VARCHAR(50) NOT NULL,
	PRIMARY KEY (`id`)
);
INSERT INTO `TblSalesFileGroup` (`name`) VALUES ('Completed Projects');
INSERT INTO `TblSalesFileGroup` (`name`) VALUES ('Installation Instructions');



CREATE TABLE `TblSalesFile` (
	`id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`groupID` INT UNSIGNED NOT NULL,
	`name` VARCHAR(100) NOT NULL,
	`file_name` VARCHAR(200) NOT NULL,
	`thumbnail` VARCHAR(200) NULL DEFAULT NULL,
	`thumbnail_width` INT(11) NULL DEFAULT NULL,
	`thumbnail_height` INT(11) NULL DEFAULT NULL,
	`archived` TINYINT(1) NOT NULL DEFAULT 0,
	`RecordCreated` DATETIME NOT NULL,
	`RecordUpdated` DATETIME NULL DEFAULT NULL,
	PRIMARY KEY (`id`),
	CONSTRAINT `FK_TblSalesFile_TblSalesFileGroup` FOREIGN KEY (`groupID`) REFERENCES `TblSalesFileGroup` (`id`)
);



CREATE TABLE `TblOrdersBOM_SalesFile` (
	`id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`OrderID` INT NOT NULL,
	`SalesFileID` INT UNSIGNED NOT NULL,
	PRIMARY KEY (`id`),
	UNIQUE INDEX `idxTblOrdersBOM_SalesFile_UniqueFilerPerOrder` (`OrderID`, `SalesFileID`),
	CONSTRAINT `FK_TblOrdersBOM_SalesFile_TblOrdersBOM` FOREIGN KEY (`OrderID`) REFERENCES `TblOrdersBOM` (`OrderID`),
	CONSTRAINT `FK_TblOrdersBOM_SalesFile_TblSalesFile` FOREIGN KEY (`SalesFileID`) REFERENCES `TblSalesFile` (`id`)
);
