DELIMITER $$



CREATE TRIGGER `CustomerContact_before_upd_tr1` BEFORE UPDATE ON `CustomerContact`
  FOR EACH ROW
BEGIN
DECLARE stateCountry INT;


select CountryID
INTO @stateCountry
from TblState
where state = NEW.ContactState;


IF @stateCountry <> NEW.ContactCountryID THEN
	SET @message_text = Concat('State and country must match. State=', NEW.ContactState, '; CountryID=', NEW.ContactCountryID);
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @message_text;
END IF;


END
$$



CREATE TRIGGER `CustomerContact_before_ins_tr1` BEFORE INSERT ON `CustomerContact`
  FOR EACH ROW
BEGIN
DECLARE stateCountry INT;


select CountryID
INTO @stateCountry
from TblState
where state = NEW.ContactState;


IF @stateCountry <> NEW.ContactCountryID THEN
	SET @message_text = Concat('State and country must match. State=', NEW.ContactState, '; CountryID=', NEW.ContactCountryID);
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @message_text;
END IF;


END
$$


DELIMITER ;