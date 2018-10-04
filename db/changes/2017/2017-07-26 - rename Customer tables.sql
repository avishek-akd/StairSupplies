RENAME TABLE `CustomerContact` TO `TblCustomerContact`;
RENAME TABLE `Customers` TO `TblCustomer`;
RENAME TABLE `CustomerType` TO `TblCustomerType`;
RENAME TABLE `CustomerInitialContact` TO `TblCustomerInitialContact`;



DELIMITER $$



DROP TRIGGER IF EXISTS `CustomerContact_before_ins_tr1`
$$
CREATE TRIGGER `TblCustomerContact_before_ins_tr1` BEFORE INSERT ON `TblCustomerContact` FOR EACH ROW BEGIN
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



DROP TRIGGER IF EXISTS `CustomerContact_before_upd_tr1`
$$
CREATE TRIGGER `TblCustomerContact_before_upd_tr1` BEFORE UPDATE ON `TblCustomerContact` FOR EACH ROW BEGIN
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



DELIMITER ;