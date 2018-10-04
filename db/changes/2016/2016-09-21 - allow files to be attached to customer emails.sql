CREATE TABLE `TblOrdersBOM_CustomerEmail` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`d_order_id` INT NOT NULL,
	`d_employee_id` INT NOT NULL,
	`d_email_sent_to` VARCHAR(200) NOT NULL,
	`d_message` VARCHAR(3000) NOT NULL,
	`d_record_created` DATETIME NOT NULL,
	PRIMARY KEY (`id`)
) ENGINE=InnoDB;
ALTER TABLE `TblOrdersBOM_CustomerEmail`
	ADD CONSTRAINT `FK_TblOrdersBOM_CustomerEmail_TblOrdersBOM` FOREIGN KEY (`d_order_id`) REFERENCES `TblOrdersBOM` (`OrderID`);
ALTER TABLE `TblOrdersBOM_CustomerEmail`
	ADD CONSTRAINT `FK_TblOrdersBOM_CustomerEmail_Employees` FOREIGN KEY (`d_employee_id`) REFERENCES `Employees` (`EmployeeID`);



CREATE TABLE `TblOrdersBOM_CustomerEmailFile` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`d_customer_email_id` INT NOT NULL,
	`d_file` VARCHAR(200) NOT NULL,
	PRIMARY KEY (`id`)
) ENGINE=InnoDB;
ALTER TABLE `TblOrdersBOM_CustomerEmailFile`
	ADD CONSTRAINT `FK_TblOrdersBOM_CustomerEmailFile_TblOrdersBOM_CustomerEmail` FOREIGN KEY (`d_customer_email_id`) REFERENCES `TblOrdersBOM_CustomerEmail` (`id`);
