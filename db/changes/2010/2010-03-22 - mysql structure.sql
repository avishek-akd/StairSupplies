-- ----------------------------------------------------------------------
-- MySQL Migration Toolkit
-- SQL Create Script
-- ----------------------------------------------------------------------

SET FOREIGN_KEY_CHECKS = 0;

DROP DATABASE IF EXISTS `ironbaluster_dbo`;
CREATE DATABASE IF NOT EXISTS `ironbaluster_dbo`
  CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `ironbaluster_dbo`;
-- -------------------------------------
-- Tables

CREATE TABLE `ironbaluster_dbo`.`Tbl_SpecialOrder` (
  `SpecialOrderID` INT(10) NOT NULL,
  PRIMARY KEY (`SpecialOrderID`)
)
ENGINE = INNODB
CHARACTER SET utf8 COLLATE utf8_general_ci;

CREATE TABLE `ironbaluster_dbo`.`Shipping_Methods` (
  `ShippingMethodID` INT(10) NOT NULL AUTO_INCREMENT,
  `ShippingMethod` VARCHAR(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `url` VARCHAR(255) NULL,
  `active` TINYINT NULL DEFAULT 1,
  `is_required` TINYINT NULL,
  `display_in_confirmation` TINYINT NULL,
  `ups_service_type` VARCHAR(3) NULL,
  `tracking_url` VARCHAR(200) NULL,
  PRIMARY KEY (`ShippingMethodID`)
)
ENGINE = INNODB
CHARACTER SET utf8 COLLATE utf8_general_ci;

CREATE TABLE `ironbaluster_dbo`.`Tbl_SpecialOrder_new` (
  `sp_id` INT(10) NOT NULL AUTO_INCREMENT,
  `orderid` INT(10) NULL,
  `specialorderid` INT(10) NOT NULL,
  `dimensions` TINYINT NULL,
  `email_sent` TINYINT NULL,
  `customer_approval` TINYINT NULL,
  `programming_complete` TINYINT NULL,
  `dim_date` DATETIME NULL,
  `dim_firstname` VARCHAR(50) NULL,
  `dim_lastname` VARCHAR(50) NULL,
  `customer_initials` VARCHAR(50) NULL,
  `customer_date` DATETIME NULL,
  `customer_ip` VARCHAR(50) NULL,
  `pcomplete_date` DATETIME NULL,
  `pcomplete_fname` VARCHAR(50) NULL,
  `pcomplete_lname` VARCHAR(50) NULL,
  `dim_username` VARCHAR(50) NULL,
  `email_date` DATETIME NULL,
  `email_username` VARCHAR(50) NULL,
  `customer_username` VARCHAR(50) NULL,
  `pcomplete_username` VARCHAR(50) NULL,
  PRIMARY KEY (`sp_id`)
)
ENGINE = INNODB
CHARACTER SET utf8 COLLATE utf8_general_ci;

CREATE TABLE `ironbaluster_dbo`.`surveymail2` (
  `CustomerID` INT(10) NOT NULL,
  `orderID` INT(10) NOT NULL,
  `sentdate` DATETIME NULL
)
ENGINE = INNODB
CHARACTER SET utf8 COLLATE utf8_general_ci;

CREATE TABLE `ironbaluster_dbo`.`Products` (
  `ProductID` INT(10) NOT NULL AUTO_INCREMENT,
  `CompanyID` INT(10) NOT NULL,
  `Vendor_ID` INT(10) NOT NULL DEFAULT 0,
  `ProductType_id` INT(10) NOT NULL DEFAULT 1,
  `ProductName` VARCHAR(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `Product_Descripton` VARCHAR(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `PUnitPrice_old` DECIMAL(19, 4) NOT NULL DEFAULT 0,
  `Purchase_Price` DECIMAL(19, 4) NOT NULL DEFAULT 0,
  `Inventory_Number` VARCHAR(50) NULL DEFAULT 0,
  `Unit_of_Measure` VARCHAR(10) NOT NULL DEFAULT 'Each',
  `DateEntered` DATETIME NULL ,
  `DateUpdated` DATETIME NULL ,
  `In_House_Notes` LONGTEXT NULL,
  `Customer_Notes` LONGTEXT NULL,
  `Qty_On_Hand` INT(10) NOT NULL DEFAULT 0,
  `Qty_Reorder_Min` INT(10) NOT NULL DEFAULT 0,
  `Qty_On_Order` INT(10) NOT NULL DEFAULT 0,
  `Qty_Available` INT(10) NOT NULL DEFAULT 0,
  `Qty_to_reorder` INT(10) NOT NULL DEFAULT 0,
  `Qty_Allocated` INT(10) NOT NULL DEFAULT 0,
  `Qty_BackOrdered` INT(10) NOT NULL DEFAULT 0,
  `Bin` VARCHAR(50) NULL,
  `Pcs_Per_box` VARCHAR(50) NULL,
  `UnitWeight` DECIMAL(10, 2) NOT NULL DEFAULT 0,
  `PiecesPerCarton` VARCHAR(255) NULL,
  `archived` TINYINT NULL DEFAULT 0,
  `DropShip` TINYINT NULL DEFAULT 0,
  `SpeciesID` INT(10) NULL,
  `BoardFootage` DECIMAL(7, 2) NULL,
  `Production_Instructions` VARCHAR(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `PUnitPrice` DECIMAL(19, 4) NOT NULL DEFAULT 0,
  `EmployeeRate` DECIMAL(10, 4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`ProductID`),
  INDEX `idx_Products_ProductType_id` (`ProductType_id`),
  INDEX `IX_Product_Descripton` (`Product_Descripton`),
  INDEX `IX_ProductName` (`ProductName`),
  INDEX `IX_Vendor_ID` (`Vendor_ID`),
  INDEX `Products_idx` (`CompanyID`),
  INDEX `Products_idx2` (`SpeciesID`),
  INDEX `Products60` (`ProductID`, `Qty_On_Hand`, `Qty_Allocated`),
  CONSTRAINT `FK_Products_TBLVendor` FOREIGN KEY `FK_Products_TBLVendor` (`Vendor_ID`)
    REFERENCES `ironbaluster_dbo`.`TBLVendor` (`Vendor_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Products_fk_company` FOREIGN KEY `Products_fk_company` (`CompanyID`)
    REFERENCES `ironbaluster_dbo`.`Company` (`CompanyID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Products_fk_Species` FOREIGN KEY `Products_fk_Species` (`SpeciesID`)
    REFERENCES `ironbaluster_dbo`.`tbl_lumber_species` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Products_fk_ProductType` FOREIGN KEY `Products_fk_ProductType` (`ProductType_id`)
    REFERENCES `ironbaluster_dbo`.`TblProductType` (`ProductType_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
)
ENGINE = INNODB
CHARACTER SET utf8 COLLATE utf8_general_ci;

CREATE TABLE `ironbaluster_dbo`.`Country` (
  `id` INT(10) NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `Code2` VARCHAR(2) NULL,
  `SortOrder` TINYINT(3) NULL,
  PRIMARY KEY (`id`)
)
ENGINE = INNODB
CHARACTER SET utf8 COLLATE utf8_general_ci;

CREATE TABLE `ironbaluster_dbo`.`tbl_lumber_species` (
  `id` INT(10) NOT NULL AUTO_INCREMENT,
  `d_name` VARCHAR(100) NOT NULL,
  `d_is_active` TINYINT NOT NULL,
  `d_date_created` DATETIME NOT NULL,
  `d_date_updated` DATETIME NULL,
  PRIMARY KEY (`id`)
)
ENGINE = INNODB
CHARACTER SET utf8 COLLATE utf8_general_ci;

CREATE TABLE `ironbaluster_dbo`.`tbl_lumber_availability` (
  `id` INT(10) NOT NULL AUTO_INCREMENT,
  `d_species_id` INT(10) NOT NULL,
  `d_vendor_id` INT(10) NOT NULL,
  `d_notes` VARCHAR(200) NULL,
  `d_updated_by` INT(10) NULL,
  `d_updated_on` DATETIME NULL,
  `d_date_4_4` VARCHAR(200) NULL,
  `d_date_5_4` VARCHAR(200) NULL,
  `d_date_8_4` VARCHAR(200) NULL,
  `d_date_other` VARCHAR(200) NULL,
  PRIMARY KEY (`id`)
)
ENGINE = INNODB
CHARACTER SET utf8 COLLATE utf8_general_ci;

CREATE TABLE `ironbaluster_dbo`.`Tbl_Terms` (
  `Terms` VARCHAR(50) NOT NULL,
  `Active` TINYINT NULL DEFAULT 1,
  PRIMARY KEY (`Terms`)
)
ENGINE = INNODB
CHARACTER SET utf8 COLLATE utf8_general_ci;

CREATE TABLE `ironbaluster_dbo`.`Tbl_UnitOfMeasure` (
  `Unit_of_measure` VARCHAR(10) NOT NULL,
  `dsp_order` VARCHAR(50) NULL DEFAULT 'A',
  PRIMARY KEY (`Unit_of_measure`)
)
ENGINE = INNODB
CHARACTER SET utf8 COLLATE utf8_general_ci;

CREATE TABLE `ironbaluster_dbo`.`Employees_module` (
  `Module_id` INT(10) NOT NULL,
  `Module_name` VARCHAR(100) NULL,
  `Module_directory` VARCHAR(100) NULL,
  PRIMARY KEY (`Module_id`)
)
ENGINE = INNODB
CHARACTER SET utf8 COLLATE utf8_general_ci;

CREATE TABLE `ironbaluster_dbo`.`Employees_role` (
  `role_id` INT(10) NOT NULL AUTO_INCREMENT,
  `role_name` VARCHAR(50) NULL,
  PRIMARY KEY (`role_id`)
)
ENGINE = INNODB
CHARACTER SET utf8 COLLATE utf8_general_ci;

CREATE TABLE `ironbaluster_dbo`.`tblRGAReturnReason` (
  `id` INT(10) NOT NULL AUTO_INCREMENT,
  `d_name` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`id`)
)
ENGINE = INNODB
CHARACTER SET utf8 COLLATE utf8_general_ci;

CREATE TABLE `ironbaluster_dbo`.`TblProductType` (
  `ProductType_id` INT(10) NOT NULL AUTO_INCREMENT,
  `ProductType` VARCHAR(50) NULL,
  `description` VARCHAR(255) NULL,
  `archived` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`ProductType_id`)
)
ENGINE = INNODB
CHARACTER SET utf8 COLLATE utf8_general_ci;

CREATE TABLE `ironbaluster_dbo`.`tblRGAStage` (
  `id` INT(10) NOT NULL AUTO_INCREMENT,
  `d_name` VARCHAR(100) NOT NULL,
  `d_css_class` VARCHAR(100) NULL,
  `d_button_value` VARCHAR(100) NULL,
  `d_send_email_customer` TINYINT NULL,
  `d_send_email_customer_service` TINYINT NULL,
  `d_send_email_accounting` TINYINT NULL,
  `d_assign_rga` TINYINT NULL,
  `d_has_internal_notes` TINYINT NULL DEFAULT 0,
  `d_subject` VARCHAR(200) NULL,
  PRIMARY KEY (`id`)
)
ENGINE = INNODB
CHARACTER SET utf8 COLLATE utf8_general_ci;

CREATE TABLE `ironbaluster_dbo`.`TblState` (
  `State` VARCHAR(2) NOT NULL,
  `StateFull` VARCHAR(50) NOT NULL,
  `CountryId` INT(10) NULL,
  `SalesTax` DECIMAL(10, 4) NULL,
  PRIMARY KEY (`State`),
  INDEX `TblState_idx` (`CountryId`),
  CONSTRAINT `TblState_fk` FOREIGN KEY `TblState_fk` (`CountryId`)
    REFERENCES `ironbaluster_dbo`.`Country` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
)
ENGINE = INNODB
CHARACTER SET utf8 COLLATE utf8_general_ci;

CREATE TABLE `ironbaluster_dbo`.`TBLVendor` (
  `Vendor_ID` INT(10) NOT NULL AUTO_INCREMENT,
  `Vendor` VARCHAR(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `Vendor_Address` VARCHAR(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `Vendor_City` VARCHAR(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `Vendor_State` VARCHAR(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `Vendor_Zip` VARCHAR(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `Vendor_Phone` VARCHAR(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `Vendor_FAX` VARCHAR(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `Attention` VARCHAR(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `DateEntered` DATETIME NOT NULL ,
  `DateUpdated` DATETIME NOT NULL,
  `Email` VARCHAR(100) NULL,
  `Terms` VARCHAR(50) NULL DEFAULT 'Net 30',
  `primaryContact` VARCHAR(50) NULL,
  `primaryEmail` VARCHAR(50) NULL,
  `DropShip` TINYINT NULL DEFAULT 0,
  `Logo` LONGBLOB NULL,
  `active` TINYINT NULL DEFAULT 1,
  `mfg` TINYINT NULL DEFAULT 0,
  PRIMARY KEY (`Vendor_ID`),
  INDEX `IX_Vendor_1` (`Vendor`)
)
ENGINE = INNODB
CHARACTER SET utf8 COLLATE utf8_general_ci;

CREATE TABLE `ironbaluster_dbo`.`survey` (
  `cust_id` INT(10) NULL,
  `ord_id` INT(10) NULL,
  `ship_date` DATETIME NULL,
  `satisfaction` CHAR(25) NULL,
  `sales_perform` VARCHAR(1000) NULL,
  `cust_service` VARCHAR(1000) NULL,
  `prod_quality` VARCHAR(1000) NULL,
  `ord_time` VARCHAR(1000) NULL,
  `web_help` VARCHAR(1000) NULL,
  `home_price` VARCHAR(50) NULL,
  `reorder` CHAR(10) NULL,
  `imp_service` VARCHAR(2000) NULL,
  `imp_prod` VARCHAR(2000) NULL,
  `current_dt` DATETIME NULL,
  `survey_id` INT(10) NULL
)
ENGINE = INNODB
CHARACTER SET utf8 COLLATE utf8_general_ci;

CREATE TABLE `ironbaluster_dbo`.`TblOrdersBOM_status` (
  `statusid` INT(10) NOT NULL AUTO_INCREMENT,
  `orderid` INT(10) NULL,
  `estimate_date` DATETIME NULL,
  `estimate_userId` INT(10) NULL,
  `estimate_UserLastName` VARCHAR(50) NULL,
  `ordered_date` DATETIME NULL,
  `ordered_userid` INT(10) NULL,
  `ordered_UserLastName` VARCHAR(50) NULL,
  `released_date` DATETIME NULL,
  `released_userid` INT(10) NULL,
  `released_userlastname` VARCHAR(50) NULL,
  `production_date` DATETIME NULL,
  `production_userid` INT(10) NULL,
  `production_userLastName` VARCHAR(50) NULL,
  `cancelled_date` DATETIME NULL,
  `cancelled_userid` INT(10) NULL,
  `cancelled_userLastName` VARCHAR(50) NULL,
  `paid_date` DATETIME NULL,
  `paid_userid` INT(10) NULL,
  `paid_userLastName` VARCHAR(50) NULL,
  `due_date` DATETIME NULL,
  `due_userid` INT(10) NULL,
  `due_userlastname` VARCHAR(50) NULL,
  `final_date` DATETIME NULL,
  `final_UserId` INT(10) NULL,
  `final_UserLastName` VARCHAR(50) NULL,
  `credit_date` DATETIME NULL,
  `credit_UserId` INT(10) NULL,
  `credit_UserLastName` VARCHAR(50) NULL,
  `invoiced_date` DATETIME NULL,
  `invoiced_UserId` INT(10) NULL,
  `invoiced_UserLastName` VARCHAR(50) NULL,
  PRIMARY KEY (`statusid`),
  INDEX `TblOrdersBOM_status_idx` (`orderid`),
  CONSTRAINT `TblOrdersBOM_status_fk` FOREIGN KEY `TblOrdersBOM_status_fk` (`orderid`)
    REFERENCES `ironbaluster_dbo`.`TblOrdersBOM` (`OrderID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION
)
ENGINE = INNODB
CHARACTER SET utf8 COLLATE utf8_general_ci;

CREATE TABLE `ironbaluster_dbo`.`tbl_settings` (
  `id` BIGINT(19) NULL,
  `d_company_id` INT(10) NOT NULL,
  `d_order_policy` VARCHAR(7000) NULL,
  `d_email_customer_service` VARCHAR(200) NULL,
  `d_email_accounting` VARCHAR(200) NULL,
  `d_email_support` VARCHAR(200) NULL,
  `d_email_sales` VARCHAR(100) NULL,
  `d_email_subject_ack` VARCHAR(100) NULL,
  `d_email_subject_quotation` VARCHAR(100) NULL,
  `d_email_subject_invoice` VARCHAR(100) NULL,
  `d_email_subject_invoice_shipment` VARCHAR(100) NULL,
  INDEX `tbl_settings_idx` (`d_company_id`),
  CONSTRAINT `tbl_settings_fk` FOREIGN KEY `tbl_settings_fk` (`d_company_id`)
    REFERENCES `ironbaluster_dbo`.`Company` (`CompanyID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
)
ENGINE = INNODB
CHARACTER SET utf8 COLLATE utf8_general_ci;

CREATE TABLE `ironbaluster_dbo`.`tblRGARequest` (
  `id` INT(10) NOT NULL AUTO_INCREMENT,
  `d_order_number` VARCHAR(50) NOT NULL,
  `d_rga_number` INT(10) NULL,
  `d_company_name` VARCHAR(50) NULL,
  `d_firstname` VARCHAR(50) NOT NULL,
  `d_lastname` VARCHAR(50) NOT NULL,
  `d_address1` VARCHAR(50) NOT NULL,
  `d_address2` VARCHAR(50) NULL,
  `d_city` VARCHAR(50) NOT NULL,
  `d_state` VARCHAR(2) NOT NULL,
  `d_zip` VARCHAR(50) NOT NULL,
  `d_country` VARCHAR(50) NULL,
  `d_phone` VARCHAR(20) NOT NULL,
  `d_email` VARCHAR(100) NOT NULL,
  `d_number_of_packages` INT(10) NULL,
  `d_return_reason_id` INT(10) NOT NULL,
  `d_details` LONGTEXT NULL,
  `d_notes_internal` LONGTEXT NULL,
  `d_notes_customer` LONGTEXT NULL,
  `d_is_archived` TINYINT NULL DEFAULT 0,
  `d_date_created` DATETIME NULL,
  `d_date_updated` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `tblRGARequest_idx` (`d_return_reason_id`),
  CONSTRAINT `FK_tblRGARequest_tblRGAReturnReason` FOREIGN KEY `FK_tblRGARequest_tblRGAReturnReason` (`d_return_reason_id`)
    REFERENCES `ironbaluster_dbo`.`tblRGAReturnReason` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
)
ENGINE = INNODB
CHARACTER SET utf8 COLLATE utf8_general_ci;

CREATE TABLE `ironbaluster_dbo`.`surveymail` (
  `CustomerID` INT(10) NULL,
  `orderID` INT(10) NULL,
  `sentdate` DATETIME NULL
)
ENGINE = INNODB
CHARACTER SET utf8 COLLATE utf8_general_ci;

CREATE TABLE `ironbaluster_dbo`.`TblOrdersBOM_Exceptions` (
  `id` INT(10) NOT NULL,
  `exceptionname` VARCHAR(500) NULL,
  PRIMARY KEY (`id`)
)
ENGINE = INNODB
CHARACTER SET utf8 COLLATE utf8_general_ci;

CREATE TABLE `ironbaluster_dbo`.`TblOrdersBOM` (
  `OrderID` INT(10) NOT NULL AUTO_INCREMENT,
  `CustomerID` INT(10) NOT NULL,
  `EmployeeID` INT(10) NULL,
  `ShippingMethodID` INT(10) NULL DEFAULT 3,
  `OrderDate` DATETIME NULL,
  `Job_Name` VARCHAR(200) NULL,
  `ShipName` VARCHAR(50) NULL,
  `ShipAddress` VARCHAR(255) NULL,
  `ShipPhoneNumber` VARCHAR(50) NULL,
  `OrderTotal` DECIMAL(19, 4) NULL DEFAULT 0,
  `OrderSubTotal` DECIMAL(19, 4) NULL DEFAULT 0,
  `FreightCharge` DECIMAL(19, 4) NULL DEFAULT 0,
  `ActFreightCharge` DECIMAL(19, 4) NULL DEFAULT 0,
  `SalesTaxRate` DECIMAL(10, 4) NULL DEFAULT 0,
  `Status` VARCHAR(50) NULL,
  `Notes` LONGTEXT NULL,
  `In_House_Notes` LONGTEXT NULL,
  `Duedate` DATETIME NULL,
  `DateCreated` DATETIME NULL ,
  `DateUpdated` DATETIME NULL ,
  `PONumber` VARCHAR(50) NULL,
  `Terms` VARCHAR(50) NULL,
  `Paid` TINYINT NULL DEFAULT 0,
  `PaidDate` DATETIME NULL,
  `PaidUser` VARCHAR(50) NULL,
  `Estimate` TINYINT NULL DEFAULT 0,
  `EstimateDate` DATETIME NULL ,
  `EstimateUser` VARCHAR(50) NULL,
  `Ordered` TINYINT NULL DEFAULT 0,
  `OrderedDate` DATETIME NULL,
  `OrderedUser` VARCHAR(50) NULL,
  `Archived` TINYINT NULL DEFAULT 0,
  `ArchivedDate` DATETIME NULL,
  `Shipped` TINYINT NULL DEFAULT 0,
  `ShippedDate` DATETIME NULL,
  `ShippedUser` VARCHAR(50) NULL,
  `Released` TINYINT NULL DEFAULT 0,
  `ReleasedDate` DATETIME NULL,
  `ReleasedUser` VARCHAR(50) NULL,
  `ReadytoShip` TINYINT NULL DEFAULT 0,
  `ReadytoShipDate` DATETIME NULL,
  `ReadytoShipUser` VARCHAR(50) NULL,
  `CustomerAcknowledgement` TINYINT NULL DEFAULT 0,
  `CustomerAcknowledgementDate` DATETIME NULL,
  `CustomerAcknowledgementInitials` CHAR(20) NULL,
  `CustomerAcknowledgementIP` CHAR(20) NULL,
  `EmailAck` TINYINT NULL DEFAULT 0,
  `EmailAckDate` DATETIME NULL,
  `EmailAckUser` VARCHAR(50) NULL,
  `EmailShipAck` TINYINT NULL DEFAULT 0,
  `EmailShipAckDate` DATETIME NULL,
  `EmailShipAckUser` VARCHAR(50) NULL,
  `FinishShop` TINYINT NULL DEFAULT 0,
  `FinishShopDate` DATETIME NULL,
  `ShippedPartial` TINYINT NULL DEFAULT 0,
  `ShippedPartialDate` DATETIME NULL,
  `Invoiced` TINYINT NULL DEFAULT 0,
  `InvoicedDate` DATETIME NULL,
  `Updated` TINYINT NULL DEFAULT 0,
  `UpdatedDate` DATETIME NULL,
  `UpdatedBy` VARCHAR(50) NULL,
  `statustext` VARCHAR(50) NULL,
  `ShippingDirections` LONGTEXT NULL,
  `OrderWeight` DECIMAL(10, 2) NULL DEFAULT 0,
  `CreditCardCharged` TINYINT NULL DEFAULT 0,
  `CreditCardChargeddate` DATETIME NULL ,
  `Cancelled` TINYINT NULL DEFAULT 0,
  `CancelledDate` DATETIME NULL,
  `BackOrderID` INT(10) NULL DEFAULT 0,
  `ShippedBy_Id` INT(10) NULL DEFAULT 0,
  `PickedBy_Id` INT(10) NULL DEFAULT 0,
  `PackedBy_Id` INT(10) NULL DEFAULT 0,
  `SalesMan_Id` INT(10) NULL,
  `CustomerService_id` INT(10) NULL,
  `ShipCompanyName` VARCHAR(50) NULL,
  `ShipContactFirstName` VARCHAR(50) NULL,
  `ShipContactLastName` VARCHAR(50) NULL,
  `ShipAddress1` VARCHAR(50) NULL,
  `ShipAddress2` VARCHAR(50) NULL,
  `ShipAddress3` VARCHAR(50) NULL,
  `ShipAddress4` VARCHAR(50) NULL,
  `ShipCity` VARCHAR(50) NULL,
  `ShipState` VARCHAR(20) NULL,
  `ShipPostalCode` VARCHAR(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `BillCompanyName` VARCHAR(50) NULL,
  `BillContactFirstName` VARCHAR(50) NULL,
  `BillContactLastName` VARCHAR(50) NULL,
  `BillAddress1` VARCHAR(50) NULL,
  `BillAddress2` VARCHAR(50) NULL,
  `BillAddress3` VARCHAR(50) NULL,
  `BillAddress4` VARCHAR(50) NULL,
  `BillCity` VARCHAR(50) NULL,
  `BillState` VARCHAR(20) NULL,
  `BillPostalCode` VARCHAR(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `PhoneNumber` VARCHAR(50) NULL,
  `FaxNumber` VARCHAR(50) NULL,
  `CellPhone` VARCHAR(50) NULL,
  `Email` VARCHAR(50) NULL,
  `Backorder` TINYINT NULL DEFAULT 0,
  `Production` TINYINT NULL DEFAULT 0,
  `ProductionDate` DATETIME NULL,
  `ProductName` VARCHAR(50) NULL,
  `WoodType` VARCHAR(50) NULL,
  `EmployeeIDReportedReadyToShip` INT(10) NULL,
  `DateFinal` DATETIME NULL,
  `DateReportedReadyToShip` DATETIME NULL,
  `PurchaseOrderNumber` VARCHAR(150) NULL,
  `estimated_shipping_cost` DECIMAL(10, 2) NULL,
  `CompanyID` INT(10) NOT NULL,
  `InvoicedBy` VARCHAR(50) NULL,
  `CustomerAcknowledgementSignature` VARCHAR(100) NULL,
  PRIMARY KEY (`OrderID`),
  INDEX `IX_CustomerID` (`CustomerID`),
  INDEX `IX_EmployeeID` (`EmployeeID`),
  INDEX `IX_OrdersBOMJob_Name` (`Job_Name`),
  INDEX `IX_Status` (`Status`),
  INDEX `IX_Terms` (`Terms`),
  INDEX `TblOrdersBOM_idx` (`CustomerService_id`),
  INDEX `TblOrdersBOM_idx2` (`SalesMan_Id`),
  INDEX `TblOrdersBOM_idx3` (`ProductionDate`),
  INDEX `TblOrdersBOM_idx4` (`Duedate`),
  INDEX `TblOrdersBOM_idx5` (`CompanyID`),
  INDEX `TblOrdersBOM_idx6` (`ShippingMethodID`),
  INDEX `TblOrdersBOM_idx7` (`EmployeeIDReportedReadyToShip`),
  INDEX `TblOrdersBOM23` (`OrderID`, `ShipCompanyName`, `ShipContactFirstName`, `ShipAddress1`, `ShipAddress2`, `ShipAddress3`, `ShipCity`, `ShipState`, `ShipPostalCode`, `PhoneNumber`, `FaxNumber`, `Email`),
  CONSTRAINT `TblOrdersBOM_fk_Company` FOREIGN KEY `TblOrdersBOM_fk_Company` (`CompanyID`)
    REFERENCES `ironbaluster_dbo`.`Company` (`CompanyID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `TblOrdersBOM_fk` FOREIGN KEY `TblOrdersBOM_fk` (`SalesMan_Id`)
    REFERENCES `ironbaluster_dbo`.`Employees` (`EmployeeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `TblOrdersBOM_fk2` FOREIGN KEY `TblOrdersBOM_fk2` (`CustomerService_id`)
    REFERENCES `ironbaluster_dbo`.`Employees` (`EmployeeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `TblOrdersBOM_fk3` FOREIGN KEY `TblOrdersBOM_fk3` (`EmployeeID`)
    REFERENCES `ironbaluster_dbo`.`Employees` (`EmployeeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `TblOrdersBOM_fk4` FOREIGN KEY `TblOrdersBOM_fk4` (`ShippingMethodID`)
    REFERENCES `ironbaluster_dbo`.`Shipping_Methods` (`ShippingMethodID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `TblOrdersBOM_fk5` FOREIGN KEY `TblOrdersBOM_fk5` (`EmployeeIDReportedReadyToShip`)
    REFERENCES `ironbaluster_dbo`.`Employees` (`EmployeeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_TblOrdersBOM_Customers` FOREIGN KEY `FK_TblOrdersBOM_Customers` (`CustomerID`)
    REFERENCES `ironbaluster_dbo`.`Customers` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
)
ENGINE = INNODB
CHARACTER SET utf8 COLLATE utf8_general_ci;

CREATE TABLE `ironbaluster_dbo`.`TblProductVendors` (
  `ProductVendorID` INT(10) NOT NULL AUTO_INCREMENT,
  `ProductID` INT(10) NOT NULL,
  `Vendor_ID` INT(10) NOT NULL,
  `VendorPartNum` VARCHAR(50) NULL,
  `Purchase_Price` DECIMAL(19, 4) NULL DEFAULT 0,
  `DateEntered` DATETIME NULL ,
  `DateUpdated` DATETIME NULL ,
  PRIMARY KEY (`ProductVendorID`),
  INDEX `IX_ProductID` (`ProductID`),
  INDEX `IX_Vendor_ID` (`Vendor_ID`),
  INDEX `TblProductVendors56` (`Vendor_ID`, `ProductID`, `ProductVendorID`),
  CONSTRAINT `FK_TblProductVendors_TBLVendor` FOREIGN KEY `FK_TblProductVendors_TBLVendor` (`Vendor_ID`)
    REFERENCES `ironbaluster_dbo`.`TBLVendor` (`Vendor_ID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_TblProductVendors_Products` FOREIGN KEY `FK_TblProductVendors_Products` (`ProductID`)
    REFERENCES `ironbaluster_dbo`.`Products` (`ProductID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION
)
ENGINE = INNODB
CHARACTER SET utf8 COLLATE utf8_general_ci;

CREATE TABLE `ironbaluster_dbo`.`tblRGAProduct` (
  `id` INT(10) NOT NULL AUTO_INCREMENT,
  `d_quantity` INT(10) NULL,
  `d_part_number` CHAR(100) NULL,
  `d_rga_request_id` INT(10) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `tblRGAProduct_idx` (`d_rga_request_id`),
  CONSTRAINT `FK_tblRGAProduct_tblRGARequest` FOREIGN KEY `FK_tblRGAProduct_tblRGARequest` (`d_rga_request_id`)
    REFERENCES `ironbaluster_dbo`.`tblRGARequest` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION
)
ENGINE = INNODB
CHARACTER SET utf8 COLLATE utf8_general_ci;

CREATE TABLE `ironbaluster_dbo`.`tblRGAStatus` (
  `id` INT(10) NOT NULL AUTO_INCREMENT,
  `d_stage_id` INT(10) NOT NULL,
  `d_rga_request_id` INT(10) NOT NULL,
  `d_employee_id` INT(10) NULL,
  `d_message_subject` VARCHAR(200) NULL,
  `d_message_content` VARCHAR(2000) NULL,
  `d_internal_notes` VARCHAR(2000) NULL,
  `d_date_created` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `idxEmployee` (`d_employee_id`),
  INDEX `idxRequest` (`d_rga_request_id`),
  INDEX `idxStage` (`d_stage_id`),
  CONSTRAINT `FK_tblRGAStatus_Employees` FOREIGN KEY `FK_tblRGAStatus_Employees` (`d_employee_id`)
    REFERENCES `ironbaluster_dbo`.`Employees` (`EmployeeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_tblRGAStatus_tblRGARequest` FOREIGN KEY `FK_tblRGAStatus_tblRGARequest` (`d_rga_request_id`)
    REFERENCES `ironbaluster_dbo`.`tblRGARequest` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_tblRGAStatus_tblRGAStage` FOREIGN KEY `FK_tblRGAStatus_tblRGAStage` (`d_stage_id`)
    REFERENCES `ironbaluster_dbo`.`tblRGAStage` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
)
ENGINE = INNODB
CHARACTER SET utf8 COLLATE utf8_general_ci;

CREATE TABLE `ironbaluster_dbo`.`TblOrdersBOM_Items` (
  `OrderItemsID` INT(10) NOT NULL AUTO_INCREMENT,
  `OrderID` INT(10) NULL,
  `ProductID` INT(10) NULL,
  `Quantity` DECIMAL(10, 2) NULL DEFAULT 0,
  `QuantityShipped` DECIMAL(10, 2) NULL DEFAULT 0,
  `Unit_of_Measure` VARCHAR(10) NULL,
  `UnitPrice` DECIMAL(19, 4) NULL DEFAULT 0,
  `Discount` DECIMAL(10, 4) NULL DEFAULT 0,
  `Status` VARCHAR(50) NULL,
  `Special_Instructions` VARCHAR(150) NULL,
  `In_House_Notes` LONGTEXT NULL,
  `Customer_Notes` LONGTEXT NULL,
  `ProductName` VARCHAR(100) NULL,
  `Product_Descripton` VARCHAR(500) NULL,
  `Purchase_Price` DECIMAL(19, 4) NULL DEFAULT 0,
  `UnitWeight` DECIMAL(10, 2) NULL DEFAULT 0,
  `ReadytoShip` TINYINT NULL DEFAULT 0,
  `Prod_BoardFeet` DECIMAL(18, 0) NULL DEFAULT 0,
  `Shipped` TINYINT NULL DEFAULT 0,
  `ShippedDate` DATETIME NULL,
  `PRC` TINYINT NULL DEFAULT 0,
  `Final` TINYINT NULL DEFAULT 0,
  `Prefinishing_Complete` TINYINT NULL DEFAULT 0,
  `PRC_Initials` LONGTEXT NULL,
  `Final_Initials` LONGTEXT NULL,
  `Prefinishing_Complete_Initials` LONGTEXT NULL,
  `PRC_Date` DATETIME NULL,
  `Final_Date` DATETIME NULL,
  `Prefinishing_Complete_Date` DATETIME NULL,
  `PRC_EmployeeID` BIGINT(19) NULL,
  `Final_EmployeeID` BIGINT(19) NULL,
  `Prefinishing_Complete_EmployeeID` BIGINT(19) NULL,
  `ExceptionOpened` TINYINT NULL DEFAULT 0,
  `ExceptonDateCreated` DATETIME NULL,
  `ExceptionDateClosed` DATETIME NULL,
  `ExceptionClosed` TINYINT NULL DEFAULT 0,
  `Outsource` TINYINT NULL,
  `OutsourceDate` DATETIME NULL,
  `OutsourceInitials` LONGTEXT NULL,
  `exceptionOpened_EmployeeID` BIGINT(19) NULL,
  `ExceptionClosed_EmployeeID` BIGINT(19) NULL,
  `outsource_EmployeeID` BIGINT(19) NULL,
  `ExceptionId` BIGINT(19) NULL,
  `RecordCreated` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`OrderItemsID`),
  INDEX `idx_TblOrdersBOM_Items_ProductID` (`ProductID`),
  INDEX `IX_OrderID` (`OrderID`),
  INDEX `TblOrdersBOM_Items_idx` (`ExceptionId`),
  INDEX `TblOrdersBOM_Items_idx2` (`PRC_EmployeeID`),
  INDEX `TblOrdersBOM_Items_idx3` (`Final_EmployeeID`),
  INDEX `TblOrdersBOM_Items_idx4` (`Prefinishing_Complete_EmployeeID`),
  INDEX `TblOrdersBOM_Items_idx5` (`exceptionOpened_EmployeeID`),
  INDEX `TblOrdersBOM_Items_idx6` (`ExceptionClosed_EmployeeID`),
  INDEX `TblOrdersBOM_Items_idx7` (`outsource_EmployeeID`),
  INDEX `TblOrdersBOM_Items19` (`OrderID`, `OrderItemsID`, `Quantity`, `QuantityShipped`, `Unit_of_Measure`, `Special_Instructions`, `ProductName`, `Product_Descripton`),
  INDEX `TblOrdersBOM_Items49` (`OrderItemsID`, `OrderID`, `Quantity`),
  CONSTRAINT `FK_TblOrdersBOM_Items_Products` FOREIGN KEY `FK_TblOrdersBOM_Items_Products` (`ProductID`)
    REFERENCES `ironbaluster_dbo`.`Products` (`ProductID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `TblOrdersBOM_Items_fk` FOREIGN KEY `TblOrdersBOM_Items_fk` (`OrderID`)
    REFERENCES `ironbaluster_dbo`.`TblOrdersBOM` (`OrderID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION
)
ENGINE = INNODB
CHARACTER SET utf8 COLLATE utf8_general_ci;

CREATE TABLE `ironbaluster_dbo`.`TblOrdersBOMmemos` (
  `OrderMemoID` INT(10) NOT NULL AUTO_INCREMENT,
  `OrderID` INT(10) NOT NULL,
  `DateCreated` DATETIME NULL ,
  `Cat` VARCHAR(50) NULL,
  `Memo` LONGTEXT NULL,
  `IsTicket` TINYINT NULL DEFAULT 0,
  `IsTicketCompleted` TINYINT NULL DEFAULT 0,
  PRIMARY KEY (`OrderMemoID`),
  INDEX `TblOrdersBOMmemos28` (`OrderMemoID`, `OrderID`),
  CONSTRAINT `TblOrdersBOMmemos_fk` FOREIGN KEY `TblOrdersBOMmemos_fk` (`OrderID`)
    REFERENCES `ironbaluster_dbo`.`TblOrdersBOM` (`OrderID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION
)
ENGINE = INNODB
CHARACTER SET utf8 COLLATE utf8_general_ci;

CREATE TABLE `ironbaluster_dbo`.`TblProductTypeInclude` (
  `id` INT(10) NOT NULL AUTO_INCREMENT,
  `parentTypeId` INT(10) NOT NULL,
  `childTypeId` INT(10) NOT NULL,
  PRIMARY KEY (`id`)
)
ENGINE = INNODB
CHARACTER SET utf8 COLLATE utf8_general_ci;

CREATE TABLE `ironbaluster_dbo`.`Employees_role_access` (
  `role_id` INT(10) NOT NULL,
  `Module_id` INT(10) NOT NULL,
  INDEX `idx_Employees_role_access_module` (`Module_id`),
  INDEX `idx_Employees_role_access_role` (`role_id`),
  CONSTRAINT `FK_Employees_role_access_module` FOREIGN KEY `FK_Employees_role_access_module` (`Module_id`)
    REFERENCES `ironbaluster_dbo`.`Employees_module` (`Module_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Employees_role_access_role` FOREIGN KEY `FK_Employees_role_access_role` (`role_id`)
    REFERENCES `ironbaluster_dbo`.`Employees_role` (`role_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION
)
ENGINE = INNODB
CHARACTER SET utf8 COLLATE utf8_general_ci;

CREATE TABLE `ironbaluster_dbo`.`Customers` (
  `CustomerID` INT(10) NOT NULL AUTO_INCREMENT,
  `ContactCompanyName` VARCHAR(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `ContactFirstName` VARCHAR(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `ContactLastName` VARCHAR(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `ContactAddress1` VARCHAR(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `ContactAddress2` VARCHAR(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `ContactAddress3` VARCHAR(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `ContactAddress4` VARCHAR(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `ContactCity` VARCHAR(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `StateOrProvince_old` VARCHAR(20) NULL DEFAULT 'IN',
  `ContactPostalCode` VARCHAR(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `Country_old` VARCHAR(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `ContactTitle` VARCHAR(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `ContactPhoneNumber` VARCHAR(50) NULL,
  `ContactFaxNumber` VARCHAR(50) NULL,
  `ContactCellPhone` VARCHAR(50) NULL,
  `Email` VARCHAR(50) NULL,
  `Password` VARCHAR(20) NULL,
  `Terms` VARCHAR(50) NULL DEFAULT 'Credit Card',
  `TaxID_Number` VARCHAR(50) NULL,
  `TaxExempt` TINYINT NULL DEFAULT 1,
  `DateUpdated` DATETIME NULL,
  `DateEntered` DATETIME NULL,
  `ShipCompanyName` VARCHAR(50) NULL,
  `ShipFirstName` VARCHAR(50) NULL,
  `ShipLastName` VARCHAR(50) NULL,
  `ShipAddress1` VARCHAR(100) NULL,
  `ShipAddress2` VARCHAR(100) NULL,
  `ShipAddress3` VARCHAR(100) NULL,
  `ShipAddress4` VARCHAR(100) NULL,
  `ShipCity` VARCHAR(50) NULL,
  `ShipState_old` VARCHAR(20) NULL,
  `ShipPostalCode` VARCHAR(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `BillCompanyName` VARCHAR(50) NULL,
  `BillFirstName` VARCHAR(50) NULL,
  `BillLastName` VARCHAR(50) NULL,
  `BillAddress1` VARCHAR(100) NULL,
  `BillAddress2` VARCHAR(100) NULL,
  `BillAddress3` VARCHAR(100) NULL,
  `BillAddress4` VARCHAR(100) NULL,
  `BillCity` VARCHAR(50) NULL,
  `BillState_old` VARCHAR(20) NULL,
  `BillPostalCode` VARCHAR(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `CustomerType` VARCHAR(50) NULL,
  `Annual_Sales_Forcast` DECIMAL(19, 4) NULL DEFAULT 0,
  `YTD_Sales` DECIMAL(19, 4) NULL,
  `Last_years_Sales` DECIMAL(19, 4) NULL,
  `LastSale` CHAR(10) NULL,
  `CustomerNotes` VARCHAR(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `CanLogin` TINYINT NULL DEFAULT 1,
  `FollowUp` DATETIME NULL,
  `SalesPerson` INT(10) NULL,
  `FollowUpPerson` INT(10) NULL,
  `LeadType` VARCHAR(10) NULL DEFAULT 'Inbound',
  `CreditHold` TINYINT NULL DEFAULT 0,
  `ContactCountryId` INT(10) NULL,
  `Country_new` VARCHAR(255) NULL,
  `ContactState` VARCHAR(2) NULL,
  `ContactStateOther` VARCHAR(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `ShipState` VARCHAR(2) NULL,
  `ShipStateOther` VARCHAR(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `ShipCountryId` INT(10) NULL,
  `BillState` VARCHAR(2) NULL,
  `BillStateOther` VARCHAR(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `BillCountryId` INT(10) NULL,
  `ContactState_new` VARCHAR(255) NULL,
  `ShipState_new` VARCHAR(255) NULL,
  `BillState_new` VARCHAR(255) NULL,
  `BillingEmails` VARCHAR(255) NULL,
  PRIMARY KEY (`CustomerID`),
  INDEX `Customers_idx` (`SalesPerson`),
  INDEX `Customers_idx2` (`FollowUpPerson`),
  INDEX `Customers_idx3` (`ContactState`),
  INDEX `Customers_idx4` (`ShipState`),
  INDEX `Customers_idx5` (`ShipCountryId`),
  INDEX `Customers_idx6` (`BillState`),
  INDEX `Customers_idx7` (`BillCountryId`),
  INDEX `Customers_idx8` (`ContactCountryId`),
  INDEX `IX_Customers` (`ContactCompanyName`),
  INDEX `IX_Terms` (`Terms`),
  CONSTRAINT `Customers_fk` FOREIGN KEY `Customers_fk` (`SalesPerson`)
    REFERENCES `ironbaluster_dbo`.`Employees` (`EmployeeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Customers_fk2` FOREIGN KEY `Customers_fk2` (`FollowUpPerson`)
    REFERENCES `ironbaluster_dbo`.`Employees` (`EmployeeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Customers_fk4` FOREIGN KEY `Customers_fk4` (`ContactCountryId`)
    REFERENCES `ironbaluster_dbo`.`Country` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Customers_fk5` FOREIGN KEY `Customers_fk5` (`ContactState`)
    REFERENCES `ironbaluster_dbo`.`TblState` (`State`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Customers_fk3` FOREIGN KEY `Customers_fk3` (`ShipState`)
    REFERENCES `ironbaluster_dbo`.`TblState` (`State`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Customers_fk6` FOREIGN KEY `Customers_fk6` (`ShipCountryId`)
    REFERENCES `ironbaluster_dbo`.`Country` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Customers_fk7` FOREIGN KEY `Customers_fk7` (`BillState`)
    REFERENCES `ironbaluster_dbo`.`TblState` (`State`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Customers_fk8` FOREIGN KEY `Customers_fk8` (`BillCountryId`)
    REFERENCES `ironbaluster_dbo`.`Country` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
)
ENGINE = INNODB
CHARACTER SET utf8 COLLATE utf8_general_ci;


CREATE TABLE `ironbaluster_dbo`.`TblOrdersBOM_Shipments` (
  `OrderShipment_id` INT(10) NOT NULL AUTO_INCREMENT,
  `OrderID` int NOT NULL,
  `ShippingMethodID` int NULL DEFAULT 3,
  `ShippingMethodUPS` varchar(200) NULL,
  `ShippedBy_Id` int NULL,
  `TrackingNumber` varchar(150) NULL,
  `DateAdded` datetime NULL,
  `DateUpdated` datetime NULL,
  `Paid` TINYINT DEFAULT 0 NULL,
  `Invoiced` TINYINT DEFAULT 0 NULL,
  `ShipmentNumber` varchar(10) NOT NULL,
  `InvoiceDate` date NULL,
  `actual_shipping_cost` decimal(10, 2) NULL,
  `signature_file` varchar(100) NULL,
  `signature_date` datetime NULL,
  `delivered` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`OrderShipment_id`),
  INDEX `TblOrdersBOM_ShipmentsItems_idx` (`OrderID`),
  INDEX `TblOrdersBOM_ShipmentsItems_idx2` (`ShippingMethodID`),
  INDEX `TblOrdersBOM_ShipmentsItems_idx3` (`ShippedBy_Id`),
  UNIQUE `TblOrdersBOM_ShipmentsItems_idx4` (`ShipmentNumber`),
  CONSTRAINT `TblOrdersBOM_OrderShipments_fk` FOREIGN KEY (`OrderID`) 
    REFERENCES `TblOrdersBOM` (`OrderID`) 
    ON UPDATE NO ACTION
    ON DELETE NO ACTION,
  CONSTRAINT `TblOrdersBOM_OrderShipments_fk2` FOREIGN KEY (`ShippingMethodID`) 
    REFERENCES `Shipping_Methods` (`ShippingMethodID`) 
    ON UPDATE NO ACTION
    ON DELETE NO ACTION,
  CONSTRAINT `TblOrdersBOM_Shipments_fk` FOREIGN KEY (`ShippedBy_Id`) 
    REFERENCES `Employees` (`EmployeeID`) 
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
)
ENGINE = INNODB
CHARACTER SET utf8 COLLATE utf8_general_ci;


CREATE TABLE `ironbaluster_dbo`.`TblOrdersBOM_ShipmentsItems` (
  `OrderShipmentDetails_ID` INT(10) NOT NULL AUTO_INCREMENT,
  `OrderShipment_id` INT(10) NOT NULL,
  `OrderItemsID` INT(10) NOT NULL,
  `QuantityShipped` DECIMAL(10, 2) NOT NULL,
  `BoxSkidNumber` VARCHAR(10) NULL,
  `DateAdded` DATETIME NULL ,
  `DateUpdated` DATETIME NULL ,
  PRIMARY KEY (`OrderShipmentDetails_ID`),
  INDEX `TblOrdersBOM_ShipmentsItems_idx` (`OrderShipment_id`),
  INDEX `TblOrdersBOM_ShipmentsItems_idx2` (`OrderItemsID`),
  CONSTRAINT `TblOrdersBOM_ShipmentsItems_fk` FOREIGN KEY `TblOrdersBOM_ShipmentsItems_fk` (`OrderShipment_id`)
    REFERENCES `TblOrdersBOM_Shipments` (`OrderShipment_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `TblOrdersBOM_ShipmentsItems_fk2` FOREIGN KEY `TblOrdersBOM_ShipmentsItems_fk2` (`OrderItemsID`)
    REFERENCES `TblOrdersBOM_Items` (`OrderItemsID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
)
ENGINE = INNODB
CHARACTER SET utf8 COLLATE utf8_general_ci;

CREATE TABLE `ironbaluster_dbo`.`CustomerNotes` (
  `CustomerNotes_ID` INT(10) NOT NULL AUTO_INCREMENT,
  `CustomerID` INT(10) NULL,
  `DateAdded` DATETIME NULL ,
  `DateUpdated` DATETIME NULL ,
  `Memo` LONGTEXT NULL,
  `Sales Person` INT(10) NULL,
  `NoteType` VARCHAR(100) NULL DEFAULT 'Inbound',
  `Response` LONGTEXT NULL,
  `FollowUpComplete` INT(10) NOT NULL DEFAULT 0,
  `DateFollowUpComplete` DATETIME NULL,
  `DateFollowUpDue` DATETIME NULL,
  `CustomerNoteResponseID` INT(10) NOT NULL DEFAULT 0,
  `CustomerNoteTypeID` INT(10) NOT NULL DEFAULT 0,
  `Forcast` VARCHAR(50) NULL,
  PRIMARY KEY (`CustomerNotes_ID`),
  INDEX `CustomerNotes_idx` (`Sales Person`),
  INDEX `CustomerNotes_idx2` (`CustomerID`),
  CONSTRAINT `CustomerNotes_fk` FOREIGN KEY `CustomerNotes_fk` (`Sales Person`)
    REFERENCES `ironbaluster_dbo`.`Employees` (`EmployeeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `CustomerNotes_fk2` FOREIGN KEY `CustomerNotes_fk2` (`CustomerID`)
    REFERENCES `ironbaluster_dbo`.`Customers` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
)
ENGINE = INNODB
CHARACTER SET utf8 COLLATE utf8_general_ci;

CREATE TABLE `ironbaluster_dbo`.`Employees` (
  `EmployeeID` INT(10) NOT NULL AUTO_INCREMENT,
  `FirstName` VARCHAR(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `LastName` VARCHAR(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `Title` VARCHAR(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `Extension` VARCHAR(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `WorkPhone` VARCHAR(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `Archive` TINYINT NULL DEFAULT 0,
  `username` VARCHAR(50) NULL,
  `email` VARCHAR(50) NULL,
  `EmployeeCode` CHAR(4) NULL,
  `Role_id` INT(10) NULL,
  `Password` VARCHAR(50) NULL,
  `vendor_id` INT(10) NULL,
  `CellPhone` VARCHAR(50) NULL,
  `HomePhone` VARCHAR(50) NULL,
  `EmergencyContactName` VARCHAR(100) NULL,
  `EmergencyContactNumber` VARCHAR(50) NULL,
  `Address` VARCHAR(100) NULL,
  `City` VARCHAR(50) NULL,
  `State` VARCHAR(50) NULL,
  `Zip` VARCHAR(10) NULL,
  `StartDate` DATETIME NULL,
  `ReceivedAccessHandbook` TINYINT NULL DEFAULT 0,
  `TrainingForkliftComplete` TINYINT NULL DEFAULT 0,
  `TrainingHazComComplete` TINYINT NULL DEFAULT 0,
  `TrainingConfinedSpaceComplete` TINYINT NULL DEFAULT 0,
  `ChauffersLicenseLogged` TINYINT NULL DEFAULT 0,
  PRIMARY KEY (`EmployeeID`),
  INDEX `idx_Employees_role` (`Role_id`),
  INDEX `idx_Employees_Vendor` (`vendor_id`),
  CONSTRAINT `FK_Employees_Role` FOREIGN KEY `FK_Employees_Role` (`Role_id`)
    REFERENCES `ironbaluster_dbo`.`Employees_role` (`role_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Employees_Vendor` FOREIGN KEY `FK_Employees_Vendor` (`vendor_id`)
    REFERENCES `ironbaluster_dbo`.`TBLVendor` (`Vendor_ID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION
)
ENGINE = INNODB
CHARACTER SET utf8 COLLATE utf8_general_ci;

CREATE TABLE `ironbaluster_dbo`.`TblOrdersBOM_Update` (
  `id` INT(10) NOT NULL AUTO_INCREMENT,
  `d_update_date` DATETIME NULL,
  `orderID` INT(10) NULL,
  `employeeID` INT(10) NULL,
  PRIMARY KEY (`id`),
  INDEX `TblOrdersBOM_Update_idx` (`orderID`),
  INDEX `TblOrdersBOM_Update_idx2` (`employeeID`),
  CONSTRAINT `TblOrdersBOM_Update_fk2` FOREIGN KEY `TblOrdersBOM_Update_fk2` (`employeeID`)
    REFERENCES `ironbaluster_dbo`.`Employees` (`EmployeeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `TblOrdersBOM_Update_fk` FOREIGN KEY `TblOrdersBOM_Update_fk` (`orderID`)
    REFERENCES `ironbaluster_dbo`.`TblOrdersBOM` (`OrderID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION
)
ENGINE = INNODB
CHARACTER SET utf8 COLLATE utf8_general_ci;

CREATE TABLE `ironbaluster_dbo`.`Company` (
  `CompanyID` INT(10) NOT NULL AUTO_INCREMENT,
  `CompanyName` VARCHAR(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `Address` VARCHAR(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `City` VARCHAR(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `StateOrProvince` VARCHAR(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `PostalCode` VARCHAR(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `Country` VARCHAR(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `PhoneNumber` VARCHAR(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `FaxNumber` VARCHAR(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `FileSuffix` VARCHAR(10) NULL,
  `webAddress` VARCHAR(100) NULL,
  PRIMARY KEY (`CompanyID`)
)
ENGINE = INNODB
CHARACTER SET utf8 COLLATE utf8_general_ci;

CREATE TABLE `ironbaluster_dbo`.`Sites` (
  `id` INT(10) NOT NULL,
  `Name` VARCHAR(50) NULL,
  PRIMARY KEY (`id`)
)
ENGINE = INNODB
CHARACTER SET utf8 COLLATE utf8_general_ci;

CREATE TABLE `ironbaluster_dbo`.`TblOrdersBOM_UpdateDetails` (
  `id` INT(10) NOT NULL AUTO_INCREMENT,
  `orderUpdateID` INT(10) NULL,
  `field_name` VARCHAR(50) NULL,
  `old_value` VARCHAR(200) NULL,
  `new_value` VARCHAR(200) NULL,
  PRIMARY KEY (`id`),
  INDEX `TblOrdersBOM_UpdateDetails_idx` (`orderUpdateID`),
  CONSTRAINT `TblOrdersBOM_UpdateDetails_fk` FOREIGN KEY `TblOrdersBOM_UpdateDetails_fk` (`orderUpdateID`)
    REFERENCES `ironbaluster_dbo`.`TblOrdersBOM_Update` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION
)
ENGINE = INNODB
CHARACTER SET utf8 COLLATE utf8_general_ci;

CREATE TABLE `ironbaluster_dbo`.`CustomerLogins` (
  `id` INT(10) NOT NULL,
  `customerID` INT(10) NOT NULL,
  `siteID` INT(10) NOT NULL,
  `loginTime` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `CustomerLogins_idx` (`customerID`),
  INDEX `CustomerLogins_idx2` (`siteID`),
  CONSTRAINT `CustomerLogins_fk` FOREIGN KEY `CustomerLogins_fk` (`customerID`)
    REFERENCES `ironbaluster_dbo`.`Customers` (`CustomerID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `CustomerLogins_fk2` FOREIGN KEY `CustomerLogins_fk2` (`siteID`)
    REFERENCES `ironbaluster_dbo`.`Sites` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION
)
ENGINE = INNODB
CHARACTER SET utf8 COLLATE utf8_general_ci;

CREATE TABLE `ironbaluster_dbo`.`Tblspecialorders_files` (
  `files_id` INT(10) NOT NULL AUTO_INCREMENT,
  `specialorder_id` INT(10) NULL,
  `file_name` VARCHAR(50) NULL,
  `date` VARCHAR(50) NULL,
  PRIMARY KEY (`files_id`)
)
ENGINE = INNODB
CHARACTER SET utf8 COLLATE utf8_general_ci;



SET FOREIGN_KEY_CHECKS = 1;

-- ----------------------------------------------------------------------
-- EOF

