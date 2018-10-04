ALTER TABLE `tbl_settings_global`
	ADD COLUMN `late_order_days` INT NOT NULL DEFAULT '0' AFTER `stain_price_multiplier`;
UPDATE `tbl_settings_global` SET `late_order_days`=2 WHERE  `id`=1;