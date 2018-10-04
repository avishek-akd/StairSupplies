ALTER TABLE `TblCountry`
	CHANGE COLUMN `id` `CountryID` INT(10) NOT NULL AUTO_INCREMENT,
	CHANGE COLUMN `Name` `CountryName` VARCHAR(100) NULL DEFAULT NULL
;


ALTER TABLE `TblState`
	ALTER `CountryId` DROP DEFAULT
;
ALTER TABLE `TblState`
	CHANGE COLUMN `CountryId` `CountryID` INT(10) NOT NULL AFTER `StateFull`
;


CREATE OR REPLACE SQL SECURITY INVOKER VIEW `vShipWorksOrders` AS
SELECT
	TblOrdersBOM.OrderID, TblOrdersBOM.RecordCreated, Coalesce(TblOrdersBOM.RecordUpdated, TblOrdersBOM.RecordCreated) AS RecordUpdated,

	BillCompanyName, BillContactFirstName, BillContactLastName,
	BillContactFullName AS BillFullName,
	BillAddress1, BillAddress2, BillAddress3, BillCity, BillState,
	BillStateOther, BillPostalCode, billingCountry.CountryName AS BillCountryName,
	BillPhoneNumber, BillFaxNumber, BillCellPhone, BillEmails AS BillEmail,

	ShipCompanyName, ShipContactFirstName, ShipContactLastName,
	ShipContactFullName AS ShipFullName,
	ShipAddress1, ShipAddress2, ShipAddress3, ShipCity, ShipState,
	ShipStateOther, ShipPostalCode, shippingCountry.CountryName AS ShipCountryName,
	ShipPhoneNumber, ShipFaxNumber, ShipCellPhone, ShipEmails AS ShipEmail

FROM TblOrdersBOM
	LEFT JOIN TblOrdersBOM_Shipments        ON TblOrdersBOM_Shipments.OrderID = TblOrdersBOM.OrderID
	LEFT JOIN TblCountry AS billingCountry  ON billingCountry.CountryID = BillCountryID
	LEFT JOIN TblCountry AS shippingCountry ON shippingCountry.CountryID = ShipCountryID
;