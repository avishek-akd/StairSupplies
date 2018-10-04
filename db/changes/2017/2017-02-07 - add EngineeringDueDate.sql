ALTER TABLE `TblOrdersBOM`
	ADD COLUMN `EngineeringDueDate` DATE NULL DEFAULT NULL AFTER `EngineeringRequired_userId`;
