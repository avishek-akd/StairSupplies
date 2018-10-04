EXEC sp_rename '[dbo].[TblOrdersBOM].[Delivered]', 'Shipped', 'COLUMN'
GO
EXEC sp_rename '[dbo].[TblOrdersBOM].[DeliveredDate]', 'ShippedDate', 'COLUMN'
GO
EXEC sp_rename '[dbo].[TblOrdersBOM].[DeliveredPartial]', 'ShippedPartial', 'COLUMN'
GO
EXEC sp_rename '[dbo].[TblOrdersBOM].[DeliveredPartialDate]', 'ShippedPartialDate', 'COLUMN'
GO
EXEC sp_rename '[dbo].[TblOrdersBOM].[DeliveredUser]', 'ShippedUser', 'COLUMN'
GO


EXEC sp_rename '[dbo].[TblOrdersBOM_Items].[Delivered]', 'Shipped', 'COLUMN'
GO
EXEC sp_rename '[dbo].[TblOrdersBOM_Items].[DeliveredDate]', 'ShippedDate', 'COLUMN'
GO


EXEC sp_rename '[dbo].[TblOrdersBOM_Shipping].[Delivered]', 'Shipped', 'COLUMN'
GO
EXEC sp_rename '[dbo].[TblOrdersBOM_Shipping].[DeliveredDate]', 'ShippedDate', 'COLUMN'
GO
EXEC sp_rename '[dbo].[TblOrdersBOM_Shipping].[DeliveredPartial]', 'ShippedPartial', 'COLUMN'
GO
EXEC sp_rename '[dbo].[TblOrdersBOM_Shipping].[DeliveredPartialDate]', 'ShippedPartialDate', 'COLUMN'
GO
EXEC sp_rename '[dbo].[TblOrdersBOM_Shipping].[DeliveredUser]', 'ShippedUser', 'COLUMN'
GO


EXEC sp_rename '[dbo].[TblOrdersBOM_Shipping_Details].[Delivered]', 'Shipped', 'COLUMN'
GO
EXEC sp_rename '[dbo].[TblOrdersBOM_Shipping_Details].[DeliveredDate]', 'ShippedDate', 'COLUMN'
GO
EXEC sp_rename '[dbo].[TblOrdersBOM_Shipping_Details].[DeliveredPartial]', 'ShippedPartial', 'COLUMN'
GO
EXEC sp_rename '[dbo].[TblOrdersBOM_Shipping_Details].[DeliveredPartialDate]', 'ShippedPartialDate', 'COLUMN'
GO
EXEC sp_rename '[dbo].[TblOrdersBOM_Shipping_Details].[DeliveredUser]', 'ShippedUser', 'COLUMN'
GO


insert into tblProductType (ProductType, Description) Values ('WildWood', 'WildWood');
declare @id int;
set @id = (select scope_identity() );
insert into tblProductTypeCompany (ProductTypeId, CompanyId) values (@id, 3);


ALTER TRIGGER [dbo].[setHistory] ON [dbo].[TblOrdersBOM]
WITH EXECUTE AS CALLER
FOR UPDATE
AS
DECLARE @orderID numeric(10, 0);
DECLARE @orderUpdateID int;
DECLARE @oldValue VARCHAR(200);
DECLARE @newValue VARCHAR(200);
DECLARE @atLeastOneFieldUpdated bit;


IF UPDATE(Estimate) OR UPDATE(Ordered) OR UPDATE(Released) OR UPDATE(Shipped)
	OR UPDATE(Cancelled) OR UPDATE(DueDate) OR UPDATE(CreditCardCharged) OR UPDATE(PaidDate)
BEGIN

    SET @atLeastOneFieldUpdated =     
    	(SELECT 1
        WHERE ((SELECT Estimate FROM deleted) <> (SELECT Estimate FROM inserted))
        	OR ((SELECT Ordered FROM deleted) <> (SELECT Ordered FROM inserted))
        	OR ((SELECT Released FROM deleted) <> (SELECT Released FROM inserted))
        	OR ((SELECT Shipped FROM deleted) <> (SELECT Shipped FROM inserted))
        	OR ((SELECT Cancelled FROM deleted) <> (SELECT Cancelled FROM inserted))
        	OR ((SELECT DueDate FROM deleted) <> (SELECT DueDate FROM inserted))
        	OR ((SELECT CreditCardCharged FROM deleted) <> (SELECT CreditCardCharged FROM inserted))
        	OR ((SELECT PaidDate FROM deleted) <> (SELECT PaidDate FROM inserted))
        );
              
	/*  Nothing to do if no field was updated  */
	IF @atLeastOneFieldUpdated IS NULL
    BEGIN
    	SELECT 0 AS orderUpdateID
    	RETURN
    END


	BEGIN TRANSACTION AuditTrans;

	SELECT @orderID = orderID FROM inserted;
    INSERT INTO tblOrdersBOM_Update(d_update_date, orderID) VALUES(GetDate(), @orderID);
	SELECT @orderUpdateID = SCOPE_IDENTITY();


    IF Update(Estimate)
    BEGIN
	    SELECT @oldValue = Estimate FROM deleted;
	    SELECT @newValue = Estimate FROM inserted;
        IF @oldValue <> @newValue
        BEGIN
		    INSERT INTO tblOrdersBOM_UpdateDetails(orderUpdateID, field_name, old_value, new_value)
    		VALUES (@orderUpdateID, 'Estimate', @oldValue, @newValue);
        END
    END      
    IF Update(Ordered)
    BEGIN
	    SELECT @oldValue = Ordered FROM deleted;
	    SELECT @newValue = Ordered FROM inserted;
        IF @oldValue <> @newValue
        BEGIN
		    INSERT INTO tblOrdersBOM_UpdateDetails(orderUpdateID, field_name, old_value, new_value)
    		VALUES (@orderUpdateID, 'Ordered', @oldValue, @newValue);
        END
    END      
    IF Update(Released)
    BEGIN
	    SELECT @oldValue = Released FROM deleted;
	    SELECT @newValue = Released FROM inserted;
        IF @oldValue <> @newValue
        BEGIN
		    INSERT INTO tblOrdersBOM_UpdateDetails(orderUpdateID, field_name, old_value, new_value)
    		VALUES (@orderUpdateID, 'Released', @oldValue, @newValue);
        END
    END  
    IF Update(Shipped)
    BEGIN
	    SELECT @oldValue = Shipped FROM deleted;
	    SELECT @newValue = Shipped FROM inserted;
        IF @oldValue <> @newValue
        BEGIN
		    INSERT INTO tblOrdersBOM_UpdateDetails(orderUpdateID, field_name, old_value, new_value)
    		VALUES (@orderUpdateID, 'Shipped', @oldValue, @newValue);
        END
    END          
    IF Update(Cancelled)
    BEGIN
	    SELECT @oldValue = Cancelled FROM deleted;
	    SELECT @newValue = Cancelled FROM inserted;
        IF @oldValue <> @newValue
        BEGIN
		    INSERT INTO tblOrdersBOM_UpdateDetails(orderUpdateID, field_name, old_value, new_value)
    		VALUES (@orderUpdateID, 'Cancelled', @oldValue, @newValue);
        END
    END  
    IF Update(DueDate)
    BEGIN
	    SELECT @oldValue = DueDate FROM deleted;
	    SELECT @newValue = DueDate FROM inserted;
        IF @oldValue <> @newValue
        BEGIN
		    INSERT INTO tblOrdersBOM_UpdateDetails(orderUpdateID, field_name, old_value, new_value)
	    	VALUES (@orderUpdateID, 'DueDate', @oldValue, @newValue);
        END
    END  
    IF Update(CreditCardCharged)
    BEGIN
	    SELECT @oldValue = CreditCardCharged FROM deleted;
	    SELECT @newValue = CreditCardCharged FROM inserted;
        IF @oldValue <> @newValue
        BEGIN
		    INSERT INTO tblOrdersBOM_UpdateDetails(orderUpdateID, field_name, old_value, new_value)
    		VALUES (@orderUpdateID, 'CreditCardCharged', @oldValue, @newValue);
        END
    END  
    IF Update(PaidDate)
    BEGIN
	    SELECT @oldValue = PaidDate FROM deleted;
	    SELECT @newValue = PaidDate FROM inserted;
        IF @oldValue <> @newValue
        BEGIN
		    INSERT INTO tblOrdersBOM_UpdateDetails(orderUpdateID, field_name, old_value, new_value)
    		VALUES (@orderUpdateID, 'PaidDate', @oldValue, @newValue);
        END
    END           

   	SELECT @orderUpdateID AS orderUpdateID

    COMMIT TRANSACTION AuditTrans;
END

SELECT 0 AS orderUpdateID
GO