using System;
using System.Data;


namespace StairSupplies
{
	public partial class Payments
    {
        public partial class Transactions
        {
            public partial class Payeezy
            {


                public static DataTable Load(Int32 paymentTransactionPayeezyID)
                {
                    try
                    {
                        return StairSupplies.Database.PaymentTransactions_Payeezy.Load(paymentTransactionPayeezyID);
                    }
                    catch (Exception ex)
                    {
						PeakeyTools.Api.Log(PeakeyTools.Api.ApiName.payeezy, "Could not load Payeezy transaction by ID.", ex, "EXCEPTION");
						throw new Exception("Could not load Payeezy transaction by ID.", ex);
                    }
                }


				public static DataTable EnumerateByCard(String cardHoldersName, String cardEndingDigits, String cardExpiration, Int32 customerID, Int32 employeeID)
				{
					try
					{
						return StairSupplies.Database.PaymentTransactions_Payeezy.EnumerateByCard(cardHoldersName, cardEndingDigits, cardExpiration, customerID, employeeID);
					}
					catch (Exception ex)
					{
						PeakeyTools.Api.Log(PeakeyTools.Api.ApiName.payeezy, "Could not enumerate Payeezy transactions by credit card information.", ex, "EXCEPTION");
						throw new Exception("Could not enumerate Payeezy transactions by credit card information.", ex);
					}
				}


            }


        }
	}
}