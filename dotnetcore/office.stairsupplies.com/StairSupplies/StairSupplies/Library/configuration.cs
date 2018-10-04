using System;
using System.Collections.Generic;
using System.IO;


namespace StairSupplies
{
	public partial class Library
	{


		public static String LOG_PATH = System.IO.Directory.GetCurrentDirectory() + "/";


		public class Configuration
		{


			public static Int32 SERVICE_PORT { get; private set; }


			class Settings
			{
				// Database
				internal string MysqlUsername { get; set; }
				internal string MysqlPassword { get; set; }
				internal string MysqlServer { get; set; }
				internal string MysqlPort { get; set; }
				internal string MysqlDbName { get; set; }

				// Payeezy
				internal string GatewayID { get; set; }
				internal string GatewayPassword { get; set; }
				internal string KeyID { get; set; }
				internal string HmacKey { get; set; }
				internal string PayeezyMode { get; set; }

				// Quickbooks
				internal string Quickbooks_Client_ID { get; set; }
				internal string Quickbooks_Client_Secret { get; set; }
				internal string Quickbooks_Realm_ID { get; set; }
				internal string Quickbooks_Redirect_URI { get; set; }
				internal string Quickbooks_Mode { get; set; }
			}


			public static void Load()
			{
				try
				{
					string path = System.IO.Directory.GetCurrentDirectory() + "/stairsupplies.cfg";
					Settings configurationSettings;

						System.IO.StreamReader file = new System.IO.StreamReader(path);
						using (StreamReader sr = new StreamReader(path))
						{
							configurationSettings = new Settings();

							while (true)
							{
								string line = sr.ReadLine();
								string settingName = "";
								string settingValue = "";

								if (line == null)
								{
									break;
								}
								if (line == "" || line.StartsWith("#"))
								{
									continue;
								}

								settingName = line.Substring(0, line.IndexOf(":"));
								settingValue = line.Substring(line.IndexOf(":") + 1);
								switch (settingName.ToLower())
								{
									case "mysql_username":
										configurationSettings.MysqlUsername = settingValue;
										break;
									case "mysql_password":
										configurationSettings.MysqlPassword = settingValue;
										break;
									case "mysql_server":
										configurationSettings.MysqlServer = settingValue;
										break;
									case "mysql_port":
										configurationSettings.MysqlPort = settingValue;
										break;
									case "mysql_db_name":
										configurationSettings.MysqlDbName = settingValue;
										break;


									case "gateway_id":
										configurationSettings.GatewayID = settingValue;
										break;
									case "gateway_password":
										configurationSettings.GatewayPassword = settingValue;
										break;
									case "key_id":
										configurationSettings.KeyID = settingValue;
										break;
									case "hmac_key":
										configurationSettings.HmacKey = settingValue;
										break;
									case "payeezy_mode":
										configurationSettings.PayeezyMode = settingValue;
										break;

									case "service_port":
										SERVICE_PORT = Int32.Parse(settingValue);
										break;

									case "quickbooks_client_id":
										configurationSettings.Quickbooks_Client_ID = settingValue;
										break;
									case "quickbooks_client_secret":
										configurationSettings.Quickbooks_Client_Secret = settingValue;
										break;
									case "quickbooks_realm_id":
										configurationSettings.Quickbooks_Realm_ID = settingValue;
										break;
									case "quickbooks_redirect_uri":
										configurationSettings.Quickbooks_Redirect_URI = settingValue;
										break;
									case "quickbooks_mode":
										configurationSettings.Quickbooks_Mode = settingValue;
										break;


									case "log_path":
										if (settingValue.Length > 0)
										{
											LOG_PATH = settingValue;
										}
										break;
								}
							}


							// Check for missing configuration settings
							if (configurationSettings.MysqlUsername == null)
							{
								throw new ConfigurationException("mysql_username");
							}
							else if (configurationSettings.MysqlPassword == null)
							{
								throw new ConfigurationException("mysql_password");
							}
							else if (configurationSettings.MysqlServer == null)
							{
								throw new ConfigurationException("mysql_server");
							}
							else if (configurationSettings.MysqlPort == null)
							{
								throw new ConfigurationException("mysql_port");
							}
							else if (configurationSettings.MysqlDbName == null)
							{
								throw new ConfigurationException("mysql_db_name");
							}
							else if (configurationSettings.GatewayID == null)
							{
								throw new ConfigurationException("gateway_id");
							}
							else if (configurationSettings.GatewayPassword == null)
							{
								throw new ConfigurationException("gateway_password");
							}
							else if (configurationSettings.KeyID == null)
							{
								throw new ConfigurationException("key_id");
							}
							else if (configurationSettings.HmacKey == null)
							{
								throw new ConfigurationException("hmac_key");
							}
							else if (configurationSettings.PayeezyMode == null)
							{
								throw new ConfigurationException("payeezy_mode");
							}
							else if (configurationSettings.Quickbooks_Client_ID == null)
							{
								throw new ConfigurationException("quickbooks_client_id");
							}
							else if (configurationSettings.Quickbooks_Client_Secret == null)
							{
								throw new ConfigurationException("quickbooks_client_secret");
							}
							//else if (configurationSettings.Quickbooks_Realm_ID == null)
							//{
							//	throw new ConfigurationException("quickbooks_realm_id");
							//}
							else if (configurationSettings.Quickbooks_Redirect_URI == null)
							{
								throw new ConfigurationException("quickbooks_redirect_uri");
							}
							else if (configurationSettings.Quickbooks_Mode == null)
							{
								throw new ConfigurationException("quickbooks_mode");
							}
							else if (SERVICE_PORT == 0)
							{
								throw new ConfigurationException("service_port");
							}


							PeakeyTools.Database.MySQL.ConnectionString = "server=" + configurationSettings.MysqlServer +
																		  "; port=" + configurationSettings.MysqlPort +
																		  "; database=" + configurationSettings.MysqlDbName +
																		  "; user=" + configurationSettings.MysqlUsername +
																		  "; password=" + configurationSettings.MysqlPassword;


							StairSupplies.API.Payeezy.GatewayID = configurationSettings.GatewayID;
							StairSupplies.API.Payeezy.GatewayPassword = configurationSettings.GatewayPassword;
							StairSupplies.API.Payeezy.KeyID = configurationSettings.KeyID;
							StairSupplies.API.Payeezy.HmacKey = configurationSettings.HmacKey;
							switch (configurationSettings.PayeezyMode.ToLower())
							{
								case "live":
									StairSupplies.API.Payeezy.ApiURL = "https://api.globalgatewaye4.firstdata.com";
									break;
								default:
									StairSupplies.API.Payeezy.ApiURL = "https://api.demo.globalgatewaye4.firstdata.com";
									break;
							}


							StairSupplies.API.Quickbooks.ClientID = configurationSettings.Quickbooks_Client_ID;
							StairSupplies.API.Quickbooks.ClientSecret = configurationSettings.Quickbooks_Client_Secret;
							//StairSupplies.API.Quickbooks.RealmID = configurationSettings.Quickbooks_Realm_ID;
							StairSupplies.API.Quickbooks.RedirectURI = configurationSettings.Quickbooks_Redirect_URI;
							switch (configurationSettings.Quickbooks_Mode.ToLower())
							{
								case "live":
									StairSupplies.API.Quickbooks.ApiURL = "https://quickbooks.api.intuit.com";
									break;
								default:
									StairSupplies.API.Quickbooks.ApiURL = "https://sandbox-quickbooks.api.intuit.com";
									break;
							}
						}
				}
				catch (Exception ex)
				{
					throw new Exception("Could not parse configuration settings.", ex);
				}
			}


		}


	}
}
