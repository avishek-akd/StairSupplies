ALTER TABLE `TblAllowedIPsIP`
	DROP INDEX `FK__tbl_allowed_ips_list`,
	ADD INDEX `idxFK_ListID` (`ListID`)
;


ALTER TABLE `TblAudit`
	DROP INDEX `idxEmployee`,
	ADD INDEX `idxFK_d_employee_id` (`d_employee_id`),
	DROP INDEX `FK_TblAudit_OrderID`,
	ADD INDEX `idxFK_OrderID` (`OrderID`),
	DROP INDEX `FK_TblAudit_Customers`,
	ADD INDEX `idxFK_CustomerID` (`CustomerID`),
	DROP INDEX `idxLastGroupUpdate`,
	ADD INDEX `idx_LastGroupUpdate` (`groupLastAction`)
;

ALTER TABLE `TblAuditFieldChange`
	DROP INDEX `TblOrdersBOM_UpdateDetails_idx`,
	ADD INDEX `idxFK_AuditID` (`d_audit_id`)
;
ALTER TABLE `TblCompanyLocation`
	DROP INDEX `idxCompanyID`,
	ADD INDEX `idxFK_CompanyID` (`CompanyID`)
;


ALTER TABLE `TblCustomer`
	DROP INDEX `Customers_idx`,
	ADD INDEX `idxFK_SalesPersonID` (`SalesPersonID`),
	DROP INDEX `FK_Customers_Employees`,
	ADD INDEX `idxFK_CustomerServicePersonID` (`CustomerServicePersonID`),
	DROP INDEX `FK_Customers_Tbl_Terms`,
	ADD INDEX `idxFK_TermsID` (`TermsID`),
	DROP INDEX `FK_Customers_Company`,
	ADD INDEX `idxFK_CompanyID` (`defaultCompanyID`),
	DROP INDEX `FK_Customers_CustomerContact`,
	ADD INDEX `idxFK_defaultBillingContactID` (`defaultBillingContactID`),
	DROP INDEX `FK_Customers_CustomerContact_2`,
	ADD INDEX `idxFK_defaultShippingContactID` (`defaultShippingContactID`),
	DROP INDEX `FK_Customers_CustomerType`,
	ADD INDEX `idxFK_CustomerTypeID` (`CustomerTypeID`),
	DROP INDEX `FK_Customers_CustomerInitialContact`,
	ADD INDEX `idxFK_InitialContactID` (`InitialContactID`)
;
ALTER TABLE `TblCustomerContact`
	DROP INDEX `CustomerContact_idxCustomer`,
	ADD INDEX `idxFK_CustomerID` (`CustomerID`),
	DROP INDEX `CustomerContact_idxState`,
	ADD INDEX `idxFK_CustomerState` (`ContactState`),
	DROP INDEX `CustomerContact_idxCountry`,
	ADD INDEX `idxFK_CustomerCountryID` (`ContactCountryId`)
;
ALTER TABLE `TblCustomerContact`
	DROP INDEX `unqResetPasswordUUID`,
	ADD UNIQUE INDEX `unq_ResetPasswordUUID` (`ResetPasswordUUID`)
;
ALTER TABLE `TblCustomerContactEmail`
	DROP INDEX `idxCustomerContactID`,
	ADD INDEX `idxFK_CustomerContactID` (`CustomerContactID`)
;
ALTER TABLE `TblEmployee`
	DROP INDEX `EmployeeCode`,
	ADD UNIQUE INDEX `unq_EmployeeCode` (`EmployeeCode`),
	DROP INDEX `idx_Employees_role`,
	ADD INDEX `idxFK_Role_id` (`Role_id`),
	DROP INDEX `allowed_ips_list_id`,
	ADD INDEX `idxFK_AllowedIPsListID` (`allowed_ips_list_id`)
;
ALTER TABLE `TblEmployeeRoleAccess`
	DROP INDEX `idx_Employees_role_access_role`,
	DROP INDEX `idx_Employees_role_access_module`,
	ADD INDEX `idxFK_Module_id` (`Module_id`),
	ADD PRIMARY KEY (`role_id`, `Module_id`)
;


ALTER TABLE `TblFile`
	DROP INDEX `idxOrder`,
	ADD INDEX `idxFK_OrderID` (`orderID`),
	DROP INDEX `idxProduct`,
	ADD INDEX `idxFK_ProductID` (`productID`),
	DROP INDEX `idxOrderItems`,
	ADD INDEX `idxFK_OrderItemsID` (`orderItemsID`),
	DROP INDEX `idxOrderShipment`,
	ADD INDEX `idxFK_OrderShipmentID` (`orderShipmentID`),
	DROP INDEX `idxCustomer`,
	ADD INDEX `idxFK_CustomerID` (`customerID`),
	DROP INDEX `idxRequestStatus`,
	ADD INDEX `idxFK_rgaRequestStatusID` (`rgaRequestStatusID`),
	DROP INDEX `idxOrderCustomerVisible`,
	ADD INDEX `idxFK_orderCustomerVisibleID` (`orderCustomerVisibleID`),
	DROP INDEX `idxinHouseOrderShipmentID`,
	ADD INDEX `idxFK_inHouseOrderShipmentID` (`inHouseOrderShipmentID`)
;


ALTER TABLE `TblMaterialFinish`
	DROP INDEX `FinishOptionID`,
	DROP INDEX `d_wood_type_id`,
	ADD INDEX `idxFK_FinishOptionID` (`FinishOptionID`)
;
ALTER TABLE `TblMaterialSizeLink`
	DROP INDEX `idx_WoodType`,
	ADD INDEX `idxFK_d_material_id` (`d_material_id`)
;


ALTER TABLE `TblOrdersBOM`
	DROP INDEX `IX_EmployeeID`,
	ADD INDEX `idxFK_EnteredByEmployeeID` (`EnteredByEmployeeID`),
	DROP INDEX `IX_OrdersBOMJob_Name`,
	ADD INDEX `idx_Job_Name` (`Job_Name`),
	DROP INDEX `TblOrdersBOM_idx`,
	ADD INDEX `idxFK_CustomerServiceEmployeeID` (`CustomerServiceEmployeeID`),
	DROP INDEX `TblOrdersBOM_idx2`,
	ADD INDEX `idxFK_SalesmanEmployeeID` (`SalesmanEmployeeID`),
	DROP INDEX `TblOrdersBOM_idx3`,
	ADD INDEX `idx_WoodProductionDate` (`WoodProductionDate`),
	DROP INDEX `TblOrdersBOM_idx4`,
	ADD INDEX `idx_DueDate` (`DueDate`),
	DROP INDEX `TblOrdersBOM_idx5`,
	ADD INDEX `idxFK_CompanyID` (`CompanyID`),
	DROP INDEX `TblOrdersBOM_idx6`,
	ADD INDEX `idxFK_ShippingMethodID` (`ShippingMethodID`),
	DROP INDEX `TblOrdersBOM_idx7`,
	ADD INDEX `idxFK_ReadytoShip_userId` (`ReadytoShip_userId`),
	DROP INDEX `TblOrdersBOM_fk6`,
	ADD INDEX `idxFK_CustomerContactID` (`CustomerContactID`),
	DROP INDEX `FK_TblOrdersBOM_Employees`,
	ADD INDEX `idxFK_Remake_userId` (`Remake_userId`),
	DROP INDEX `FK_TblOrdersBOM_Employees_2`,
	ADD INDEX `idxFK_estimate_userId` (`estimate_userId`),
	DROP INDEX `FK_TblOrdersBOM_Employees_3`,
	ADD INDEX `idxFK_ordered_userid` (`ordered_userid`),
	DROP INDEX `FK_TblOrdersBOM_Employees_4`,
	ADD INDEX `idxFK_released_userid` (`released_userid`),
	DROP INDEX `FK_TblOrdersBOM_Employees_5`,
	ADD INDEX `idxFK_cancelled_userid` (`cancelled_userid`),
	DROP INDEX `FK_TblOrdersBOM_Employees_6`,
	ADD INDEX `idxFK_paid_userid` (`paid_userid`),
	DROP INDEX `FK_TblOrdersBOM_Employees_7`,
	ADD INDEX `idxFK_DueDate_userid` (`DueDate_userid`),
	DROP INDEX `FK_TblOrdersBOM_Employees_8`,
	ADD INDEX `idxFK_CreditCardCharged_UserId` (`CreditCardCharged_UserId`),
	DROP INDEX `FK_TblOrdersBOM_Employees_9`,
	ADD INDEX `idxFK_invoiced_UserId` (`invoiced_UserId`),
	DROP INDEX `DateFinal`,
	ADD INDEX `idx_WoodFinalDate` (`WoodFinalDate`),
	DROP INDEX `FK_TblOrdersBOM_Tbl_Terms`,
	ADD INDEX `idxFK_TermsID` (`TermsID`),
	DROP INDEX `FK_TblOrdersBOM_Employees_10`,
	ADD INDEX `idxFK_NeedToQuote_userId` (`NeedToQuote_userId`),
	DROP INDEX `FK_TblOrdersBOM_Employees_Status1stFollowUp`,
	ADD INDEX `idxFK_Status1stFollowUp_userId` (`Status1stFollowUp_userId`),
	DROP INDEX `FK_TblOrdersBOM_Employees_Status2ndFollowUp`,
	ADD INDEX `idxFK_Status2ndFollowUp_userId` (`Status2ndFollowUp_userId`),
	DROP INDEX `FK_TblOrdersBOM_Employees_HighProbability`,
	ADD INDEX `idxFK_HighProbability_userId` (`HighProbability_userId`),
	DROP INDEX `FK_TblOrdersBOM_Employees_FinalFollowUp`,
	ADD INDEX `idxFK_FinalFollowUp_userId` (`FinalFollowUp_userId`),
	DROP INDEX `FK_TblOrdersBOM_ReasonLossIDaaaaaa`,
	ADD INDEX `idxFK_ReasonLossID` (`ReasonLossID`),
	DROP INDEX `FK_TblOrdersBOM_ReasonWinIDaaaaaaa`,
	ADD INDEX `idxFK_ReasonWinID` (`ReasonWinID`),
	DROP INDEX `FK_TblOrdersBOM_Employees_InitialContactMade`,
	ADD INDEX `idxFK_InitialContactMade_userId` (`InitialContactMade_userId`),
	DROP INDEX `FK_TblOrdersBOM_Employees_OrderLost`,
	ADD INDEX `idxFK_OrderLost_userId` (`OrderLost_userId`),
	DROP INDEX `FK_TblOrdersBOM_Employees_Scrubbed`,
	ADD INDEX `idxFK_Scrubbed_userid` (`Scrubbed_userid`),
	DROP INDEX `FK_TblOrdersBOM_TblPostSystemType`,
	ADD INDEX `idxFK_ProductsFilterPostSystemTypeID` (`ProductsFilterPostSystemTypeID`),
	DROP INDEX `FK_TblOrdersBOM_TblPostMountingStyle`,
	ADD INDEX `idxFK_ProductsFilterPostMountingStyleID` (`ProductsFilterPostMountingStyleID`),
	DROP INDEX `FK_TblOrdersBOM_TblPostTopStyle2`,
	ADD INDEX `idxFK_ProductsFilterPostTopStyleID` (`ProductsFilterPostTopStyleID`),
	DROP INDEX `FK_TblOrdersBOM_TblMaterial_filter_metal`,
	ADD INDEX `idxFK_ProductsFilterMetalMaterialD` (`ProductsFilterMetalMaterialD`),
	DROP INDEX `FK_TblOrdersBOM_TblMaterial_filter_wood`,
	ADD INDEX `idxFK_ProductsFilterWoodMaterialD` (`ProductsFilterWoodMaterialD`),
	DROP INDEX `idxCancelledReleasedOnHold`,
	ADD INDEX `idx_CancelledReleasedOnHold` (`Cancelled`, `Released`, `onHold`),
	DROP INDEX `idxShippingAddress`,
	ADD INDEX `idx_ShippingAddress` (`ShipCompanyName`, `ShipContactFirstName`, `ShipAddress1`, `ShipAddress2`, `ShipAddress3`, `ShipCity`, `ShipState`, `ShipPostalCode`, `BillPhoneNumber`, `BillFaxNumber`)
;
ALTER TABLE `TblOrdersBOM`
	DROP INDEX `FK_TblOrdersBOM_TblOrdersBOM_Remakes`,
	ADD INDEX `idxFK_RemakeNoteID` (`RemakeNoteID`),
	DROP INDEX `TblOrdersBOM_idx_onHold_userId`,
	ADD INDEX `idxFK_onHold_userId` (`onHold_userId`),
	DROP INDEX `TblOrdersBOM_idx_EngineeringRequired_userId`,
	ADD INDEX `idxFK_EngineeringRequired_userId` (`EngineeringRequired_userId`),
	DROP INDEX `TblOrdersBOM_idx_EngineeringComplete_userId`,
	ADD INDEX `idxFK_EngineeringComplete_userId` (`EngineeringComplete_userId`),
	DROP INDEX `FK_TblOrdersBOM_Employees_15`,
	ADD INDEX `idxFK_PaidPartially_userId` (`PaidPartially_userId`),
	DROP INDEX `FK_TblOrdersBOM_TblCountry`,
	ADD INDEX `idxFK_ShipCountryId` (`ShipCountryId`),
	DROP INDEX `FK_TblOrdersBOM_TblCountry_2`,
	ADD INDEX `idxFK_BillCountryId` (`BillCountryId`),
	DROP INDEX `FK_TblOrdersBOM_billState`,
	ADD INDEX `idxFK_BillState` (`BillState`),
	DROP INDEX `FK_TblOrdersBOM_shipState`,
	ADD INDEX `idxFK_ShipState` (`ShipState`),
	DROP INDEX `idx_CustomerSelectedVersionID`,
	ADD INDEX `idxFK_CustomerSelectedVersionID` (`CustomerSelectedVersionID`)
;



ALTER TABLE `TblOrdersBOM_ActiveVersion`
	DROP INDEX `idx_OrderID`,
	ADD UNIQUE INDEX `unqFK_OrderID` (`OrderID`),
	DROP INDEX `idx_OrderVersionID`,
	ADD UNIQUE INDEX `unqFK_OrderVersionID` (`OrderVersionID`)
;



ALTER TABLE `TblOrdersBOM_Groups`
	DROP INDEX `orderID`,
	ADD INDEX `idxFK__unused_OrderID` (`_unused_OrderID`),
	DROP INDEX `idx_OrderVersionID`,
	ADD INDEX `idxFK_OrderVersionID` (`OrderVersionID`)
;



ALTER TABLE `TblOrdersBOM_Items`
	DROP INDEX `TblOrdersBOM_Items49`,

	DROP INDEX `FK_TblOrdersBOM_Items_FinishOption`,
	ADD INDEX `idxFK_FinishOptionID` (`FinishOptionID`),
	DROP INDEX `TblOrdersBOM_Items19`,
	ADD INDEX `idx__unused_OrderIDQuantityOrderItem` (`_unused_OrderID`, `QuantityOrdered`, `QuantityShipped`, `OrderItemName`, `OrderItemDescription`(255)),
	DROP INDEX `FK_TblOrdersBOM_Items_TblOrdersBOM_Faults`,
	ADD INDEX `idxFK__unused_ExceptionFaultId` (`_unused_ExceptionFaultId`),
	DROP INDEX `FK_TblOrdersBOM_Items_Employees`,
	ADD INDEX `idxFK__unused_ExceptionFaultEmployeeId` (`_unused_ExceptionFaultEmployeeId`),
	DROP INDEX `idx_ProductID`,
	ADD INDEX `idxFK_ProductID` (`ProductID`),
	DROP INDEX `idx_OrderID`,
	ADD INDEX `idxFK__unused_OrderID` (`_unused_OrderID`),
	DROP INDEX `idx_ExceptionId`,
	ADD INDEX `idxFK_ExceptionId` (`ExceptionId`),
	DROP INDEX `idx_PRC_EmployeeID`,
	ADD INDEX `idxFK__unused_PRC_EmployeeID` (`_unused_PRC_EmployeeID`),
	DROP INDEX `idx_Final_EmployeeID`,
	ADD INDEX `idxFK__unused_Final_EmployeeID` (`_unused_Final_EmployeeID`),
	DROP INDEX `idx_Prefinishing_Complete_EmployeeID`,
	ADD INDEX `idxFK__unused_Prefinishing_Complete_EmployeeID` (`_unused_Prefinishing_Complete_EmployeeID`),
	DROP INDEX `idx_ExceptionOpened_EmployeeID`,
	ADD INDEX `idxFK_ExceptionOpened_EmployeeID` (`ExceptionOpened_EmployeeID`),
	DROP INDEX `idx_ExceptionClosed_EmployeeID`,
	ADD INDEX `idxFK_ExceptionClosed_EmployeeID` (`ExceptionClosed_EmployeeID`),
	DROP INDEX `idx_OrderID_ProductID`,
	ADD INDEX `idx__unused_OrderID_ProductID` (`_unused_OrderID`, `ProductID`),
	DROP INDEX `idx_GroupID`,
	ADD INDEX `idxFK_GroupID` (`GroupID`),
	DROP INDEX `idx_OrderVersionID`,
	ADD INDEX `idxFK_OrderVersionID` (`OrderVersionID`),
	DROP INDEX `FK_TblOrdersBOM_Items_Employees_6`,
	ADD INDEX `idxFK__unused_Started_EmployeeID` (`_unused_Started_EmployeeID`),
	DROP INDEX `FK_TblOrdersBOM_Items_TblOrdersBOM_Items`,
	ADD INDEX `idxFK_AutoSuggestionParentID` (`AutoSuggestionParentID`)
;



ALTER TABLE `TblOrdersBOM_ItemsInclude`
	DROP INDEX `Index 4`,
	ADD UNIQUE INDEX `unqFK_OrderItemsID_BundleProductID` (`OrderItemsID`, `BundledProductID`),
	DROP INDEX `FK_TblOrdersBOM_ItemsInclude_Products`,
	ADD INDEX `idxFK_BundledProductID` (`BundledProductID`)
;
ALTER TABLE `TblOrdersBOM_ItemsSteps`
	DROP INDEX `OrderItemsID`,
	ADD INDEX `idxFK_OrderItemsID` (`OrderItemsID`),
	DROP INDEX `employeeID`,
	ADD INDEX `idxFK_EmployeeID` (`EmployeeID`)
;

ALTER TABLE `TblOrdersBOM_Note`
	DROP INDEX `FK_TblOrdersBOM_Note_TblOrdersBOM`,
	ADD INDEX `idxFK_OrderID` (`OrderID`),
	DROP INDEX `FK_TblOrdersBOM_Note_Employees`,
	ADD INDEX `idxFK_EmployeeID` (`EmployeeID`)
;

ALTER TABLE `TblOrdersBOM_RelatedOrders`
	DROP INDEX `idxRelatedGroupNumber`,
	ADD INDEX `idx_RelatedGroupNumber` (`RelatedGroupNumber`)
;
ALTER TABLE `TblOrdersBOM_SalesFile`
	DROP INDEX `idxTblOrdersBOM_SalesFile_UniqueFilerPerOrder`,
	ADD UNIQUE INDEX `unq_OrderID_SalesFileID` (`OrderID`, `SalesFileID`),
	DROP INDEX `FK_TblOrdersBOM_SalesFile_TblSalesFile`,
	ADD INDEX `idxSalesFileID` (`SalesFileID`)
;
ALTER TABLE `TblOrdersBOM_SentEmail`
	DROP INDEX `FK_TblOrdersBOM_CustomerEmail_TblOrdersBOM`,
	ADD INDEX `idxFK_d_order_id` (`d_order_id`),
	DROP INDEX `FK_TblOrdersBOM_CustomerEmail_Employees`,
	ADD INDEX `idxFK_d_employee_id` (`d_employee_id`)
;
ALTER TABLE `TblOrdersBOM_SentEmailFile`
	DROP INDEX `FK_TblOrdersBOM_CustomerEmailFile_TblOrdersBOM_CustomerEmail`,
	ADD INDEX `idxFK_d_send_email_id` (`d_sent_email_id`)
;


ALTER TABLE `TblOrdersBOM_Shipments`
	DROP INDEX `TblOrdersBOM_ShipmentsItems_idx4`,
	ADD UNIQUE INDEX `unq_ShipmentNumber` (`ShipmentNumber`),
	DROP INDEX `TblOrdersBOM_ShipmentsItems_idx`,
	ADD INDEX `idxFK_OrderID` (`OrderID`),
	DROP INDEX `TblOrdersBOM_ShipmentsItems_idx2`,
	ADD INDEX `idxFK_ShippingMethodID` (`ShippingMethodID`),
	DROP INDEX `idx_pulled_by_id`,
	ADD INDEX `idxFK_Pulled_by_id` (`pulled_by_id`),
	DROP INDEX `idx_packaged_by_id`,
	ADD INDEX `idxFK_packaged_by_id` (`packaged_by_id`),
	DROP INDEX `idx_processed_by_id`,
	ADD INDEX `idxFK_processed_by_id` (`processed_by_id`)
;
ALTER TABLE `TblOrdersBOM_ShipmentsItems`
	DROP INDEX `TblOrdersBOM_ShipmentsItems_idx`,
	ADD INDEX `idxFK_OrderShipment_id` (`OrderShipment_id`),
	DROP INDEX `TblOrdersBOM_ShipmentsItems_idx2`,
	ADD INDEX `idxFK_OrderItemsID` (`OrderItemsID`)
;


ALTER TABLE `TblOrdersBOM_Transactions`
	DROP INDEX `FK_TblOrdersBOM_Transactions_OrderID_idx`,
	ADD INDEX `idxFK_OrderID` (`OrderID`)
;
ALTER TABLE `TblOrdersBOM_Transactions_Accounting`
	DROP INDEX `FK_OrdersTransaction_TransactionAccounting_ID_idx`,
	ADD INDEX `idxFK_OrderTransactionID` (`OrderTransactionID`),
	DROP INDEX `FK_TblOrdersBOM_Transactions_Accounting_Type`,
	ADD INDEX `idxFK_ProductTypeAccountingTypeID` (`ProductTypeAccountingTypeID`)
;
ALTER TABLE `TblOrdersBOM_Version`
	DROP INDEX `idx_OrderID`,
	ADD INDEX `idxFK_OrderID` (`OrderID`)
;



ALTER TABLE `TblPostMountingStyle`
	DROP INDEX `unqName`,
	ADD UNIQUE INDEX `unq_Name` (`Name`)
;
ALTER TABLE `TblPostSystemType`
	DROP INDEX `unqName`,
	ADD UNIQUE INDEX `unq_Name` (`Name`)
;
ALTER TABLE `TblPostTopStyle2`
	DROP INDEX `unqName`,
	ADD UNIQUE INDEX `unq_Name` (`Name`)
;



ALTER TABLE `TblProducts`
	DROP INDEX `idx_ProductType_id`,
	ADD INDEX `idxFK_ProductType_id` (`ProductType_id`),
	DROP INDEX `idx_Product_Descripton`,
	ADD INDEX `idx_ProductDescription` (`ProductDescription`(255)),
	DROP INDEX `idx_Vendor_ID`,
	ADD INDEX `idxFK_Vendor_ID` (`Vendor_ID`),
	DROP INDEX `idx_CompanyID`,
	ADD INDEX `idxFK_CompanyID` (`CompanyID`),
	DROP INDEX `idx_BoardFootageEmployee`,
	ADD INDEX `idxFK_BoardFootageEmployee` (`BoardFootage_EmployeeID`),
	DROP INDEX `FK_Products_FinishOption`,
	ADD INDEX `idxFK_DefaultFinishOptionID` (`DefaultFinishOptionID`),
	DROP INDEX `idx_WoodTypeID`,
	ADD INDEX `idxFK_MaterialID` (`MaterialID`),
	DROP INDEX `FK_Products_TblPurchaseDepartment`,
	ADD INDEX `idxFK_PurchasingDepartmentID` (`PurchasingDepartmentID`),
	DROP INDEX `idxMaterialSizeID`,
	ADD INDEX `idxFK_MaterialSizeID` (`MaterialSizeID`),
	DROP INDEX `idx_PostTopStyleID`,
	ADD INDEX `idxFK_PostTopStyleID` (`PostTopStyleID`),
	DROP INDEX `idx_PostFootStyleID`,
	ADD INDEX `idxFK_PostFootStyleID` (`PostFootStyleID`),
	DROP INDEX `FK_Products_TblPurchaseAccount`,
	ADD INDEX `idxFK_PurchasingAccountID` (`PurchasingAccountID`)
;
ALTER TABLE `TblProductsAutoSuggest`
	DROP INDEX `Index 3`,
	ADD UNIQUE INDEX `unq_ProductID_ProductSuggestionID` (`ProductID`, `ProductSuggestionID`),
	DROP INDEX `Index 4`,
	ADD UNIQUE INDEX `unq_ProductID_GroupSuggestionID` (`ProductID`, `GroupSuggestionID`),
	DROP INDEX `ProductsAutoSuggest_ProductSuggestionID`,
	ADD INDEX `idxFK_ProductSuggestionID` (`ProductSuggestionID`),
	DROP INDEX `FK_ProductsAutoSuggest_ProductsAutoSuggestGroup`,
	ADD INDEX `idxFK_GroupSuggestionID` (`GroupSuggestionID`)
;

ALTER TABLE `TblProductsAutoSuggestGroupProduct`
	DROP INDEX `FK_ProductsAutoSuggestGroupProduct_Products`,
	ADD INDEX `idxFK_ProductID` (`ProductID`)
;
ALTER TABLE `TblProductsInclude`
	DROP INDEX `FK__Products_2`,
	ADD INDEX `idxFK_IncludedProductID` (`IncludedProductID`)
;
ALTER TABLE `TblProductType`
	DROP INDEX `FK_TblProductType_TblProductTypeType`,
	ADD INDEX `idxFK_AccountingTypeID` (`AccountingTypeID`),
	DROP INDEX `FK_TblProductType_TblProductTypeProductionType`,
	ADD INDEX `idxFK_ProductionTypeID` (`ProductionTypeID`),
	DROP INDEX `FK_TblProductType_TblProductTypeGroup`,
	ADD INDEX `idxFK_TypeGroupID` (`TypeGroupID`),
	DROP INDEX `FK_TblProductType_TblProductTypeGroupAdditional`,
	ADD INDEX `idxFK_AdditionalTypeGroupID` (`AdditionalTypeGroupID`),
	DROP INDEX `FK_TblProductType_TblPostSystemType`,
	ADD INDEX `idxFK_PostSystemTypeID` (`PostSystemTypeID`),
	DROP INDEX `FK_TblProductType_TblPostMountingStyle`,
	ADD INDEX `idxFK_PostMountingStyleID` (`PostMountingStyleID`),
	DROP INDEX `FK_TblProductType_TblPostTopStyle2`,
	ADD INDEX `idxFK_PostTopStyleID` (`PostTopStyleID`)
;
ALTER TABLE `TblProductTypeGroup`
	DROP INDEX `unqTitle`,
	ADD UNIQUE INDEX `unq_Title` (`Title`),
	DROP INDEX `FK_TblProductTypeGroup_parent`,
	ADD INDEX `idxFK_ParentGroupID` (`ParentGroupID`)
;
ALTER TABLE `TblPurchaseAccount`
	DROP INDEX `idxAccountTitle`,
	ADD UNIQUE INDEX `unq_AccountTitle` (`AccountTitle`)
;
ALTER TABLE `TblPurchaseDepartment`
	DROP INDEX `idxName`,
	ADD UNIQUE INDEX `unq_Name` (`Name`)
;
ALTER TABLE `TblPurchaseOrder`
	DROP INDEX `FK__TBLVendor`,
	ADD INDEX `idxFK_VendorID` (`vendorID`),
	DROP INDEX `FK_TblPurchaseOrder_Employees`,
	ADD INDEX `idxFK_RequestedByEmployeeID` (`RequestedByEmployeeID`),
	DROP INDEX `idxShippingLocationID`,
	ADD INDEX `idxFK_ShippingLocationID` (`ShippingLocationID`)
;

ALTER TABLE `TblPurchaseOrderEmail`
	DROP INDEX `FK__TblPurchaseOrder`,
	ADD INDEX `idxFK_PurchaseOrderID` (`PurchaseOrderID`)
;

ALTER TABLE `TblPurchaseOrderItem`
	DROP INDEX `idx_PreventDuplicateProducts`,
	ADD UNIQUE INDEX `unq_PreventDuplicateProducts` (`PurchaseOrderID`, `ProductID`),
	DROP INDEX `FK_TblPurchaseOrderItem_TblPurchaseOrder`,
	ADD INDEX `idxFK_PurchaseOrderID` (`PurchaseOrderID`),
	DROP INDEX `FK_TblPurchaseOrderItem_Products`,
	ADD INDEX `idxFK_ProductID` (`ProductID`),
	DROP INDEX `FK_TblPurchaseOrderItem_AccountID`,
	ADD INDEX `idxFK_AccountID` (`AccountID`)
;
ALTER TABLE `TblPurchaseOrderReceive`
	DROP INDEX `FK_TblPurchaseOrderReceive_TblPurchaseOrder`,
	ADD INDEX `idxFK_PurchaseOrderID` (`PurchaseOrderID`)
;

ALTER TABLE `TblPurchaseOrderReceiveItem`
	DROP INDEX `FK_TblPurchaseOrderReceiveItem_TblPurchaseOrderReceive`,
	ADD INDEX `idxFK_PurchaseOrderReceiveID` (`PurchaseOrderReceiveID`),
	DROP INDEX `FK_TblPurchaseOrderReceiveItem_TblPurchaseOrderItem`,
	ADD INDEX `idxFK_PurchaseOrderItemID` (`PurchaseOrderItemID`)
;
ALTER TABLE `TblPurchaseRequestOneTimePart`
	DROP INDEX `idxEmployee`,
	ADD INDEX `idxFK_EmployeeID` (`EmployeeID`)
;
ALTER TABLE `TblPurchaseRequestPart`
	DROP INDEX `FK_TblPurchaseOrderRequestProduct_Products`,
	ADD INDEX `idxFK_ProductID` (`ProductID`),
	DROP INDEX `FK_TblPurchaseOrderRequestProduct_Employees`,
	ADD INDEX `idxFK_EmployeeID` (`EmployeeID`)
;





ALTER TABLE `tbl_settings_per_company`
	DROP INDEX `tbl_settings_idx`,
	ADD INDEX `idxFK_d_company_id` (`d_company_id`)
;

ALTER TABLE `TblVendor`
	DROP INDEX `IX_Vendor_1`
;
ALTER TABLE `TblState`
	DROP INDEX `TblState_idx`,
	ADD INDEX `idxFK_CountryID` (`CountryId`)
;
ALTER TABLE `TblSalesFile`
	DROP INDEX `FK_TblSalesFile_TblSalesFileGroup`,
	ADD INDEX `idxFK_groupID` (`groupID`)
;
ALTER TABLE `TblRGAStatus`
	DROP INDEX `idxEmployee`,
	ADD INDEX `idxFK_d_employee_id` (`d_employee_id`),
	DROP INDEX `idxRequest`,
	ADD INDEX `idxFK_d_rga_request_id` (`d_rga_request_id`),
	DROP INDEX `idxStage`,
	ADD INDEX `idxFK_d_stage_id` (`d_stage_id`)
;
ALTER TABLE `TblRGARequest`
	DROP INDEX `d_rga_number`,
	ADD UNIQUE INDEX `uqn_preventDuplicateRGA` (`d_rga_number`),
	DROP INDEX `tblRGARequest_idx`,
	ADD INDEX `idxFK_d_return_reason_id` (`d_return_reason_id`)
;
ALTER TABLE `TblRGAProduct`
	DROP INDEX `tblRGAProduct_idx`,
	ADD INDEX `idxFK_d_rga_request_id` (`d_rga_request_id`)
;
