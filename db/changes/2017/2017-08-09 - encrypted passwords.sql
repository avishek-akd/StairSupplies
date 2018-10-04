-- Password is either NULL (doesn't exist) or filled in. Empty string makes no sense
UPDATE TblEmployee SET Password = NULL WHERE Password=''
;
UPDATE TblCustomerContact SET Password = NULL WHERE Password=''
;



--  Maximum size of scrypt encrypted password is 80
-- (see first comment on https://stackoverflow.com/questions/23985540/whats-the-is-maximum-length-of-scrypt-output)



ALTER TABLE TblEmployee
	CHANGE COLUMN `Password` `_unused_Password` VARCHAR(50) NULL DEFAULT NULL,
	ADD COLUMN `Password` VARCHAR(80) NULL DEFAULT NULL AFTER `EmployeeCode`
;



ALTER TABLE TblCustomerContact
	CHANGE COLUMN `Password` `_unused_Password` VARCHAR(20) NULL DEFAULT NULL,
	ADD COLUMN `Password` VARCHAR(80) NULL DEFAULT NULL AFTER `Email`,
	ADD COLUMN `ResetPasswordUUID` CHAR(35) NULL DEFAULT NULL AFTER `Password`,
	ADD COLUMN `ResetPasswordUUIDGeneratedOn` DATETIME NULL DEFAULT NULL AFTER `ResetPasswordUUID`,
	ADD UNIQUE INDEX `unqResetPasswordUUID` (`ResetPasswordUUID`)
;