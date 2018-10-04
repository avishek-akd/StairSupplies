--  Add the columns to the orders table
ALTER TABLE TblOrdersBOM
	ADD COLUMN `estimate_date` DATETIME NULL DEFAULT NULL,
	ADD COLUMN `estimate_userId` INT(10) NULL DEFAULT NULL,
	ADD COLUMN `estimate_UserLastName` VARCHAR(50) NULL DEFAULT NULL,
	ADD COLUMN `ordered_date` DATETIME NULL DEFAULT NULL,
	ADD COLUMN `ordered_userid` INT(10) NULL DEFAULT NULL,
	ADD COLUMN `ordered_UserLastName` VARCHAR(50) NULL DEFAULT NULL,
	ADD COLUMN `released_date` DATETIME NULL DEFAULT NULL,
	ADD COLUMN `released_userid` INT(10) NULL DEFAULT NULL,
	ADD COLUMN `released_userlastname` VARCHAR(50) NULL DEFAULT NULL,
	ADD COLUMN `cancelled_date` DATETIME NULL DEFAULT NULL,
	ADD COLUMN `cancelled_userid` INT(10) NULL DEFAULT NULL,
	ADD COLUMN `cancelled_userLastName` VARCHAR(50) NULL DEFAULT NULL,
	ADD COLUMN `paid_date` DATETIME NULL DEFAULT NULL,
	ADD COLUMN `paid_userid` INT(10) NULL DEFAULT NULL,
	ADD COLUMN `paid_userLastName` VARCHAR(50) NULL DEFAULT NULL,
	ADD COLUMN `due_date` DATETIME NULL DEFAULT NULL,
	ADD COLUMN `due_userid` INT(10) NULL DEFAULT NULL,
	ADD COLUMN `due_userlastname` VARCHAR(50) NULL DEFAULT NULL,
	ADD COLUMN `credit_date` DATETIME NULL DEFAULT NULL,
	ADD COLUMN `credit_UserId` INT(10) NULL DEFAULT NULL,
	ADD COLUMN `credit_UserLastName` VARCHAR(50) NULL DEFAULT NULL,
	ADD COLUMN `invoiced_date` DATETIME NULL DEFAULT NULL,
	ADD COLUMN `invoiced_UserId` INT(10) NULL DEFAULT NULL,
	ADD COLUMN `invoiced_UserLastName` VARCHAR(50) NULL DEFAULT NULL;

	
--  Transfer the information
UPDATE TblOrdersBOM a
	INNER JOIN TblOrdersBOM_status b ON a.OrderID = b.orderid
SET a.estimate_date = b.estimate_date,
	a.estimate_userId = b.estimate_userId,
	a.estimate_UserLastName = b.estimate_UserLastName,
	a.ordered_date = b.ordered_date,
	a.ordered_userid = b.ordered_userid,
	a.ordered_UserLastName = b.ordered_UserLastName,
	a.released_date = b.released_date,
	a.released_userid = b.released_userid,
	a.released_userlastname = b.released_userlastname,
	a.cancelled_date = b.cancelled_date,
	a.cancelled_userid = b.cancelled_userid,
	a.cancelled_userLastName = b.cancelled_userLastName,
	a.paid_date = b.paid_date,
	a.paid_userid = b.paid_userid,
	a.paid_userLastName = b.paid_userLastName,
	a.due_date = b.due_date,
	a.due_userid = b.due_userid,
	a.due_userlastname = b.due_userlastname,
	a.credit_date = b.credit_date,
	a.credit_UserId = b.credit_UserId,
	a.credit_UserLastName = b.credit_UserLastName,
	a.invoiced_date = b.invoiced_date,
	a.invoiced_UserId = b.invoiced_UserId,
	a.invoiced_UserLastName = b.invoiced_UserLastName;

--  Don't delete unused table right away, wait for a while to see if they're really not used
RENAME TABLE `TblOrdersBOM_status` TO `z_unused_TblOrdersBOM_status`;
RENAME TABLE `TblOrdersBOMmemos` TO `z_unused_TblOrdersBOMmemos`;


ALTER TABLE `TblOrdersBOM`
	CHANGE COLUMN `Updated` `z_unused_Updated` TINYINT(4) NULL DEFAULT '0' AFTER `InvoicedDate`,
	CHANGE COLUMN `UpdatedDate` `z_unused_UpdatedDate` DATETIME NULL DEFAULT NULL AFTER `z_unused_Updated`,
	CHANGE COLUMN `UpdatedBy` `z_unused_UpdatedBy` VARCHAR(50) NULL DEFAULT NULL AFTER `z_unused_UpdatedDate`;

ALTER TABLE `TblOrdersBOM`
	ADD COLUMN `Remake_date` DATETIME NULL DEFAULT NULL AFTER `RemakeNotes`,
	ADD COLUMN `Remake_userId` INT NULL DEFAULT NULL AFTER `Remake_date`,
	ADD COLUMN `Remake_UserLastName` VARCHAR(50) NULL DEFAULT NULL AFTER `Remake_userId`;

ALTER TABLE `TblOrdersBOM`
	CHANGE COLUMN `ShipName` `ShipName` VARCHAR(50) NULL DEFAULT NULL AFTER `CustomerService_id`,
	CHANGE COLUMN `ShipAddress` `z_unused_ShipAddress` VARCHAR(255) NULL DEFAULT NULL AFTER `ShipContactLastName`, 
	CHANGE COLUMN `ShipPhoneNumber` `ShipPhoneNumber` VARCHAR(50) NULL DEFAULT NULL AFTER `ShipPostalCode`;

ALTER TABLE `TblOrdersBOM`
	CHANGE COLUMN `OrderSubTotal` `z_unused_OrderSubTotal` DECIMAL(19,4) NULL DEFAULT '0.0000' AFTER `OrderTotal`,
	CHANGE COLUMN `PONumber` `z_unused_PONumber` VARCHAR(50) NULL DEFAULT NULL AFTER `DateUpdated`;
	
ALTER TABLE `TblOrdersBOM`
	CHANGE COLUMN `PaidUser` `z_unused_PaidUser` VARCHAR(50) NULL DEFAULT NULL AFTER `PaidDate`,
	CHANGE COLUMN `EstimateUser` `z_unused_EstimateUser` VARCHAR(50) NULL DEFAULT NULL AFTER `EstimateDate`,
	CHANGE COLUMN `OrderedUser` `z_unused_OrderedUser` VARCHAR(50) NULL DEFAULT NULL AFTER `OrderedDate`,
	CHANGE COLUMN `ShippedUser` `z_unused_ShippedUser` VARCHAR(50) NULL DEFAULT NULL AFTER `ShippedDate`,
	CHANGE COLUMN `ReleasedUser` `z_unused_ReleasedUser` VARCHAR(50) NULL DEFAULT NULL AFTER `ReleasedDate`,
	CHANGE COLUMN `ReadytoShipUser` `z_unused_ReadytoShipUser` VARCHAR(50) NULL DEFAULT NULL AFTER `ReadytoShipDate`;

ALTER TABLE `TblOrdersBOM`
	CHANGE COLUMN `EmailAck` `z_unused_EmailAck` TINYINT(4) NULL DEFAULT '0' AFTER `CustomerAcknowledgementIP`,
	CHANGE COLUMN `EmailAckDate` `z_unused_EmailAckDate` DATETIME NULL DEFAULT NULL AFTER `z_unused_EmailAck`,
	CHANGE COLUMN `EmailAckUser` `z_unused_EmailAckUser` VARCHAR(50) NULL DEFAULT NULL AFTER `z_unused_EmailAckDate`,
	CHANGE COLUMN `EmailShipAck` `z_unused_EmailShipAck` TINYINT(4) NULL DEFAULT '0' AFTER `z_unused_EmailAckUser`,
	CHANGE COLUMN `EmailShipAckDate` `z_unused_EmailShipAckDate` DATETIME NULL DEFAULT NULL AFTER `z_unused_EmailShipAck`,
	CHANGE COLUMN `EmailShipAckUser` `z_unused_EmailShipAckUser` VARCHAR(50) NULL DEFAULT NULL AFTER `z_unused_EmailShipAckDate`;

ALTER TABLE `TblOrdersBOM`
	CHANGE COLUMN `FinishShop` `z_unused_FinishShop` TINYINT(4) NULL DEFAULT '0' AFTER `z_unused_EmailShipAckUser`,
	CHANGE COLUMN `FinishShopDate` `z_unused_FinishShopDate` DATETIME NULL DEFAULT NULL AFTER `z_unused_FinishShop`,
	CHANGE COLUMN `BackOrderID` `z_unused_BackOrderID` INT(10) NULL DEFAULT '0' AFTER `CancelledDate`,
	CHANGE COLUMN `Backorder` `z_unused_Backorder` TINYINT(4) NULL DEFAULT '0' AFTER `Email`;
	
ALTER TABLE `TblOrdersBOM`
	CHANGE COLUMN `Production` `z_unused_Production` TINYINT(4) NULL DEFAULT '0' AFTER `z_unused_Backorder`;

ALTER TABLE `TblOrdersBOM` DROP FOREIGN KEY `TblOrdersBOM_fk5`;
ALTER TABLE `TblOrdersBOM`
	CHANGE COLUMN `CustomerAcknowledgementSignature` `CustomerAcknowledgementSignature` VARCHAR(100) NULL DEFAULT NULL AFTER `CustomerAcknowledgementIP`,
	CHANGE COLUMN `ReadytoShip` `ReadytoShip` TINYINT(4) NULL DEFAULT '0' AFTER `WoodType`,
	CHANGE COLUMN `ReadytoShipDate` `z_old_ReadytoShipDate` DATETIME NULL DEFAULT NULL AFTER `ReadytoShip`,
	CHANGE COLUMN `EmployeeIDReportedReadyToShip` `ReadytoShip_userId` INT(10) NULL DEFAULT NULL AFTER `z_old_ReadytoShipDate`,
	CHANGE COLUMN `DateReportedReadyToShip` `ReadytoShip_date` DATETIME NULL DEFAULT NULL AFTER `ReadytoShip_userId`,
	ADD CONSTRAINT `TblOrdersBOM_fk5` FOREIGN KEY (`ReadytoShip_userId`) REFERENCES `Employees` (`EmployeeID`) ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE `TblOrdersBOM`
	CHANGE COLUMN `EstimateDate` `z_unused_EstimateDate` DATETIME NULL DEFAULT NULL AFTER `Estimate`,
	CHANGE COLUMN `orderedDate` `z_unused_orderedDate` DATETIME NULL DEFAULT NULL AFTER `Ordered`,
	CHANGE COLUMN `releasedDate` `z_unused_releasedDate` DATETIME NULL DEFAULT NULL AFTER `Released`,
	CHANGE COLUMN `invoicedDate` `z_unused_invoicedDate` DATETIME NULL DEFAULT NULL AFTER `Invoiced`,
	CHANGE COLUMN `cancelledDate` `z_unused_cancelledDate` DATETIME NULL DEFAULT NULL AFTER `Cancelled`,
	CHANGE COLUMN `CreditCardChargeddate` `z_unused_CreditCardChargeddate` DATETIME NULL DEFAULT NULL AFTER `CreditCardCharged`,
	CHANGE COLUMN `PaidDate` `z_unused_PaidDate` DATETIME NULL DEFAULT NULL AFTER `Paid`;

ALTER TABLE `TblOrdersBOM`
	CHANGE COLUMN `InvoicedBy` `z_unused_InvoicedBy` VARCHAR(50) NULL DEFAULT NULL AFTER `CompanyID`,
	CHANGE COLUMN `ProductName` `z_unused_ProductName` VARCHAR(50) NULL DEFAULT NULL AFTER `ProductionDate`,
	CHANGE COLUMN `OrderDate` `z_unused_OrderDate` DATETIME NULL DEFAULT NULL AFTER `ShippingMethodID`,
	CHANGE COLUMN `ActFreightCharge` `z_unused_ActFreightCharge` DECIMAL(19,4) NULL DEFAULT '0.0000' AFTER `FreightCharge`,
	CHANGE COLUMN `Status` `z_unused_Status` VARCHAR(50) NULL DEFAULT NULL AFTER `SalesTaxRate`,
	CHANGE COLUMN `Notes` `z_unused_Notes` LONGTEXT NULL AFTER `z_unused_Status`,
	CHANGE COLUMN `Archived` `z_unused_Archived` TINYINT(4) NULL DEFAULT '0' AFTER `z_unused_OrderedUser`,
	CHANGE COLUMN `ArchivedDate` `z_unused_ArchivedDate` DATETIME NULL DEFAULT NULL AFTER `z_unused_Archived`;

ALTER TABLE `TblOrdersBOM`
	CHANGE COLUMN `ShippedPartial` `ShippedPartial` TINYINT(4) NULL DEFAULT '0' AFTER `ShippedDate`,
	CHANGE COLUMN `ShippedPartialDate` `z_unused_ShippedPartialDate` DATETIME NULL DEFAULT NULL AFTER `ShippedPartial`,
	CHANGE COLUMN `ShippedBy_Id` `z_unused_ShippedBy_Id` INT(10) NULL DEFAULT '0' AFTER `z_unused_BackOrderID`,
	CHANGE COLUMN `PickedBy_Id` `z_unused_PickedBy_Id` INT(10) NULL DEFAULT '0' AFTER `z_unused_ShippedBy_Id`,
	CHANGE COLUMN `PackedBy_Id` `z_unused_PackedBy_Id` INT(10) NULL DEFAULT '0' AFTER `z_unused_PickedBy_Id`,
	CHANGE COLUMN `SalesMan_Id` `SalesMan_Id` INT(10) NULL DEFAULT NULL AFTER `EmployeeID`,
	CHANGE COLUMN `CustomerService_id` `CustomerService_id` INT(10) NULL DEFAULT NULL AFTER `SalesMan_Id`;
