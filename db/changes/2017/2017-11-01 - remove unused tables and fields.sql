ALTER TABLE `TblAudit`
	DROP COLUMN `_unused_d_item_id`;


ALTER TABLE `TblCustomer`
	DROP COLUMN `_unused_BillCompanyName`,
	DROP COLUMN `_unused_BillFirstName`,
	DROP COLUMN `_unused_BillLastName`,
	DROP COLUMN `_unused_BillAddress1`,
	DROP COLUMN `_unused_BillAddress2`,
	DROP COLUMN `_unused_BillAddress3`,
	DROP COLUMN `_unused_BillCity`,
	DROP COLUMN `_unused_BillState`,
	DROP COLUMN `_unused_BillStateOther`,
	DROP COLUMN `_unused_BillPostalCode`,
	DROP COLUMN `_unused_BillCountryID`,
	DROP COLUMN `_unused_ShipCompanyName`,
	DROP COLUMN `_unused_ShipFirstName`,
	DROP COLUMN `_unused_ShipLastName`,
	DROP COLUMN `_unused_ShipAddress1`,
	DROP COLUMN `_unused_ShipAddress2`,
	DROP COLUMN `_unused_ShipAddress3`,
	DROP COLUMN `_unused_ShipCity`,
	DROP COLUMN `_unused_ShipState`,
	DROP COLUMN `_unused_ShipStateOther`,
	DROP COLUMN `_unused_ShipPostalCode`,
	DROP COLUMN `_unused_ShipCountryID`,
	DROP COLUMN `_unused_FollowUp`,
	DROP COLUMN `_unused_SalesPersonCommission`,
	DROP FOREIGN KEY `Customers_fk6`,
	DROP FOREIGN KEY `Customers_fk8`,
	DROP FOREIGN KEY `FK_Customers_TblState`,
	DROP FOREIGN KEY `FK_Customers_TblState_2`
;
ALTER TABLE `TblCustomerContact`
	DROP COLUMN `_unused_ContactTitle`
;



ALTER TABLE `TblEmployee`
	DROP COLUMN `_unused_Address`,
	DROP COLUMN `_unused_City`,
	DROP COLUMN `_unused_State`,
	DROP COLUMN `_unused_Zip`,
	DROP COLUMN `_unused_WorkPhone`,
	DROP COLUMN `_unused_Extension`,
	DROP COLUMN `_unused_HomePhone`,
	DROP COLUMN `_unused_EmergencyContactName`,
	DROP COLUMN `_unused_EmergencyContactNumber`,
	DROP COLUMN `_unused_username`,
	DROP COLUMN `_unused_vendor_id`,
	DROP COLUMN `_unused_ReceivedAccessHandbook`,
	DROP COLUMN `_unused_TrainingForkliftComplete`,
	DROP COLUMN `_unused_TrainingHazComComplete`,
	DROP COLUMN `_unused_TrainingConfinedSpaceComplete`,
	DROP COLUMN `_unused_ChauffersLicenseLogged`,
	DROP COLUMN `_unused_iPhoneToken`,
	DROP FOREIGN KEY `FK_Employees_Vendor`;


ALTER TABLE `TblFile`
	DROP COLUMN `_unused_customerContactID`,
	DROP FOREIGN KEY `FK_TblFile_CustomerContact`;
ALTER TABLE `TblFinishOption`
	DROP COLUMN `_unused_ProductionTimeInDays`,
	DROP COLUMN `_unused_CableRailCssStyle`;
ALTER TABLE `TblMaterial`
	DROP COLUMN `_unused_d_cable_rail_css_style`;
ALTER TABLE `TblOrdersBOM_Items`
	DROP COLUMN `_unused_Special_Instructions`,
	DROP COLUMN `_unused_QuantityPulled`,
	DROP COLUMN `_unused_so_dimensions`,
	DROP COLUMN `_unused_so_dimensions_date`,
	DROP COLUMN `_unused_so_dimensions_employeeID`,
	DROP COLUMN `_unused_so_email_sent`,
	DROP COLUMN `_unused_so_email_sent_date`,
	DROP COLUMN `_unused_so_email_sent_employeeID`,
	DROP COLUMN `_unused_so_customer_approved`,
	DROP COLUMN `_unused_so_customer_approved_date`,
	DROP COLUMN `_unused_so_customer_approved_employeeID`,
	DROP COLUMN `_unused_so_programming_complete`,
	DROP COLUMN `_unused_so_programming_complete_date`,
	DROP COLUMN `_unused_so_programming_complete_employeeID`,
	DROP COLUMN `_unused_CableRailProgress`,
	DROP FOREIGN KEY `FK_TblOrdersBOM_Items_Employees1`,
	DROP FOREIGN KEY `FK_TblOrdersBOM_Items_Employees2`,
	DROP FOREIGN KEY `FK_TblOrdersBOM_Items_Employees3`,
	DROP FOREIGN KEY `FK_TblOrdersBOM_Items_Employees4`;

ALTER TABLE `TblOrdersBOM`
	DROP COLUMN `_unused_In_House_Notes`,
	DROP COLUMN `_unused_In_House_Notes_bk`,
	DROP COLUMN `_unused_Notes_From_Customer`,
	DROP COLUMN `_unused_ShipName`,
	DROP COLUMN `_unused_ShipPhoneNumber`,
	DROP COLUMN `_unused_MaterialWoodID`,
	DROP COLUMN `_unused_MaterialMetalID`,
	DROP COLUMN `_unused_CableRailProductionDayID`,
	DROP FOREIGN KEY `FK_TblOrdersBOM_TblCableRailProductionDay`,
	DROP FOREIGN KEY `FK_TblOrdersBOM_TblMaterial`,
	DROP FOREIGN KEY `FK_TblOrdersBOM_tbl_wood_type`;
ALTER TABLE `TblOrdersBOM_ItemsHistory`
	DROP COLUMN `_unused_fieldName`,
	DROP COLUMN `_unused_value`;
ALTER TABLE `TblProductType`
	DROP COLUMN `_unused_ShowInProductionReport`,
	DROP COLUMN `_unused_DailyFinalThreshold`,
	DROP COLUMN `_unused_ShowOnAddOrderItem`,
	DROP COLUMN `_unused_isPost`,
	DROP COLUMN `_unused_isHandrail`;
ALTER TABLE `TblProducts`
	DROP COLUMN `_unused_ProductionComplexityPoints`,
	DROP COLUMN `_unused_ShowOnInventory`,
	DROP COLUMN `_unused_PurchasingAccountCode`;
ALTER TABLE `TblPurchaseOrder`
	DROP COLUMN `_unused_PartsTotalAmount`,
	DROP COLUMN `_unused_TotalAmount`,
	DROP COLUMN `_unused_Deleted`;
ALTER TABLE `TblPurchaseOrderItem`
	DROP COLUMN `_unused_QuantityReceived`;
ALTER TABLE `TblPurchaseRequestPart`
	DROP COLUMN `_unused_PurchaseOrderCreated`,
	DROP COLUMN `_unused_RecordUpdated`;
ALTER TABLE `TblVendor`
	DROP COLUMN `_unused_primaryContact`,
	DROP COLUMN `_unused_primaryEmail`;
ALTER TABLE `tbl_settings_global`
	DROP COLUMN `_unused_machine_down_emails`;










DROP TABLE `_unused_TblMachineTrainedEmployee`;
DROP TABLE `_unused_TblMachine`;
DROP TABLE `_unused_TblCableRailProductionDay`;
DROP TABLE `_unused_tbl_wood_type_availability`;
DROP FUNCTION `_unused_fUnitPriceWithDiscount`;
DROP FUNCTION `_unused_fPreFinishCost`;
DROP FUNCTION `_unused_fItemPriceWithDiscount`;
DROP FUNCTION `_unused_fUnitDiscount`;
DROP FUNCTION `_unused_fUnitCost`;
