ALTER TABLE `TblOrdersBOM`
	ADD COLUMN `EngineeringRequiredCore` TINYINT(1) NOT NULL DEFAULT 0 AFTER `EngineeringRequired`,
	ADD COLUMN `EngineeringRequiredFlight` TINYINT(1) NOT NULL DEFAULT 0 AFTER `EngineeringRequiredCore`,
	ADD COLUMN `EngineeringRequiredWood` TINYINT(1) NOT NULL DEFAULT 0 AFTER `EngineeringRequiredFlight`,
	ADD COLUMN `EngineeringRequiredOther` TINYINT(1) NOT NULL DEFAULT 0 AFTER `EngineeringRequiredWood`,

	ADD COLUMN `EngineeringCompleteCore` TINYINT(1) NOT NULL DEFAULT 0 AFTER `EngineeringComplete`,
	ADD COLUMN `EngineeringCompleteFlight` TINYINT(1) NOT NULL DEFAULT 0 AFTER `EngineeringCompleteCore`,
	ADD COLUMN `EngineeringCompleteWood` TINYINT(1) NOT NULL DEFAULT 0 AFTER `EngineeringCompleteFlight`,
	ADD COLUMN `EngineeringCompleteOther` TINYINT(1) NOT NULL DEFAULT 0 AFTER `EngineeringCompleteWood`
;
UPDATE `TblOrdersBOM`
SET
	EngineeringRequiredCore = 1
WHERE EngineeringRequired = 1
;
UPDATE `TblOrdersBOM`
SET
	EngineeringCompleteCore = 1
WHERE EngineeringComplete = 1
;