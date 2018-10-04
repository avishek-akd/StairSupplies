/*  Each finish option has a multiplier that is applied to the finish price of the product when that product is added to the order  */
ALTER TABLE `FinishOption`
	ADD COLUMN `FinishPriceMultiplier` DECIMAL(5,2) NOT NULL COMMENT 'Multiplier that is applied to a product\'s Finish price' AFTER `description`
;
update FinishOption
set FinishPriceMultiplier = 1
;