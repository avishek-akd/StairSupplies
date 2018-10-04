ALTER TABLE `TblEmployee`
	ADD COLUMN `LongTermLogin` TINYINT(4) NOT NULL DEFAULT '0' COMMENT '=1 Once this user logges in it shouldn\'t be logged out, even if CF restarts. This is used for the unattented auto-refreshing reports. ' AFTER `EmailSignatureViewrail`
;
