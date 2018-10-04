ALTER TABLE `TblOrdersBOM` ADD COLUMN `HubspotDealID` INT(10) NULL DEFAULT NULL AFTER `_unused_OrderWeight`
;

ALTER TABLE `TblCustomer` ADD COLUMN `HubspotContactID` INT(10) NULL DEFAULT NULL AFTER `defaultDiscountPercent`
;

CREATE TABLE `TblSync` (
  `SyncID` int(11) NOT NULL AUTO_INCREMENT,
  `ObjectType` varchar(50) NOT NULL,
  `ObjectID` int(11) NOT NULL,
  `Destination` varchar(50) NOT NULL,
  `Failures` int(11) DEFAULT '0',
  `DateSubmitted` datetime DEFAULT NULL,
  `DateFinished` datetime DEFAULT NULL,
  `DateNextAttempt` datetime DEFAULT NULL,
  PRIMARY KEY (`SyncID`)
) ENGINE=InnoDB
;