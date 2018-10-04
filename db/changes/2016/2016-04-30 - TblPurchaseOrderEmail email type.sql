ALTER TABLE `TblPurchaseOrderEmail`
	ADD COLUMN `MessageType` TINYINT NOT NULL DEFAULT '1' COMMENT '=1 Standard message, =2 Reminder message' AFTER `PurchaseOrderID`;
