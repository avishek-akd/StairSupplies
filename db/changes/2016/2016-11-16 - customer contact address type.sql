ALTER TABLE `CustomerContact`
	ADD COLUMN `AddressType` TINYINT UNSIGNED NOT NULL DEFAULT '0' COMMENT '=0 Unknown address type, =1 Commercial Address, =2 Residential Address' AFTER `CustomerID`;
