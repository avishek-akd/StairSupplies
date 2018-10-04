using System;
using MySql.Data.MySqlClient;
using System.Data;


namespace StairSupplies.Database
{


	public class PaymentTransactions
	{


		public static DataTable Load_By_Order_ID_And_Processed_Date(Int32 orderID, String processedDate)
		{
			MySqlConnection cn = null;
			MySqlCommand cmd = new MySqlCommand();
			MySqlDataReader dr = null;
			try
			{
                PeakeyTools.Database.MySQL.OpenConnection(ref cn, ref cmd);
				cmd.CommandText = @"
SELECT 
	* 
FROM 
	TblPaymentTransactions 
WHERE 
	OrderID = @OrderID AND 
	ProcessedDate = @ProcessedDate
";

				PeakeyTools.Database.MySQL.AddParameter(cmd, "@OrderID", MySqlDbType.Int32, orderID);
				PeakeyTools.Database.MySQL.AddParameter(cmd, "@ProcessedDate", MySqlDbType.DateTime, processedDate);

				PeakeyTools.Database.MySQL.TrimCommandText(cmd);
				dr = cmd.ExecuteReader();

				return PeakeyTools.Database.MySQL.DataReaderToDataTable(dr);
			}
			catch (Exception ex)
			{
				PeakeyTools.Api.Log(PeakeyTools.Api.ApiName.payeezy, "Could not load Payeezy Payment Transaction by orderID and processedDate.", ex, "EXCEPTION");
				throw new Exception("Could not load Payeezy Payment Transaction by orderID and processedDate.", ex);
			}
			finally
			{
				PeakeyTools.Database.MySQL.CleanUp(cn, cmd, dr);
			}
		}


		public static Boolean Save(StairSupplies.Payments.Transactions.Item item)
		{
			MySqlConnection cn = null;
			MySqlCommand cmd = null;
			try
			{
				String transactionApproved = "0";
				String transactionError = "0";

				if (item.Approved)
				{
					transactionApproved = "1";
				}
				else
				{
					transactionError = "1";
				}

				PeakeyTools.Database.MySQL.OpenConnection(ref cn, ref cmd);
				cmd.CommandText = @"
INSERT INTO TblPaymentTransactions
(
	OrderID,
	OrderVersionID,
	EmployeeID,
	ProcessedDate,
	Transaction_Approved,
	Transaction_Error
)
VALUES
(
	@OrderID,
	@OrderVersionID,
	@EmployeeID,
	@ProcessedDate,
	@Transaction_Approved,
	@Transaction_Error
)
";

				PeakeyTools.Database.MySQL.AddParameter(cmd, "@OrderID", MySqlDbType.Int32, item.OrderID);
				PeakeyTools.Database.MySQL.AddParameter(cmd, "@OrderVersionID", MySqlDbType.Int32, item.OrderVersionID);
				PeakeyTools.Database.MySQL.AddParameter(cmd, "@EmployeeID", MySqlDbType.Int32, item.EmployeeID);
				PeakeyTools.Database.MySQL.AddParameter(cmd, "@ProcessedDate", MySqlDbType.DateTime, item.ProcessedDate);
				PeakeyTools.Database.MySQL.AddParameter(cmd, "@Transaction_Approved", MySqlDbType.Bit, transactionApproved);
				PeakeyTools.Database.MySQL.AddParameter(cmd, "@Transaction_Error", MySqlDbType.Bit, transactionError);

				PeakeyTools.Database.MySQL.TrimCommandText(cmd);
				cmd.ExecuteNonQuery();
				return true;
			}
			catch (Exception ex)
			{
				PeakeyTools.Api.Log(PeakeyTools.Api.ApiName.payeezy, "Could not Save payment transaction.", ex, "EXCEPTION");
				throw new Exception("Could not Save payment transaction", ex);
			}
			finally
			{
				PeakeyTools.Database.MySQL.CleanUp(cn, cmd, null);
			}
		}


	}


}
