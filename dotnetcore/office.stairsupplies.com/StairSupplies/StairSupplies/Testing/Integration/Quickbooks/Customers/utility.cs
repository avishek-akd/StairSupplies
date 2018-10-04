using System;
using System.Collections.Generic;
using System.Data;
using System.Threading.Tasks;


namespace StairSupplies.Testing
{
	public partial class Integration
	{
		public partial class Quickbooks
		{
			public partial class Customers
			{


				#region Public Methods


				public static Boolean Run(DataTable dataTable, String firstName, String lastName)
				{
					try
					{
						Boolean failure = false;


						failure = failure | !Create(dataTable, firstName, lastName);


						return !failure;
					}
					catch (Exception ex)
					{
						PeakeyTools.Api.Log(PeakeyTools.Api.ApiName.quickbooks, "Could not run Quickbook integration tests for customers.", ex, "TESTING");
						throw new Exception("Could not run Quickbook integration tests for customers.", ex);
					}
				}


				#endregion


				#region Private Methods


				private static Boolean Create(DataTable dataTable, String firstName, String lastName)
				{
					var methodInfo = System.Reflection.MethodBase.GetCurrentMethod();
					var fullMethodName = string.Format("{0}.{1}()", methodInfo.ReflectedType.FullName.Replace("+", "."), methodInfo.Name);

					try
					{
						StairSupplies.API.Quickbooks.DataTypes.Customer customer = null;


						customer = StairSupplies.API.Quickbooks.Customer.Create(firstName, lastName);
						if (customer == null)
						{
							CreateDataRow(dataTable, fullMethodName, DateTime.Now, "failed", "Could not create Quickbook customer.");
							return false;
						}


						CreateDataRow(dataTable, fullMethodName, DateTime.Now, "success", "");
						return true;
					}
					catch (Exception ex)
					{
						CreateDataRow(dataTable, fullMethodName, DateTime.Now, "failed", ex.Message + "" + ex.StackTrace);
						return false;
					}
				}


				#endregion


			}
		}
	}
}