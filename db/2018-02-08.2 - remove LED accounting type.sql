DELETE
FROM TblOrdersBOM_Transactions_Accounting
WHERE ProductTypeAccountingTypeID = 4
;


DELETE
FROM TblProductTypeAccountingType
WHERE id = 4
;