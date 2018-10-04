ALTER TABLE `Company`
	CHANGE COLUMN `FileSuffix` `FileSuffix` VARCHAR(10) NULL DEFAULT NULL COMMENT 'Suffix applied to files (logos, etc). For example the suffix stairs will be applied to the logo: logo_stairs.jpg' AFTER `FaxNumber`;
ALTER TABLE `Customers`
	CHANGE COLUMN `ContactState` `ContactState` VARCHAR(2) NULL DEFAULT NULL COMMENT 'If the country is USA or Canada then ContactState is a foreign key into the tblState table. Otherwise the ContactStateOther field must be filled in.' AFTER `ContactCity`,
	CHANGE COLUMN `CreditHold` `CreditHold` TINYINT(4) NULL DEFAULT '0' COMMENT 'If this is true then the sales department needs to be contacted before shipping or doing production work for this customer.' AFTER `LeadType`,
	CHANGE COLUMN `BillingEmails` `BillingEmails` VARCHAR(255) NULL DEFAULT NULL COMMENT 'The invoice from the invoicing module is sent to these emails.' AFTER `CreditHold`;
ALTER TABLE `Employees`  
	CHANGE COLUMN `Role_id` `Role_id` INT(10) NULL DEFAULT NULL COMMENT 'Employee role in the application.' AFTER `EmployeeCode`, 
	CHANGE COLUMN `vendor_id` `vendor_id` INT(10) NULL DEFAULT NULL COMMENT 'The employee can be a vendor that needs access to parts of the application so this is his id.' AFTER `Password`;
ALTER TABLE `Employees_module` 
	CHANGE COLUMN `Module_directory` `Module_directory` VARCHAR(100) NULL DEFAULT NULL COMMENT 'Directory (relative to ironbaluster/ root) under which the module resides. Examples: "CustomerService", "purchasing/lumber_availability", etc' AFTER `Module_name`;
ALTER TABLE `Products`  
	CHANGE COLUMN `PUnitPrice` `PUnitPrice` DECIMAL(19,4) NOT NULL DEFAULT '0.0000' COMMENT 'Standard selling price, per unit' AFTER `ProductDescription`;
ALTER TABLE `TblOrdersBOM_Shipments` 
	CHANGE COLUMN `ShipmentNumber` `ShipmentNumber` VARCHAR(10) NOT NULL COMMENT 'Shipment Number is the order number plus the shipment index as a letter. For example for order 28000 we will have shipments: 28000-A, 28000-B, 28000-C, 28000-D, etc' AFTER `Invoiced`,
	CHANGE COLUMN `delivered` `delivered` TINYINT(4) NOT NULL DEFAULT '0' COMMENT '=1 if the shipment was delivered, =0 otherwise. This is used for the iPhone application to avoid displaying shipments that are delivered.' AFTER `actual_shipping_cost`;
