DELIMITER $$



-- Replace needle with str_rep in str, case insensitive (MySQL's replace function is case sensitive so we need a new function)
DROP FUNCTION IF EXISTS `replace_ci`
$$
CREATE FUNCTION `replace_ci`(
	`str` TEXT,
	`needle` CHAR(255),
	`str_rep` CHAR(255)
)
RETURNS text
DETERMINISTIC
SQL SECURITY INVOKER
COMMENT ''
BEGIN
        DECLARE return_str TEXT DEFAULT '';
        DECLARE lower_str TEXT;
        DECLARE lower_needle TEXT;
        DECLARE pos INT DEFAULT 1;
        DECLARE old_pos INT DEFAULT 1;

        SELECT lower(str) INTO lower_str;
        SELECT lower(needle) INTO lower_needle;
        SELECT locate(lower_needle, lower_str, pos) INTO pos;
        WHILE pos > 0 DO
            SELECT concat(return_str, substr(str, old_pos, pos-old_pos), str_rep) INTO return_str;
            SELECT pos + char_length(needle) INTO pos;
            SELECT pos INTO old_pos;
            SELECT locate(lower_needle, lower_str, pos) INTO pos;
        END WHILE;
        SELECT concat(return_str, substr(str, old_pos, char_length(str))) INTO return_str;
        RETURN return_str;
END
$$



DELIMITER ;