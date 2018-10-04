--  Hide wildwood from system
UPDATE `Company` SET `isActive`=0 WHERE  `CompanyID`=3
;


--  Disable all Wildwood employees
-- 
-- 155	Helmuth, Dennis 	6168	Wildwood Only
-- 229	Helmuth, Janell 	4949	Wildwood Only
-- 236	Lambright, Steve 	1158	Wildwood Only
-- 342	Stahley, Ed 	9880	Wildwood Only
-- 344	Medina, Frank 	5197	Wildwood Only
-- 375	Helmuth, Marla 	3295	Wildwood Only
-- 376	Lopez, Francisco 	5654	Wildwood Only
-- 377	Ortiz, Paula 	7685	Wildwood Only
-- 378	Rodriguez, Rene 	448	Wildwood Only
-- 380	Yoder, Marlin 	5662	Wildwood Only
-- 381	Helmuth, Galen 	1970	Wildwood Only
-- 382	Otto, Derrick 	9342	Wildwood Only
-- 387	Alaniz, Salome 	4138	Wildwood Only
update Employees
set Archive = 1
where EmployeeID IN (155, 229, 236, 342, 344, 375, 376, 377, 378, 380, 381, 382, 387)
;