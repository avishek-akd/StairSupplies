DROP TABLE TblMaterialAlternativeName
;

ALTER TABLE TblMaterial
	ADD COLUMN `d_name_in_product` VARCHAR(50) NULL DEFAULT NULL COMMENT 'When searching for similar products this is the how the material name appears in the product name.' AFTER `d_name`
;
UPDATE TblMaterial SET d_name_in_product = d_name;
UPDATE TblMaterial SET d_name_in_product = 'Douglas Fir' WHERE id = 37;
UPDATE TblMaterial SET d_name_in_product = '316SS' WHERE id = 70;
UPDATE TblMaterial SET d_name_in_product = '304SS' WHERE id = 71;
UPDATE TblMaterial SET d_name_in_product = 'Alum' WHERE id = 73;