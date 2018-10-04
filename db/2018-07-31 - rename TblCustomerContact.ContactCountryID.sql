ALTER TABLE `TblCustomerContact`
	CHANGE COLUMN `ContactCountryId` `ContactCountryID` INT(10) NULL DEFAULT NULL AFTER `ContactPostalCode`
;