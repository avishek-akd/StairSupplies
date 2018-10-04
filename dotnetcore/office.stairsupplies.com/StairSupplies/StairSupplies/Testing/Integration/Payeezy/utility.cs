using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Threading.Tasks;


namespace StairSupplies.Testing
{
	public partial class Integration
	{
		public partial class Payeezy
		{


			public static Boolean Run(DataTable apiStatuses)
			{
				try
				{
					// Payeezy Payment test data
					API.Payeezy.Payment.TransactionData paymentTransactionData = new API.Payeezy.Payment.TransactionData();
					paymentTransactionData.dollarAmount = 1.00;
					paymentTransactionData.cardNumber = "4111111111111111";
					paymentTransactionData.expirationDate = "1218";
					paymentTransactionData.cardHoldersName = "First Last";
					paymentTransactionData.orderID = 127761;
					paymentTransactionData.orderVersionID = 96714;
					paymentTransactionData.securityCode = "123";
					paymentTransactionData.employeeID = 1;

					// Payeezy Recharge test data
					API.Payeezy.Recharge.TransactionData rechargeTransactionData = new API.Payeezy.Recharge.TransactionData();
					rechargeTransactionData.paymentTransactionPayeezyID = 1;
					rechargeTransactionData.dollarAmount = 1.00;
					rechargeTransactionData.orderID = 127761;
					rechargeTransactionData.orderVersionID = 96714;
					rechargeTransactionData.employeeID = 1;

					// Payeezy Refund test data
					API.Payeezy.Refund.TransactionData refundTransactionData = new API.Payeezy.Refund.TransactionData();
					refundTransactionData.cardHoldersName = "First Last";
					refundTransactionData.cardEndingDigits = "1111";
					refundTransactionData.cardExpiration = "1218";
					refundTransactionData.dollarAmount = 1.00;
					refundTransactionData.orderID = 127761;
					refundTransactionData.customerID = 62055;
					refundTransactionData.orderVersionID = 96714;
					refundTransactionData.employeeID = 1;


					if (!Payment.Run(apiStatuses, paymentTransactionData))
					{
						return false;
					}
					if (!Recharge.Run(apiStatuses, rechargeTransactionData))
					{
						return false;
					}
					if (!Refund.Run(apiStatuses, refundTransactionData))
					{
						return false;
					}


					return true;
				}
				catch (Exception ex)
				{
					PeakeyTools.Api.Log(PeakeyTools.Api.ApiName.quickbooks, "Could not run Payeezy integration tests.", ex, "TESTING");
					throw new Exception("Could not run Payeezy integration tests.", ex);
				}
			}


		}
	}
}