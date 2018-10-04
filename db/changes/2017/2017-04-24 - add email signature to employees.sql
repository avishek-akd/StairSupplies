ALTER TABLE Employees
	ADD COLUMN EmailSignature VARCHAR(2000) NULL DEFAULT NULL COMMENT 'Email signature for emails. HTML.' AFTER `SalesCommission`
;