ALTER TABLE `Company`
	ADD COLUMN `salesUrlPrefix` VARCHAR(100) NULL DEFAULT NULL AFTER `webAddress`;

	
UPDATE `Company` SET `salesUrlPrefix`='http://sales.stairsupplies.net/sales' WHERE  `CompanyID`=1;
UPDATE `Company` SET `salesUrlPrefix`='http://sales.stairsupplies.net/sales' WHERE  `CompanyID`=2;
UPDATE `Company` SET `salesUrlPrefix`='http://sales.stairsupplies.net/sales' WHERE  `CompanyID`=3;
UPDATE `Company` SET `salesUrlPrefix`='http://sales.viewrailsystems.com/sales' WHERE  `CompanyID`=4;
