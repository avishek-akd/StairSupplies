--  We don't need LONGTEXT, Varchar is good enough
ALTER TABLE `TblOrdersBOM`
	CHANGE COLUMN `Notes_From_Customer` `Notes_From_Customer` VARCHAR(4000) NULL COLLATE 'utf8_unicode_ci' AFTER `_unused_In_House_Notes_bk`,
	CHANGE COLUMN `ShippingDirections` `ShippingDirections` VARCHAR(2000) NULL COLLATE 'utf8_unicode_ci' AFTER `CustomerQuotationPONumber`;
ALTER TABLE `TblRGARequest`
	CHANGE COLUMN `d_details` `d_details` VARCHAR(2000) NULL DEFAULT NULL,
	CHANGE COLUMN `d_notes_internal` `d_notes_internal` VARCHAR(1000) NULL DEFAULT NULL;


--  iPhoneToken is no longer used	
ALTER TABLE `Employees`
	CHANGE COLUMN `iPhoneToken` `_unused_iPhoneToken` CHAR(64) NULL DEFAULT NULL COMMENT 'Device token ID used by the employee when he last signed in.' COLLATE 'utf8_unicode_ci' AFTER `ChauffersLicenseLogged`;

--  Archive should be at the end of the fields
ALTER TABLE `Employees`
	CHANGE COLUMN `Archive` `Archive` TINYINT(4) NULL DEFAULT '0' AFTER `_unused_iPhoneToken`;


--  Missing Foreign Key
ALTER TABLE `Customers`
	ADD CONSTRAINT `FK_Customers_CustomerType` FOREIGN KEY (`CustomerTypeID`) REFERENCES `CustomerType` (`id`);



DELIMITER $$


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

IF NEW.AddressType NOT BETWEEN 0 AND 2
THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'AddressType must be between 0 and 2';
END IF;


END
$$



DELIMITER ;