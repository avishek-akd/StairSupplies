ALTER TABLE `TblProductType`
	CHANGE COLUMN `isPost2` `postType` TINYINT(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT '=0 not post, =1 is post, =2 goes with post' AFTER `ShowOnAddOrderItem2`,
	CHANGE COLUMN `isHandrail2` `handrailType` TINYINT(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT '=0 not handrail, =1 is handrail, =2 goes with handrail' AFTER `PostTopStyleID`
;
