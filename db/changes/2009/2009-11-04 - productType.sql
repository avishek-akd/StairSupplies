begin
declare @aaa  int
declare @gg  CURSOR

set @gg = CURSOR FOR SELECT ProductType_id from tblProductType WHERE ProductType_id <> 26
open @gg
FETCH NEXT FROM @gg INTO @aaa
WHILE @@FETCH_STATUS = 0
BEGIN
	insert into tblProductTypeCompany (ProductTypeId, CompanyId) VALUES (@aaa, 3)
	FETCH NEXT FROM @gg INTO @aaa
END
CLOSE @gg
DEALLOCATE @gg

end
