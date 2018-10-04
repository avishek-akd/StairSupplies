DELIMITER $$



--  State and Country need to be in sync (we have triggers but existing data is wrong)
UPDATE CustomerContact
SET `ContactStateOther`='TX_'
WHERE  `CustomerContactID`=28734
$$
UPDATE CustomerContact
SET ContactCountryID = (SELECT countryid FROM TblState WHERE State = CustomerContact.ContactState)
WHERE contactState IS NOT NULL
$$
--  State is valid, should be in the regular field, not in Other 
UPDATE CustomerContact
SET ContactState = ContactStateOther,
	ContactStateOther = NULL
WHERE ContactStateOther IN (SELECT State FROM TblState)
	AND ContactCountryID in (1,2)
$$
UPDATE CustomerContact
SET ContactState = (select State from TblState WHERE StateFull = ContactStateOther),
	ContactStateOther = NULL
WHERE ContactStateOther IN (select StateFull from TblState)
$$
--  State is valid but we don't have the country
UPDATE CustomerContact
SET
	ContactCountryId = (SELECT CountryId FROM TblState WHERE State = CustomerContact.ContactState)
WHERE ContactState IN (SELECT State from TblState)
	AND ContactCountryID IS NULL
$$
UPDATE CustomerContact
SET ContactStateOther = NULL 
WHERE contactState IS NOT NULL
$$
UPDATE CustomerContact
SET ContactStateOther=NULL
WHERE ContactStateOther IS NOT NULL
	AND ContactCountryID IN (1,2)
$$
UPDATE CustomerContact
SET ContactStateOther = NULL
WHERE ContactStateOther IS NOT NULL
	AND ContactState IS NOT NULL
$$




UPDATE TblOrdersBOM
SET ShipCountryID = (SELECT countryid FROM TblState WHERE State = TblOrdersBOM.ShipState)
WHERE ShipState IS NOT NULL
$$
UPDATE TblOrdersBOM
SET ShipState = ShipStateOther,
	ShipStateOther = NULL
WHERE ShipStateOther IN (SELECT State FROM TblState)
$$
UPDATE TblOrdersBOM
SET ShipCountryId = (SELECT CountryId FROM TblState WHERE ShipState = State)
WHERE ShipState IN (select State from TblState)
	AND ShipCountryId IS NULL
$$
UPDATE TblOrdersBOM
SET ShipCountryId = 1
WHERE ShipCountryId IS NULL
$$



UPDATE TblOrdersBOM
SET BillCountryID = (SELECT countryid FROM TblState WHERE State = TblOrdersBOM.BillState)
WHERE BillState IS NOT NULL
$$
UPDATE TblOrdersBOM
SET BillState = BillStateOther,
	BillStateOther = NULL
WHERE BillStateOther IN (SELECT State FROM TblState)
$$
UPDATE TblOrdersBOM
SET BillCountryId = (SELECT CountryId FROM TblState WHERE BillState = State)
WHERE BillState IN (select State from TblState)
	AND BillCountryId IS NULL
$$
UPDATE TblOrdersBOM
SET BillCountryId = 1
WHERE BillCountryId IS NULL
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


DROP TRIGGER IF EXISTS TblOrdersBOM_before_ins_tr1
$$
CREATE TRIGGER `TblOrdersBOM_before_ins_tr1` BEFORE INSERT ON `TblOrdersBOM`
  FOR EACH ROW
BEGIN
DECLARE stateCountry INT;

IF NEW.BillState IS NOT NULL THEN
		select CountryID
		INTO @stateCountry
		from TblState
		where state = NEW.BillState;
		
		IF @stateCountry <> NEW.BillCountryID THEN
			SET @message_text = Concat('Billing state and country must match. State=', NEW.BillState, '; CountryID=', NEW.BillCountryID);
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @message_text;
		END IF;
END IF;
IF NEW.BillState IS NOT NULL AND NEW.BillStateOther IS NOT NULL
THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Only one of BillState or BillStateOther must be given.';
END IF;

IF NEW.ShipState IS NOT NULL THEN
		select CountryID
		INTO @stateCountry
		from TblState
		where state = NEW.ShipState;
		
		IF @stateCountry <> NEW.ShipCountryID THEN
			SET @message_text = Concat('Shippingstate and country must match. State=', NEW.ShipState, '; CountryID=', NEW.ShipCountryID);
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @message_text;
		END IF;
END IF;
IF NEW.ShipState IS NOT NULL AND NEW.ShipStateOther IS NOT NULL
THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Only one of ShipState or ShipStateOther must be given.';
END IF;

END
$$


DROP TRIGGER IF EXISTS TblOrdersBOM_before_upd_tr1
$$
CREATE TRIGGER `TblOrdersBOM_before_upd_tr1` BEFORE UPDATE ON `TblOrdersBOM`
  FOR EACH ROW
BEGIN
DECLARE stateCountry INT;

IF NEW.BillState IS NOT NULL THEN
		select CountryID
		INTO @stateCountry
		from TblState
		where state = NEW.BillState;
		
		IF @stateCountry <> NEW.BillCountryID THEN
			SET @message_text = Concat('Billing state and country must match. State=', NEW.BillState, '; CountryID=', NEW.BillCountryID);
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @message_text;
		END IF;
END IF;
IF NEW.BillState IS NOT NULL AND NEW.BillStateOther IS NOT NULL
THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Only one of BillState or BillStateOther must be given.';
END IF;

IF NEW.ShipState IS NOT NULL THEN
		select CountryID
		INTO @stateCountry
		from TblState
		where state = NEW.ShipState;
		
		IF @stateCountry <> NEW.ShipCountryID THEN
			SET @message_text = Concat('Shippingstate and country must match. State=', NEW.ShipState, '; CountryID=', NEW.ShipCountryID);
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @message_text;
		END IF;
END IF;
IF NEW.ShipState IS NOT NULL AND NEW.ShipStateOther IS NOT NULL
THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Only one of ShipState or ShipStateOther must be given.';
END IF;

END
$$



DELIMITER ;