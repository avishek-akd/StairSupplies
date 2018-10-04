ALTER TABLE TblProductType
	CHANGE COLUMN `type` z_unused_type TINYINT(1) NULL DEFAULT NULL COMMENT '=1 Stock, =2 Production' AFTER archived,
	ADD COLUMN type_id INT UNSIGNED NULL DEFAULT NULL AFTER z_unused_type;

CREATE TABLE TblProductTypeType (
	id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
	title VARCHAR(50) NOT NULL,
	PRIMARY KEY (id)
)
COMMENT='This is the type of ProductType'
COLLATE='utf8_general_ci';

INSERT INTO `TblProductTypeType` (`title`) VALUES ('Stock');
INSERT INTO `TblProductTypeType` (`title`) VALUES ('Production');
INSERT INTO `TblProductTypeType` (`title`) VALUES ('Cable Rail');
INSERT INTO `TblProductTypeType` (`title`) VALUES ('LED');


ALTER TABLE TblProductType
	ADD CONSTRAINT FK_TblProductType_TblProductTypeType FOREIGN KEY (type_id) REFERENCES TblProductTypeType (id);


update TblProductType set type_id = z_unused_type;


CREATE PROCEDURE `pricePerCategory`(IN `orderID` INTEGER(11))
	LANGUAGE SQL
	NOT DETERMINISTIC
	CONTAINS SQL
	SQL SECURITY INVOKER
	COMMENT ''
BEGIN

SELECT TblProductTypeType.title, Coalesce(Sum( Round((1 - discount) * unitPrice, 2) * quantity ), 0) as total
FROM TblProductType
INNER JOIN TblProductTypeType ON TblProductTypeType.id = TblProductType.type_id
LEFT JOIN Products            ON Products.ProductType_id = TblProductType.ProductType_id
LEFT JOIN TblOrdersBOM_Items  ON (TblOrdersBOM_Items.ProductID = Products.ProductId
AND TblOrdersBOM_Items.OrderId = orderID)
GROUP BY TblProductType.type_id
ORDER BY TblProductType.type_id ASC;

END
