UPDATE TblOrdersBOM_Items
SET unitPrice = 0
WHERE unitprice is null;

ALTER TABLE `TblOrdersBOM_Items`  CHANGE COLUMN `UnitPrice` `UnitPrice` DECIMAL(19,4) NOT NULL DEFAULT '0.0000' AFTER `Unit_of_Measure`;
