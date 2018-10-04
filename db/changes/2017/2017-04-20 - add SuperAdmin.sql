INSERT INTO Employees_role
	(role_name)
VALUES
	('SuperAdmin')
;

INSERT INTO Employees_role_access
	(role_id, module_id)
SELECT LAST_INSERT_ID(), Module_id
	FROM Employees_module
;