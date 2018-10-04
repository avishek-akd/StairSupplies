--  For some reason ContactFullName needs to be NULL-able otherwise unrelated ALTER TABLEs fail on TblCustomerContact
ALTER TABLE `TblCustomerContact`
	CHANGE COLUMN `ContactFullName` `ContactFullName` VARCHAR(100) AS (concat(`ContactFirstName`,' ',`ContactLastName`)) VIRTUAL COMMENT 'Generated from first and last name'
;
ALTER TABLE `TblCustomerContact`
	CHANGE COLUMN `ContactFullName` `ContactFullName` VARCHAR(100) AS (Concat_ws(' ', Coalesce(ContactFirstName, ''), Coalesce(ContactLastName, ''))) VIRTUAL COMMENT 'Generated from first and last name'
;
