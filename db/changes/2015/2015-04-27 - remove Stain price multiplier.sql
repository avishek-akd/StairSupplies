ALTER TABLE `tbl_settings_global`
	ALTER `stain_price_multiplier` DROP DEFAULT;
ALTER TABLE `tbl_settings_global`
	CHANGE COLUMN `stain_price_multiplier` `_unused_stain_price_multiplier` DECIMAL(5,2) NOT NULL COMMENT '1.2 for 120%, 0.9 for 90% (lower than 1 means smaller stain cost than finish cost)' AFTER `_unused_conversion_factor_machine2`;

DROP FUNCTION IF EXISTS fPreFinishCost;
CREATE FUNCTION `fPreFinishCost`(
        finishTitle VARCHAR(100),
        preFinishCost DECIMAL(10,2),
        finishOptionMultiplier DECIMAL(5,2)
    )
    RETURNS decimal(10,2)
    DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY DEFINER
    COMMENT ''
RETURN IF(finishTitle IS NULL, 0, preFinishCost * Coalesce(finishOptionMultiplier, 0));
