using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Text;
using System.Xml;


namespace StairSupplies.API
{
	public partial class Payeezy
	{


        public class Refund
        {


			#region Declarations


			public struct TransactionData
			{
				public Int32 orderID;
				public Int32 customerID;
				public Int32 orderVersionID;
				public Int32 employeeID;
				public String cardHoldersName;
				public String cardEndingDigits;
				public String cardExpiration;
				public Double dollarAmount;
			}


			#endregion


			// Payeezy Tagged Refund
			// A 'Bad Request (64) - Invalid Refund' error will be received if the refund amount is more than the transaction's charge amount
			public static String SubmitRefundTransaction(TransactionData transactionData)
			{
				try
				{
					Double totalAmountRefunded = 0;
					Dictionary<Int32, Double> validTransactions = new Dictionary<Int32, Double>();

					DataTable payeezyTransactions = StairSupplies.Payments.Transactions.Payeezy.EnumerateByCard(transactionData.cardHoldersName, transactionData.cardEndingDigits, transactionData.cardExpiration, transactionData.customerID, transactionData.employeeID);
					if (payeezyTransactions.Rows.Count == 0)
					{
						return PeakeyTools.Api.ToJSON(false, true, "Could not enumerate Payeezy transactions by credit card information.");
					}

					foreach (DataRow row in payeezyTransactions.Rows)
					{
						Int32 payeezyTransactionID = PeakeyTools.Database.MySQL.NullInt32(row["PayeezyTransactionID"].ToString());
						Int32 cardExpirationMonth = PeakeyTools.Database.MySQL.NullInt32(row["ExpirationMonth"].ToString());
						Int32 cardExpirationYear = PeakeyTools.Database.MySQL.NullInt32(row["ExpirationYear"].ToString());
						Int32 currentMonth = Int32.Parse(DateTime.UtcNow.ToString("MM"));
						Int32 currentYear = Int32.Parse(DateTime.UtcNow.ToString("yy"));
						Double amountAvailable = Math.Round(PeakeyTools.Database.MySQL.NullDouble(row["TotalCharged"].ToString()) - PeakeyTools.Database.MySQL.NullDouble(row["TotalRefund"].ToString()), 2);

						// Is the card expired?
						if ((currentMonth > cardExpirationMonth) && (currentYear == cardExpirationYear))
						{
							continue;
						}
						if (currentYear > cardExpirationYear)
						{
							continue;
						}
						if (amountAvailable <= 0)
						{
							continue;
						}
						if (amountAvailable == transactionData.dollarAmount) // Transaction meets exact refund amount
						{
							return PeakeyTools.Api.DynamicToJSON(IssueRefund(payeezyTransactionID, transactionData.dollarAmount, transactionData.orderID, transactionData.orderVersionID, transactionData.employeeID));
						}

						// Add valid transactions to list for later looping
						validTransactions.Add(payeezyTransactionID, amountAvailable);
					}

					// Is there a transaction with a bigger amount?
					foreach (var item in validTransactions)
					{
						if ( item.Value > transactionData.dollarAmount)
						{
							return PeakeyTools.Api.DynamicToJSON(IssueRefund(item.Key, transactionData.dollarAmount, transactionData.orderID, transactionData.orderVersionID, transactionData.employeeID));
						}
					}

					// Will need to refund multiple transactions
					foreach (var item in validTransactions)
					{
						dynamic refundTransaction = null;

						if ( (item.Value + totalAmountRefunded) > transactionData.dollarAmount)
						{
							totalAmountRefunded = transactionData.dollarAmount - totalAmountRefunded;

							return PeakeyTools.Api.DynamicToJSON(IssueRefund(item.Key, totalAmountRefunded, transactionData.orderID, transactionData.orderVersionID, transactionData.employeeID));
						}

						refundTransaction = IssueRefund(item.Key, item.Value, transactionData.orderID, transactionData.orderVersionID, transactionData.employeeID);
						if (refundTransaction.successful == "true")
						{
							totalAmountRefunded += item.Value;

							if (totalAmountRefunded == transactionData.dollarAmount)
							{
								return PeakeyTools.Api.ToJSON(true, false, "Refund successfully processed.");
							}

							continue;
						}
					}

					// There was a bad api response.. or no transactions are valid for the refund process (cards could all be expired etc.)
					if (totalAmountRefunded == 0)
					{
						return PeakeyTools.Api.ToJSON(false, true, "Could not find any valid transactions to refund. No refund amount has been applied.");
					}
					else
					{
						return PeakeyTools.Api.ToJSON(false, true, "Could not refund full amount. A partial refund amount of " + totalAmountRefunded.ToString("C") + " has been applied.");
					}
				}
				catch (Exception ex)
				{
					PeakeyTools.Api.Log(PeakeyTools.Api.ApiName.payeezy, "An error has occurred while attempting to retrieve transactions for refunding. [OrderID]: " + transactionData.orderID + " [OrderVersionID]: " + transactionData.orderVersionID + " [Amount]: " + transactionData.dollarAmount, ex, "EXCEPTION");
					return PeakeyTools.Api.ToJSON(false, true, "An error has occurred while attempting to retrieve transactions for refunding. " + ex.Message);
				}
			}


			public static dynamic IssueRefund(Int32 paymentTransactionPayeezyID, Double dollarAmount, Int32 orderID, Int32 orderVersionID, Int32 employeeID)
            {
				String response = "";

				try
                {
                    StringBuilder stringBuilder = new StringBuilder();
					String authorizationNum = "";

					// Retrieve needed data from record ID
					DataTable payeezyTransaction = StairSupplies.Payments.Transactions.Payeezy.Load(paymentTransactionPayeezyID);
					if (payeezyTransaction.Rows.Count == 0)
					{
						return PeakeyTools.Api.ToDynamic(false, true, "Could not load Payeezy transaction by ID.");
					}

					authorizationNum = PeakeyTools.Database.MySQL.NullString(payeezyTransaction.Rows[0]["Authorization_Num"].ToString());

					using (StringWriter stringWriter = new StringWriter(stringBuilder))
                    {
                        using (XmlTextWriter xmlWriter = new XmlTextWriter(stringWriter))
                        {
							xmlWriter.Formatting = Formatting.Indented;

							xmlWriter.WriteStartElement("Transaction");
							xmlWriter.WriteElementString("ExactID", StairSupplies.API.Payeezy.GatewayID);
							xmlWriter.WriteElementString("Password", StairSupplies.API.Payeezy.GatewayPassword);
							xmlWriter.WriteElementString("Transaction_Type", "34");
							xmlWriter.WriteElementString("Transaction_Tag", PeakeyTools.Database.MySQL.NullString(payeezyTransaction.Rows[0]["Transaction_Tag"].ToString()));
							xmlWriter.WriteElementString("DollarAmount", dollarAmount.ToString("F"));
							xmlWriter.WriteElementString("Authorization_Num", authorizationNum);

							xmlWriter.WriteEndElement();
						}
                    }

                    StairSupplies.Payments.Transactions.Payeezy.Item paymentTransactionPayeezy = new StairSupplies.Payments.Transactions.Payeezy.Item();
					response = Submit(stringBuilder);
					paymentTransactionPayeezy = ParseXML(response);
					paymentTransactionPayeezy.TransactionType = "refund";
					paymentTransactionPayeezy.PaymentTransactionReferenceID = paymentTransactionPayeezyID;

					// Save Payment Transaction item to database
					StairSupplies.Payments.Transactions.Item paymentTransaction = new StairSupplies.Payments.Transactions.Item();
					paymentTransaction.OrderID = orderID;
					paymentTransaction.OrderVersionID = orderVersionID;
					paymentTransaction.ProcessedDate = DateTime.UtcNow.ToString("yyyy-MM-dd HH:mm:ss");
					paymentTransaction.EmployeeID = employeeID;
					if (paymentTransactionPayeezy.Approved)
					{
						paymentTransaction.Approved = true;
					}
					if (!paymentTransaction.Save())
                    {
						PeakeyTools.Api.Log(PeakeyTools.Api.ApiName.payeezy, "Could not save Payment Transaction to database for refund. [OrderID]: " + orderID + " [OrderVersionID]: " + orderVersionID + " [AuthorizationNum]: " + authorizationNum + " [Amount]: " + dollarAmount, "EXCEPTION");
						return PeakeyTools.Api.ToDynamic(false, true, "Could not save Payment Transaction to database for refund.");
                    }

                    // Save Payeezy Payment Transaction item to database
                    DataTable dt = StairSupplies.Payments.Transactions.Load_By_Order_ID_And_Processed_Date(orderID, paymentTransaction.ProcessedDate);
                    if (dt.Rows.Count > 0) // Find the PaymentTransactionID value from Payment Transaction table
                    {
						paymentTransactionPayeezy.PaymentTransactionID = Int32.Parse(dt.Rows[0]["PaymentTransactionID"].ToString());
                        if (!paymentTransactionPayeezy.Save())
                        {
							PeakeyTools.Api.Log(PeakeyTools.Api.ApiName.payeezy, "Could not save Payeezy Payment Transaction to database for refund. [OrderID]: " + orderID + " [OrderVersionID]: " + orderVersionID + " [AuthorizationNum]: " + authorizationNum + " [Amount]: " + dollarAmount, "EXCEPTION");
							return PeakeyTools.Api.ToDynamic(false, true, "Could not save Payeezy Payment Transaction to database for refund.");
                        }
                    }

                    // Was the payment successful?
                    if (paymentTransactionPayeezy.Approved)
					{
                         return PeakeyTools.Api.ToDynamic(true, false, "Refund successfully processed.");
                    }

					PeakeyTools.Api.Log(PeakeyTools.Api.ApiName.payeezy, "Failed to refund credit card. [Reason]: " + paymentTransactionPayeezy.BankMessage + " [OrderID]: " + orderID + " [Full Response]: " + response, "EXCEPTION");
					return PeakeyTools.Api.ToDynamic(false, false, "Failed to refund credit card (" + paymentTransactionPayeezy.BankMessage + ").");
                }
                catch (Exception ex)
                {
					PeakeyTools.Api.Log(PeakeyTools.Api.ApiName.payeezy, "An error has occurred while attempting to refund a transaction. [OrderID]: " + orderID + " [Full Response]: " + response, ex, "EXCEPTION");
					return PeakeyTools.Api.ToDynamic(false, true, "An error has occurred while attempting to refund a transaction. " + ex.Message);
                }
            }


            public static StairSupplies.Payments.Transactions.Payeezy.Item ParseXML(String response)
            {
                try
                {
                    StairSupplies.Payments.Transactions.Payeezy.Item paymentTransactionPayeezy = new StairSupplies.Payments.Transactions.Payeezy.Item();
                    XmlDocument xmldoc = new XmlDocument();
                    XmlNode nodeBankResponseCode;
                    XmlNode nodeBankMessage;
                    XmlNode nodeCardType;
                    XmlNode nodeExactID;
                    XmlNode nodeDollarAmount;
                    XmlNode nodeCardHoldersName;
                    XmlNode nodeTransactionTag;
                    XmlNode nodeAuthorizationNum;
                    XmlNode nodeExactResponseCode;
                    XmlNode nodeExactMessage;
                    XmlNode nodeSequenceNo;
                    XmlNode nodeRetrievalRefNo;
                    XmlNode nodeExpiryDate;
                    XmlNode nodeTransarmorToken;
					XmlNode nodeApproved;

                    xmldoc.LoadXml(response);

                    foreach (XmlNode node in xmldoc.GetElementsByTagName("TransactionResult"))
                    {
                        nodeBankResponseCode = node.SelectSingleNode("Bank_Resp_Code");
                        nodeBankMessage = node.SelectSingleNode("Bank_Message");
                        nodeCardType = node.SelectSingleNode("CardType");
                        nodeExactID = node.SelectSingleNode("ExactID");
                        nodeDollarAmount = node.SelectSingleNode("DollarAmount");
                        nodeCardHoldersName = node.SelectSingleNode("CardHoldersName");
                        nodeTransactionTag = node.SelectSingleNode("Transaction_Tag");
                        nodeAuthorizationNum = node.SelectSingleNode("Authorization_Num");
                        nodeExactResponseCode = node.SelectSingleNode("EXact_Resp_Code");
                        nodeExactMessage = node.SelectSingleNode("EXact_Message");
                        nodeSequenceNo = node.SelectSingleNode("SequenceNo");
                        nodeRetrievalRefNo = node.SelectSingleNode("Retrieval_Ref_No");
                        nodeExpiryDate = node.SelectSingleNode("Expiry_Date");
                        nodeTransarmorToken = node.SelectSingleNode("TransarmorToken");
						nodeApproved = node.SelectSingleNode("Transaction_Approved");

						if (nodeBankResponseCode != null)
                        {
							paymentTransactionPayeezy.BankResponseCode = nodeBankResponseCode.InnerText;
                        }
                        if (nodeBankMessage != null)
                        {
							paymentTransactionPayeezy.BankMessage = nodeBankMessage.InnerText;
                        }
                        if (nodeCardType != null)
                        {
							paymentTransactionPayeezy.CardType = nodeCardType.InnerText;
                        }
                        if (nodeExactID != null)
                        {
							paymentTransactionPayeezy.ExactID = nodeExactID.InnerText;
                        }
                        if (nodeDollarAmount != null)
                        {
							paymentTransactionPayeezy.DollarAmount = Double.Parse(nodeDollarAmount.InnerText);
                        }
                        if (nodeCardHoldersName != null)
                        {
							paymentTransactionPayeezy.CardHoldersName = nodeCardHoldersName.InnerText.Replace("%20", " ");
                        }
                        if (nodeTransactionTag != null)
                        {
							paymentTransactionPayeezy.TransactionTag = nodeTransactionTag.InnerText;
                        }
                        if (nodeAuthorizationNum != null)
                        {
							paymentTransactionPayeezy.AuthorizationNum = nodeAuthorizationNum.InnerText;
                        }
                        if (nodeExactResponseCode != null)
                        {
							paymentTransactionPayeezy.ExactResponseCode = nodeExactResponseCode.InnerText;
                        }
                        if (nodeExactMessage != null)
                        {
							paymentTransactionPayeezy.ExactMessage = nodeExactMessage.InnerText;
                        }
                        if (nodeSequenceNo != null)
                        {
							paymentTransactionPayeezy.SequenceNo = nodeSequenceNo.InnerText;
                        }
                        if (nodeRetrievalRefNo != null)
                        {
							paymentTransactionPayeezy.RetrievalRefNo = nodeRetrievalRefNo.InnerText;
                        }
                        if (nodeExpiryDate != null)
                        {
							paymentTransactionPayeezy.ExpiryDate = nodeExpiryDate.InnerText;
                        }
                        if (nodeTransarmorToken != null)
                        {
							paymentTransactionPayeezy.TransarmorToken = nodeTransarmorToken.InnerText;
                        }
						if (nodeApproved != null)
						{
							paymentTransactionPayeezy.Approved = PeakeyTools.Database.MySQL.NullBoolean(nodeApproved.InnerText);
						}
                    }

                    return paymentTransactionPayeezy;
                }
                catch (Exception ex)
                {
					PeakeyTools.Api.Log(PeakeyTools.Api.ApiName.payeezy, "Could not parse XML from Payeezy refund API response.", ex, "EXCEPTION");
					throw new Exception("Could not parse XML from Payeezy refund API response.", ex);
                }
            }


        }


	}
}