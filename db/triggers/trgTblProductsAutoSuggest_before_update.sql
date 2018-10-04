DELIMITER $$


DROP TRIGGER IF EXISTS `trgTblProductsAutoSuggest_before_update`
$$
CREATE TRIGGER `trgTblProductsAutoSuggest_before_update` BEFORE UPDATE ON `TblProductsAutoSuggest` FOR EACH ROW BEGIN

IF ((NEW.ProductSuggestionID IS NULL and NEW.GroupSuggestionID IS NULL)
	OR (NEW.ProductSuggestionID IS NOT NULL and NEW.GroupSuggestionID IS NOT NULL)) THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Only one of ProductSuggestionID or GroupSuggestionID must be filled.';
END IF;

IF NEW.GroupSuggestionID IS NOT NULL AND NEW.Mandatory = 1 THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Mandatory cannot be set for groups.';
END IF;

END
$$


DELIMITER ;