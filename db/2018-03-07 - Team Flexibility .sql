CREATE TABLE `TblAccountingTeams` (
  `AccountingTeamID` int(10) NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) NOT NULL,
  PRIMARY KEY (`AccountingTeamID`),
  UNIQUE INDEX `unqName`(`Name`)
) ENGINE=InnoDB
;

  
ALTER TABLE `TblEmployee`
	ADD COLUMN `AccountingTeamID` INT(10) NULL;
ALTER TABLE `TblEmployee`
	ADD CONSTRAINT `FK_TblEmployee_AccountingTeamID` FOREIGN KEY (`AccountingTeamID`) REFERENCES `TblAccountingTeams` (`AccountingTeamID`) ON UPDATE NO ACTION ON DELETE NO ACTION;