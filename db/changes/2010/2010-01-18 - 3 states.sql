--
-- State
--
ALTER TABLE [dbo].[TblState]
ADD [CountryId] int NULL
GO
UPDATE tblState SET CountryId = 1
GO
ALTER TABLE [dbo].[TblState]
ADD CONSTRAINT [TblState_fk] FOREIGN KEY ([CountryId]) 
  REFERENCES [dbo].[Country] ([id]) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
GO
CREATE NONCLUSTERED INDEX [TblState_idx] ON [dbo].[TblState]
  ([CountryId])
WITH (
  PAD_INDEX = OFF,
  DROP_EXISTING = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  SORT_IN_TEMPDB = OFF,
  ONLINE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
GO
INSERT INTO tblState(State, StateFull, CountryId) VALUES('OR', 'Oregon', 1);
INSERT INTO tblState(State, StateFull, CountryId) VALUES('MT', 'Montana', 1);
INSERT INTO tblState(State, StateFull, CountryId) VALUES('DE', 'Delaware', 1);
INSERT INTO tblState(State, StateFull, CountryId) VALUES('VI', 'Virgin Islands', 1);

INSERT INTO tblState(State, StateFull, CountryId) VALUES('AB', 'Alberta', 2);
INSERT INTO tblState(State, StateFull, CountryId) VALUES('BC', 'British Columbia', 2);
INSERT INTO tblState(State, StateFull, CountryId) VALUES('MB', 'Manitoba', 2);
INSERT INTO tblState(State, StateFull, CountryId) VALUES('NB', 'New Brunswick', 2);
INSERT INTO tblState(State, StateFull, CountryId) VALUES('NL', 'Newfoundland and Labrador', 2);
INSERT INTO tblState(State, StateFull, CountryId) VALUES('NL', 'Northwest Territories', 2);
INSERT INTO tblState(State, StateFull, CountryId) VALUES('NS', 'Nova Scotia', 2);
INSERT INTO tblState(State, StateFull, CountryId) VALUES('NU', 'Nunavut', 2);
INSERT INTO tblState(State, StateFull, CountryId) VALUES('ON', 'Ontario', 2);
INSERT INTO tblState(State, StateFull, CountryId) VALUES('PE', 'Prince Edward Island', 2);
INSERT INTO tblState(State, StateFull, CountryId) VALUES('QC', 'Quebec', 2);
INSERT INTO tblState(State, StateFull, CountryId) VALUES('SK', 'Saskatchewan', 2);
INSERT INTO tblState(State, StateFull, CountryId) VALUES('YT', 'Yukon', 2);