ALTER TABLE `TblOrdersBOM`
	CHANGE COLUMN `BillContactFullName` `BillContactFullName` VARCHAR(100) GENERATED ALWAYS AS ( CONCAT(BillContactFirstName, ' ', BillContactLastName) ) VIRTUAL NULL COMMENT 'Generated from first and last name',
	CHANGE COLUMN `ShipContactFullName` `ShipContactFullName` VARCHAR(100) GENERATED ALWAYS AS ( CONCAT(ShipContactFirstName, ' ', ShipContactLastName) ) VIRTUAL NULL COMMENT 'Generated from first and last name'
;