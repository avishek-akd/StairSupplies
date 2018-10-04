using System;
using Microsoft.AspNetCore.Mvc;


namespace StairSupplies.Controllers
{


	[Route("api/quickbooks")]
	public class QuickbooksController : Controller
	{


		[HttpPost("invoice")]
		public string SalesTransactionToInvoice(Int32 orderTransactionID)
		{
			if (orderTransactionID == 0)
			{
				PeakeyTools.Api.Log(PeakeyTools.Api.ApiName.quickbooks, "'orderTransactionID' is missing as a parameter in the Quickbook API url.", "EXCEPTION");
				return PeakeyTools.Api.ToJSON(false, true, "Error: 'orderTransactionID' is missing as a parameter in the Quickbook API url.");
			}


			return StairSupplies.API.Quickbooks.Invoice.SyncToQuickbooks(orderTransactionID);
		}


	}


}