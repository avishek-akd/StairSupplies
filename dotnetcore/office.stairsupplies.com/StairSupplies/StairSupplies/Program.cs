using System;
using System.Data;
using Microsoft.AspNetCore;
using Microsoft.AspNetCore.Hosting;


namespace StairSupplies
{


    public class Program
    {


		public static DateTime startupTime = DateTime.MinValue;


		public static void Main(string[] args)
        {
			startupTime = DateTime.Now;
			StairSupplies.Library.Configuration.Load(); // Get configuration settings from stairsupplies.cfg


			if (args.Length > 0 && args[0].ToLower() == "testing")
			{
				DataTable apiStatuses = Testing.Integration.Run();


				foreach (DataRow row in apiStatuses.Rows)
				{
					String output = "";
					DateTime timeSpan = PeakeyTools.Database.MySQL.NullDate(row["timespan"].ToString());
					String methodName = PeakeyTools.Database.MySQL.NullString(row["method_name"].ToString());
					String status = PeakeyTools.Database.MySQL.NullString(row["status"].ToString());
					String reason = PeakeyTools.Database.MySQL.NullString(row["reason"].ToString());

					if (reason == "")
					{
						output = "[Method Name]: " + methodName + "\t[Time]: " + timeSpan.ToString() + "\t[Status]: " + status;
					}
					else
					{
						output = "[Method Name]: " + methodName + "\t[Time]: " + timeSpan.ToString() + "\t[Status]: " + status + "\t[Reason]: " + reason;
					}

					Console.WriteLine(output);
					System.Diagnostics.Debug.WriteLine(output);
				}


				return;
			}


			BuildWebHost(args).Run();
        }


        public static IWebHost BuildWebHost(string[] args) =>
            WebHost.CreateDefaultBuilder(args)
                .UseStartup<Startup>()
				.UseUrls("http://localhost:" + StairSupplies.Library.Configuration.SERVICE_PORT)
                .Build();
    }


}
