CREATE TABLE [dbo].[tblOrdersBOM_Update] (
  [id] int IDENTITY(1, 1) NOT NULL,
  [d_update_date] datetime NULL,
  [orderID] numeric(10, 0) NULL,
  [employeeID] int NULL
GO
ALTER TABLE [dbo].[tblOrdersBOM_Update]
ADD CONSTRAINT [tblOrdersBOM_Update_pk] PRIMARY KEY ([id])
GO
ALTER TABLE [dbo].[tblOrdersBOM_Update]
ADD CONSTRAINT [tblOrdersBOM_Update_fk] FOREIGN KEY ([orderID]) 
  REFERENCES [dbo].[TblOrdersBOM] ([OrderID]) 
  ON UPDATE NO ACTION
  ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblOrdersBOM_Update]
ADD CONSTRAINT [tblOrdersBOM_Update_fk2] FOREIGN KEY ([employeeID]) 
  REFERENCES [dbo].[Employees] ([EmployeeID]) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
GO
CREATE NONCLUSTERED INDEX [tblOrdersBOM_Update_idx] ON [dbo].[tblOrdersBOM_Update]
  ([orderID])
GO
CREATE NONCLUSTERED INDEX [tblOrdersBOM_Update_idx2] ON [dbo].[tblOrdersBOM_Update]
  ([employeeID])
GO



CREATE TABLE [dbo].[tblOrdersBOM_UpdateDetails] (
  [id] int IDENTITY(1, 1) NOT NULL,
  [orderUpdateID] int NULL,
  [field_name] varchar(50) NULL,
  [old_value] varchar(200) NULL,
  [new_value] varchar(200) NULL,
  PRIMARY KEY CLUSTERED ([id])
)
GO
CREATE NONCLUSTERED INDEX [tblOrdersBOM_UpdateDetails_idx] ON [dbo].[tblOrdersBOM_UpdateDetails]
  ([orderUpdateID])
GO
ALTER TABLE [dbo].[tblOrdersBOM_UpdateDetails]
ADD CONSTRAINT [tblOrdersBOM_UpdateDetails_fk] FOREIGN KEY ([orderUpdateID]) 
  REFERENCES [dbo].[tblOrdersBOM_Update] ([id]) 
  ON UPDATE NO ACTION
  ON DELETE CASCADE
GO



CREATE TRIGGER [dbo].[setHistory] ON [dbo].[TblOrdersBOM]
FOR INSERT, UPDATE
AS
DECLARE @orderID numeric(10, 0);
DECLARE @orderUpdateID int;
DECLARE @oldValue VARCHAR(200);
DECLARE @newValue VARCHAR(200);
DECLARE @atLeastOneFieldUpdated bit;


IF UPDATE(Estimate) OR UPDATE(Ordered) OR UPDATE(Released) OR UPDATE(Delivered)
	OR UPDATE(Cancelled) OR UPDATE(DueDate) OR UPDATE(CreditCardCharged) OR UPDATE(PaidDate)
BEGIN
	BEGIN TRANSACTION


	SELECT @orderID = orderID FROM inserted;
    INSERT INTO tblOrdersBOM_Update(d_update_date, orderID) VALUES(GetDate(), @orderID);
	SELECT @orderUpdateID = SCOPE_IDENTITY();

	
    SET @atLeastOneFieldUpdated = 0;
    
    
    IF Update(Estimate)
    BEGIN
	    SELECT @oldValue = Estimate FROM deleted;
	    SELECT @newValue = Estimate FROM inserted;
        IF @oldValue <> @newValue
        BEGIN
		    INSERT INTO tblOrdersBOM_UpdateDetails(orderUpdateID, field_name, old_value, new_value)
    		VALUES (@orderUpdateID, 'Estimate', @oldValue, @newValue);
            SET @atLeastOneFieldUpdated = 1;
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
            SET @atLeastOneFieldUpdated = 1;
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
            SET @atLeastOneFieldUpdated = 1;
        END
    END  
    IF Update(Delivered)
    BEGIN
	    SELECT @oldValue = Delivered FROM deleted;
	    SELECT @newValue = Delivered FROM inserted;
        IF @oldValue <> @newValue
        BEGIN
		    INSERT INTO tblOrdersBOM_UpdateDetails(orderUpdateID, field_name, old_value, new_value)
    		VALUES (@orderUpdateID, 'Delivered', @oldValue, @newValue);
            SET @atLeastOneFieldUpdated = 1;
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
            SET @atLeastOneFieldUpdated = 1;
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
            SET @atLeastOneFieldUpdated = 1;
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
            SET @atLeastOneFieldUpdated = 1;
        END
    END  
    IF Update(PaidDate)
    BEGIN
	    SELECT @oldValue = PaidDate FROM deleted;
	    SELECT @newValue = PaidDate FROM inserted;
        IF @oldValue <> @newValue
        BEGIN
		    INSERT INTO tblOrdersBOM_UpdateDetails(orderUpdateID, field_name, old_value, new_value)
    		VALUES (@orderUpdateID, 'PaidDate', @oldValue, @newValue);SET @atLeastOneFieldUpdated = 1;
        END
    END           
    

    if @atLeastOneFieldUpdated = 1
		/*  If we have at least 1 field updated then commit */    
	    COMMIT TRANSACTION;
    ELSE
    	/*  No field is actually updated, remove the already inserted rows into tblOrdersBOM_Update  */
    	ROLLBACK TRANSACTION;      
      
END
GO