DELIMITER $$



ALTER TABLE `ProductsAutoSuggest`
	ADD COLUMN `Mandatory` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '=1 This suggestion is automatically/always added to the order when the linked product is added.' AFTER `GroupSuggestionID`
$$	



DROP TRIGGER IF EXISTS ProductsAutoSuggest_before_ins_tr1
$$
CREATE TRIGGER `ProductsAutoSuggest_before_ins_tr1` BEFORE INSERT ON `ProductsAutoSuggest`
  FOR EACH ROW
BEGIN

IF ((NEW.ProductSuggestionID IS NULL and NEW.GroupSuggestionID IS NULL)
	OR (NEW.ProductSuggestionID IS NOT NULL and NEW.GroupSuggestionID IS NOT NULL)) THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Only one of ProductSuggestionID or GroupSuggestionID must be filled.';
END IF;

IF NEW.GroupSuggestionID IS NOT NULL AND NEW.Mandatory = 1 THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Mandatory cannot be set for groups.';
END IF;

END
$$



DROP TRIGGER IF EXISTS ProductsAutoSuggest_before_upd_tr1
$$
CREATE TRIGGER `ProductsAutoSuggest_before_upd_tr1` BEFORE UPDATE ON `ProductsAutoSuggest`
  FOR EACH ROW
BEGIN

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