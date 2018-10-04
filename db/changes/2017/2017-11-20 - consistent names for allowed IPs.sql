ALTER TABLE `tbl_allowed_ips_list`
	ALTER `d_name` DROP DEFAULT,
	ALTER `d_record_created` DROP DEFAULT
;
ALTER TABLE `tbl_allowed_ips_list`
	CHANGE COLUMN `id` `ListID` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT FIRST,
	CHANGE COLUMN `d_name` `Title` VARCHAR(100) NOT NULL COLLATE 'utf8_unicode_ci' AFTER `ListID`,
	CHANGE COLUMN `d_record_created` `RecordCreated` DATETIME NOT NULL AFTER `Title`,
	CHANGE COLUMN `d_record_updated` `RecordUpdated` DATETIME NULL DEFAULT NULL AFTER `RecordCreated`
;
RENAME TABLE `tbl_allowed_ips_list` TO `TblAllowedIPsList`
;




ALTER TABLE `tbl_allowed_ips_ip`
	ALTER `d_list_id` DROP DEFAULT,
	ALTER `d_ip` DROP DEFAULT,
	ALTER `d_record_created` DROP DEFAULT
;
ALTER TABLE `tbl_allowed_ips_ip`
	CHANGE COLUMN `id` `AllowedIPID` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT FIRST,
	CHANGE COLUMN `d_list_id` `ListID` INT(10) UNSIGNED NOT NULL AFTER `AllowedIPID`,
	CHANGE COLUMN `d_ip` `IPAddress` VARCHAR(15) NOT NULL COMMENT 'This can be an actual IP address (/32) or wildcard * (wildcard matches all addresses)' COLLATE 'utf8_unicode_ci' AFTER `ListID`,
	CHANGE COLUMN `d_record_created` `RecordCreated` DATETIME NOT NULL AFTER `IPAddress`,
	CHANGE COLUMN `d_record_updated` `RecordUpdated` DATETIME NULL DEFAULT NULL AFTER `RecordCreated`
;
RENAME TABLE `tbl_allowed_ips_ip` TO `TblAllowedIPsIP`
;
ALTER TABLE `TblAllowedIPsIP`
	DROP COLUMN `RecordCreated`,
	DROP COLUMN `RecordUpdated`
;



DELIMITER $$


DROP TRIGGER IF EXISTS `tbl_allowed_ips_ip_before_ins_tr1`
$$
CREATE TRIGGER `TblAllowedIPsIP_before_ins_tr1` BEFORE INSERT ON `TblAllowedIPsIP` FOR EACH ROW BEGIN
IF NEW.IPAddress <> '*' THEN
	IF INET_ATON(NEW.IPAddress) IS NULL THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid IP address.';
    END IF;
END IF;
END
$$



DROP TRIGGER IF EXISTS `tbl_allowed_ips_ip_before_upd_tr1`
$$
CREATE TRIGGER `TblAllowedIPsIP_before_upd_tr1` BEFORE UPDATE ON `TblAllowedIPsIP` FOR EACH ROW BEGIN
IF NEW.IPAddress <> '*' THEN
	IF INET_ATON(NEW.IPAddress) IS NULL THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid IP address.';
    END IF;
END IF;
END
$$


DELIMITER ;