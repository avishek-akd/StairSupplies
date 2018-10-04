CREATE TABLE `TblOrdersBOM_RelatedOrders` (
	`OrderID` INT(10) NOT NULL,
	`RelatedGroupNumber` INT NOT NULL,
	PRIMARY KEY (`OrderID`),
	INDEX `idxRelatedGroupNumber` (`RelatedGroupNumber`),
	CONSTRAINT `FK_TblOrdersBOM_RelatedOrders_TblOrdersBOM` FOREIGN KEY (`OrderID`) REFERENCES `TblOrdersBOM` (`OrderID`) ON UPDATE NO ACTION ON DELETE NO ACTION
) Engine=INNODB
;