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


		public class Item
		{


			public static Quickbooks.DataTypes.Item FindByName(String itemName)
			{
				try
				{
					String query = String.Format(@"
SELECT
	*
FROM
	Item
WHERE
	Name = '{0}'
", itemName);
					query = PeakeyTools.Database.MySQL.TrimQueryText(query);


					dynamic response = JsonConvert.DeserializeObject(Quickbooks.SubmitQuery(query));
					if (response != null && response.QueryResponse != null && response.QueryResponse.Item != null)
					{
						dynamic data = response.QueryResponse.Item[0];

						Quickbooks.DataTypes.Item item = new Quickbooks.DataTypes.Item
						{
							ID = PeakeyTools.Database.MySQL.NullInt32(data.Id.Value),
							Name = data.Name.Value
						};

						return item;
					}


					return null;
				}
				catch (Exception ex)
				{
					PeakeyTools.Api.Log(PeakeyTools.Api.ApiName.quickbooks, "Could not find Quickbook Item by name. [Item Name]: " + itemName + " " + ex.Message, "EXCEPTION");
					throw new Exception("An error has occurred while checking if the customer exists in Quickbooks.", ex);
				}
			}


		}


	}
}