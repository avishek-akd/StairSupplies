ALTER TABLE `TblPurchaseOrder`
	CHANGE COLUMN `CustomerNotes` `CustomerNotes` VARCHAR(2000) NULL DEFAULT NULL COMMENT 'Notes visible to the customer' COLLATE 'utf8_unicode_ci' AFTER `TotalAmount`;
