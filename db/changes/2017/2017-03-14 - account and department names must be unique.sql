ALTER TABLE `TblPurchaseAccount`
	ADD UNIQUE INDEX `idxAccountTitle` (`AccountTitle`);
ALTER TABLE `TblPurchaseDepartment`
	ADD UNIQUE INDEX `idxName` (`Name`);
