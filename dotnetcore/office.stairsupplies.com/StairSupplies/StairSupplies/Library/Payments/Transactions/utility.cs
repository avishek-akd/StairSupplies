using System;
using System.Data;


namespace StairSupplies
{
	public partial class Payments
    {
        public partial class Transactions
        {


            public static DataTable Load_By_Order_ID_And_Processed_Date(Int32 orderID, String processedDate)
            {
                try
                {
                    return StairSupplies.Database.PaymentTransactions.Load_By_Order_ID_And_Processed_Date(orderID, processedDate);
                }
                catch (Exception ex)
                {
					PeakeyTools.Api.Log(PeakeyTools.Api.ApiName.payeezy, "Could not load Payment Transaction.", ex, "EXCEPTION");
					throw new Exception("Could not load Payment Transaction.", ex);
                }
            }


		}
	}
}