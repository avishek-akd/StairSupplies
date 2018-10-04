ALTER TABLE Products
	ADD COLUMN FinishCost DECIMAL(10,2) NOT NULL DEFAULT '0.00' COMMENT 'Finish costs' AFTER inboundFreightCost;

UPDATE Products SET FinishCost = 0;