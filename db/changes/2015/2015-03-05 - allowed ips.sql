DELIMITER $$


CREATE TABLE `tbl_allowed_ips_list` (
	`id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`d_name` VARCHAR(100) NOT NULL,
	`d_record_created` DATETIME NOT NULL,
	`d_record_updated` DATETIME NULL DEFAULT NULL,
	PRIMARY KEY (`id`)
)
COLLATE='utf8_unicode_ci'
ENGINE=InnoDB
$$


CREATE TABLE `tbl_allowed_ips_ip` (
	`id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`d_list_id` INT UNSIGNED NOT NULL,
	`d_ip` VARCHAR(15) NOT NULL COMMENT 'This can be the actual email address or the wildcard * (wildcard matches all addresses)',
	`d_record_created` DATETIME NOT NULL,
	`d_record_updated` DATETIME NULL,
	PRIMARY KEY (`id`),
	CONSTRAINT `FK__tbl_allowed_ips_list` FOREIGN KEY (`d_list_id`) REFERENCES `tbl_allowed_ips_list` (`id`) ON UPDATE NO ACTION ON DELETE CASCADE
)
COLLATE='utf8_unicode_ci'
ENGINE=InnoDB
$$
CREATE DEFINER = CURRENT_USER TRIGGER `tbl_allowed_ips_ip_before_ins_tr1` BEFORE INSERT ON `tbl_allowed_ips_ip`
  FOR EACH ROW
BEGIN
IF NEW.d_ip <> '*' THEN
	IF INET_ATON(NEW.d_ip) IS NULL THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid IP address.';
    END IF;
END IF;
END
$$
CREATE DEFINER = CURRENT_USER TRIGGER `tbl_allowed_ips_ip_before_upd_tr1` BEFORE UPDATE ON `tbl_allowed_ips_ip`
  FOR EACH ROW
BEGIN
IF NEW.d_ip <> '*' THEN
	IF INET_ATON(NEW.d_ip) IS NULL THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid IP address.';
    END IF;
END IF;
END
$$



INSERT INTO `tbl_allowed_ips_list` (`d_name`, `d_record_created`) VALUES ('From everywhere', Now())
$$
INSERT INTO `tbl_allowed_ips_ip` (`d_list_id`, `d_ip`, `d_record_created`) VALUES (LAST_INSERT_ID(), '*', Now())
$$
INSERT INTO `tbl_allowed_ips_list` (`d_name`, `d_record_created`) VALUES ('From nowhere', Now())
$$
INSERT INTO `tbl_allowed_ips_ip` (`d_list_id`, `d_ip`, `d_record_created`) VALUES (LAST_INSERT_ID(), '1.1.1.1', Now())
$$


ALTER TABLE `Employees`
	ADD COLUMN `allowed_ips_list_id` INT UNSIGNED NOT NULL DEFAULT 1 COMMENT 'Restricts the IP lists where this Employee is allowed to login into the /ironbluaster area' AFTER `Role_id`,
	ADD INDEX `allowed_ips_list_id` (`allowed_ips_list_id`),
	ADD CONSTRAINT `FK_Employees_tbl_allowed_ips_list` FOREIGN KEY (`allowed_ips_list_id`) REFERENCES `tbl_allowed_ips_list` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION
$$


DELIMITER ;