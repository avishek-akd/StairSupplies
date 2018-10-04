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


		public class Preferences
		{


			public static List<Quickbooks.DataTypes.Preferences.CustomField> EnumerateCustomFields()
			{
				try
				{
					String query = @"
SELECT
	*
FROM
	Preferences
";
					query = PeakeyTools.Database.MySQL.TrimQueryText(query);


					dynamic response = JsonConvert.DeserializeObject(Quickbooks.SubmitQuery(query));
					if (response != null && response.QueryResponse != null && response.QueryResponse.Preferences != null) // Custom fields exist
					{
						List<Quickbooks.DataTypes.Preferences.CustomField> customFields = new List<DataTypes.Preferences.CustomField>();


						foreach (var item in response.QueryResponse.Preferences[0].SalesFormsPrefs.CustomField[1].CustomField)
						{
							Quickbooks.DataTypes.Preferences.CustomField customField = new Quickbooks.DataTypes.Preferences.CustomField
							{
								ID = PeakeyTools.Database.MySQL.NullInt32(item.Name.Value.Substring(item.Name.Value.Length - 1, 1)), // Parse ID since QB includes the ID in the name field for some reason (Can only have up to 3 custom fields, so subtract 1)
								Name = item.Name.Value,
								Type = item.Type.Value,
								StringValue = item.StringValue.Value
							};

							customFields.Add(customField);
						}


						if (customFields.Count > 0)
						{
							return customFields;
						}
					}


					return null;
				}
				catch (Exception ex)
				{
					PeakeyTools.Api.Log(PeakeyTools.Api.ApiName.quickbooks, "An error has occurred while attempting to enumerate Quickbook custom fields. " + ex.Message, "EXCEPTION");
					throw new Exception("Could not enumerate Quickbook custom fields.", ex);
				}
			}


		}


	}
}