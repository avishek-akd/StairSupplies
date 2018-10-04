ALTER TABLE `TblProductType`
	ADD COLUMN `type` TINYINT(1) NULL COMMENT '=1 Stock, =2 Production' AFTER `archived`;

-- Default all are Production
update TblProductType set type = 2;

--  Only some are stock
update TblProductType
set type = 1
where ProductType_id in (1,8,12);
