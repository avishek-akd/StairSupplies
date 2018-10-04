ALTER TABLE `Products`
	ADD COLUMN `UnitPriceNAC` DECIMAL(19,4) NULL DEFAULT '0.0000' COMMENT 'Price that is used for North Atlantic Corp customers' AFTER `VR_Part`;


DELIMITER $$


DROP FUNCTION IF EXISTS `fGetProductUnitPrice`$$
CREATE FUNCTION `fGetProductUnitPrice`(`companyID` INT, `CustomerTypeID` INT, `unitPrice` DECIMAL(19,4), `unitPriceViewrail` DECIMAL(19,4), `unitPriceNAC` DECIMAL(19,4))
	RETURNS decimal(19,4)
	LANGUAGE SQL
	DETERMINISTIC
	CONTAINS SQL
	SQL SECURITY DEFINER
	COMMENT ''
BEGIN
	IF ( CustomerTypeID = 14 ) THEN
		RETURN unitPriceNAC;
	ELSE
		BEGIN
			IF ( companyID = 4 ) THEN
				RETURN unitPriceViewrail;
			ELSE
				RETURN unitPrice;
			END IF;
		END;
	END IF;
END$$


DELIMITER ;