DELIMITER $$


DROP TRIGGER IF EXISTS `trgTblOrdersBOM_before_update`
$$
CREATE TRIGGER `trgTblOrdersBOM_before_update` BEFORE UPDATE ON `TblOrdersBOM` FOR EACH ROW BEGIN
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
			SET @message_text = Concat('Shipping state and country must match. State=', NEW.ShipState, '; CountryID=', NEW.ShipCountryID);
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