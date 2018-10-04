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


		public class Term
		{


			public static Quickbooks.DataTypes.Term FindByName(String termName)
			{
				try
				{
					String query = String.Format(@"
SELECT
	*
FROM
	Term
WHERE
	Name = '{0}'
", termName);
					query = PeakeyTools.Database.MySQL.TrimQueryText(query);


					dynamic response = JsonConvert.DeserializeObject(Quickbooks.SubmitQuery(query));
					if (response != null && response.QueryResponse != null && response.QueryResponse.Term != null)
					{
						dynamic data = response.QueryResponse.Term[0];

						Quickbooks.DataTypes.Term term = new Quickbooks.DataTypes.Term
						{
							ID = PeakeyTools.Database.MySQL.NullInt32(data.Id.Value),
							Name = data.Name.Value
						};

						return term;
					}


					return null;
				}
				catch (Exception ex)
				{
					PeakeyTools.Api.Log(PeakeyTools.Api.ApiName.quickbooks, "Could not find Quickbook Term by name. [Term Name]: " + termName + " " + ex.Message, "EXCEPTION");
					throw new Exception("An error has occurred while checking if the customer exists in Quickbooks.", ex);
				}
			}


			public static List<Quickbooks.DataTypes.Term> Enumerate()
			{
				try
				{
					String query = @"
SELECT
	*
FROM
	Term
";
					query = PeakeyTools.Database.MySQL.TrimQueryText(query);


					dynamic response = JsonConvert.DeserializeObject(Quickbooks.SubmitQuery(query));
					if (response != null && response.QueryResponse != null && response.QueryResponse.Term != null) // Term exists
					{
						List<Quickbooks.DataTypes.Term> terms = new List<DataTypes.Term>();


						foreach (var item in response.QueryResponse.Term)
						{
							Quickbooks.DataTypes.Term term = new Quickbooks.DataTypes.Term
							{
								ID = PeakeyTools.Database.MySQL.NullInt32(item.Id.Value),
								Name = item.Name.Value,
								Active = PeakeyTools.Database.MySQL.NullBoolean(item.Active.Value)
							};

							terms.Add(term);
						}


						if (terms.Count > 0)
						{
							return terms;
						}
					}


					return null;
				}
				catch (Exception ex)
				{
					PeakeyTools.Api.Log(PeakeyTools.Api.ApiName.quickbooks, "An error has occurred while attempting to enumerate Quickbook terms. " + ex.Message, "EXCEPTION");
					throw new Exception("Could not enumerate Quickbook terms.", ex);
				}
			}


		}


	}
}