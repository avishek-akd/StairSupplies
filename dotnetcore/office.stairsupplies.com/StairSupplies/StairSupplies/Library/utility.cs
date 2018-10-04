//***********************************************************************************************************************
//
//	Copyright 2018, Peakey Enterprise LLC
//	All rights reserved
//	http://www.peakey.com/
//
//	You may not sell or redistribute any of this code in whole or in part.
//
//	Perpetual license to this file granted to StairSupplies, may be transferred with ownership of stairsupplies website.
//
//*********************************************************************************************************************
using System;
using System.IO;
using MySql.Data.MySqlClient;
using System.Data;
using System.Net;
using Newtonsoft.Json;

namespace PeakeyTools
{
	public partial class Api
	{


		public enum ApiName
		{
			hubspot,
			payeezy,
			quickbooks,
			all
		}


		// TODO: Switch Payeezy/Hubspot logging to use this class
		public static dynamic ToDynamic(Boolean successful, Boolean notify, String apiResponse)
		{
			try
			{
				dynamic transactionResponse = null;

				transactionResponse = new System.Dynamic.ExpandoObject();
				transactionResponse.successful = successful.ToString().ToLower();
				transactionResponse.notify = notify.ToString().ToLower(); // If the response has failed, do we need to be notified about the error via front end
				transactionResponse.apiResponse = apiResponse;

				return transactionResponse;
			}
			catch
			{
				return null;
			}
		}


		public static String ToJSON(Boolean successful, Boolean notify, String apiResponse)
		{
			try
			{
				dynamic transactionResponse = null;

				transactionResponse = new System.Dynamic.ExpandoObject();
				transactionResponse.successful = successful.ToString().ToLower();
				transactionResponse.notify = notify.ToString().ToLower(); // If the response has failed, do we need to be notified about the error via front end
				transactionResponse.apiResponse = apiResponse;

				return Newtonsoft.Json.JsonConvert.SerializeObject(transactionResponse);
			}
			catch
			{
				return null;
			}
		}


		public static String DynamicToJSON(dynamic dynamicObject)
		{
			try
			{
				return Newtonsoft.Json.JsonConvert.SerializeObject(dynamicObject);
			}
			catch
			{
				return null;
			}
		}


		public static void Log(ApiName apiName, String data, String logType)
		{
			String logPath = StairSupplies.Library.LOG_PATH;
			String filePath = "";


			if (logPath == "")
			{
				return;
			}
			if (data == "")
			{
				return;
			}
			if (logType == "")
			{
				return;
			}
			filePath = logPath + apiName + "/" + logType.ToLower() + "/" + DateTime.Now.ToString("yyyy-MM-dd") + ".txt";


			if (Directory.Exists(logPath))
			{
				if (!Directory.Exists(logPath + apiName))
				{
					Directory.CreateDirectory(logPath + apiName);
				}
				if (!Directory.Exists(logPath + apiName + "/" + logType.ToLower()))
				{
					Directory.CreateDirectory(logPath + apiName + "/" + logType.ToLower());
				}

				File.AppendAllText(filePath, DateTime.UtcNow.ToString("MM-dd-yyyy hh:mm:sstt") + "\t" + data + "\r\n");
			}
		}


		public static void Log(ApiName apiName, String data, Exception ex, String logType)
		{
			data += "\t[Error Message]: " + ex.Message + "\t[Inner Exception]: " + ex.InnerException + "\t[Stacktrace]: " + ex.StackTrace;
			Log(apiName, data, logType);
		}


	}


	public partial class Web
	{


		public static String GetHTTP(String url)
		{
			WebRequest request = null;
			IAsyncResult result = null;
			WebResponse response = null;
			Stream responseStream = null;
			StreamReader reader = null;
			String strResponse = "";

			try
			{
				ServicePointManager.Expect100Continue = true;
				ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12;
				request = WebRequest.Create(url);
				result = request.BeginGetResponse(null, null);
				while (!result.IsCompleted)
				{
					System.Threading.Thread.Sleep(50);
				}

				response = request.EndGetResponse(result);
				responseStream = response.GetResponseStream();
				reader = new StreamReader(responseStream);
				strResponse = reader.ReadToEnd();

				return strResponse;
			}
			catch (Exception ex)
			{
				throw new Exception("Could not perform GetHTTP", ex);
			}
			finally
			{
				if (reader != null)
				{
					reader.Dispose();
				}
				if (responseStream != null)
				{
					responseStream.Dispose();
				}
				if (response != null)
				{
					response.Dispose();
				}
			}
		}


	}


	public partial class Other
	{


		public static String RetrieveJsonObjectValue(String jsonObject, String key)
		{
			try
			{
				Newtonsoft.Json.Linq.JObject result = Newtonsoft.Json.JsonConvert.DeserializeObject<Newtonsoft.Json.Linq.JObject>(jsonObject);

				return (string)result[key];
			}
			catch (Exception ex)
			{
				throw new Exception("Could not retrieve JSON object value.", ex);
			}
		}


		public static String RetrievePipelineIdFromJSON(String jsonObject, String name)
		{
			try
			{
				Newtonsoft.Json.Linq.JArray obj = Newtonsoft.Json.JsonConvert.DeserializeObject<Newtonsoft.Json.Linq.JArray>(jsonObject);
				foreach (var result in obj)
				{
					string pipelineName = (string)result["label"];
					string pipelineID = (string)result["pipelineId"];

					if (pipelineName.ToLower() == name.ToLower())
					{
						return pipelineID;
					}
				}

				return "default";
			}
			catch (Exception ex)
			{
				throw new Exception("Could not retrieve pipeline ID from JSON.", ex);
			}
		}


		public static String GetTimestamp(DateTime value)
		{
			try
			{
				long unixTimestamp = (long)value.Subtract(new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc)).TotalMilliseconds;

				return unixTimestamp.ToString();
			}
			catch (Exception ex)
			{
				throw new Exception("Could not get unix time stamp.", ex);
			}
		}


		public static String GetUnixDate(DateTime value)
		{
			try
			{
				long unixTimestamp = (long)value.Subtract(new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc).Date).TotalMilliseconds;

				return unixTimestamp.ToString();
			}
			catch (Exception ex)
			{
				throw new Exception("Could not get unix time stamp.", ex);
			}
		}


		public static DateTime UnixTimeStampToDateTime(double unixTimeStamp)
		{
			try
			{
				// Unix timestamp is seconds past epoch
				System.DateTime dtDateTime = new DateTime(1970, 1, 1, 0, 0, 0, 0, System.DateTimeKind.Utc);
				dtDateTime = dtDateTime.AddSeconds(unixTimeStamp).ToLocalTime();
				return dtDateTime;
			}
			catch (Exception ex)
			{
				throw new Exception("Could not convert unix timestamp to date/time", ex);
			}
		}


		public static Boolean IsValidJson(string data)
		{
			data = data.Trim();
			if ((data.StartsWith("{") && data.EndsWith("}")) || (data.StartsWith("[") && data.EndsWith("]")))
			{
				try
				{
					dynamic obj = JsonConvert.DeserializeObject(data);
					return true;
				}
				catch // not valid
				{
					return false;
				}
			}
			else
			{
				return false;
			}
		}


	}


	public partial class Database
	{


		public static class MySQL
		{


			#region Declarations


			private static Int32 intCommandTimeout = 30;
			private static String connectionString = "";


			#endregion


			#region Public Methods


			public static void CleanUp(MySqlConnection cn, MySqlCommand cmd, MySqlDataReader dr)
			{
				CleanUp(cn, cmd, dr, null);
			}


			public static void CleanUp(MySqlConnection cn, MySqlCommand cmd, MySqlDataReader dr, DataSet ds)
			{
				try
				{
					if (cn != null)
					{
						cn.Close();
						cn.Dispose();
						cn = null;
					}

					if (cmd != null)
					{
						cmd.Dispose();
						cmd = null;
					}

					if (dr != null)
					{
						dr.Dispose();
						dr.Close();
						dr = null;
					}

					if (ds != null)
					{
						ds.Dispose();
						ds = null;
					}
				}
				catch (Exception ex)
				{
					throw new Exception("Could not perform CleanUp", ex);
				}
			}


			public static DataTable DataReaderToDataTable(MySqlDataReader dr)
			{
				DataTable dt = new DataTable();
				try
				{
					int colCount = dr.FieldCount;

					for (int counter = 0; counter < colCount; counter++)
					{
						if (!dt.Columns.Contains(dr.GetName(counter)))
						{
							dt.Columns.Add(dr.GetName(counter));
						}
					}

					if (dr.HasRows)
					{
						while (dr.Read())
						{
							DataRow row = dt.NewRow();

							for (int counter = 0; counter < colCount; counter++)
							{
								String value = dr[counter].ToString();

								row[counter] = dr[counter].ToString();
							}

							dt.Rows.Add(row);
						}
					}

					return dt;
				}
				catch (Exception ex)
				{
					throw new Exception("Could not read data table.", ex);
				}
			}


			public static void AddParameter(MySqlCommand cmd, String strParameterName, MySqlDbType DataType, Object objValue)
			{
				try
				{
					MySqlParameter param = new MySqlParameter();

					param.ParameterName = strParameterName;
					param.MySqlDbType = DataType;
					param.Value = objValue;

					cmd.Parameters.Add(param);
				}
				catch (Exception ex)
				{
					throw new Exception("Could not add paramter to command.", ex);
				}
			}


			public static MySqlCommand TrimCommandText(MySqlCommand cmd)
			{
				try
				{
					cmd.CommandText =
						cmd.CommandText
						.Replace(System.Environment.NewLine, " ")
						.Replace("\t", " ").Trim()
						.Replace("[", "").Replace("]", "");
					return cmd;
				}
				catch (Exception ex)
				{
					throw new Exception("Could not trim command text.", ex);
				}
			}


			public static String TrimQueryText(String query)
			{
				try
				{
					query =
						query
						.Replace(System.Environment.NewLine, " ")
						.Replace("\t", " ")
						.Replace("[", "").Replace("]", "");
					return query;
				}
				catch (Exception ex)
				{
					throw new Exception("Could not trim query text.", ex);
				}
			}


			public static DateTime NullDate(Object Field)
			{
				try
				{
					if (DBNull.Value != Field)
					{
						return DateTime.Parse(Field.ToString());
					}

					return DateTime.MinValue;
				}
				catch (Exception)
				{
					return DateTime.MinValue;
				}
			}


			public static Guid NullGuid(Object Field)
			{
				try
				{
					if (DBNull.Value != Field)
					{
						return Guid.Parse(Field.ToString());
					}

					return Guid.Empty;
				}
				catch (Exception)
				{
					return Guid.Empty;
				}
			}


			public static Boolean NullIntToBoolean(Object Field)
			{
				try
				{
					if (DBNull.Value != Field)
					{
						return Convert.ToBoolean(NullInt32(Field));
					}

					return false;
				}
				catch (Exception)
				{
					return false;
				}
			}


			public static Int32 NullInt32(Object Field)
			{
				try
				{
					if (DBNull.Value != Field)
					{
						return Int32.Parse(Field.ToString());
					}

					return 0;
				}
				catch (Exception)
				{
					return 0;
				}
			}


			public static String NullString(Object Field)
			{
				try
				{
					if (DBNull.Value != Field)
					{
						return Field.ToString();
					}

					return "";
				}
				catch (Exception)
				{
					return "";
				}
			}


			public static Boolean NullBoolean(Object Field)
			{
				try
				{
					if (DBNull.Value != Field)
					{
						return Boolean.Parse(Field.ToString());
					}

					return false;
				}
				catch (Exception)
				{
					return false;
				}
			}


			public static Double NullDouble(Object Field)
			{
				try
				{
					if (DBNull.Value != Field)
					{
						return Double.Parse(Field.ToString());
					}

					return 0.00;
				}
				catch (Exception)
				{
					return 0.00;
				}
			}


			public static String BooleanToInt32(Boolean value)
			{
				try
				{
					return Convert.ToInt32(value).ToString();
				}
				catch (Exception)
				{
					return "0";
				}
			}


			public static Boolean OpenConnection(ref MySqlConnection cn, ref MySqlCommand cmd)
			{
				cn = new MySqlConnection(ConnectionString);
				cmd = new MySqlCommand();

				cmd.Connection = cn;
				cmd.CommandTimeout = intCommandTimeout;
				cn.Open();

				return true;
			}


			#endregion


			#region Properties


			public static String ConnectionString
			{
				get
				{
					try
					{
						return connectionString;
					}
					catch (Exception ex)
					{
						throw new Exception("Could not get Connection string for database.", ex);
					}
				}
				set
				{
					try
					{
						connectionString = value;
					}
					catch (Exception ex)
					{
						throw new Exception("Could not set Connection string for database.", ex);
					}
				}
			}


			#endregion


		}


	}
}