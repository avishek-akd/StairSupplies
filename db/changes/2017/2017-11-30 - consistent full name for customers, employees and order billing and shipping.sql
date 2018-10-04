ALTER TABLE `TblOrdersBOM`
	CHANGE COLUMN `credit_date` `CreditCardCharged_date` DATETIME NULL DEFAULT NULL AFTER `PaidPartially_userId`,
	CHANGE COLUMN `credit_UserId` `CreditCardCharged_UserId` INT(10) NULL DEFAULT NULL AFTER `CreditCardCharged_date`
;



ALTER TABLE `TblCustomerContact`
	ADD COLUMN `ContactFullName` VARCHAR(100) GENERATED ALWAYS AS ( CONCAT(ContactFirstName, ' ', ContactLastName) ) VIRTUAL NOT NULL COMMENT 'Generated from first and last name' AFTER `ContactLastName`
;
ALTER TABLE `TblEmployee`
	ADD COLUMN `FullName` VARCHAR(100) GENERATED ALWAYS AS ( CONCAT(FirstName, ' ', LastName) ) VIRTUAL NOT NULL COMMENT 'Generated from first and last name' AFTER `LastName`
;
ALTER TABLE `TblOrdersBOM`
	ADD COLUMN `BillContactFullName` VARCHAR(100) GENERATED ALWAYS AS ( CONCAT(BillContactFirstName, ' ', BillContactLastName) ) VIRTUAL NOT NULL COMMENT 'Generated from first and last name' AFTER `BillContactLastName`,
	ADD COLUMN `ShipContactFullName` VARCHAR(100) GENERATED ALWAYS AS ( CONCAT(ShipContactFirstName, ' ', ShipContactLastName) ) VIRTUAL NOT NULL COMMENT 'Generated from first and last name' AFTER `ShipContactLastName`
;