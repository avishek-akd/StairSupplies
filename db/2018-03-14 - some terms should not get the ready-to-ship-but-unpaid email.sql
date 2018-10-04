ALTER TABLE TblTerms
	ADD COLUMN SendUnpaidAutoEmail TINYINT(1) NOT NULL DEFAULT 1 COMMENT '=0 no auto-email when order is ready for shipping' AFTER Terms
;

UPDATE TblTerms
SET SendUnpaidAutoEmail = 0
--  Amazon and No charge remake
WHERE id IN (20, 22)
;