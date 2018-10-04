ALTER TABLE `tbl_settings_per_company`
	DROP FOREIGN KEY `tbl_settings_fk`;
ALTER TABLE `tbl_settings_per_company`
	ADD CONSTRAINT `FK_tbl_settings_per_company_d_company_id` FOREIGN KEY (`d_company_id`) REFERENCES `TblCompany` (`CompanyID`) ON UPDATE NO ACTION ON DELETE NO ACTION
;


ALTER TABLE `TblState`
	DROP FOREIGN KEY `TblState_fk`;
ALTER TABLE `TblState`
	ADD CONSTRAINT `FK_TblState_CountryID` FOREIGN KEY (`CountryId`) REFERENCES `TblCountry` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION
;


ALTER TABLE `TblSalesFile`
	DROP FOREIGN KEY `FK_TblSalesFile_TblSalesFileGroup`;
ALTER TABLE `TblSalesFile`
	ADD CONSTRAINT `FK_TblSalesFile_GroupID` FOREIGN KEY (`groupID`) REFERENCES `TblSalesFileGroup` (`id`)
;


ALTER TABLE `TblRGAStatus`
	DROP FOREIGN KEY `FK_tblRGAStatus_Employees`,
	DROP FOREIGN KEY `FK_tblRGAStatus_tblRGARequest`,
	DROP FOREIGN KEY `FK_tblRGAStatus_tblRGAStage`;
ALTER TABLE `TblRGAStatus`
	ADD CONSTRAINT `FK_TblRGAStatus_d_employee_id` FOREIGN KEY (`d_employee_id`) REFERENCES `TblEmployee` (`EmployeeID`) ON UPDATE NO ACTION ON DELETE NO ACTION,
	ADD CONSTRAINT `FK_TblRGAStatus_d_rga_request_id` FOREIGN KEY (`d_rga_request_id`) REFERENCES `TblRGARequest` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION,
	ADD CONSTRAINT `FK_TblRGAStatus_d_stage_id` FOREIGN KEY (`d_stage_id`) REFERENCES `TblRGAStage` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION
;


ALTER TABLE `TblRGARequest`
	DROP FOREIGN KEY `FK_tblRGARequest_tblRGAReturnReason`;
ALTER TABLE `TblRGARequest`
	ADD CONSTRAINT `FK_TblRGARequest_d_return_reason_id` FOREIGN KEY (`d_return_reason_id`) REFERENCES `TblRGAReturnReason` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION
;


ALTER TABLE `TblRGAProduct`
	DROP FOREIGN KEY `FK_tblRGAProduct_tblRGARequest`;
ALTER TABLE `TblRGAProduct`
	ADD CONSTRAINT `FK_TblRGAProduct_d_rga_request_id` FOREIGN KEY (`d_rga_request_id`) REFERENCES `TblRGARequest` (`id`) ON UPDATE NO ACTION ON DELETE CASCADE
;


ALTER TABLE `TblPurchaseRequestPart`
	DROP FOREIGN KEY `FK_TblPurchaseOrderRequestProduct_Employees`,
	DROP FOREIGN KEY `FK_TblPurchaseOrderRequestProduct_Products`;
ALTER TABLE `TblPurchaseRequestPart`
	ADD CONSTRAINT `FK_TblPurchaseRequestPart_EmployeeID` FOREIGN KEY (`EmployeeID`) REFERENCES `TblEmployee` (`EmployeeID`),
	ADD CONSTRAINT `FK_TblPurchaseRequestPart_ProductID` FOREIGN KEY (`ProductID`) REFERENCES `TblProducts` (`ProductID`)
;
ALTER TABLE `TblPurchaseRequestOneTimePart`
	DROP FOREIGN KEY `FK_TblPurchaseOneTimePartRequest_Employees`;
ALTER TABLE `TblPurchaseRequestOneTimePart`
	ADD CONSTRAINT `FK_TblPurchaseRequestOneTimePart_EmployeeID` FOREIGN KEY (`EmployeeID`) REFERENCES `TblEmployee` (`EmployeeID`)
;


ALTER TABLE `TblPurchaseOrderReceiveItem`
	DROP FOREIGN KEY `FK_TblPurchaseOrderReceiveItem_TblPurchaseOrderItem`,
	DROP FOREIGN KEY `FK_TblPurchaseOrderReceiveItem_TblPurchaseOrderReceive`;
ALTER TABLE `TblPurchaseOrderReceiveItem`
	ADD CONSTRAINT `FK_TblPurchaseOrderReceiveItem_PurchaseOrderItemID` FOREIGN KEY (`PurchaseOrderItemID`) REFERENCES `TblPurchaseOrderItem` (`id`),
	ADD CONSTRAINT `FK_TblPurchaseOrderReceiveItem_PurchaseOrderReceiveID` FOREIGN KEY (`PurchaseOrderReceiveID`) REFERENCES `TblPurchaseOrderReceive` (`id`) ON DELETE CASCADE
;


ALTER TABLE `TblPurchaseOrderReceive`
	DROP FOREIGN KEY `FK_TblPurchaseOrderReceive_TblPurchaseOrder`;
ALTER TABLE `TblPurchaseOrderReceive`
	ADD CONSTRAINT `FK_TblPurchaseOrderReceive_PurchaseOrderID` FOREIGN KEY (`PurchaseOrderID`) REFERENCES `TblPurchaseOrder` (`id`)
;


ALTER TABLE `TblPurchaseOrderItem`
	DROP FOREIGN KEY `FK_TblPurchaseOrderItem_Products`,
	DROP FOREIGN KEY `FK_TblPurchaseOrderItem_TblPurchaseOrder`;
ALTER TABLE `TblPurchaseOrderItem`
	ADD CONSTRAINT `FK_TblPurchaseOrderItem_ProductID` FOREIGN KEY (`ProductID`) REFERENCES `TblProducts` (`ProductID`),
	ADD CONSTRAINT `FK_TblPurchaseOrderItem_PurchaseOrderID` FOREIGN KEY (`PurchaseOrderID`) REFERENCES `TblPurchaseOrder` (`id`)
;


ALTER TABLE `TblPurchaseOrderEmail`
	DROP FOREIGN KEY `FK__TblPurchaseOrder`;
ALTER TABLE `TblPurchaseOrderEmail`
	ADD CONSTRAINT `FK_TblPurchaseOrderEmail_PurchaseOrderID` FOREIGN KEY (`PurchaseOrderID`) REFERENCES `TblPurchaseOrder` (`id`)
;


ALTER TABLE `TblPurchaseOrder`
	DROP FOREIGN KEY `FK_TblPurchaseOrder_Employees`,
	DROP FOREIGN KEY `FK_TblPurchaseOrder_TblCompanyLocation`,
	DROP FOREIGN KEY `FK__TBLVendor`;
ALTER TABLE `TblPurchaseOrder`
	ADD CONSTRAINT `FK_TblPurchaseOrder_RequestedByEmployeeID` FOREIGN KEY (`RequestedByEmployeeID`) REFERENCES `TblEmployee` (`EmployeeID`),
	ADD CONSTRAINT `FK_TblPurchaseOrder_ShippingLocationID` FOREIGN KEY (`ShippingLocationID`) REFERENCES `TblCompanyLocation` (`LocationID`) ON UPDATE NO ACTION ON DELETE NO ACTION,
	ADD CONSTRAINT `FK_TblPurchaseOrder_vendorID` FOREIGN KEY (`vendorID`) REFERENCES `TblVendor` (`Vendor_ID`)
;


ALTER TABLE `TblProductTypeGroup`
	DROP FOREIGN KEY `FK_TblProductTypeGroup_parent`;
ALTER TABLE `TblProductTypeGroup`
	ADD CONSTRAINT `FK_TblProductTypeGroup_ParentGroupID` FOREIGN KEY (`ParentGroupID`) REFERENCES `TblProductTypeGroup` (`ProductTypeGroupID`) ON UPDATE NO ACTION ON DELETE NO ACTION
;


ALTER TABLE `TblProductType`
	DROP FOREIGN KEY `FK_TblProductType_TblPostMountingStyle`,
	DROP FOREIGN KEY `FK_TblProductType_TblPostSystemType`,
	DROP FOREIGN KEY `FK_TblProductType_TblPostTopStyle2`,
	DROP FOREIGN KEY `FK_TblProductType_TblProductTypeGroup`,
	DROP FOREIGN KEY `FK_TblProductType_TblProductTypeGroupAdditional`,
	DROP FOREIGN KEY `FK_TblProductType_TblProductTypeProductionType`,
	DROP FOREIGN KEY `FK_TblProductType_TblProductTypeType`;
ALTER TABLE `TblProductType`
	ADD CONSTRAINT `FK_TblProductType_PostMountingStyleID` FOREIGN KEY (`PostMountingStyleID`) REFERENCES `TblPostMountingStyle` (`PostMountingStyleID`) ON UPDATE NO ACTION ON DELETE NO ACTION,
	ADD CONSTRAINT `FK_TblProductType_PostSystemTypeID` FOREIGN KEY (`PostSystemTypeID`) REFERENCES `TblPostSystemType` (`PostSystemTypeID`) ON UPDATE NO ACTION ON DELETE NO ACTION,
	ADD CONSTRAINT `FK_TblProductType_PostTopStyleID` FOREIGN KEY (`PostTopStyleID`) REFERENCES `TblPostTopStyle2` (`PostTopStyleID`) ON UPDATE NO ACTION ON DELETE NO ACTION,
	ADD CONSTRAINT `FK_TblProductType_TypeGroupID` FOREIGN KEY (`TypeGroupID`) REFERENCES `TblProductTypeGroup` (`ProductTypeGroupID`) ON UPDATE NO ACTION ON DELETE NO ACTION,
	ADD CONSTRAINT `FK_TblProductType_AdditionalTypeGroupID` FOREIGN KEY (`AdditionalTypeGroupID`) REFERENCES `TblProductTypeGroup` (`ProductTypeGroupID`) ON UPDATE NO ACTION ON DELETE NO ACTION,
	ADD CONSTRAINT `FK_TblProductType_ProductionTypeID` FOREIGN KEY (`ProductionTypeID`) REFERENCES `TblProductTypeProductionType` (`id`),
	ADD CONSTRAINT `FK_TblProductType_AccountingTypeID` FOREIGN KEY (`AccountingTypeID`) REFERENCES `TblProductTypeAccountingType` (`id`)
;


ALTER TABLE `TblProductsInclude`
	DROP FOREIGN KEY `FK__Products`,
	DROP FOREIGN KEY `FK__Products_2`;
ALTER TABLE `TblProductsInclude`
	ADD CONSTRAINT `FK_TblProductsInclude_ParentProductID` FOREIGN KEY (`ParentProductID`) REFERENCES `TblProducts` (`ProductID`) ON DELETE CASCADE,
	ADD CONSTRAINT `FK_TblProductsInclude_IncludedProductID` FOREIGN KEY (`IncludedProductID`) REFERENCES `TblProducts` (`ProductID`)
;


ALTER TABLE `TblProductsAutoSuggestGroupProduct`
	DROP FOREIGN KEY `FK_ProductsAutoSuggestGroupProduct_Products`,
	DROP FOREIGN KEY `FK_ProductsAutoSuggestGroupProduct_ProductsAutoSuggestGroup`;
ALTER TABLE `TblProductsAutoSuggestGroupProduct`
	ADD CONSTRAINT `FK_TblProductsAutoSuggestGroupProduct_ProductID` FOREIGN KEY (`ProductID`) REFERENCES `TblProducts` (`ProductID`),
	ADD CONSTRAINT `FK_TblProductsAutoSuggestGroupProduct_GroupID` FOREIGN KEY (`GroupID`) REFERENCES `TblProductsAutoSuggestGroup` (`id`)
;


ALTER TABLE `TblProductsAutoSuggest`
	DROP FOREIGN KEY `FK_ProductsAutoSuggest_ProductsAutoSuggestGroup`,
	DROP FOREIGN KEY `TblProductsAutoSuggest_ibfk_1`,
	DROP FOREIGN KEY `TblProductsAutoSuggest_ibfk_2`;
ALTER TABLE `TblProductsAutoSuggest`
	ADD CONSTRAINT `FK_TblProductsAutoSuggest_GroupSuggestionID` FOREIGN KEY (`GroupSuggestionID`) REFERENCES `TblProductsAutoSuggestGroup` (`id`),
	ADD CONSTRAINT `FK_TblProductsAutoSuggest_ProductID` FOREIGN KEY (`ProductID`) REFERENCES `TblProducts` (`ProductID`),
	ADD CONSTRAINT `FK_TblProductsAutoSuggest_ProductSuggestionID` FOREIGN KEY (`ProductSuggestionID`) REFERENCES `TblProducts` (`ProductID`)
;


ALTER TABLE `TblProducts`
	DROP FOREIGN KEY `FK_Products_Employees`,
	DROP FOREIGN KEY `FK_Products_FinishOption`,
	DROP FOREIGN KEY `FK_Products_TBLVendor`,
	DROP FOREIGN KEY `FK_Products_TblPostFootStyle`,
	DROP FOREIGN KEY `FK_Products_TblPostTopStyle`,
	DROP FOREIGN KEY `FK_Products_TblPurchaseAccount`,
	DROP FOREIGN KEY `FK_Products_TblPurchaseDepartment`,
	DROP FOREIGN KEY `FK_Products_tbl_lumber_type`,
	DROP FOREIGN KEY `Products_fk_Material`,
	DROP FOREIGN KEY `Products_fk_ProductType`,
	DROP FOREIGN KEY `Products_fk_company`;
ALTER TABLE `TblProducts`
	ADD CONSTRAINT `FK_TblProducts_BoardFootage_EmployeeID` FOREIGN KEY (`BoardFootage_EmployeeID`) REFERENCES `TblEmployee` (`EmployeeID`) ON UPDATE NO ACTION ON DELETE NO ACTION,
	ADD CONSTRAINT `FK_TblProducts_DefaultFinishOptionID` FOREIGN KEY (`DefaultFinishOptionID`) REFERENCES `TblFinishOption` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION,
	ADD CONSTRAINT `FK_TblProducts_Vendor_ID` FOREIGN KEY (`Vendor_ID`) REFERENCES `TblVendor` (`Vendor_ID`) ON UPDATE NO ACTION ON DELETE NO ACTION,
	ADD CONSTRAINT `FK_TblProducts_PostFootStyleID` FOREIGN KEY (`PostFootStyleID`) REFERENCES `TblPostFootStyle` (`PostFootStyleID`) ON UPDATE NO ACTION ON DELETE NO ACTION,
	ADD CONSTRAINT `FK_TblProducts_PostTopStyleID` FOREIGN KEY (`PostTopStyleID`) REFERENCES `TblPostTopStyle` (`PostTopStyleID`) ON UPDATE NO ACTION ON DELETE NO ACTION,
	ADD CONSTRAINT `FK_TblProducts_PurchasingAccountID` FOREIGN KEY (`PurchasingAccountID`) REFERENCES `TblPurchaseAccount` (`PurchaseAccountID`) ON UPDATE NO ACTION ON DELETE NO ACTION,
	ADD CONSTRAINT `FK_TblProducts_PurchasingDepartmentID` FOREIGN KEY (`PurchasingDepartmentID`) REFERENCES `TblPurchaseDepartment` (`id`),
	ADD CONSTRAINT `FK_TblProducts_MaterialSizeID` FOREIGN KEY (`MaterialSizeID`) REFERENCES `TblMaterialSize` (`id`),
	ADD CONSTRAINT `FK_TblProducts_MaterialID` FOREIGN KEY (`MaterialID`) REFERENCES `TblMaterial` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION,
	ADD CONSTRAINT `FK_TblProducts_ProductType_id` FOREIGN KEY (`ProductType_id`) REFERENCES `TblProductType` (`ProductType_id`) ON UPDATE NO ACTION ON DELETE NO ACTION,
	ADD CONSTRAINT `FK_TblProducts_CompanyID` FOREIGN KEY (`CompanyID`) REFERENCES `TblCompany` (`CompanyID`) ON UPDATE NO ACTION ON DELETE NO ACTION
;


ALTER TABLE `TblOrdersBOM_Version`
	DROP FOREIGN KEY `FK_TblOrdersBOM_Version_TblOrdersBOM`;
ALTER TABLE `TblOrdersBOM_Version`
	ADD CONSTRAINT `FK_TblOrdersBOM_Version_OrderID` FOREIGN KEY (`OrderID`) REFERENCES `TblOrdersBOM` (`OrderID`) ON UPDATE NO ACTION ON DELETE NO ACTION
;


ALTER TABLE `TblOrdersBOM_Transactions_Accounting`
	DROP FOREIGN KEY `FK_OrdersTransaction_TransactionAccounting_ID`,
	DROP FOREIGN KEY `FK_TblOrdersBOM_Transactions_Accounting_Type`;
ALTER TABLE `TblOrdersBOM_Transactions_Accounting`
	ADD CONSTRAINT `FK_TblOrdersBOM_Transactions_Accounting_OrderTransactionID` FOREIGN KEY (`OrderTransactionID`) REFERENCES `TblOrdersBOM_Transactions` (`OrderTransactionID`) ON UPDATE NO ACTION ON DELETE NO ACTION,
	ADD CONSTRAINT `FK_TblOrdersBOM_Transactions_Accounting_ProductTypeAccounting` FOREIGN KEY (`ProductTypeAccountingTypeID`) REFERENCES `TblProductTypeAccountingType` (`id`)
;


ALTER TABLE `TblOrdersBOM_Transactions`
	DROP FOREIGN KEY `FK_TblOrdersBOM_Transactions_OrderID`;
ALTER TABLE `TblOrdersBOM_Transactions`
	ADD CONSTRAINT `FK_TblOrdersBOM_Transactions_OrderID` FOREIGN KEY (`OrderID`) REFERENCES `TblOrdersBOM` (`OrderID`) ON UPDATE NO ACTION ON DELETE NO ACTION
;


ALTER TABLE `TblOrdersBOM_ShipmentsItems`
	DROP FOREIGN KEY `TblOrdersBOM_ShipmentsItems_fk`,
	DROP FOREIGN KEY `TblOrdersBOM_ShipmentsItems_fk2`;
ALTER TABLE `TblOrdersBOM_ShipmentsItems`
	ADD CONSTRAINT `FK_TblOrdersBOM_ShipmentsItems_OrderShipment_id` FOREIGN KEY (`OrderShipment_id`) REFERENCES `TblOrdersBOM_Shipments` (`OrderShipment_id`) ON UPDATE NO ACTION ON DELETE CASCADE,
	ADD CONSTRAINT `FK_TblOrdersBOM_ShipmentsItems_OrderItemsID` FOREIGN KEY (`OrderItemsID`) REFERENCES `TblOrdersBOM_Items` (`OrderItemsID`) ON UPDATE NO ACTION ON DELETE NO ACTION
;


ALTER TABLE `TblOrdersBOM_Shipments`
	DROP FOREIGN KEY `FK_TblOrdersBOM_Shipments_Employees`,
	DROP FOREIGN KEY `FK_TblOrdersBOM_Shipments_Employees_2`,
	DROP FOREIGN KEY `FK_TblOrdersBOM_Shipments_Employees_3`,
	DROP FOREIGN KEY `TblOrdersBOM_OrderShipments_fk`,
	DROP FOREIGN KEY `TblOrdersBOM_OrderShipments_fk2`;
ALTER TABLE `TblOrdersBOM_Shipments`
	ADD CONSTRAINT `FK_TblOrdersBOM_Shipments_pulled_by_id` FOREIGN KEY (`pulled_by_id`) REFERENCES `TblEmployee` (`EmployeeID`),
	ADD CONSTRAINT `FK_TblOrdersBOM_Shipments_packaged_by_id` FOREIGN KEY (`packaged_by_id`) REFERENCES `TblEmployee` (`EmployeeID`),
	ADD CONSTRAINT `FK_TblOrdersBOM_Shipments_processed_by_id` FOREIGN KEY (`processed_by_id`) REFERENCES `TblEmployee` (`EmployeeID`),
	ADD CONSTRAINT `FK_TblOrdersBOM_Shipments_OrderID` FOREIGN KEY (`OrderID`) REFERENCES `TblOrdersBOM` (`OrderID`) ON UPDATE NO ACTION ON DELETE NO ACTION,
	ADD CONSTRAINT `FK_TblOrdersBOM_Shipments_ShippingMethodID` FOREIGN KEY (`ShippingMethodID`) REFERENCES `TblShippingMethods` (`ShippingMethodID`) ON UPDATE NO ACTION ON DELETE NO ACTION
;


ALTER TABLE `TblOrdersBOM_SentEmailFile`
	DROP FOREIGN KEY `FK_TblOrdersBOM_CustomerEmailFile_TblOrdersBOM_CustomerEmail`;
ALTER TABLE `TblOrdersBOM_SentEmailFile`
	ADD CONSTRAINT `FK_TblOrdersBOM_SentEmailFile_d_sent_email_id` FOREIGN KEY (`d_sent_email_id`) REFERENCES `TblOrdersBOM_SentEmail` (`id`)
;


ALTER TABLE `TblOrdersBOM_SentEmail`
	DROP FOREIGN KEY `FK_TblOrdersBOM_CustomerEmail_Employees`,
	DROP FOREIGN KEY `FK_TblOrdersBOM_CustomerEmail_TblOrdersBOM`;
ALTER TABLE `TblOrdersBOM_SentEmail`
	ADD CONSTRAINT `FK_TblOrdersBOM_SentEmail_d_employee_id` FOREIGN KEY (`d_employee_id`) REFERENCES `TblEmployee` (`EmployeeID`),
	ADD CONSTRAINT `FK_TblOrdersBOM_SentEmail_d_order_id` FOREIGN KEY (`d_order_id`) REFERENCES `TblOrdersBOM` (`OrderID`)
;


ALTER TABLE `TblOrdersBOM_SalesFile`
	DROP FOREIGN KEY `FK_TblOrdersBOM_SalesFile_TblOrdersBOM`,
	DROP FOREIGN KEY `FK_TblOrdersBOM_SalesFile_TblSalesFile`;
ALTER TABLE `TblOrdersBOM_SalesFile`
	ADD CONSTRAINT `FK_TblOrdersBOM_SalesFile_OrderID` FOREIGN KEY (`OrderID`) REFERENCES `TblOrdersBOM` (`OrderID`),
	ADD CONSTRAINT `FK_TblOrdersBOM_SalesFile_SalesFileID` FOREIGN KEY (`SalesFileID`) REFERENCES `TblSalesFile` (`id`)
;


ALTER TABLE `TblOrdersBOM_RelatedOrders`
	DROP FOREIGN KEY `FK_TblOrdersBOM_RelatedOrders_TblOrdersBOM`;
ALTER TABLE `TblOrdersBOM_RelatedOrders`
	ADD CONSTRAINT `FK_TblOrdersBOM_RelatedOrders_OrderID` FOREIGN KEY (`OrderID`) REFERENCES `TblOrdersBOM` (`OrderID`) ON UPDATE NO ACTION ON DELETE NO ACTION
;


ALTER TABLE `TblOrdersBOM_Note`
	DROP FOREIGN KEY `FK_TblOrdersBOM_Note_Employees`,
	DROP FOREIGN KEY `FK_TblOrdersBOM_Note_TblOrdersBOM`;
ALTER TABLE `TblOrdersBOM_Note`
	ADD CONSTRAINT `FK_TblOrdersBOM_Note_EmployeeID` FOREIGN KEY (`EmployeeID`) REFERENCES `TblEmployee` (`EmployeeID`),
	ADD CONSTRAINT `FK_TblOrdersBOM_Note_OrderID` FOREIGN KEY (`OrderID`) REFERENCES `TblOrdersBOM` (`OrderID`)
;


ALTER TABLE `TblOrdersBOM_ItemsSteps`
	DROP FOREIGN KEY `FK_TblOrdersBOM_ItemsHistory_TblOrdersBOM_Items`,
	DROP FOREIGN KEY `FK__TblOrdersBOM_ItemsHistory_Employees`;
ALTER TABLE `TblOrdersBOM_ItemsSteps`
	ADD CONSTRAINT `FK_TblOrdersBOM_ItemsSteps_OrderItemsID` FOREIGN KEY (`OrderItemsID`) REFERENCES `TblOrdersBOM_Items` (`OrderItemsID`),
	ADD CONSTRAINT `FK_TblOrdersBOM_ItemsSteps_EmployeeID` FOREIGN KEY (`EmployeeID`) REFERENCES `TblEmployee` (`EmployeeID`)
;


ALTER TABLE `TblOrdersBOM_ItemsInclude`
	DROP FOREIGN KEY `FK_TblOrdersBOM_ItemsInclude_Products`,
	DROP FOREIGN KEY `FK_TblOrdersBOM_ItemsInclude_TblOrdersBOM_Items`;
ALTER TABLE `TblOrdersBOM_ItemsInclude`
	ADD CONSTRAINT `FK_TblOrdersBOM_ItemsInclude_BundledProductID` FOREIGN KEY (`BundledProductID`) REFERENCES `TblProducts` (`ProductID`),
	ADD CONSTRAINT `FK_TblOrdersBOM_ItemsInclude_OrderItemsID` FOREIGN KEY (`OrderItemsID`) REFERENCES `TblOrdersBOM_Items` (`OrderItemsID`)
;


ALTER TABLE `TblOrdersBOM_Items`
	DROP FOREIGN KEY `FK_TblOrdersBOM_Items_Employees_4`,
	DROP FOREIGN KEY `FK_TblOrdersBOM_Items_Employees_5`,
	DROP FOREIGN KEY `FK_TblOrdersBOM_Items_FinishOption`,
	DROP FOREIGN KEY `FK_TblOrdersBOM_Items_Products`,
	DROP FOREIGN KEY `FK_TblOrdersBOM_Items_TblOrdersBOM_Exceptions`,
	DROP FOREIGN KEY `FK_TblOrdersBOM_Items_TblOrdersBOM_Groups`,
	DROP FOREIGN KEY `FK_TblOrdersBOM_Items_TblOrdersBOM_Items`,
	DROP FOREIGN KEY `FK_TblOrdersBOM_Items_TblOrdersBOM_Version`;
ALTER TABLE `TblOrdersBOM_Items`
	ADD CONSTRAINT `FK_TblOrdersBOM_Items_ExceptionOpened_EmployeeID` FOREIGN KEY (`ExceptionOpened_EmployeeID`) REFERENCES `TblEmployee` (`EmployeeID`),
	ADD CONSTRAINT `FK_TblOrdersBOM_Items_ExceptionClosed_EmployeeID` FOREIGN KEY (`ExceptionClosed_EmployeeID`) REFERENCES `TblEmployee` (`EmployeeID`),
	ADD CONSTRAINT `FK_TblOrdersBOM_Items_FinishOptionID` FOREIGN KEY (`FinishOptionID`) REFERENCES `TblFinishOption` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION,
	ADD CONSTRAINT `FK_TblOrdersBOM_Items_ProductID` FOREIGN KEY (`ProductID`) REFERENCES `TblProducts` (`ProductID`) ON UPDATE NO ACTION ON DELETE NO ACTION,
	ADD CONSTRAINT `FK_TblOrdersBOM_Items_ExceptionId` FOREIGN KEY (`ExceptionId`) REFERENCES `TblOrdersBOM_Exceptions` (`id`),
	ADD CONSTRAINT `FK_TblOrdersBOM_Items_GroupID` FOREIGN KEY (`GroupID`) REFERENCES `TblOrdersBOM_Groups` (`groupID`),
	ADD CONSTRAINT `FK_TblOrdersBOM_Items_AutoSuggestionParentID` FOREIGN KEY (`AutoSuggestionParentID`) REFERENCES `TblOrdersBOM_Items` (`OrderItemsID`),
	ADD CONSTRAINT `FK_TblOrdersBOM_Items_OrderVersionID` FOREIGN KEY (`OrderVersionID`) REFERENCES `TblOrdersBOM_Version` (`OrderVersionID`) ON UPDATE NO ACTION ON DELETE CASCADE
;


ALTER TABLE `TblOrdersBOM_Groups`
	DROP FOREIGN KEY `FK_TblOrdersBOM_Groups_TblOrdersBOM_Version`;
ALTER TABLE `TblOrdersBOM_Groups`
	ADD CONSTRAINT `FK_TblOrdersBOM_Groups_OrderVersionID` FOREIGN KEY (`OrderVersionID`) REFERENCES `TblOrdersBOM_Version` (`OrderVersionID`) ON UPDATE NO ACTION ON DELETE CASCADE
;


ALTER TABLE `TblOrdersBOM_ActiveVersion`
	DROP FOREIGN KEY `FK_TblOrdersBOM_ActiveVersion_TblOrdersBOM`,
	DROP FOREIGN KEY `FK_TblOrdersBOM_ActiveVersion_TblOrdersBOM_Version`;
ALTER TABLE `TblOrdersBOM_ActiveVersion`
	ADD CONSTRAINT `FK_TblOrdersBOM_ActiveVersion_OrderID` FOREIGN KEY (`OrderID`) REFERENCES `TblOrdersBOM` (`OrderID`) ON UPDATE NO ACTION ON DELETE NO ACTION,
	ADD CONSTRAINT `FK_TblOrdersBOM_ActiveVersion_OrderVersionID` FOREIGN KEY (`OrderVersionID`) REFERENCES `TblOrdersBOM_Version` (`OrderVersionID`) ON UPDATE NO ACTION ON DELETE NO ACTION
;



ALTER TABLE `TblOrdersBOM`
	DROP FOREIGN KEY `FK_TblOrdersBOM_Employees`,
	DROP FOREIGN KEY `FK_TblOrdersBOM_Employees_10`,
	DROP FOREIGN KEY `FK_TblOrdersBOM_Employees_12`,
	DROP FOREIGN KEY `FK_TblOrdersBOM_Employees_13`,
	DROP FOREIGN KEY `FK_TblOrdersBOM_Employees_14`,
	DROP FOREIGN KEY `FK_TblOrdersBOM_Employees_15`,
	DROP FOREIGN KEY `FK_TblOrdersBOM_Employees_2`,
	DROP FOREIGN KEY `FK_TblOrdersBOM_Employees_3`,
	DROP FOREIGN KEY `FK_TblOrdersBOM_Employees_4`,
	DROP FOREIGN KEY `FK_TblOrdersBOM_Employees_5`,
	DROP FOREIGN KEY `FK_TblOrdersBOM_Employees_6`,
	DROP FOREIGN KEY `FK_TblOrdersBOM_Employees_7`,
	DROP FOREIGN KEY `FK_TblOrdersBOM_Employees_8`,
	DROP FOREIGN KEY `FK_TblOrdersBOM_Employees_9`,
	DROP FOREIGN KEY `FK_TblOrdersBOM_Employees_FinalFollowUp`
;
ALTER TABLE `TblOrdersBOM`
	ADD CONSTRAINT `FK_TblOrdersBOM_Remake_userId` FOREIGN KEY (`Remake_userId`) REFERENCES `TblEmployee` (`EmployeeID`),
	ADD CONSTRAINT `FK_TblOrdersBOM_NeedToQuote_userId` FOREIGN KEY (`NeedToQuote_userId`) REFERENCES `TblEmployee` (`EmployeeID`) ON UPDATE NO ACTION ON DELETE NO ACTION,
	ADD CONSTRAINT `FK_TblOrdersBOM_onHold_userId` FOREIGN KEY (`onHold_userId`) REFERENCES `TblEmployee` (`EmployeeID`),
	ADD CONSTRAINT `FK_TblOrdersBOM_EngineeringRequired_userId` FOREIGN KEY (`EngineeringRequired_userId`) REFERENCES `TblEmployee` (`EmployeeID`),
	ADD CONSTRAINT `FK_TblOrdersBOM_EngineeringComplete_userId` FOREIGN KEY (`EngineeringComplete_userId`) REFERENCES `TblEmployee` (`EmployeeID`),
	ADD CONSTRAINT `FK_TblOrdersBOM_PartiallyPaid_userId` FOREIGN KEY (`PaidPartially_userId`) REFERENCES `TblEmployee` (`EmployeeID`),
	ADD CONSTRAINT `FK_TblOrdersBOM_estimate_userId` FOREIGN KEY (`estimate_userId`) REFERENCES `TblEmployee` (`EmployeeID`),
	ADD CONSTRAINT `FK_TblOrdersBOM_ordered_userId` FOREIGN KEY (`ordered_userid`) REFERENCES `TblEmployee` (`EmployeeID`),
	ADD CONSTRAINT `FK_TblOrdersBOM_released_userId` FOREIGN KEY (`released_userid`) REFERENCES `TblEmployee` (`EmployeeID`),
	ADD CONSTRAINT `FK_TblOrdersBOM_cancelled_userId` FOREIGN KEY (`cancelled_userid`) REFERENCES `TblEmployee` (`EmployeeID`),
	ADD CONSTRAINT `FK_TblOrdersBOM_paid_userId` FOREIGN KEY (`paid_userid`) REFERENCES `TblEmployee` (`EmployeeID`),
	ADD CONSTRAINT `FK_TblOrdersBOM_DueDate_userId` FOREIGN KEY (`DueDate_userid`) REFERENCES `TblEmployee` (`EmployeeID`),
	ADD CONSTRAINT `FK_TblOrdersBOM_CreditCardCharged_UserId` FOREIGN KEY (`CreditCardCharged_UserId`) REFERENCES `TblEmployee` (`EmployeeID`),
	ADD CONSTRAINT `FK_TblOrdersBOM_invoiced_userId` FOREIGN KEY (`invoiced_UserId`) REFERENCES `TblEmployee` (`EmployeeID`),
	ADD CONSTRAINT `FK_TblOrdersBOM_FinalFollowUp_userId` FOREIGN KEY (`FinalFollowUp_userId`) REFERENCES `TblEmployee` (`EmployeeID`)
;
ALTER TABLE `TblOrdersBOM`
	DROP FOREIGN KEY `FK_TblOrdersBOM_Employees_HighProbability`,
	DROP FOREIGN KEY `FK_TblOrdersBOM_Employees_InitialContactMade`,
	DROP FOREIGN KEY `FK_TblOrdersBOM_Employees_OrderLost`,
	DROP FOREIGN KEY `FK_TblOrdersBOM_Employees_Scrubbed`,
	DROP FOREIGN KEY `FK_TblOrdersBOM_Employees_Status1stFollowUp`,
	DROP FOREIGN KEY `FK_TblOrdersBOM_Employees_Status2ndFollowUp`,
	DROP FOREIGN KEY `FK_TblOrdersBOM_ReasonLossIDaaaaaa`,
	DROP FOREIGN KEY `FK_TblOrdersBOM_ReasonWinIDaaaaaaa`;
ALTER TABLE `TblOrdersBOM`
	ADD CONSTRAINT `FK_TblOrdersBOM_HighProbability_userId` FOREIGN KEY (`HighProbability_userId`) REFERENCES `TblEmployee` (`EmployeeID`),
	ADD CONSTRAINT `FK_TblOrdersBOM_InitialContactMade_userId` FOREIGN KEY (`InitialContactMade_userId`) REFERENCES `TblEmployee` (`EmployeeID`),
	ADD CONSTRAINT `FK_TblOrdersBOM_OrderLost_userId` FOREIGN KEY (`OrderLost_userId`) REFERENCES `TblEmployee` (`EmployeeID`),
	ADD CONSTRAINT `FK_TblOrdersBOM_Scrubbed_userId` FOREIGN KEY (`Scrubbed_userid`) REFERENCES `TblEmployee` (`EmployeeID`),
	ADD CONSTRAINT `FK_TblOrdersBOM_Status1stFollowUp_userId` FOREIGN KEY (`Status1stFollowUp_userId`) REFERENCES `TblEmployee` (`EmployeeID`),
	ADD CONSTRAINT `FK_TblOrdersBOM_Status2ndFollowUp_userId` FOREIGN KEY (`Status2ndFollowUp_userId`) REFERENCES `TblEmployee` (`EmployeeID`),
	ADD CONSTRAINT `FK_TblOrdersBOM_ReasonLossID` FOREIGN KEY (`ReasonLossID`) REFERENCES `TblReasonLoss` (`ReasonLossID`),
	ADD CONSTRAINT `FK_TblOrdersBOM_ReasonWinID` FOREIGN KEY (`ReasonWinID`) REFERENCES `TblReasonWin` (`ReasonWinID`)
;
ALTER TABLE `TblOrdersBOM`
	DROP FOREIGN KEY `FK_TblOrdersBOM_TblCountry`,
	DROP FOREIGN KEY `FK_TblOrdersBOM_TblCountry_2`,
	DROP FOREIGN KEY `FK_TblOrdersBOM_TblMaterial_filter_metal`,
	DROP FOREIGN KEY `FK_TblOrdersBOM_TblMaterial_filter_wood`,
	DROP FOREIGN KEY `FK_TblOrdersBOM_TblOrdersBOM_Remakes`,
	DROP FOREIGN KEY `FK_TblOrdersBOM_TblOrdersBOM_Version`,
	DROP FOREIGN KEY `FK_TblOrdersBOM_TblPostMountingStyle`,
	DROP FOREIGN KEY `FK_TblOrdersBOM_TblPostSystemType`,
	DROP FOREIGN KEY `FK_TblOrdersBOM_TblPostTopStyle2`,
	DROP FOREIGN KEY `FK_TblOrdersBOM_Tbl_Terms`,
	DROP FOREIGN KEY `FK_TblOrdersBOM_billState`,
	DROP FOREIGN KEY `FK_TblOrdersBOM_shipState`;
ALTER TABLE `TblOrdersBOM`
	ADD CONSTRAINT `FK_TblOrdersBOM_ShipCountryId` FOREIGN KEY (`ShipCountryId`) REFERENCES `TblCountry` (`id`),
	ADD CONSTRAINT `FK_TblOrdersBOM_BillCountryId` FOREIGN KEY (`BillCountryId`) REFERENCES `TblCountry` (`id`),
	ADD CONSTRAINT `FK_TblOrdersBOM_ProductsFilterMetalMaterialD` FOREIGN KEY (`ProductsFilterMetalMaterialD`) REFERENCES `TblMaterial` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION,
	ADD CONSTRAINT `FK_TblOrdersBOM_ProductsFilterWoodMaterialD` FOREIGN KEY (`ProductsFilterWoodMaterialD`) REFERENCES `TblMaterial` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION,
	ADD CONSTRAINT `FK_TblOrdersBOM_RemakeNoteID` FOREIGN KEY (`RemakeNoteID`) REFERENCES `TblOrdersBOM_Remakes` (`id`),
	ADD CONSTRAINT `FK_TblOrdersBOM_CustomerSelectedVersionID` FOREIGN KEY (`CustomerSelectedVersionID`) REFERENCES `TblOrdersBOM_Version` (`OrderVersionID`) ON UPDATE NO ACTION ON DELETE NO ACTION,
	ADD CONSTRAINT `FK_TblOrdersBOM_ProductsFilterPostMountingStyleID` FOREIGN KEY (`ProductsFilterPostMountingStyleID`) REFERENCES `TblPostMountingStyle` (`PostMountingStyleID`) ON UPDATE NO ACTION ON DELETE NO ACTION,
	ADD CONSTRAINT `FK_TblOrdersBOM_ProductsFilterPostSystemTypeID` FOREIGN KEY (`ProductsFilterPostSystemTypeID`) REFERENCES `TblPostSystemType` (`PostSystemTypeID`) ON UPDATE NO ACTION ON DELETE NO ACTION,
	ADD CONSTRAINT `FK_TblOrdersBOM_ProductsFilterPostTopStyleID` FOREIGN KEY (`ProductsFilterPostTopStyleID`) REFERENCES `TblPostTopStyle2` (`PostTopStyleID`) ON UPDATE NO ACTION ON DELETE NO ACTION,
	ADD CONSTRAINT `FK_TblOrdersBOM_TermsID` FOREIGN KEY (`TermsID`) REFERENCES `TblTerms` (`id`),
	ADD CONSTRAINT `FK_TblOrdersBOM_BillState` FOREIGN KEY (`BillState`) REFERENCES `TblState` (`State`),
	ADD CONSTRAINT `FK_TblOrdersBOM_ShipState` FOREIGN KEY (`ShipState`) REFERENCES `TblState` (`State`)
;
ALTER TABLE `TblOrdersBOM`
	DROP FOREIGN KEY `TblOrdersBOM_fk`,
	DROP FOREIGN KEY `TblOrdersBOM_fk2`,
	DROP FOREIGN KEY `TblOrdersBOM_fk3`,
	DROP FOREIGN KEY `TblOrdersBOM_fk4`,
	DROP FOREIGN KEY `TblOrdersBOM_fk5`,
	DROP FOREIGN KEY `TblOrdersBOM_fk6`,
	DROP FOREIGN KEY `TblOrdersBOM_fk_Company`;
ALTER TABLE `TblOrdersBOM`
	ADD CONSTRAINT `FK_TblOrdersBOM_SalesmanEmployeeID` FOREIGN KEY (`SalesmanEmployeeID`) REFERENCES `TblEmployee` (`EmployeeID`) ON UPDATE NO ACTION ON DELETE NO ACTION,
	ADD CONSTRAINT `FK_TblOrdersBOM_CustomerServiceEmployeeID` FOREIGN KEY (`CustomerServiceEmployeeID`) REFERENCES `TblEmployee` (`EmployeeID`) ON UPDATE NO ACTION ON DELETE NO ACTION,
	ADD CONSTRAINT `FK_TblOrdersBOM_EnteredByEmployeeID` FOREIGN KEY (`EnteredByEmployeeID`) REFERENCES `TblEmployee` (`EmployeeID`) ON UPDATE NO ACTION ON DELETE NO ACTION,
	ADD CONSTRAINT `FK_TblOrdersBOM_ShippingMethodID` FOREIGN KEY (`ShippingMethodID`) REFERENCES `TblShippingMethods` (`ShippingMethodID`) ON UPDATE NO ACTION ON DELETE NO ACTION,
	ADD CONSTRAINT `FK_TblOrdersBOM_ReadyToShip_userId` FOREIGN KEY (`ReadytoShip_userId`) REFERENCES `TblEmployee` (`EmployeeID`) ON UPDATE NO ACTION ON DELETE NO ACTION,
	ADD CONSTRAINT `FK_TblOrdersBOM_CustomerContactID` FOREIGN KEY (`CustomerContactID`) REFERENCES `TblCustomerContact` (`CustomerContactID`) ON UPDATE NO ACTION ON DELETE NO ACTION,
	ADD CONSTRAINT `FK_TblOrdersBOM_CompanyID` FOREIGN KEY (`CompanyID`) REFERENCES `TblCompany` (`CompanyID`) ON UPDATE NO ACTION ON DELETE NO ACTION
;




ALTER TABLE `TblMaterialSizeLink`
	DROP FOREIGN KEY `FK__tbl_lumber_type`,
	DROP FOREIGN KEY `FK__tbl_wood_type`;
ALTER TABLE `TblMaterialSizeLink`
	ADD CONSTRAINT `FK_TblMaterialSizeLink_d_material_size_id` FOREIGN KEY (`d_material_size_id`) REFERENCES `TblMaterialSize` (`id`) ON DELETE CASCADE,
	ADD CONSTRAINT `TblMaterialSizeLink_d_material_id` FOREIGN KEY (`d_material_id`) REFERENCES `TblMaterial` (`id`) ON DELETE CASCADE
;


ALTER TABLE `TblMaterialFinish`
	DROP FOREIGN KEY `FK_tbl_wood_type_finishes_FinishOption`,
	DROP FOREIGN KEY `FK_tbl_wood_type_finishes_tbl_wood_type`;
ALTER TABLE `TblMaterialFinish`
	ADD CONSTRAINT `FK_TblMaterialFinish_FinishOptionID` FOREIGN KEY (`FinishOptionID`) REFERENCES `TblFinishOption` (`id`),
	ADD CONSTRAINT `FK_TblMaterialFinish_d_material_id` FOREIGN KEY (`d_material_id`) REFERENCES `TblMaterial` (`id`)
;



ALTER TABLE `TblFile`
	DROP FOREIGN KEY `FK_TblFile_Customers`,
	DROP FOREIGN KEY `FK_TblFile_Products`,
	DROP FOREIGN KEY `FK_TblFile_TblOrdersBOM`,
	DROP FOREIGN KEY `FK_TblFile_TblOrdersBOM_2`,
	DROP FOREIGN KEY `FK_TblFile_TblOrdersBOM_Items`,
	DROP FOREIGN KEY `FK_TblFile_TblOrdersBOM_Shipments`,
	DROP FOREIGN KEY `FK_TblFile_tblRGAStatus`;
ALTER TABLE `TblFile`
	ADD CONSTRAINT `FK_TblFile_CustomerID` FOREIGN KEY (`customerID`) REFERENCES `TblCustomer` (`CustomerID`) ON UPDATE NO ACTION ON DELETE NO ACTION,
	ADD CONSTRAINT `FK_TblFile_ProductID` FOREIGN KEY (`productID`) REFERENCES `TblProducts` (`ProductID`) ON UPDATE NO ACTION ON DELETE NO ACTION,
	ADD CONSTRAINT `FK_TblFile_OrderID` FOREIGN KEY (`orderID`) REFERENCES `TblOrdersBOM` (`OrderID`) ON UPDATE NO ACTION ON DELETE NO ACTION,
	ADD CONSTRAINT `FK_TblFile_orderCustomerVisibleID` FOREIGN KEY (`orderCustomerVisibleID`) REFERENCES `TblOrdersBOM` (`OrderID`) ON UPDATE NO ACTION ON DELETE NO ACTION,
	ADD CONSTRAINT `FK_TblFile_OrderItemsID` FOREIGN KEY (`orderItemsID`) REFERENCES `TblOrdersBOM_Items` (`OrderItemsID`) ON UPDATE NO ACTION ON DELETE NO ACTION,
	ADD CONSTRAINT `FK_TblFile_orderShipmentID` FOREIGN KEY (`orderShipmentID`) REFERENCES `TblOrdersBOM_Shipments` (`OrderShipment_id`) ON UPDATE NO ACTION ON DELETE NO ACTION,
	ADD CONSTRAINT `FK_TblFile_rgaRequestStatusID` FOREIGN KEY (`rgaRequestStatusID`) REFERENCES `TblRGAStatus` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION
;


ALTER TABLE `TblEmployeeRoleAccess`
	DROP FOREIGN KEY `FK_Employees_role_access_module`,
	DROP FOREIGN KEY `FK_Employees_role_access_role`;
ALTER TABLE `TblEmployeeRoleAccess`
	ADD CONSTRAINT `FK_TblEmployeeRoleAccess_module_id` FOREIGN KEY (`Module_id`) REFERENCES `TblEmployeeModule` (`Module_id`) ON UPDATE NO ACTION ON DELETE CASCADE,
	ADD CONSTRAINT `FK_TblEmployeeRoleAccess_role_id` FOREIGN KEY (`role_id`) REFERENCES `TblEmployeeRole` (`role_id`) ON UPDATE NO ACTION ON DELETE CASCADE
;



ALTER TABLE `TblEmployee`
	DROP FOREIGN KEY `FK_Employees_Role`,
	DROP FOREIGN KEY `FK_Employees_tbl_allowed_ips_list`;
ALTER TABLE `TblEmployee`
	ADD CONSTRAINT `FK_Employees_Role_id` FOREIGN KEY (`Role_id`) REFERENCES `TblEmployeeRole` (`role_id`) ON UPDATE NO ACTION ON DELETE NO ACTION,
	ADD CONSTRAINT `FK_Employees_allowed_ips_list_id` FOREIGN KEY (`allowed_ips_list_id`) REFERENCES `TblAllowedIPsList` (`ListID`) ON UPDATE NO ACTION ON DELETE NO ACTION
;


ALTER TABLE `TblCustomerContactEmail`
	DROP FOREIGN KEY `FK_TblCustomerContactEmail_CustomerContact`;
ALTER TABLE `TblCustomerContactEmail`
	ADD CONSTRAINT `FK_TblCustomerContactEmail_CustomerContactID` FOREIGN KEY (`CustomerContactID`) REFERENCES `TblCustomerContact` (`CustomerContactID`) ON UPDATE NO ACTION ON DELETE CASCADE
;



ALTER TABLE `TblCustomerContact`
	DROP FOREIGN KEY `FK_CustomerContact_Country`,
	DROP FOREIGN KEY `FK_CustomerContact_Customers`,
	DROP FOREIGN KEY `FK_CustomerContact_TblState`;
ALTER TABLE `TblCustomerContact`
	ADD CONSTRAINT `FK_TblCustomerContact_ContactCountryId` FOREIGN KEY (`ContactCountryId`) REFERENCES `TblCountry` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION,
	ADD CONSTRAINT `FK_TblCustomerContact_CustomerID` FOREIGN KEY (`CustomerID`) REFERENCES `TblCustomer` (`CustomerID`) ON UPDATE NO ACTION ON DELETE CASCADE,
	ADD CONSTRAINT `FK_TblCustomerContact_ContactState` FOREIGN KEY (`ContactState`) REFERENCES `TblState` (`State`) ON UPDATE NO ACTION ON DELETE NO ACTION
;



ALTER TABLE `TblCustomer`
	DROP FOREIGN KEY `Customers_fk`,
	DROP FOREIGN KEY `FK_Customers_Company`,
	DROP FOREIGN KEY `FK_Customers_CustomerContact`,
	DROP FOREIGN KEY `FK_Customers_CustomerContact_2`,
	DROP FOREIGN KEY `FK_Customers_CustomerInitialContact`,
	DROP FOREIGN KEY `FK_Customers_CustomerType`,
	DROP FOREIGN KEY `FK_Customers_Employees`,
	DROP FOREIGN KEY `FK_Customers_Tbl_Terms`;
ALTER TABLE `TblCustomer`
	ADD CONSTRAINT `FK_TblCustomer_SalesPersonID` FOREIGN KEY (`SalesPersonID`) REFERENCES `TblEmployee` (`EmployeeID`) ON UPDATE NO ACTION ON DELETE NO ACTION,
	ADD CONSTRAINT `FK_TblCustomer_defaultCompanyID` FOREIGN KEY (`defaultCompanyID`) REFERENCES `TblCompany` (`CompanyID`),
	ADD CONSTRAINT `FK_TblCustomer_defaultBillingContactID` FOREIGN KEY (`defaultBillingContactID`) REFERENCES `TblCustomerContact` (`CustomerContactID`),
	ADD CONSTRAINT `FK_TblCustomer_defaultShippingContactID` FOREIGN KEY (`defaultShippingContactID`) REFERENCES `TblCustomerContact` (`CustomerContactID`),
	ADD CONSTRAINT `FK_TblCustomer_InitialContactID` FOREIGN KEY (`InitialContactID`) REFERENCES `TblCustomerInitialContact` (`InitialContactID`),
	ADD CONSTRAINT `FK_TblCustomer_CustomerTypeID` FOREIGN KEY (`CustomerTypeID`) REFERENCES `TblCustomerType` (`id`),
	ADD CONSTRAINT `FK_TblCustomer_CustomerServicePersonID` FOREIGN KEY (`CustomerServicePersonID`) REFERENCES `TblEmployee` (`EmployeeID`) ON UPDATE NO ACTION ON DELETE NO ACTION,
	ADD CONSTRAINT `FK_TblCustomer_TermsID` FOREIGN KEY (`TermsID`) REFERENCES `TblTerms` (`id`)
;


ALTER TABLE `TblCompanyLocation`
	DROP FOREIGN KEY `FK_TblCompanyLocation_TblCompany`;
ALTER TABLE `TblCompanyLocation`
	ADD CONSTRAINT `FK_TblCompanyLocation_CompanyID` FOREIGN KEY (`CompanyID`) REFERENCES `TblCompany` (`CompanyID`) ON UPDATE NO ACTION ON DELETE NO ACTION
;



ALTER TABLE `TblAuditFieldChange`
	DROP FOREIGN KEY `TblOrdersBOM_UpdateDetails_fk`;
ALTER TABLE `TblAuditFieldChange`
	ADD CONSTRAINT `FK_TblAuditFieldChange_d_audit_id` FOREIGN KEY (`d_audit_id`) REFERENCES `TblAudit` (`id`) ON UPDATE NO ACTION ON DELETE CASCADE
;



ALTER TABLE `TblAudit`
	DROP FOREIGN KEY `FK_TblAudit_Customers`,
	DROP FOREIGN KEY `TblOrdersBOM_Update_fk2`;
ALTER TABLE `TblAudit`
	ADD CONSTRAINT `FK_TblAudit_CustomerID` FOREIGN KEY (`CustomerID`) REFERENCES `TblCustomer` (`CustomerID`),
	ADD CONSTRAINT `FK_TblAudit_d_employee_id` FOREIGN KEY (`d_employee_id`) REFERENCES `TblEmployee` (`EmployeeID`) ON UPDATE NO ACTION ON DELETE NO ACTION
;


ALTER TABLE `TblAllowedIPsIP`
	DROP FOREIGN KEY `FK__tbl_allowed_ips_list`;
ALTER TABLE `TblAllowedIPsIP`
	ADD CONSTRAINT `FK_TblAllowedIPsIP_ListID` FOREIGN KEY (`ListID`) REFERENCES `TblAllowedIPsList` (`ListID`) ON UPDATE NO ACTION ON DELETE CASCADE
;
