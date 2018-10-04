using MySql.Data.MySqlClient;
using System;
using System.Data;


namespace StairSupplies.Database
{


	public class PaymentTransactions_Payeezy
	{


		public static DataTable EnumerateByCard(String cardHoldersName, String cardEndingDigits, String cardExpiration, Int32 customerID, Int32 employeeID)
		{
			MySqlConnection cn = null;
			MySqlCommand cmd = new MySqlCommand();
			MySqlDataReader DR = null;
			try
			{
				PeakeyTools.Database.MySQL.OpenConnection(ref cn, ref cmd);
				cmd.CommandText = @"
SELECT
	PayeezyTransactionID,
    ExpirationMonth,
    ExpirationYear,
    TotalCharged,
    CASE WHEN TotalRefund IS NULL THEN
		0.00
    ELSE
		TotalRefund
    END AS TotalRefund,
	ProcessedDate
FROM
	(
		SELECT
			PaymentTransaction_PayeezyID AS PayeezyTransactionID,
			LEFT(Expiry_Date, 2) AS ExpirationMonth,
			RIGHT(Expiry_Date, 2) As ExpirationYear,
			ROUND(DollarAmount, 2) AS TotalCharged,
			(
				SELECT
					ROUND(SUM(DollarAmount), 2) AS DollarAmount
				FROM 
					TblPaymentTransactions_Payeezy 
				WHERE 
					PaymentTransaction_Payeezy_ReferenceID = PayeezyTransactionID AND
					TransactionType = 'refund'
			) AS TotalRefund,
			ProcessedDate
		FROM
			TblPaymentTransactions
			INNER JOIN TblPaymentTransactions_Payeezy ON TblPaymentTransactions_Payeezy.PaymentTransactionID = TblPaymentTransactions.PaymentTransactionID
			INNER JOIN TblOrdersBOM ON TblOrdersBOM.OrderID = TblPaymentTransactions.OrderID
			INNER JOIN TblCustomerContact ON TblCustomerContact.CustomerContactID = TblOrdersBOM.CustomerContactID
		WHERE
			TblCustomerContact.CustomerID = @CustomerID AND
			(
				TransactionType = 'payment' OR
				TransactionType = 'recharge'
			) AND
			RIGHT(TransarmorToken, 4) = @CardEndingDigits AND
			CardHoldersName = @CardHoldersName AND
			Expiry_Date = @CardExpiration AND
			TransarmorToken <> '' AND
			Authorization_Num <> '' AND
			Transaction_Tag <> ''
	) AS ChargedTransactions
ORDER BY
	ProcessedDate DESC
";

				PeakeyTools.Database.MySQL.AddParameter(cmd, "@CustomerID", MySqlDbType.Int32, customerID);
				PeakeyTools.Database.MySQL.AddParameter(cmd, "@EmployeeID", MySqlDbType.Int32, employeeID);
				PeakeyTools.Database.MySQL.AddParameter(cmd, "@CardHoldersName", MySqlDbType.VarChar, cardHoldersName);
				PeakeyTools.Database.MySQL.AddParameter(cmd, "@CardEndingDigits", MySqlDbType.VarChar, cardEndingDigits);
				PeakeyTools.Database.MySQL.AddParameter(cmd, "@CardExpiration", MySqlDbType.VarChar, cardExpiration);

				PeakeyTools.Database.MySQL.TrimCommandText(cmd);
				DR = cmd.ExecuteReader();

				return PeakeyTools.Database.MySQL.DataReaderToDataTable(DR);
			}
			catch (Exception ex)
			{
				PeakeyTools.Api.Log(PeakeyTools.Api.ApiName.payeezy, "Could not load Payeezy transactions by card information.", ex, "EXCEPTION");
				throw new Exception("Could not load Payeezy transactions by card information.", ex);
			}
			finally
			{
				PeakeyTools.Database.MySQL.CleanUp(cn, cmd, DR);
			}
		}


		public static DataTable Load(Int32 paymentTransactionPayeezyID)
		{
			MySqlConnection cn = null;
			MySqlCommand cmd = new MySqlCommand();
			MySqlDataReader DR = null;
			try
			{
                PeakeyTools.Database.MySQL.OpenConnection(ref cn, ref cmd);
				cmd.CommandText = @"
SELECT 
	* 
FROM 
	TblPaymentTransactions_Payeezy 
WHERE 
	PaymentTransaction_PayeezyID = @PaymentTransaction_PayeezyID
";

				PeakeyTools.Database.MySQL.AddParameter(cmd, "@PaymentTransaction_PayeezyID", MySqlDbType.Int32, paymentTransactionPayeezyID);

				PeakeyTools.Database.MySQL.TrimCommandText(cmd);
				DR = cmd.ExecuteReader();

				return PeakeyTools.Database.MySQL.DataReaderToDataTable(DR);
			}
			catch (Exception ex)
			{
				PeakeyTools.Api.Log(PeakeyTools.Api.ApiName.payeezy, "Could not load Payeezy transaction by ID.", ex, "EXCEPTION");
				throw new Exception("Could not load Payeezy transaction by ID.", ex);
			}
			finally
			{
				PeakeyTools.Database.MySQL.CleanUp(cn, cmd, DR);
			}
		}


		public static Boolean Save(StairSupplies.Payments.Transactions.Payeezy.Item item)
		{
			MySqlConnection cn = null;
			MySqlCommand cmd = null;
			try
			{
				PeakeyTools.Database.MySQL.OpenConnection(ref cn, ref cmd);
				cmd.CommandText = @"
INSERT INTO TblPaymentTransactions_Payeezy 
( 
	PaymentTransactionID, 
";

				if (item.PaymentTransactionReferenceID != 0)
				{
					cmd.CommandText += "PaymentTransaction_Payeezy_ReferenceID, ";
				}

				cmd.CommandText += @"
	ExactID, 
	DollarAmount, 
	Transaction_Tag, 
	Authorization_Num, 
	CardHoldersName, 
	Exact_Response_Code, 
	Exact_Message, 
	Bank_Response_Code, 
	Bank_Message, 
	Sequence_No, 
	Retrieval_Ref_No, 
	CardType, 
	TransactionType, 
	Expiry_Date, 
	TransarmorToken 
) 
VALUES 
( 
	@PaymentTransactionID, 
";

				if (item.PaymentTransactionReferenceID != 0)
				{
					cmd.CommandText += "@PaymentTransaction_Payeezy_ReferenceID, ";
				}

				cmd.CommandText += @"
	@ExactID, 
	@DollarAmount, 
	@Transaction_Tag, 
	@Authorization_Num, 
	@CardHoldersName, 
	@Exact_Response_Code, 
	@Exact_Message, 
	@Bank_Response_Code, 
	@Bank_Message, 
	@Sequence_No, 
	@Retrieval_Ref_No, 
	@CardType, 
	@TransactionType, 
	@Expiry_Date, 
	@TransarmorToken 
)
";

				PeakeyTools.Database.MySQL.AddParameter(cmd, "@PaymentTransactionID", MySqlDbType.Int32, item.PaymentTransactionID);
				PeakeyTools.Database.MySQL.AddParameter(cmd, "@PaymentTransaction_Payeezy_ReferenceID", MySqlDbType.Int32, item.PaymentTransactionReferenceID);
				PeakeyTools.Database.MySQL.AddParameter(cmd, "@ExactID", MySqlDbType.VarChar, item.ExactID);
				PeakeyTools.Database.MySQL.AddParameter(cmd, "@DollarAmount", MySqlDbType.VarChar, item.DollarAmount.ToString("F2"));
				PeakeyTools.Database.MySQL.AddParameter(cmd, "@Transaction_Tag", MySqlDbType.VarChar, item.TransactionTag);
				PeakeyTools.Database.MySQL.AddParameter(cmd, "@Authorization_Num", MySqlDbType.VarChar, item.AuthorizationNum);
				PeakeyTools.Database.MySQL.AddParameter(cmd, "@CardHoldersName", MySqlDbType.VarChar, item.CardHoldersName);
				PeakeyTools.Database.MySQL.AddParameter(cmd, "@Exact_Response_Code", MySqlDbType.VarChar, item.ExactResponseCode);
				PeakeyTools.Database.MySQL.AddParameter(cmd, "@Exact_Message", MySqlDbType.VarChar, item.ExactMessage);
				PeakeyTools.Database.MySQL.AddParameter(cmd, "@Bank_Response_Code", MySqlDbType.VarChar, item.BankResponseCode);
				PeakeyTools.Database.MySQL.AddParameter(cmd, "@Bank_Message", MySqlDbType.VarChar, item.BankMessage);
				PeakeyTools.Database.MySQL.AddParameter(cmd, "@Sequence_No", MySqlDbType.VarChar, item.SequenceNo);
				PeakeyTools.Database.MySQL.AddParameter(cmd, "@Retrieval_Ref_No", MySqlDbType.VarChar, item.RetrievalRefNo);
				PeakeyTools.Database.MySQL.AddParameter(cmd, "@CardType", MySqlDbType.VarChar, item.CardType);
				PeakeyTools.Database.MySQL.AddParameter(cmd, "@TransactionType", MySqlDbType.VarChar, item.TransactionType);
				PeakeyTools.Database.MySQL.AddParameter(cmd, "@Expiry_Date", MySqlDbType.VarChar, item.ExpiryDate);
				PeakeyTools.Database.MySQL.AddParameter(cmd, "@TransarmorToken", MySqlDbType.VarChar, item.TransarmorToken);

				PeakeyTools.Database.MySQL.TrimCommandText(cmd);
				cmd.ExecuteNonQuery();
				return true;
			}
			catch (Exception ex)
			{
				PeakeyTools.Api.Log(PeakeyTools.Api.ApiName.payeezy, "Could not save Payeezy Payment Transaction data.", ex, "EXCEPTION");
				throw new Exception("Could not save Payeezy Payment Transaction data.", ex);
			}
			finally
			{
				PeakeyTools.Database.MySQL.CleanUp(cn, cmd, null);
			}
		}


	}


}