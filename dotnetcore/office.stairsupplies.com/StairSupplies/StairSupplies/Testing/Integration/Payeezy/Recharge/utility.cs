using Newtonsoft.Json;
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
		public partial class Payeezy
		{
			public partial class Recharge
			{


				#region Public Methods


				public static Boolean Run(DataTable apiStatuses, API.Payeezy.Recharge.TransactionData transactionData)
				{
					try
					{
						Boolean failure = false;


						failure = failure | !TestCaseSubmitRechargeTransaction(apiStatuses, transactionData);


						return !failure;
					}
					catch (Exception ex)
					{
						PeakeyTools.Api.Log(PeakeyTools.Api.ApiName.quickbooks, "Could not run Payeezy integration tests for recharge transaction.", ex, "TESTING");
						throw new Exception("Could not run Payeezy integration tests for recharge transaction.", ex);
					}
				}


				#endregion


				#region Private Methods


				private static Boolean TestCaseSubmitRechargeTransaction(DataTable apiStatuses, API.Payeezy.Recharge.TransactionData transactionData)
				{
					var methodInfo = System.Reflection.MethodBase.GetCurrentMethod();
					var fullMethodName = string.Format("{0}.{1}()", methodInfo.ReflectedType.FullName.Replace("+", "."), methodInfo.Name);

					try
					{
						dynamic response = JsonConvert.DeserializeObject(StairSupplies.API.Payeezy.Recharge.SubmitRechargeTransaction(transactionData));
						if (response.successful.Value == "false")
						{
							CreateDataRow(apiStatuses, fullMethodName, DateTime.Now, "failed", "Could not submit recharge transaction to Payeezy. " + response.apiResponse.Value);
							return false;
						}


						CreateDataRow(apiStatuses, fullMethodName, DateTime.Now, "success", "");
						return true;
					}
					catch (Exception ex)
					{
						CreateDataRow(apiStatuses, fullMethodName, DateTime.Now, "failed", ex.Message + "" + ex.StackTrace);
						return false;
					}
				}


				#endregion


			}
		}
	}
}