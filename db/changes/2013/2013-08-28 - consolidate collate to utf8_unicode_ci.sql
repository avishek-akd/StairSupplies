alter table Company charset=utf8 collate=utf8_unicode_ci;
alter table Country charset=utf8 collate=utf8_unicode_ci;
alter table CustomerContact charset=utf8 collate=utf8_unicode_ci;
alter table CustomerLogins charset=utf8 collate=utf8_unicode_ci;
alter table Customers charset=utf8 collate=utf8_unicode_ci;
alter table Employees charset=utf8 collate=utf8_unicode_ci;
alter table Employees_module charset=utf8 collate=utf8_unicode_ci;
alter table Employees_role charset=utf8 collate=utf8_unicode_ci;
alter table Employees_role_access charset=utf8 collate=utf8_unicode_ci;
alter table FinishOption charset=utf8 collate=utf8_unicode_ci;
alter table Products charset=utf8 collate=utf8_unicode_ci;
alter table Shipping_Methods charset=utf8 collate=utf8_unicode_ci;
alter table Sites charset=utf8 collate=utf8_unicode_ci;
alter table TBLVendor charset=utf8 collate=utf8_unicode_ci;
alter table TblAudit charset=utf8 collate=utf8_unicode_ci;
alter table TblAuditFieldChange charset=utf8 collate=utf8_unicode_ci;
alter table TblOrdersBOM charset=utf8 collate=utf8_unicode_ci;
alter table TblOrdersBOM_Exceptions charset=utf8 collate=utf8_unicode_ci;
alter table TblOrdersBOM_Items charset=utf8 collate=utf8_unicode_ci;
alter table TblOrdersBOM_Shipments charset=utf8 collate=utf8_unicode_ci;
alter table TblProductType charset=utf8 collate=utf8_unicode_ci;
alter table TblProductTypeInclude charset=utf8 collate=utf8_unicode_ci;
alter table TblProductTypeType charset=utf8 collate=utf8_unicode_ci;
alter table TblState charset=utf8 collate=utf8_unicode_ci;
alter table Tbl_SpecialOrder charset=utf8 collate=utf8_unicode_ci;
alter table Tbl_Terms charset=utf8 collate=utf8_unicode_ci;
alter table Tbl_UnitOfMeasure charset=utf8 collate=utf8_unicode_ci;
alter table tblRGAProduct charset=utf8 collate=utf8_unicode_ci;
alter table tblRGARequest charset=utf8 collate=utf8_unicode_ci;
alter table tblRGAReturnReason charset=utf8 collate=utf8_unicode_ci;
alter table tblRGAStage charset=utf8 collate=utf8_unicode_ci;
alter table tblRGAStatus charset=utf8 collate=utf8_unicode_ci;
alter table tbl_settings_global charset=utf8 collate=utf8_unicode_ci;
alter table tbl_settings_per_company charset=utf8 collate=utf8_unicode_ci;
alter table tbl_wood_type charset=utf8 collate=utf8_unicode_ci;
alter table tbl_wood_type_availability charset=utf8 collate=utf8_unicode_ci;



alter table Company convert to character set utf8 collate utf8_unicode_ci;
alter table Country convert to character set utf8 collate utf8_unicode_ci;
alter table Employees convert to character set utf8 collate utf8_unicode_ci;
alter table Employees_module convert to character set utf8 collate utf8_unicode_ci;
alter table Employees_role convert to character set utf8 collate utf8_unicode_ci;
alter table FinishOption convert to character set utf8 collate utf8_unicode_ci;
alter table Products convert to character set utf8 collate utf8_unicode_ci;
alter table Shipping_Methods convert to character set utf8 collate utf8_unicode_ci;
alter table Sites convert to character set utf8 collate utf8_unicode_ci;
alter table TBLVendor convert to character set utf8 collate utf8_unicode_ci;
alter table TblAudit convert to character set utf8 collate utf8_unicode_ci;
alter table TblAuditFieldChange convert to character set utf8 collate utf8_unicode_ci;
alter table TblOrdersBOM convert to character set utf8 collate utf8_unicode_ci;
alter table TblOrdersBOM_Exceptions convert to character set utf8 collate utf8_unicode_ci;
alter table TblOrdersBOM_Items convert to character set utf8 collate utf8_unicode_ci;
alter table TblOrdersBOM_Shipments convert to character set utf8 collate utf8_unicode_ci;
alter table TblProductType convert to character set utf8 collate utf8_unicode_ci;
alter table TblProductTypeType convert to character set utf8 collate utf8_unicode_ci;
alter table Tbl_Terms convert to character set utf8 collate utf8_unicode_ci;
alter table Tbl_UnitOfMeasure convert to character set utf8 collate utf8_unicode_ci;
alter table tblRGAProduct convert to character set utf8 collate utf8_unicode_ci;
alter table tblRGARequest convert to character set utf8 collate utf8_unicode_ci;
alter table tblRGAReturnReason convert to character set utf8 collate utf8_unicode_ci;
alter table tblRGAStage convert to character set utf8 collate utf8_unicode_ci;
alter table tblRGAStatus convert to character set utf8 collate utf8_unicode_ci;
alter table tbl_settings_per_company convert to character set utf8 collate utf8_unicode_ci;
alter table tbl_wood_type convert to character set utf8 collate utf8_unicode_ci;
alter table tbl_wood_type_availability convert to character set utf8 collate utf8_unicode_ci;



ALTER TABLE `CustomerContact`
	DROP FOREIGN KEY `CustomerContact_fk2`;
ALTER TABLE `Customers`
	DROP FOREIGN KEY `Customers_fk3`,
	DROP FOREIGN KEY `Customers_fk7`;
	
alter table Customers convert to character set utf8 collate utf8_unicode_ci;
alter table CustomerContact convert to character set utf8 collate utf8_unicode_ci;
alter table TblState convert to character set utf8 collate utf8_unicode_ci;

ALTER TABLE `CustomerContact`
	ADD CONSTRAINT `FK_CustomerContact_TblState` FOREIGN KEY (`ContactState`) REFERENCES `TblState` (`State`) ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `Customers`
	ADD CONSTRAINT `FK_Customers_TblState` FOREIGN KEY (`BillState`) REFERENCES `TblState` (`State`) ON UPDATE NO ACTION ON DELETE NO ACTION,
	ADD CONSTRAINT `FK_Customers_TblState_2` FOREIGN KEY (`ShipState`) REFERENCES `TblState` (`State`) ON UPDATE NO ACTION ON DELETE NO ACTION;
