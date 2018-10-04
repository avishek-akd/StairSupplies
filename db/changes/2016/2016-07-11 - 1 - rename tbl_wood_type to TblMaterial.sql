ALTER TABLE `tbl_wood_type`
	ADD COLUMN `d_type` VARCHAR(5) NULL COMMENT 'wood or metal' AFTER `d_name`,
	COMMENT='Type of material';
RENAME TABLE `tbl_wood_type` TO `TblMaterial`;
UPDATE TblMaterial SET d_type = 'wood';
UPDATE TblMaterial SET d_type = 'metal' where d_name like '%steel%' or d_name like '%Aluminum%';
UPDATE TblMaterial SET d_name = 'Stock Wood' WHERE id=27;



RENAME TABLE `tbl_wood_type_finishes` TO `TblMaterialFinish`;
ALTER TABLE `TblMaterialFinish`
	ALTER `d_wood_type_id` DROP DEFAULT;
ALTER TABLE `TblMaterialFinish`
	CHANGE COLUMN `d_wood_type_id` `d_material_id` INT(11) NOT NULL FIRST;



RENAME TABLE `tbl_wood_type_lumber_type` TO `TblMaterialLumberType`;
ALTER TABLE `TblMaterialLumberType`
	ALTER `d_wood_type_id` DROP DEFAULT;
ALTER TABLE `TblMaterialLumberType`
	CHANGE COLUMN `d_wood_type_id` `d_material_id` INT(10) NOT NULL AFTER `id`;



ALTER TABLE `TblOrdersBOM`
	CHANGE COLUMN `WoodTypeID` `MaterialWoodID` INT(11) NULL DEFAULT NULL AFTER `ShippedDate`;
ALTER TABLE `TblOrdersBOM`
	ADD COLUMN `MaterialMetalID` INT(11) NULL DEFAULT NULL AFTER `MaterialWoodID`,
	ADD CONSTRAINT `FK_TblOrdersBOM_TblMaterial` FOREIGN KEY (`MaterialMetalID`) REFERENCES `TblMaterial` (`id`);

	
	
ALTER TABLE `Products`
	DROP FOREIGN KEY `Products_fk_WoodType`;
ALTER TABLE `Products`
	CHANGE COLUMN `WoodTypeID` `MaterialID` INT(10) NULL DEFAULT NULL AFTER `ProductType_id`,
	ADD CONSTRAINT `Products_fk_Material` FOREIGN KEY (`MaterialID`) REFERENCES `TblMaterial` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION;


	
DELIMITER $$

	

DROP VIEW IF EXISTS vOrderItemCosts
$$
CREATE SQL SECURITY INVOKER VIEW vOrderItemCosts AS
SELECT orderItemsId,
		IF(costsAreFrozen = 1,
			OBOMI.costPurchase,
			Products.Purchase_price
			) AS costPurchase,
		IF(costsAreFrozen = 1,
			OBOMI.costPurchaseIncludedProducts,
			Products.PurchasePriceOfIncludedProducts
			) AS costPurchaseIncludedProducts,
		IF(costsAreFrozen = 1,
			IF(OBOMI.costPurchase IS NULL, OBOMI.costPurchaseIncludedProducts, OBOMI.costPurchase),
			IF(Products.Purchase_price IS NULL, Products.PurchasePriceOfIncludedProducts, Products.Purchase_price)
			) AS costOfPurchase,
		IF(costsAreFrozen = 1,
			OBOMI.costOfLabor,
			Products.LaborCost
			) AS costOfLabor,
		IF(costsAreFrozen = 1,
			OBOMI.costPreFinish,
			Products.PreFinishCost
			) AS costPreFinish,
		IF(costsAreFrozen = 1,
			OBOMI.costFinishOptionMultiplier,
			TblFinishOption.FinishPriceMultiplier
			) AS costFinishOptionMultiplier,
		IF(costsAreFrozen = 1,
			IF(OBOMI.FinishOptionID IS NULL, 0, Coalesce(OBOMI.costPreFinish * OBOMI.costFinishOptionMultiplier, 0)),
			IF(OBOMI.FinishOptionID IS NULL, 0, Coalesce(Products.PreFinishCost * TblFinishOption.FinishPriceMultiplier, 0))
			) AS costOfPreFinish,
		IF(costsAreFrozen = 1,
			OBOMI.costLumberRate,
			TblMaterialLumberType.d_lumber_rate
			) AS costLumberRate,
		IF(costsAreFrozen = 1,
			OBOMI.costBoardFootage,
			Products.boardFootage
			) AS costBoardFootage,
		IF(costsAreFrozen = 1,
			Coalesce(OBOMI.costLumberRate * OBOMI.costBoardFootage, 0),
			Coalesce(TblMaterialLumberType.d_lumber_rate * Products.boardFootage, 0)
			) AS costOfBoardFootage,
		IF(costsAreFrozen = 1,
			IF(OBOMI.costPurchase IS NULL, OBOMI.costPurchaseIncludedProducts, OBOMI.costPurchase)
			+ OBOMI.costOfLabor
			+ Coalesce(OBOMI.costPreFinish * OBOMI.costFinishOptionMultiplier, 0)
			+ Coalesce(OBOMI.costLumberRate * OBOMI.costBoardFootage, 0)
			,
			IF(Products.Purchase_price IS NULL, Products.PurchasePriceOfIncludedProducts, Products.Purchase_price)
			+ Products.LaborCost
			+ Coalesce(Products.PreFinishCost * TblFinishOption.FinishPriceMultiplier, 0)
			+ Coalesce(TblMaterialLumberType.d_lumber_rate * Products.boardFootage, 0)
			) AS costPerUnit
FROM TblOrdersBOM_Items AS OBOMI
	INNER JOIN Products             ON Products.productID = OBOMI.productID
	LEFT JOIN TblFinishOption       ON TblFinishOption.id = OBOMI.FinishOptionID
	LEFT JOIN TblMaterial           ON TblMaterial.id = Products.MaterialID
	LEFT JOIN TblMaterialLumberType ON (TblMaterialLumberType.d_material_id = Products.MaterialID
											AND TblMaterialLumberType.d_lumber_type_id = Products.LumberTypeID)
$$


DROP VIEW IF EXISTS vOrderItems
$$
CREATE ALGORITHM=UNDEFINED SQL SECURITY INVOKER VIEW `vOrderItems` AS 
select `TblOrdersBOM_Items`.`OrderItemsID` AS `orderItemsID`,
       `TblOrdersBOM_Items`.`OrderID` AS `orderID`,
       `TblOrdersBOM_Items`.`GroupID` AS `GroupID`,
       `TblOrdersBOM_Items`.`UnitPrice` AS `unitPrice`,
       `TblOrdersBOM_Items`.`ProductName` AS `ProductName`,
       `TblOrdersBOM_Items`.`ProductDescription` AS `ProductDescription`,
       `TblOrdersBOM_Items`.`In_House_Notes` AS `in_house_notes`,
       `TblOrdersBOM_Items`.`Customer_Notes` AS `Customer_Notes`,
       `TblOrdersBOM_Items`.`PostNumbersList` AS `PostNumbersList`,
       `TblOrdersBOM_Items`.`QuantityOrdered` AS `QuantityOrdered`,
       `TblOrdersBOM_Items`.`UnitWeight` AS `unitWeight`,
       `TblOrdersBOM_Items`.`QuantityShipped` AS `quantityShipped`,
       `TblOrdersBOM_Items`.`DiscountPercent` AS `discountPercent`,
       `TblOrdersBOM_Items`.`Shipped` AS `shipped`,
       `TblOrdersBOM_Items`.`GroupSortField` AS `GroupSortField`,
       `TblOrdersBOM_Items`.`Special_Instructions` AS `Special_Instructions`,
       vOrderItemPrice.unitPriceDiscounted AS `discountedUnitPrice`,
       vOrderItemPrice.unitPriceDiscounted * QuantityOrdered AS itemPrice,
       `TblOrdersBOM_Items`.`FinishOptionID` AS `FinishOptionID`,
       `Products`.`MaterialID` AS `MaterialID`,
       `TblMaterial`.`d_name` AS `materialName`,
       `TblMaterial`.`d_finish_image_unfinished` AS `d_finish_image_unfinished`,
       `TblMaterial`.`d_finish_image_standard` AS `d_finish_image_standard`,
       `TblFinishOption`.`FinishImage` AS `FinishImage`,
       `TblFinishOption`.`title` AS `finishOptionTitle`,
       `Products`.`Unit_of_Measure` AS `Unit_of_Measure`,
       `Products`.`ProductType_id` AS `ProductType_Id`,
       `Products`.`ProductID` AS `ProductID`
from `TblOrdersBOM_Items`
	INNER JOIN vOrderItemPrice    ON vOrderItemPrice.OrderItemsID = TblOrdersBOM_Items.OrderItemsID
     left join `Products`         ON `Products`.`ProductID` = `TblOrdersBOM_Items`.`ProductID`
     left join `TblMaterial`      ON `TblMaterial`.`id` = `Products`.`MaterialID`
     left join `TblFinishOption`  ON `TblFinishOption`.`id` = `TblOrdersBOM_Items`.`FinishOptionID`
order by `TblOrdersBOM_Items`.`OrderItemsID`
$$



DELIMITER ;
