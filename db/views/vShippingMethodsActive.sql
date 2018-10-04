CREATE OR REPLACE SQL SECURITY INVOKER VIEW `vShippingMethodsActive` AS 
SELECT
    `TblShippingMethods`.`ShippingMethodID` AS `ShippingMethodID`,
    `TblShippingMethods`.`ShippingMethod` AS `ShippingMethod`,
    `TblShippingMethods`.`TrackingNumberRequired` AS `TrackingNumberRequired`,
    `TblShippingMethods`.`EstimatedArrivalDateRequired` AS `EstimatedArrivalDateRequired` 
FROM 
    `TblShippingMethods` 
WHERE 
    (`TblShippingMethods`.`active` = 1) 
ORDER BY 
    `TblShippingMethods`.`ShippingMethod`
;