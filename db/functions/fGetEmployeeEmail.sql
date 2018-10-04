DELIMITER $$



DROP FUNCTION IF EXISTS `fGetEmployeeEmail`
$$
CREATE FUNCTION `fGetEmployeeEmail` (pCompanyID INT, EmailStairs VARCHAR(50), pEmailViewrail VARCHAR(50))
	RETURNS VARCHAR(50)
	DETERMINISTIC
	SQL SECURITY INVOKER
	COMMENT 'Each employee has 2 email addresses, one for StairSupplies and another one for Viewrail. Return the right address depending on the company.
	If the Viewrail address is not filled in the Stairsupplies one is returned'
BEGIN
	DECLARE COMPANY_VIEWRAIL INT DEFAULT 4;

	RETURN IF(pCompanyID = COMPANY_VIEWRAIL AND pEmailViewrail IS NOT NULL AND pEmailViewrail <> '', pEmailViewrail, EmailStairs);
END
$$



DELIMITER ;