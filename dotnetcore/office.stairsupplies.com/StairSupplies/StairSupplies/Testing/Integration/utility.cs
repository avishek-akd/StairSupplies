using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Threading.Tasks;


namespace StairSupplies.Testing
{
	public partial class Integration
	{


		public static DataTable Run()
		{
			try
			{
				DataTable apiStatuses = new DataTable();
				apiStatuses.Columns.Add("method_name", typeof(string));
				apiStatuses.Columns.Add("timespan", typeof(DateTime));
				apiStatuses.Columns.Add("status", typeof(string));
				apiStatuses.Columns.Add("reason", typeof(string));


				Testing.Integration.Payeezy.Run(apiStatuses);
				Testing.Integration.Quickbooks.Run(apiStatuses);


				return apiStatuses;
			}
			catch (Exception ex)
			{
				PeakeyTools.Api.Log(PeakeyTools.Api.ApiName.quickbooks, "Could not run integration tests.", ex, "TESTING");
				throw new Exception("Could not run integration tests.", ex);
			}
		}


		public static void CreateDataRow(DataTable dataTable, String methodName, DateTime timeSpan, String status, String reason)
		{
			try
			{
				DataRow row = dataTable.NewRow();
				row["method_name"] = methodName;
				row["timespan"] = timeSpan;
				row["status"] = status;
				row["reason"] = reason;


				dataTable.Rows.Add(row);
			}
			catch (Exception ex)
			{
				PeakeyTools.Api.Log(PeakeyTools.Api.ApiName.quickbooks, "Could not create DataRow during integration test.", ex, "TESTING");
				throw new Exception("Could not create DataRow during integration test.", ex);
			}
		}


	}
}