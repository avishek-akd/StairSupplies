using MySql.Data.MySqlClient;
using System;
using System.Data;


namespace StairSupplies.Database
{


	public class Settings
	{


		public static DataTable LoadByName(String settingName)
		{
			MySqlConnection cn = null;
			MySqlCommand cmd = new MySqlCommand();
			MySqlDataReader DR = null;
			try
			{
				PeakeyTools.Database.MySQL.OpenConnection(ref cn, ref cmd);
				cmd.CommandText = @"
SELECT 
	* 
FROM 
	TblSettings 
WHERE 
	Setting = @settingName
";

				PeakeyTools.Database.MySQL.AddParameter(cmd, "@settingName", MySqlDbType.VarChar, settingName);

				PeakeyTools.Database.MySQL.TrimCommandText(cmd);
				DR = cmd.ExecuteReader();

				return PeakeyTools.Database.MySQL.DataReaderToDataTable(DR);
			}
			catch (Exception ex)
			{
				throw new Exception("Could not load setting '" + settingName + "' by name.", ex);
			}
			finally
			{
				PeakeyTools.Database.MySQL.CleanUp(cn, cmd, DR);
			}
		}


		public static Boolean Save(String settingName, String settingValue)
		{
			MySqlConnection cn = null;
			MySqlCommand cmd = null;
			DataTable DT = null;
			try
			{
				Boolean blnFound = false;
				DT = LoadByName(settingName);
				if (DT.Rows.Count > 0)
				{
					blnFound = true;
				}

				PeakeyTools.Database.MySQL.OpenConnection(ref cn, ref cmd);
				if (blnFound)
				{
					cmd.CommandText = @"
UPDATE 
	TblSettings 
SET 
	Value = @settingValue 
WHERE 
	Setting = @settingName
";
				}
				else
				{
					cmd.CommandText = @"
INSERT INTO TblSettings 
( 
	Setting, 
	Value 
) 
VALUES 
( 
	@settingName, 
	@settingValue 
)
";
				}

				PeakeyTools.Database.MySQL.AddParameter(cmd, "@settingName", MySqlDbType.VarChar, settingName);
				PeakeyTools.Database.MySQL.AddParameter(cmd, "@settingValue", MySqlDbType.VarChar, settingValue);

				PeakeyTools.Database.MySQL.TrimCommandText(cmd);
				cmd.ExecuteNonQuery();
				return true;
			}
			catch (Exception ex)
			{
				throw new Exception("Could not update/save setting.", ex);
			}
			finally
			{
				PeakeyTools.Database.MySQL.CleanUp(cn, cmd, null);
			}
		}


	}


}