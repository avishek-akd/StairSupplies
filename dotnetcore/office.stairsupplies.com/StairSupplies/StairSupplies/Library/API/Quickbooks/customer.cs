using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;


namespace StairSupplies.API
{
	public partial class Quickbooks
	{


		public class Customer
		{


			public static Quickbooks.DataTypes.Customer Create(String firstName, String lastName)
			{
				try
				{
					if (firstName == "")
					{
						return null;
					}
					if (lastName == "")
					{
						return null;
					}


					// Check if customer already exists in Quickbooks
					Quickbooks.DataTypes.Customer existingCustomer = FindExisting(firstName, lastName);
					if (existingCustomer != null)
					{
						return existingCustomer;
					}


					// Create customer
					dynamic customerInfo = null;
					customerInfo = new System.Dynamic.ExpandoObject();
					customerInfo.GivenName = firstName;
					customerInfo.FamilyName = lastName;
					customerInfo.DisplayName = firstName + " " + lastName;


					dynamic response = JsonConvert.DeserializeObject(Quickbooks.PostRequest("customer", JsonConvert.SerializeObject(customerInfo)));
					if (response != null && response.Customer != null)
					{
						dynamic data = response.Customer;

						Quickbooks.DataTypes.Customer customer = new Quickbooks.DataTypes.Customer
						{
							ID = PeakeyTools.Database.MySQL.NullInt32(data.Id.Value),
							GivenName = data.GivenName.Value,
							FamilyName = data.FamilyName.Value
						};

						if (data.SalesTermRef != null)
						{
							if (data.SalesTermRef.value != null)
							{
								customer.TermID = PeakeyTools.Database.MySQL.NullInt32(data.SalesTermRef.value.Value);
							}
							if (data.SalesTermRef.name != null)
							{
								customer.TermName = data.SalesTermRef.name.Value;
							}
						}
						if (data.PrimaryEmailAddr != null)
						{
							customer.PrimaryEmailAddr = data.PrimaryEmailAddr.Address.Value;
						}
						if (data.PrimaryPhone != null)
						{
							customer.PrimaryPhone = data.PrimaryPhone.FreeFormNumber.Value;
						}

						return customer;
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


						PeakeyTools.Api.Log(PeakeyTools.Api.ApiName.quickbooks, "An error has occurred while creating the customer in Quickbooks. " +
													"\t[Error Message]: " + error.Message +
													"\t[Error Detail]: " + error.Detail +
													"\t[First Name]: " + firstName +
													"\t[Last Name]: " + lastName,
													"EXCEPTION");

						return null;
					}


					return null;
				}
				catch (Exception ex)
				{
					PeakeyTools.Api.Log(PeakeyTools.Api.ApiName.quickbooks, "An error has occurred while creating the customer in Quickbooks. " + ex.Message +
													"\t[First Name]: " + firstName +
													"\t[Last Name]: " + lastName,
													"EXCEPTION");
					throw new Exception("An error has occurred while creating the customer in Quickbooks.", ex);
				}
			}


			private static Quickbooks.DataTypes.Customer FindExisting(String firstName, String lastName)
			{
				try
				{
					String query = String.Format(@"
SELECT
	*
FROM
	Customer
WHERE
	GivenName = '{0}' AND
	FamilyName = '{1}'
", firstName, lastName);
					query = PeakeyTools.Database.MySQL.TrimQueryText(query);


					dynamic response = JsonConvert.DeserializeObject(Quickbooks.SubmitQuery(query));
					if (response != null && response.QueryResponse != null && response.QueryResponse.Customer != null) // Customer exists
					{
						dynamic data = response.QueryResponse.Customer[0];

						Quickbooks.DataTypes.Customer customer = new Quickbooks.DataTypes.Customer
						{
							ID = PeakeyTools.Database.MySQL.NullInt32(data.Id.Value),
							GivenName = data.GivenName.Value,
							FamilyName = data.FamilyName.Value
						};

						if (data.SalesTermRef != null)
						{
							customer.TermID = PeakeyTools.Database.MySQL.NullInt32(data.SalesTermRef.value);
							customer.TermName = data.SalesTermRef.name;
						}
						if (data.DisplayName != null)
						{
							customer.DisplayName = data.DisplayName.Value;
						}
						if (data.PrimaryEmailAddr != null)
						{
							customer.PrimaryEmailAddr = data.PrimaryEmailAddr.Address.Value;
						}
						if (data.PrimaryPhone != null)
						{
							customer.PrimaryPhone = data.PrimaryPhone.FreeFormNumber.Value;
						}

						return customer;
					}


					return null;
				}
				catch (Exception ex)
				{
					PeakeyTools.Api.Log(PeakeyTools.Api.ApiName.quickbooks, "An error has occurred while checking if the customer exists in Quickbooks. " + ex.Message +
													"\t[First Name]: " + firstName +
													"\t[Last Name]: " + lastName,
													"EXCEPTION");
					throw new Exception("An error has occurred while checking if the customer exists in Quickbooks.", ex);
				}
			}


		}


	}
}
