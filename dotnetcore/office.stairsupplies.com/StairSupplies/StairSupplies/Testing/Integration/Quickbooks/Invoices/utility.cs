using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Threading.Tasks;


namespace StairSupplies.Testing
{
	public partial class Integration
	{
		public partial class Quickbooks
		{
			public partial class Invoices
			{


				#region Public Methods


				public static Boolean Run(DataTable dataTable, Int32 orderTransactionID)
				{
					try
					{
						Boolean failure = false;


						failure = failure | !TestCaseCreateTransaction(dataTable, orderTransactionID);


						return !failure;
					}
					catch (Exception ex)
					{
						PeakeyTools.Api.Log(PeakeyTools.Api.ApiName.quickbooks, "Could not run Quickbook integration tests for invoices.", ex, "TESTING");
						throw new Exception("Could not run Quickbook integration tests for invoices.", ex);
					}
				}


				#endregion


				#region Private Methods


				private static Boolean TestCaseCreateTransaction(DataTable dataTable, Int32 orderTransactionID)
				{
					var methodInfo = System.Reflection.MethodBase.GetCurrentMethod();
					var fullMethodName = string.Format("{0}.{1}()", methodInfo.ReflectedType.FullName.Replace("+", "."), methodInfo.Name);

					try
					{
						dynamic response = JsonConvert.DeserializeObject(StairSupplies.API.Quickbooks.Invoice.SyncToQuickbooks(orderTransactionID));
						if (response.successful.Value == "false")
						{
							CreateDataRow(dataTable, fullMethodName, DateTime.Now, "failed", "Could not sync to Quickbooks. " + response.apiResponse.Value);
							return false;
						}


						CreateDataRow(dataTable, fullMethodName, DateTime.Now, "success", "");
						return true;
					}
					catch (Exception ex)
					{
						CreateDataRow(dataTable, fullMethodName, DateTime.Now, "failed", ex.Message + " " + ex.StackTrace);
						return false;
					}
				}


				#endregion


			}
		}
	}
}