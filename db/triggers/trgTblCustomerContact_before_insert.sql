DELIMITER $$


DROP TRIGGER IF EXISTS `trgTblCustomerContact_before_insert`
$$
CREATE TRIGGER `trgTblCustomerContact_before_insert` BEFORE INSERT ON `TblCustomerContact` FOR EACH ROW BEGIN
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

IF NEW.ContactState IS NOT NULL AND NEW.ContactStateOther IS NOT NULL
THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Only one of ContactState or ContactStateOther must be given.';
END IF;

IF NEW.AddressType NOT BETWEEN 0 AND 2
THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'AddressType must be between 0 and 2';
END IF;


END
$$


DELIMITER ;