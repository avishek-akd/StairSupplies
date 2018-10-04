using System;
using Microsoft.AspNetCore.Mvc;


namespace StairSupplies.Controllers
{


	[Route("api/payeezy")]
	public class PayeezyController : Controller
	{


		[HttpPost("payment")]
		public string Payment(Double dollarAmount, String cardNumber, String expirationDate, String cardHoldersName, Int32 orderID, Int32 orderVersionID, String securityCode, Int32 employeeID)
		{
			if (dollarAmount == 0)
			{
				PeakeyTools.Api.Log(PeakeyTools.Api.ApiName.payeezy, "'dollarAmount' is missing as a parameter in the Payeezy Payment API url.", "EXCEPTION");
				return PeakeyTools.Api.ToJSON(false, true, "Error: 'dollarAmount' is missing as a parameter in the Payeezy Payment API url.");
			}
			if (cardNumber == null)
			{
				PeakeyTools.Api.Log(PeakeyTools.Api.ApiName.payeezy, "'cardNumber' is missing as a parameter in the Payeezy Payment API url.", "EXCEPTION");
				return PeakeyTools.Api.ToJSON(false, true, "Error: 'cardNumber' is missing as a parameter in the Payeezy Payment API url.");
			}
			if (expirationDate == null)
			{
				PeakeyTools.Api.Log(PeakeyTools.Api.ApiName.payeezy, "'expirationDate' is missing as a parameter in the Payeezy Payment API url.", "EXCEPTION");
				return PeakeyTools.Api.ToJSON(false, true, "Error: 'expirationDate' is missing as a parameter in the Payeezy Payment API url.");
			}
			if (cardHoldersName == null)
			{
				PeakeyTools.Api.Log(PeakeyTools.Api.ApiName.payeezy, "'cardHoldersName' is missing as a parameter in the Payeezy Payment API url.", "EXCEPTION");
				return PeakeyTools.Api.ToJSON(false, true, "Error: 'cardHoldersName' is missing as a parameter in the Payeezy Payment API url.");
			}
			if (orderID == 0)
			{
				PeakeyTools.Api.Log(PeakeyTools.Api.ApiName.payeezy, "'orderID' is missing as a parameter in the Payeezy Payment API url.", "EXCEPTION");
				return PeakeyTools.Api.ToJSON(false, true, "Error: 'orderID' is missing as a parameter in the Payeezy Payment API url.");
			}
			if (orderVersionID == 0)
			{
				PeakeyTools.Api.Log(PeakeyTools.Api.ApiName.payeezy, "'orderVersionID' is missing as a parameter in the Payeezy Payment API url.", "EXCEPTION");
				return PeakeyTools.Api.ToJSON(false, true, "Error: 'orderVersionID' is missing as a parameter in the Payeezy Payment API url.");
			}
			if (securityCode == null)
			{
				PeakeyTools.Api.Log(PeakeyTools.Api.ApiName.payeezy, "'securityCode' is missing as a parameter in the Payeezy Payment API url.", "EXCEPTION");
				return PeakeyTools.Api.ToJSON(false, true, "Error: 'securityCode' is missing as a parameter in the Payeezy Payment API url.");
			}
			if (employeeID == 0)
			{
				PeakeyTools.Api.Log(PeakeyTools.Api.ApiName.payeezy, "'employeeID' is missing as a parameter in the Payeezy Recharge API url.", "EXCEPTION");
				return PeakeyTools.Api.ToJSON(false, true, "Error: 'employeeID' is missing as a parameter in the Payeezy Recharge API url.");
			}


			API.Payeezy.Payment.TransactionData transactionData = new API.Payeezy.Payment.TransactionData();
			transactionData.dollarAmount = dollarAmount;
			transactionData.cardNumber = cardNumber;
			transactionData.expirationDate = expirationDate;
			transactionData.cardHoldersName = cardHoldersName;
			transactionData.orderID = orderID;
			transactionData.orderVersionID = orderVersionID;
			transactionData.securityCode = securityCode;
			transactionData.employeeID = employeeID;


			return StairSupplies.API.Payeezy.Payment.SubmitPaymentTransaction(transactionData);
		}


        [HttpPost("refund")]
		public string Refund(String cardHoldersName, String cardEndingDigits, String expirationDate, Double dollarAmount, Int32 orderID, Int32 orderVersionID, Int32 employeeID, Int32 customerID)
		{
			if (cardHoldersName == null)
			{
				PeakeyTools.Api.Log(PeakeyTools.Api.ApiName.payeezy, "'cardHoldersName' is missing as a parameter in the Payeezy Refund API url.", "EXCEPTION");
				return PeakeyTools.Api.ToJSON(false, true, "Error: 'cardHoldersName' is missing as a parameter in the Payeezy Refund API url.");
			}
			if (cardEndingDigits == null)
			{
				PeakeyTools.Api.Log(PeakeyTools.Api.ApiName.payeezy, "'cardEndingDigits' is missing as a parameter in the Payeezy Refund API url.", "EXCEPTION");
				return PeakeyTools.Api.ToJSON(false, true, "Error: 'cardEndingDigits' is missing as a parameter in the Payeezy Refund API url.");
			}
			if (expirationDate == null)
			{
				PeakeyTools.Api.Log(PeakeyTools.Api.ApiName.payeezy, "'expirationDate' is missing as a parameter in the Payeezy Refund API url.", "EXCEPTION");
				return PeakeyTools.Api.ToJSON(false, true, "Error: 'expirationDate' is missing as a parameter in the Payeezy Refund API url.");
			}
			if (dollarAmount == 0)
			{
				PeakeyTools.Api.Log(PeakeyTools.Api.ApiName.payeezy, "'dollarAmount' is missing as a parameter in the Payeezy Refund API url.", "EXCEPTION");
				return PeakeyTools.Api.ToJSON(false, true, "Error: 'dollarAmount' is missing as a parameter in the Payeezy Refund API url.");
			}
			if (orderID == 0)
			{
				PeakeyTools.Api.Log(PeakeyTools.Api.ApiName.payeezy, "'orderID' is missing as a parameter in the Payeezy Refund API url.", "EXCEPTION");
				return PeakeyTools.Api.ToJSON(false, true, "Error: 'orderID' is missing as a parameter in the Payeezy Refund API url.");
			}
			if (orderVersionID == 0)
			{
				PeakeyTools.Api.Log(PeakeyTools.Api.ApiName.payeezy, "'orderVersionID' is missing as a parameter in the Payeezy Refund API url.", "EXCEPTION");
				return PeakeyTools.Api.ToJSON(false, true, "Error: 'orderVersionID' is missing as a parameter in the Payeezy Refund API url.");
			}
			if (employeeID == 0)
			{
				PeakeyTools.Api.Log(PeakeyTools.Api.ApiName.payeezy, "'employeeID' is missing as a parameter in the Payeezy Recharge API url.", "EXCEPTION");
				return PeakeyTools.Api.ToJSON(false, true, "Error: 'employeeID' is missing as a parameter in the Payeezy Recharge API url.");
			}
			if (customerID == 0)
			{
				PeakeyTools.Api.Log(PeakeyTools.Api.ApiName.payeezy, "'customerID' is missing as a parameter in the Payeezy Recharge API url.", "EXCEPTION");
				return PeakeyTools.Api.ToJSON(false, true, "Error: 'customerID' is missing as a parameter in the Payeezy Recharge API url.");
			}


			API.Payeezy.Refund.TransactionData transactionData = new API.Payeezy.Refund.TransactionData();
			transactionData.cardHoldersName = cardHoldersName;
			transactionData.cardEndingDigits = cardEndingDigits;
			transactionData.cardExpiration = expirationDate;
			transactionData.dollarAmount = dollarAmount;
			transactionData.orderID = orderID;
			transactionData.customerID = customerID;
			transactionData.orderVersionID = orderVersionID;
			transactionData.employeeID = employeeID;


			return StairSupplies.API.Payeezy.Refund.SubmitRefundTransaction(transactionData);
		}


        [HttpPost("recharge")]
		public string Recharge(Int32 paymentTransactionPayeezyID, Double dollarAmount, Int32 orderID, Int32 orderVersionID, Int32 employeeID)
		{
			if (paymentTransactionPayeezyID == 0)
			{
				PeakeyTools.Api.Log(PeakeyTools.Api.ApiName.payeezy, "'paymentTransactionPayeezyID' is missing as a parameter in the Payeezy Recharge API url.", "EXCEPTION");
				return PeakeyTools.Api.ToJSON(false, true, "Error: 'paymentTransactionPayeezyID' is missing as a parameter in the Payeezy Recharge API url.");
			}
			if (dollarAmount == 0)
			{
				PeakeyTools.Api.Log(PeakeyTools.Api.ApiName.payeezy, "'dollarAmount' is missing as a parameter in the Payeezy Recharge API url.", "EXCEPTION");
				return PeakeyTools.Api.ToJSON(false, true, "Error: 'dollarAmount' is missing as a parameter in the Payeezy Recharge API url.");
			}
			if (orderID == 0)
			{
				PeakeyTools.Api.Log(PeakeyTools.Api.ApiName.payeezy, "'orderID' is missing as a parameter in the Payeezy Recharge API url.", "EXCEPTION");
				return PeakeyTools.Api.ToJSON(false, true, "Error: 'orderID' is missing as a parameter in the Payeezy Recharge API url.");
			}
			if (orderVersionID == 0)
			{
				PeakeyTools.Api.Log(PeakeyTools.Api.ApiName.payeezy, "'orderVersionID' is missing as a parameter in the Payeezy Recharge API url.", "EXCEPTION");
				return PeakeyTools.Api.ToJSON(false, true, "Error: 'orderVersionID' is missing as a parameter in the Payeezy Recharge API url.");
			}
			if (employeeID == 0)
			{
				PeakeyTools.Api.Log(PeakeyTools.Api.ApiName.payeezy, "'employeeID' is missing as a parameter in the Payeezy Recharge API url.", "EXCEPTION");
				return PeakeyTools.Api.ToJSON(false, true, "Error: 'employeeID' is missing as a parameter in the Payeezy Recharge API url.");
			}


			API.Payeezy.Recharge.TransactionData transactionData = new API.Payeezy.Recharge.TransactionData();
			transactionData.paymentTransactionPayeezyID = paymentTransactionPayeezyID;
			transactionData.dollarAmount = dollarAmount;
			transactionData.orderID = orderID;
			transactionData.orderVersionID = orderVersionID;
			transactionData.employeeID = employeeID;


			return StairSupplies.API.Payeezy.Recharge.SubmitRechargeTransaction(transactionData);
		}


	}


}