DELIMITER $$



CREATE TABLE TblPostTopStyle (
	PostTopStyleID INT UNSIGNED NOT NULL AUTO_INCREMENT,
	Name VARCHAR(50) NOT NULL,
	RecordCreated DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	RecordUpdated DATETIME NULL DEFAULT NULL,
	PRIMARY KEY(PostTopStyleID)
) ENGINE=InnoDB
$$
INSERT INTO TblPostTopStyle
	(Name)
VALUES
	('Universal top - standard bracket'), ('Universal top - half bracket'), ('Universal top - left bracket'),
	('Universal top - right bracket'), ('Flat top - standard bracket'), ('Flat top - half bracket'), ('Flat top - left bracket'),
	('Flat top - right bracket')
$$


CREATE TABLE TblPostFootStyle (
	PostFootStyleID INT UNSIGNED NOT NULL AUTO_INCREMENT,
	Name VARCHAR(50) NOT NULL,
	RecordCreated DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	RecordUpdated DATETIME NULL DEFAULT NULL,
	PRIMARY KEY(PostFootStyleID)
) ENGINE=InnoDB
$$
INSERT INTO TblPostFootStyle
	(Name)
VALUES
	('Standard Foot'), ('Standard "B" Foot'), ('Side Mount Plate'), ('Side Mount Inside Corner Plate'),
	('Side Mount Outside Corner Plate'), ('Slim Side Mount'), ('Slim Side Mount Bump Out'), ('Special Application Foot'),
	('Special Application "B"')
$$


ALTER TABLE Products
	ADD COLUMN CutLength DECIMAL(10,2) UNSIGNED DEFAULT 0 AFTER `WebsiteImageURL`,
	ADD COLUMN CutAngle INT UNSIGNED DEFAULT 0 AFTER `CutLength`,
	ADD COLUMN PostTopStyleID INT UNSIGNED DEFAULT NULL AFTER `CutAngle`,
	ADD COLUMN PostFootStyleID INT UNSIGNED DEFAULT NULL AFTER `PostTopStyleID`,
	ADD COLUMN Configuration VARCHAR(20) DEFAULT NULL AFTER `PostFootStyleID`,
	ADD COLUMN HurcoProgram VARCHAR(50) DEFAULT NULL AFTER `Configuration`,
	ADD INDEX `idx_PostTopStyleID` (`PostTopStyleID`),
	ADD INDEX `idx_PostFootStyleID` (`PostFootStyleID`),
	ADD CONSTRAINT `FK_Products_TblPostTopStyle` FOREIGN KEY (`PostTopStyleID`) REFERENCES `TblPostTopStyle` (`PostTopStyleID`) ON UPDATE NO ACTION ON DELETE NO ACTION,
	ADD CONSTRAINT `FK_Products_TblPostFootStyle` FOREIGN KEY (`PostFootStyleID`) REFERENCES `TblPostFootStyle` (`PostFootStyleID`) ON UPDATE NO ACTION ON DELETE NO ACTION
$$


CREATE TRIGGER `trg_ProductsIns` BEFORE INSERT ON `Products`
  FOR EACH ROW
BEGIN

IF NEW.CutAngle NOT BETWEEN 0 and 90
THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'CutAngle must be between 0 and 90.';
END IF;

END
$$
CREATE TRIGGER `trg_ProductsUpd` BEFORE UPDATE ON `Products`
  FOR EACH ROW
BEGIN

IF NEW.CutAngle NOT BETWEEN 0 and 90
THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'CutAngle must be between 0 and 90.';
END IF;

END
$$



DELIMITER ;