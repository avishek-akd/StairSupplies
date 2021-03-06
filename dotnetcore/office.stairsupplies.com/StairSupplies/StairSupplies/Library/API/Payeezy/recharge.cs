﻿using System;
using System.Data;
using System.IO;
using System.Text;
using System.Xml;


namespace StairSupplies.API
{
	public partial class Payeezy
	{


        public class Recharge
        {


			#region Declarations


			public struct TransactionData
			{
				public Int32 paymentTransactionPayeezyID;
				public Int32 orderID;
				public Int32 orderVersionID;
				public Int32 employeeID;
				public Double dollarAmount;
			}


			#endregion


			// Payeezy Tagged Pre-Authorization Completion
			public static String SubmitRechargeTransaction(TransactionData transactionData)
			{
				String response = "";
				String cardHoldersName = "";

                try
                {
                    StringBuilder stringBuilder = new StringBuilder();

					// Retrieve needed data from record ID
					DataTable payeezyTransaction = StairSupplies.Payments.Transactions.Payeezy.Load(transactionData.paymentTransactionPayeezyID);
					if (payeezyTransaction.Rows.Count == 0)
					{
						return PeakeyTools.Api.ToJSON(false, true, "Could not load Payeezy transaction by ID.");
					}

					cardHoldersName = PeakeyTools.Database.MySQL.NullString(payeezyTransaction.Rows[0]["CardHoldersName"].ToString());

					using (StringWriter stringWriter = new StringWriter(stringBuilder))
                    {
                        using (XmlTextWriter xmlWriter = new XmlTextWriter(stringWriter))
                        {
							DataTable billingInformation = StairSupplies.Database.TblOrdersBOM.LoadBillingInformation(transactionData.orderID);
							xmlWriter.Formatting = Formatting.Indented;

							xmlWriter.WriteStartElement("Transaction");
							xmlWriter.WriteElementString("ExactID", StairSupplies.API.Payeezy.GatewayID);
							xmlWriter.WriteElementString("Password", StairSupplies.API.Payeezy.GatewayPassword);
							xmlWriter.WriteElementString("Transaction_Type", "00");
							xmlWriter.WriteElementString("DollarAmount", transactionData.dollarAmount.ToString("F"));
							xmlWriter.WriteElementString("Expiry_Date", PeakeyTools.Database.MySQL.NullString(payeezyTransaction.Rows[0]["Expiry_Date"].ToString()));
							xmlWriter.WriteElementString("CardHoldersName", cardHoldersName);
							xmlWriter.WriteElementString("CardType", PeakeyTools.Database.MySQL.NullString(payeezyTransaction.Rows[0]["CardType"].ToString()));
							xmlWriter.WriteElementString("Reference_No", transactionData.orderID.ToString());
							xmlWriter.WriteElementString("TransarmorToken", PeakeyTools.Database.MySQL.NullString(payeezyTransaction.Rows[0]["TransarmorToken"].ToString()));

							if (billingInformation.Rows.Count > 0)
							{
								String billingAddress1 = "";
								String billingAddress2 = "";
								String billingCity = "";
								String billingState = "";
								String billingPostalCode = "";
								String billingCountryCode = "";
								String billingPhoneNumber = "";

								billingAddress1 = PeakeyTools.Database.MySQL.NullString(billingInformation.Rows[0]["BillAddress1"].ToString());
								billingAddress2 = PeakeyTools.Database.MySQL.NullString(billingInformation.Rows[0]["BillAddress2"].ToString());
								billingAddress2 += PeakeyTools.Database.MySQL.NullString(billingInformation.Rows[0]["BillAddress3"].ToString());

								billingCity = PeakeyTools.Database.MySQL.NullString(billingInformation.Rows[0]["BillCity"].ToString());
								billingState = PeakeyTools.Database.MySQL.NullString(billingInformation.Rows[0]["BillState"].ToString());
								billingPostalCode = PeakeyTools.Database.MySQL.NullString(billingInformation.Rows[0]["BillPostalCode"].ToString());
								billingCountryCode = PeakeyTools.Database.MySQL.NullString(billingInformation.Rows[0]["BillCountryCode"].ToString());
								billingPhoneNumber = PeakeyTools.Database.MySQL.NullString(billingInformation.Rows[0]["BillPhoneNumber"].ToString());

								xmlWriter.WriteStartElement("Address");
								xmlWriter.WriteElementString("Address1", billingAddress1);
								xmlWriter.WriteElementString("Address2", billingAddress2);
								xmlWriter.WriteElementString("City", billingCity);
								xmlWriter.WriteElementString("State", billingState);
								xmlWriter.WriteElementString("Zip", billingPostalCode);
								xmlWriter.WriteElementString("CountryCode", billingCountryCode);
								xmlWriter.WriteElementString("PhoneNumber", billingPhoneNumber);
								if (billingPhoneNumber != "") // PhoneType is required if phone # is provided
								{
									xmlWriter.WriteElementString("PhoneType", "H"); // H = Home; W = Work; D = Day; N = Night
								}
								xmlWriter.WriteEndElement();
							}

							xmlWriter.WriteEndElement();
						}
                    }

                    StairSupplies.Payments.Transactions.Payeezy.Item paymentTransactionPayeezy = new StairSupplies.Payments.Transactions.Payeezy.Item();
					response = Submit(stringBuilder);
					paymentTransactionPayeezy = ParseXML(response);
					paymentTransactionPayeezy.TransactionType = "recharge";
					paymentTransactionPayeezy.PaymentTransactionReferenceID = transactionData.paymentTransactionPayeezyID;

					// Save Payment Transaction item to database
					StairSupplies.Payments.Transactions.Item paymentTransaction = new StairSupplies.Payments.Transactions.Item();
					paymentTransaction.OrderID = transactionData.orderID;
					paymentTransaction.OrderVersionID = transactionData.orderVersionID;
					paymentTransaction.ProcessedDate = DateTime.UtcNow.ToString("yyyy-MM-dd HH:mm:ss");
					paymentTransaction.EmployeeID = transactionData.employeeID;
					if (paymentTransactionPayeezy.Approved)
					{
						paymentTransaction.Approved = true;
					}
					if (!paymentTransaction.Save())
                    {
						PeakeyTools.Api.Log(PeakeyTools.Api.ApiName.payeezy, "Could not save Payment Transaction to database for recharge. [OrderID]: " + transactionData.orderID + " [OrderVersionID]: " + transactionData.orderVersionID + " [CardHoldersName]: " + cardHoldersName + " [Amount]: " + transactionData.dollarAmount, "EXCEPTION");
						return PeakeyTools.Api.ToJSON(false, true, "Could not save Payment Transaction to database for recharge.");
                    }

                    // Save Payeezy Payment Transaction item to database
                    DataTable dt = StairSupplies.Payments.Transactions.Load_By_Order_ID_And_Processed_Date(transactionData.orderID, paymentTransaction.ProcessedDate);
                    if (dt.Rows.Count > 0) // Find the PaymentTransactionID value from Payment Transaction table
                    {
						paymentTransactionPayeezy.PaymentTransactionID = Int32.Parse(dt.Rows[0]["PaymentTransactionID"].ToString());
                        if (!paymentTransactionPayeezy.Save())
                        {
							PeakeyTools.Api.Log(PeakeyTools.Api.ApiName.payeezy, "Could not save Payeezy Payment Transaction to database for recharge. [OrderID]: " + transactionData.orderID + " [OrderVersionID]: " + transactionData.orderVersionID + " [CardHoldersName]: " + cardHoldersName + " [Amount]: " + transactionData.dollarAmount, "EXCEPTION");
							return PeakeyTools.Api.ToJSON(false, true, "Could not save Payeezy Payment Transaction to database for recharge.");
                        }
                    }

                    // Was the payment successful?
                    if (paymentTransactionPayeezy.Approved)
                    {
                        return PeakeyTools.Api.ToJSON(true, false, "Recharge successfully processed.");
                    }

					PeakeyTools.Api.Log(PeakeyTools.Api.ApiName.payeezy, "Failed to recharge credit card. [Reason]: " + paymentTransactionPayeezy.BankMessage + " [OrderID]: " + transactionData.orderID + " [Full Response]: " + response, "FAILURE");
					return PeakeyTools.Api.ToJSON(false, false, "Failed to recharge credit card (" + paymentTransactionPayeezy.BankMessage + ").");
                }
                catch (Exception ex)
                {
					PeakeyTools.Api.Log(PeakeyTools.Api.ApiName.payeezy, "An error has occurred while attempting to recharge a transaction. [OrderID]: " + transactionData.orderID + " [Full Response]: " + response, ex, "EXCEPTION");
					return PeakeyTools.Api.ToJSON(false, true, "An error has occurred while attempting to recharge a transaction. " + ex.Message);
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
					PeakeyTools.Api.Log(PeakeyTools.Api.ApiName.payeezy, "Could not parse XML from Payeezy recharge API response.", ex, "EXCEPTION");
					throw new Exception("Could not parse XML from Payeezy recharge API response.", ex);
                }
            }


        }


	}
}