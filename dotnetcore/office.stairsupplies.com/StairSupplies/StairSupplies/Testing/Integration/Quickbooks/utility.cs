using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text.RegularExpressions;
using System.Threading.Tasks;


namespace StairSupplies.Testing
{
	public partial class Integration
	{
		public partial class Quickbooks
		{


			public static Boolean Run(DataTable dataTable)
			{
				try
				{
					// Quickbook test data
					const Int32 orderTransactionID = 128871;
					const String firstName = "first";
					String lastName = Regex.Replace("_last_" + Guid.NewGuid().ToString(), @"[\d-]", string.Empty);



					if (!Invoices.Run(dataTable, orderTransactionID))
					{
						return false;
					}
					if (!Customers.Run(dataTable, firstName, lastName))
					{
						return false;
					}


					return true;
				}
				catch (Exception ex)
				{
					PeakeyTools.Api.Log(PeakeyTools.Api.ApiName.quickbooks, "Could not run Quickbook integration tests.", ex, "TESTING");
					throw new Exception("Could not run Quickbook integration tests.", ex);
				}
			}


		}
	}
}