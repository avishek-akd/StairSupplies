ALTER TABLE `Products`
	ADD COLUMN `inboundFreightCost` DECIMAL(10,2) NOT NULL DEFAULT '0.00' COMMENT 'shipping cost associated with receiving an inbound item ($/item)' AFTER `EmployeeRatePreFinish`;
