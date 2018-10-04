ALTER TABLE `TblPurchaseOrder`
	ADD COLUMN `CustomerNotes` VARCHAR(500) NULL COMMENT 'Notes visible to the customer' AFTER `TotalAmount`,
	ADD COLUMN `RequestedDueDate` DATE NOT NULL AFTER `CustomerNotes`;
