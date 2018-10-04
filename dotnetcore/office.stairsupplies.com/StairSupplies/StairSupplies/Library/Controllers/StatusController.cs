using System;
using System.Data;
using Microsoft.AspNetCore.Mvc;


namespace StairSupplies.Controllers
{


	[Route("api")]
	public class StatusController : Controller
	{


		[HttpGet("status")]
		public string RetrieveStatus()
		{
			TimeSpan runTime = DateTime.Now.Subtract(StairSupplies.Program.startupTime);
			String statusOutput = "";


			statusOutput += "[Elapsed Run Time]: " +
									runTime.Days.ToString("D1") + " days, " +
									runTime.Hours.ToString("D1") + " hours, " +
									runTime.Minutes.ToString("D1") + " minutes, " +
									runTime.Seconds.ToString("D1") + " seconds, " +
									runTime.Milliseconds.ToString("D1") + " milliseconds";


			return statusOutput;
		}


	}


}