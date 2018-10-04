DROP TABLE `CustomerNotes`;

--  Bad data in the database because the estimated shipping cost was required
-- and they had to enter something there...
update TblOrdersBOM
SET estimated_shipping_cost = NULL
WHERE estimated_shipping_cost IN (0, 0.01, 0.02);