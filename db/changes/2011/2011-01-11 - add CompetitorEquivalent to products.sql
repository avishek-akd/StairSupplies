ALTER TABLE `Products`
	ADD COLUMN `CompetitorEquivalent` VARCHAR(255) NULL DEFAULT NULL AFTER `inboundFreightCost`;