ALTER TABLE TblEmployee
	CHANGE COLUMN `EmailSignature` `EmailSignatureStairs` VARCHAR(2000) NULL DEFAULT NULL COMMENT 'Email signature for outgoing emails. Format: HTML',
	ADD COLUMN `EmailSignatureViewrail` VARCHAR(2000) NULL DEFAULT NULL COMMENT 'Email signature for outgoing emails. Format: HTML' AFTER `EmailSignatureStairs`
;