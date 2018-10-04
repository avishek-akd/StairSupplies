ALTER TABLE `TblOrdersBOM`
	ADD COLUMN `emailSentReadyToShipButNotFullyPaid` TINYINT(1) NOT NULL DEFAULT 0 COMMENT 'Flag to send the partially paid email only once' AFTER `Backordered`
;