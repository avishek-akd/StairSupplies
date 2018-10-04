UPDATE TblEmployee
SET
	accountingAccessLevel = 5
WHERE
	accountingAccessLevel = 4;

	
UPDATE TblEmployee
SET
	accountingAccessLevel = 4
WHERE
	accountingAccessLevel = 3;