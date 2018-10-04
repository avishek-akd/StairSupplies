using System;
using MySql.Data.MySqlClient;
using System.Data;


namespace StairSupplies.Database
{


	public class TblOrdersBOM
	{


		public static DataTable EnumerateAccountingTypesByTransactionID(Int32 orderTransactionID)
		{
			MySqlConnection cn = null;
			MySqlCommand cmd = new MySqlCommand();
			MySqlDataReader dr = null;
			try
			{
				PeakeyTools.Database.MySQL.OpenConnection(ref cn, ref cmd);
				cmd.CommandText = @"
SELECT
	IFNULL(TblOrdersBOM_Transactions_Accounting.Amount, 0) AS Total,
	CASE WHEN TblProductTypeAccountingType.Title = 'Sales Tax' THEN
		'Indiana Sales Tax'
    ELSE
		TblProductTypeAccountingType.Title
    END AS Title
FROM 
	TblOrdersBOM_Transactions_Accounting
	LEFT JOIN TblProductTypeAccountingType ON TblOrdersBOM_Transactions_Accounting.ProductTypeAccountingTypeID = TblProductTypeAccountingType.id
WHERE 
	TblOrdersBOM_Transactions_Accounting.OrderTransactionID = @orderTransactionID
ORDER BY 
	SortOrder ASC
";

				PeakeyTools.Database.MySQL.AddParameter(cmd, "@orderTransactionID", MySqlDbType.Int32, orderTransactionID);

				PeakeyTools.Database.MySQL.TrimCommandText(cmd);
				dr = cmd.ExecuteReader();

				return PeakeyTools.Database.MySQL.DataReaderToDataTable(dr);
			}
			catch (Exception ex)
			{
				throw new Exception("Could not enumerate accounting types by orderTransactionID.", ex);
			}
			finally
			{
				PeakeyTools.Database.MySQL.CleanUp(cn, cmd, dr);
			}
		}


		public static DataTable LoadBillingInformation(Int32 orderID)
		{
			MySqlConnection cn = null;
			MySqlCommand cmd = new MySqlCommand();
			MySqlDataReader dr = null;
			try
			{
				PeakeyTools.Database.MySQL.OpenConnection(ref cn, ref cmd);
				cmd.CommandText = @"
SELECT
	TblOrdersBOM.BillAddress1,
	TblOrdersBOM.BillAddress2, 
	TblOrdersBOM.BillAddress3, 
	TblOrdersBOM.BillCity, 
    TblOrdersBOM.BillState, 
    TblOrdersBOM.BillPostalCode, 
	TblOrdersBOM.BillPhoneNumber, 
	billingCountry.Code2 AS BillCountryCode
FROM 
	TblOrdersBOM 
	LEFT JOIN TblCountry AS billingCountry ON billingCountry.CountryID = TblOrdersBOM.BillCountryID
WHERE 
	TblOrdersBOM.OrderID = @orderID
";

				PeakeyTools.Database.MySQL.AddParameter(cmd, "@orderID", MySqlDbType.Int32, orderID);

				PeakeyTools.Database.MySQL.TrimCommandText(cmd);
				dr = cmd.ExecuteReader();

				return PeakeyTools.Database.MySQL.DataReaderToDataTable(dr);
			}
			catch (Exception ex)
			{
				PeakeyTools.Api.Log(PeakeyTools.Api.ApiName.payeezy, "Could not load billing information by orderID.", ex, "EXCEPTION");
				throw new Exception("Could not load billing information by orderID.", ex);
			}
			finally
			{
				PeakeyTools.Database.MySQL.CleanUp(cn, cmd, dr);
			}
		}


		public static DataTable LoadQuickbookInformation(Int32 orderTransactionID)
		{
			MySqlConnection cn = null;
			MySqlCommand cmd = new MySqlCommand();
			MySqlDataReader dr = null;
			try
			{
				PeakeyTools.Database.MySQL.OpenConnection(ref cn, ref cmd);
				cmd.CommandText = @"
SELECT
	TblOrdersBOM_Transactions.OrderID,
	TblEmployee.FirstName AS SalesPersonFirstName,
	TblTerms.TermsName,
	TblOrdersBOM.BillContactFirstName,
	TblOrdersBOM.BillContactLastName,
	TblOrdersBOM.BillCellPhone,
	SalesEmployee.FirstName AS SalesEmployeeFirstName,
    TblOrdersBOM_Transactions.TransactionDate
FROM 
	TblOrdersBOM_Transactions
	LEFT JOIN TblOrdersBOM					ON TblOrdersBOM.OrderID = TblOrdersBOM_Transactions.OrderID
	LEFT JOIN TblEmployee					ON TblEmployee.EmployeeID = TblOrdersBOM.SalesEmployeeID
	LEFT JOIN TblTerms						ON TblTerms.TermsID = TblOrdersBOM.TermsID
	LEFT JOIN TblEmployee AS SalesEmployee ON TblOrdersBOM_Transactions.SalesEmployeeID = SalesEmployee.EmployeeID
WHERE 
	TblOrdersBOM_Transactions.OrderTransactionID = @orderTransactionID
";

				PeakeyTools.Database.MySQL.AddParameter(cmd, "@orderTransactionID", MySqlDbType.Int32, orderTransactionID);

				PeakeyTools.Database.MySQL.TrimCommandText(cmd);
				dr = cmd.ExecuteReader();

				return PeakeyTools.Database.MySQL.DataReaderToDataTable(dr);
			}
			catch (Exception ex)
			{
				throw new Exception("Could not load Quickbook information from database.", ex);
			}
			finally
			{
				PeakeyTools.Database.MySQL.CleanUp(cn, cmd, dr);
			}
		}


	}


}