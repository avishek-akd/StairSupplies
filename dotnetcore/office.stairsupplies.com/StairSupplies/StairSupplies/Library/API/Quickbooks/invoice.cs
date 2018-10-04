using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Threading.Tasks;


namespace StairSupplies.API
{
	public partial class Quickbooks
	{


		public class Invoice
		{


			#region Public Methods


			public static String SyncToQuickbooks(Int32 orderTransactionID)
			{
				ClientCredentials clientCredentials = new ClientCredentials();
				DataTable quickbookData = null;

				try
				{
					// Retrieve refresh token & realmID from database (which is saved from a CF page after logging into QB)
					RetrieveCredentials();

					
					// Retrieve oAuth credentials
					//clientCredentials = StairSupplies.API.Quickbooks.RetrieveCredentialsWithoutLogin();


					// Retrieve information from database
					quickbookData = StairSupplies.Database.TblOrdersBOM.LoadQuickbookInformation(orderTransactionID);
					if (quickbookData.Rows.Count == 0)
					{
						PeakeyTools.Api.Log(PeakeyTools.Api.ApiName.quickbooks, "Could not retrieve information from database for Quickbooks.", "EXCEPTION");
						return PeakeyTools.Api.ToJSON(false, true, "Could not retrieve information from database for Quickbooks.");
					}


					// Retrieve item 'Products and Services'
					Quickbooks.DataTypes.Item itemProductAndServices = StairSupplies.API.Quickbooks.Item.FindByName("Products and Services");


					// Retrieve term 'Due on receipt'
					Quickbooks.DataTypes.Term termDueOnReceipt = Quickbooks.Term.FindByName("Due on receipt");


					// Create customer if not existing
					Int32 orderID = PeakeyTools.Database.MySQL.NullInt32(quickbookData.Rows[0]["OrderID"].ToString());
					String firstName = PeakeyTools.Database.MySQL.NullString(quickbookData.Rows[0]["BillContactFirstName"].ToString());
					String lastName = PeakeyTools.Database.MySQL.NullString(quickbookData.Rows[0]["BillContactLastName"].ToString());
					//String orderTermName = PeakeyTools.Database.MySQL.NullString(quickbookData.Rows[0]["TermsName"].ToString());
					String salesEmployeeFirstName = PeakeyTools.Database.MySQL.NullString(quickbookData.Rows[0]["SalesEmployeeFirstName"].ToString());
					DateTime transactionDate = PeakeyTools.Database.MySQL.NullDate(quickbookData.Rows[0]["TransactionDate"].ToString());
					dynamic customer = StairSupplies.API.Quickbooks.Customer.Create(firstName, lastName);
					if (customer != null)
					{
						// Transaction info
						DataTypes.Transaction transaction = new DataTypes.Transaction();
						transaction.ID = orderTransactionID;
						transaction.OrderID = orderID;
						transaction.OfficeID = transaction.OrderID + "-" + transaction.ID; // Set a unique ID for each transaction, to reference later on
						transaction.DocNumber = transaction.OrderID.ToString();
						transaction.Date = transactionDate.ToString("yyyy-MM-ddTHH:mm:ss"); // 2014-09-19T13:16:17-07:00 : "2017-08-01T01:33:50" yyyy-MM-ddTHH:mm:ssK
						transaction.SalesEmployeeFirstName = salesEmployeeFirstName;


						// Retrieve custom fields
						List<Quickbooks.DataTypes.Preferences.CustomField> customFields = Quickbooks.Preferences.EnumerateCustomFields();


						// Retrieve Products
						List<Quickbooks.DataTypes.AccountingTypes> accountingTypes = new List<DataTypes.AccountingTypes>();
						DataTable accountingTypeData = StairSupplies.Database.TblOrdersBOM.EnumerateAccountingTypesByTransactionID(orderTransactionID);
						if (accountingTypeData.Rows.Count > 0)
						{
							foreach (DataRow row in accountingTypeData.Rows)
							{
								Quickbooks.DataTypes.AccountingTypes accountingType = new DataTypes.AccountingTypes();
								accountingType.Title = PeakeyTools.Database.MySQL.NullString(row["Title"].ToString());
								accountingType.Total = PeakeyTools.Database.MySQL.NullDouble(row["Total"].ToString());

								accountingTypes.Add(accountingType);
							}
						}


						// Create invoice
						return Create(customer, transaction, itemProductAndServices, termDueOnReceipt, customFields, accountingTypes);
					}


					PeakeyTools.Api.Log(PeakeyTools.Api.ApiName.quickbooks, "Failed to process Quickbook information for adding invoice." + "\t[OrderID]: " + orderID + "\t[OrderTransactionID]: " + orderTransactionID, "EXCEPTION");
					return PeakeyTools.Api.ToJSON(false, false, "Failed to add a Quickbook invoice.");
				}
				catch (Exception ex)
				{
					PeakeyTools.Api.Log(PeakeyTools.Api.ApiName.quickbooks, "An error has occurred while attempting to add a Quickbook invoice. " + ex.Message + "\t[OrderTransactionID]: " + orderTransactionID, "EXCEPTION");
					return PeakeyTools.Api.ToJSON(false, true, "An error has occurred while attempting to add a Quickbook invoice. " + ex.Message);
				}
			}


			#endregion


			#region Private Methods


			private static dynamic Create(DataTypes.Customer customer, DataTypes.Transaction transaction, DataTypes.Item itemProductAndServices, 
											DataTypes.Term termDueOnReceipt, List<DataTypes.Preferences.CustomField> customFields, List<DataTypes.AccountingTypes> accountingTypes)
			{
				try
				{
					if (customer == null)
					{
						PeakeyTools.Api.Log(PeakeyTools.Api.ApiName.quickbooks, "Quickbook 'customer' object is null. Cannot create invoice.", "EXCEPTION");
						return PeakeyTools.Api.ToJSON(false, true, "Quickbook 'customer' object is null. Cannot create invoice.");
					}
					if (transaction == null)
					{
						PeakeyTools.Api.Log(PeakeyTools.Api.ApiName.quickbooks, "Quickbook 'transaction' object is null. Cannot create invoice.", "EXCEPTION");
						return PeakeyTools.Api.ToJSON(false, true, "Quickbook 'transaction' object is null. Cannot create invoice.");
					}
					if (customFields == null)
					{
						PeakeyTools.Api.Log(PeakeyTools.Api.ApiName.quickbooks, "Quickbook 'customFields' object is null. Cannot create invoice.", "EXCEPTION");
						return PeakeyTools.Api.ToJSON(false, true, "Quickbook 'customFields' object is null. Cannot create invoice.");
					}


					// Create invoice
					dynamic invoiceInfo = new System.Dynamic.ExpandoObject();
					invoiceInfo.TxnDate = transaction.Date;
					invoiceInfo.DocNumber = transaction.OrderID; // 'Custom transaction numbers' setting must be false under 'Company Settings'


					// Check if an invoice already exists with this transactionID and orderID ('transactionID-orderID' value is set in the custom field 'Office ID')
					Quickbooks.DataTypes.Invoice existingInvoice = FindExisting(customer, transaction);
					if (existingInvoice != null) // An invoice already exists
					{
						invoiceInfo.Id = existingInvoice.ID; // Setting an invoice ID in the json will make the API update the record
						invoiceInfo.SyncToken = existingInvoice.SyncToken;
					}


					// For the invoice date to change, MetaData.CreateTime & TxnDate must be set with the same date/time and format
					invoiceInfo.MetaData = new System.Dynamic.ExpandoObject();
					invoiceInfo.MetaData.CreateTime = transaction.Date;


					invoiceInfo.CustomerRef = new System.Dynamic.ExpandoObject();
					invoiceInfo.CustomerRef.value = customer.ID;
					invoiceInfo.CustomerRef.name = customer.DisplayName;


					// Invoice line items
					invoiceInfo.Line = new List<dynamic>();
					foreach (var item in accountingTypes)
					{
						if (item.Total == 0) // Ignore accounting types with an amount of 0.00
						{
							continue;
						}

						dynamic products = new System.Dynamic.ExpandoObject();
						products.DetailType = "SalesItemLineDetail";
						products.Description = item.Title;
						products.Amount = item.Total;

						products.SalesItemLineDetail = new System.Dynamic.ExpandoObject();
						products.SalesItemLineDetail.Qty = 0;
						//products.SalesItemLineDetail.UnitPrice = item.UnitPrice;

						if (itemProductAndServices != null)
						{
							products.SalesItemLineDetail.ItemRef = new System.Dynamic.ExpandoObject();
							products.SalesItemLineDetail.ItemRef.value = itemProductAndServices.ID;
							products.SalesItemLineDetail.ItemRef.name = itemProductAndServices.Name;
						}

						invoiceInfo.Line.Add(products);
					}


					// Invoice term
					//if (customer.TermID != 0)
					//{
					//	invoiceInfo.SalesTermRef = new System.Dynamic.ExpandoObject();
					//	invoiceInfo.SalesTermRef.value = customer.TermID;

					//	if (customer.TermName != null)
					//	{
					//		invoiceInfo.SalesTermRef.name = customer.TermName;
					//	}
					//}
					if (termDueOnReceipt != null)
					{
						invoiceInfo.SalesTermRef = new System.Dynamic.ExpandoObject();
						invoiceInfo.SalesTermRef.value = termDueOnReceipt.ID;
						invoiceInfo.SalesTermRef.name = termDueOnReceipt.Name;
					}


					// Invoice custom fields
					invoiceInfo.CustomField = new List<dynamic>();
					foreach (var item in customFields)
					{
						dynamic customField = new System.Dynamic.ExpandoObject();

						switch (item.StringValue.ToLower())
						{
							case "office id":
								customField.DefinitionId = item.ID;
								customField.Name = item.Name;
								customField.Type = item.Type;
								customField.StringValue = transaction.OfficeID;

								invoiceInfo.CustomField.Add(customField);
								break;
							case "sales rep":
								customField.DefinitionId = item.ID;
								customField.Name = item.Name;
								customField.Type = item.Type;
								customField.StringValue = transaction.SalesEmployeeFirstName;

								invoiceInfo.CustomField.Add(customField);
								break;
						}
					}


					// Submit request
					dynamic response = JsonConvert.DeserializeObject(Quickbooks.PostRequest("invoice?include=allowduplicatedocnum", JsonConvert.SerializeObject(invoiceInfo))); // Allow duplicate invoice numbers when the 'Custom transaction numbers' setting is checked
					if (response != null && response.Invoice != null)
					{
						return PeakeyTools.Api.ToJSON(true, false, "Exported transaction to Quickbooks successfully.");
					}
					else if (response != null && response.Fault != null)
					{
						dynamic data = response.Fault.Error[0];

						Quickbooks.DataTypes.Error error = new DataTypes.Error
						{
							Message = data.Message.Value,
							Detail = data.Detail.Value,
							Code = data.code.Value
						};

						PeakeyTools.Api.Log(PeakeyTools.Api.ApiName.quickbooks, "An error has occurred while creating the invoice in Quickbooks. " +
													"\t[Error Message]: " + error.Message +
													"\t[Error Detail]: " + error.Detail +
													"\t[OrderID]: " + transaction.OrderID +
													"\t[Customer Name]: " + customer.DisplayName +
													"\t[Transaction Date]: " + transaction.Date,
													"EXCEPTION");

						return PeakeyTools.Api.ToJSON(false, false, "Failed to add a Quickbook invoice. [Error Message]: " + error.Message + " [Error Detail]: " + error.Detail);
					}
					else
					{
						PeakeyTools.Api.Log(PeakeyTools.Api.ApiName.quickbooks, "Failed to add a Quickbook invoice." + "\t[OrderID]: " + transaction.OrderID + "\t[Customer Name]: " + customer.DisplayName + "\t[Transaction Date]: " + transaction.Date, "EXCEPTION");
					}

					
					return PeakeyTools.Api.ToJSON(false, false, "Failed to add a Quickbook invoice.");
				}
				catch (Exception ex)
				{
					PeakeyTools.Api.Log(PeakeyTools.Api.ApiName.quickbooks, "An error has occurred while creating the invoice in Quickbooks. " + ex.Message +
													"\t[OrderID]: " + transaction.OrderID +
													"\t[Customer Name]: " + customer.DisplayName +
													"\t[Transaction Date]: " + transaction.Date,
													"EXCEPTION");
					throw new Exception("An error has occurred while creating the invoice in Quickbooks.", ex);
				}
			}


			private static List<Quickbooks.DataTypes.Invoice> EnumerateByCustomer(DataTypes.Customer customer)
			{
				try
				{
					String query = String.Format(@"
SELECT
	Id,
	CustomField,
	DocNumber,
	SyncToken
FROM
	Invoice
WHERE
	CustomerRef = '{0}'
", customer.ID);
					query = PeakeyTools.Database.MySQL.TrimQueryText(query);


					dynamic response = JsonConvert.DeserializeObject(Quickbooks.SubmitQuery(query));
					if (response != null && response.QueryResponse != null && response.QueryResponse.Invoice != null) // Invoice exists
					{
						List<Quickbooks.DataTypes.Invoice> invoices = new List<Quickbooks.DataTypes.Invoice>();


						foreach (var item in response.QueryResponse.Invoice)
						{
							Quickbooks.DataTypes.Invoice invoice = new Quickbooks.DataTypes.Invoice
							{
								ID = PeakeyTools.Database.MySQL.NullInt32(item.Id.Value),
								SyncToken = PeakeyTools.Database.MySQL.NullInt32(item.SyncToken.Value) // Required on update, to lock an object for use (will receive an 'Stale Object Error' if not used)
							};

							if (item.DocNumber != null)
							{
								invoice.DocNumber = PeakeyTools.Database.MySQL.NullString(item.DocNumber.Value);
							}

							// Loop through each custom field
							foreach (var customFieldItem in item.CustomField)
							{
								if (customFieldItem.StringValue != null)
								{
									switch (customFieldItem.Name.Value.ToLower())
									{
										case "sales rep":
											invoice.SalesRep = customFieldItem.StringValue.Value;
											break;
										case "office id":
											invoice.OfficeID = customFieldItem.StringValue.Value;
											break;
									}
								}
							}

							invoices.Add(invoice);
						}


						if (invoices.Count > 0)
						{
							return invoices;
						}
					}


					return null;
				}
				catch (Exception ex)
				{
					PeakeyTools.Api.Log(PeakeyTools.Api.ApiName.quickbooks, "Could not enumerate Quickbook invoices by customer. " + ex.Message +
													"\t[First Name]: " + customer.GivenName +
													"\t[Last Name]: " + customer.FamilyName,
													"EXCEPTION");
					throw new Exception("Could not enumerate Quickbook invoices by customer.", ex);
				}
			}


			private static Quickbooks.DataTypes.Invoice FindExisting(DataTypes.Customer customer, DataTypes.Transaction transaction)
			{
				try
				{
					List<Quickbooks.DataTypes.Invoice> invoices = EnumerateByCustomer(customer);


					if (invoices != null)
					{
						foreach (Quickbooks.DataTypes.Invoice invoice in invoices)
						{
							if (invoice.OfficeID == transaction.OfficeID)
							{
								return invoice;
							}
						}
					}


					return null;
				}
				catch (Exception ex)
				{
					PeakeyTools.Api.Log(PeakeyTools.Api.ApiName.quickbooks, "Could not check if Quickbook invoice exists. " + ex.Message +
													"\t[Transaction ID]: " + transaction.ID +
													"\t[Order ID]: " + transaction.OrderID,
													"EXCEPTION");
					throw new Exception("Could not check if Quickbook invoice exists.", ex);
				}
			}


			#endregion


		}


	}
}
