DELIMITER $$


DROP TRIGGER IF EXISTS CustomerContact_before_upd_tr1
$$
CREATE TRIGGER `CustomerContact_before_upd_tr1` BEFORE UPDATE ON `CustomerContact`
  FOR EACH ROW
BEGIN
DECLARE stateCountry INT;


IF NEW.ContactState IS NOT NULL THEN
		select CountryID
		INTO @stateCountry
		from TblState
		where state = NEW.ContactState;
		
		IF @stateCountry <> NEW.ContactCountryID THEN
			SET @message_text = Concat('State and country must match. State=', NEW.ContactState, '; CountryID=', NEW.ContactCountryID);
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @message_text;
		END IF;
END IF;


END
$$



DROP TRIGGER IF EXISTS CustomerContact_before_ins_tr1
$$
CREATE TRIGGER `CustomerContact_before_ins_tr1` BEFORE INSERT ON `CustomerContact`
  FOR EACH ROW
BEGIN
DECLARE stateCountry INT;


IF NEW.ContactState IS NOT NULL THEN
		select CountryID
		INTO @stateCountry
		from TblState
		where state = NEW.ContactState;
		
		IF @stateCountry <> NEW.ContactCountryID THEN
			SET @message_text = Concat('State and country must match. State=', NEW.ContactState, '; CountryID=', NEW.ContactCountryID);
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @message_text;
		END IF;
END IF;


END
$$


DELIMITER ;