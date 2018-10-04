CREATE TABLE `TblPurchaseDepartment` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`Name` VARCHAR(100) NOT NULL,
	`Active` TINYINT(1) NOT NULL DEFAULT '1',
	`RecordCreated` DATETIME NOT NULL,
	`RecordUpdated` DATETIME NULL DEFAULT NULL,
	PRIMARY KEY (`id`)
)
COLLATE='utf8mb4_unicode_ci'
ENGINE=InnoDB
;


ALTER TABLE `Products`
	ADD COLUMN `PurchasingDepartmentID` INT NULL DEFAULT NULL AFTER `InventoryNote`,
	ADD CONSTRAINT `FK_Products_TblPurchaseDepartment` FOREIGN KEY (`PurchasingDepartmentID`) REFERENCES `TblPurchaseDepartment` (`id`);
