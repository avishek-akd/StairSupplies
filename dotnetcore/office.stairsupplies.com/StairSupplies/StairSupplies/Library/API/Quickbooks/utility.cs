using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Net;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;


namespace StairSupplies.API
{


	public partial class Quickbooks
	{


		#region Declerations


		private const String SETTING_CODE = "QUICKBOOKS OAUTH CODE";
		private const String SETTING_REFRESH_TOKEN = "QUICKBOOKS OAUTH REFRESH TOKEN";
		private const String SETTING_REALM_ID = "QUICKBOOKS REALMID";

		private static String clientID = "";
		private static String clientSecret = "";
		private static String realmID = ""; // Company ID (Account menu > Sandboxes)
		private static String redirectUri = "";
		private static String apiUrl = "";

		//private const String DISCOVERY_URI = "https://developer.api.intuit.com/.well-known/openid_sandbox_configuration/";
		private const String OAUTH_URI = "https://oauth.platform.intuit.com/oauth2/v1/tokens/bearer";
		private const String API_URI = "/v3/company/";

		private static ClientCredentials credentials = new ClientCredentials();


		public struct Endpoints
		{
			public static String Jwks;
			public static String Authorization;
			public static String Token;
		}


		#endregion


		#region Methods


		public static void RetrieveCredentials()
		{
			try
			{
				DataTable settingRefreshToken = StairSupplies.Database.Settings.LoadByName(SETTING_REFRESH_TOKEN);
				if (settingRefreshToken.Rows.Count == 0) // Refresh token does not yet exist... create one
				{
					RetrieveRealmID(); // The realmID is received with the Oauth code (when user logs into QB)
					RetrieveRefreshToken();
				}
				else // Refresh token already exists... renew it
				{
					RetrieveRealmID(); // The realmID is received with the Oauth code (when user logs into QB)
					RefreshToken();
				}
			}
			catch (Exception ex)
			{
				throw new Exception("Could not retrieve credentials for Quickbooks.", ex);
			}
		}


		private static void RetrieveRealmID()
		{
			try
			{
				DataTable settingRealmID = StairSupplies.Database.Settings.LoadByName(SETTING_REALM_ID);
				if (settingRealmID.Rows.Count == 0)
				{
					PeakeyTools.Api.Log(PeakeyTools.Api.ApiName.quickbooks, "Could not retrieve Quickbooks RealmID for Quickbooks from database.", "EXCEPTION");
					throw new Exception("Could not retrieve Quickbooks RealmID for Quickbooks from database.");
				}
				credentials.RealmID = PeakeyTools.Database.MySQL.NullString(settingRealmID.Rows[0]["Value"].ToString());
			}
			catch (Exception ex)
			{
				PeakeyTools.Api.Log(PeakeyTools.Api.ApiName.quickbooks, "Could not retrieve Quickbook realmID from database. " + ex.Message, "EXCEPTION");
				throw new Exception("Could not perform RetrieveRealmID.", ex);
			}
		}


		private static void RetrieveRefreshToken()
		{
			try
			{
				// Retrieve Oauth code from database (which is saved from a CF page after logging into QB)
				DataTable settingCode = StairSupplies.Database.Settings.LoadByName(SETTING_CODE);
				if (settingCode.Rows.Count == 0)
				{
					PeakeyTools.Api.Log(PeakeyTools.Api.ApiName.quickbooks, "Could not retrieve Quickbooks Oauth Code for Quickbooks from database.", "EXCEPTION");
					throw new Exception("Could not retrieve Quickbooks Oauth Code for Quickbooks from database.");
				}
				credentials.Code = PeakeyTools.Database.MySQL.NullString(settingCode.Rows[0]["Value"].ToString());


				// Retrieve Access Token & Save newly generated Refresh Token (Refresh Token expires after 100 days; Access Token expires after 1 hour)
				String basicAuth = "Basic " + Convert.ToBase64String(Encoding.ASCII.GetBytes(ClientID + ":" + ClientSecret));
				String request = string.Format("grant_type=authorization_code&code={0}&redirect_uri={1}", credentials.Code, redirectUri);

				HttpWebRequest webRequest = (HttpWebRequest)WebRequest.Create(OAUTH_URI);
				webRequest.ServerCertificateValidationCallback += (sender, certificate, chain, sslPolicyErrors) => true; // Fixes 'The remote certificate is invalid according to the validation procedure.' error
				webRequest.Method = "POST";
				webRequest.ContentType = "application/x-www-form-urlencoded";
				webRequest.Accept = "application/json";
				webRequest.Headers[HttpRequestHeader.Authorization] = basicAuth;
				webRequest.ContentLength = request.Length;
				using (StreamWriter streamWriter = new StreamWriter(webRequest.GetRequestStream()))
				{
					streamWriter.Write(request);
				}


				try
				{
					HttpWebResponse response = (HttpWebResponse)webRequest.GetResponse();
					using (StreamReader streamReader = new StreamReader(response.GetResponseStream()))
					{
						string responseData = streamReader.ReadToEnd();

						ClientCredentials refreshedCredentials = JsonConvert.DeserializeObject<ClientCredentials>(responseData);
						credentials.RefreshToken = refreshedCredentials.RefreshToken;
						credentials.AccessToken = refreshedCredentials.AccessToken;

						// Add Refresh Token to database
						StairSupplies.Database.Settings.Save(SETTING_REFRESH_TOKEN, credentials.RefreshToken);
					}
				}
				catch (WebException ex)
				{
					if (ex.Status == WebExceptionStatus.ProtocolError)
					{
						var response = ex.Response as HttpWebResponse;

						if (response != null)
						{
							using (StreamReader reader = new StreamReader(response.GetResponseStream()))
							{
								string responseText = reader.ReadToEnd();

								if (responseText != null && responseText != "")
								{
									PeakeyTools.Api.Log(PeakeyTools.Api.ApiName.quickbooks, "Could not retrieve Oauth refresh token. " + responseText, "EXCEPTION");
									throw new Exception("An error has occurred while retrieving the Oauth refresh token.", ex);
								}
							}
						}

					}


					PeakeyTools.Api.Log(PeakeyTools.Api.ApiName.quickbooks, "Could not retrieve Oauth refresh token. " + ex.Message + " " + ex.StackTrace, "EXCEPTION");
					throw new Exception("An error has occurred while retrieving the Oauth refresh token.", ex);
				}
			}
			catch (Exception ex)
			{
				PeakeyTools.Api.Log(PeakeyTools.Api.ApiName.quickbooks, "Could not retrieve Oauth refresh token. " + ex.Message, "EXCEPTION");
				throw new Exception("Could not retrieve Oauth refresh token.", ex);
			}
		}


		//private static void getDiscoveryData()
		//{
		//	try
		//	{
		//		DiscoveryData discoveryData;


		//		HttpWebRequest discoveryRequest = (HttpWebRequest)WebRequest.Create(DISCOVERY_URI);
		//		discoveryRequest.Method = "GET";
		//		discoveryRequest.Accept = "application/json";


		//		try
		//		{
		//			HttpWebResponse webResponse = (HttpWebResponse)discoveryRequest.GetResponse();
		//			using (var responseStream = new StreamReader(webResponse.GetResponseStream()))
		//			{
		//				string responseData = responseStream.ReadToEnd();

		//				discoveryData = JsonConvert.DeserializeObject<DiscoveryData>(responseData);
		//			}

		//			// Authorization endpoint url
		//			Endpoints.Authorization = discoveryData.Authorization_endpoint;

		//			// Token endpoint url
		//			Endpoints.Token = discoveryData.Token_endpoint;

		//			// UseInfo endpoint url
		//			//userinfoEndPoint = discoveryData.Userinfo_endpoint;

		//			/// Revoke endpoint url
		//			//revokeEndpoint = discoveryData.Revocation_endpoint;

		//			// Issuer endpoint Url 
		//			//issuerUrl = discoveryData.Issuer;

		//			// Json Web Key Store Url
		//			Endpoints.Jwks = discoveryData.JWKS_uri;
		//		}
		//		catch (WebException ex)
		//		{
		//			using (StreamReader responseStream = new StreamReader(ex.Response.GetResponseStream()))
		//			{
		//				throw new Exception(responseStream.ReadToEnd());
		//			}
		//		}
		//	}
		//	catch (Exception ex)
		//	{
		//		throw new Exception(ex.Message);
		//	}
		//}


		//public static ClientCredentials RetrieveCredentialsWithoutLogin() // Access tokens are valid for 3600 seconds (one hour)
		//{
		//	ClientCredentials clientCredentials = null;

		//	try
		//	{
		//		getDiscoveryData(); // Retrieve tokenEndpoint


		//		String authorizationRequest = string.Format("grant_type=client_credentials&client_id={0}&client_secret={1}",
		//			clientID,
		//			clientSecret);


		//		HttpWebRequest webRequest = (HttpWebRequest)WebRequest.Create(Endpoints.Token);
		//		webRequest.Method = "POST";
		//		webRequest.ContentType = "application/x-www-form-urlencoded";
		//		//webRequest.Accept = "application/json";


		//		using (StreamWriter streamWriter = new StreamWriter(webRequest.GetRequestStream()))
		//		{
		//			streamWriter.Write(authorizationRequest);
		//		}


		//		try
		//		{
		//			using (HttpWebResponse webResponse = (HttpWebResponse)webRequest.GetResponse())
		//			{
		//				using (StreamReader responseStream = new StreamReader(webResponse.GetResponseStream()))
		//				{
		//					String responseData = responseStream.ReadToEnd();

		//					clientCredentials = JsonConvert.DeserializeObject<ClientCredentials>(responseData);
		//				}
		//			}

		//			return clientCredentials;
		//		}
		//		catch (WebException ex)
		//		{
		//			using (StreamReader responseStream = new StreamReader(ex.Response.GetResponseStream()))
		//			{
		//				throw new Exception(responseStream.ReadToEnd());
		//			}
		//		}
		//	}
		//	catch (Exception ex)
		//	{
		//		throw new Exception(ex.Message);
		//	}
		//}


		private static void RefreshToken()
		{
			try
			{
				// Retrieve Oauth refresh token from database
				DataTable settingRefreshToken = StairSupplies.Database.Settings.LoadByName(SETTING_REFRESH_TOKEN);
				if (settingRefreshToken.Rows.Count == 0)
				{
					RetrieveRefreshToken(); // No refresh token setting was found... retrieve it by using the code
				}
				credentials.RefreshToken = PeakeyTools.Database.MySQL.NullString(settingRefreshToken.Rows[0]["Value"].ToString());


				// Refresh token
				String basicAuth = "Basic " + Convert.ToBase64String(Encoding.ASCII.GetBytes(ClientID + ":" + ClientSecret));
				String request = string.Format("grant_type=refresh_token&refresh_token={0}", credentials.RefreshToken);

				HttpWebRequest webRequest = (HttpWebRequest)WebRequest.Create(OAUTH_URI);
				webRequest.ServerCertificateValidationCallback += (sender, certificate, chain, sslPolicyErrors) => true; // Fixes 'The remote certificate is invalid according to the validation procedure.' error
				webRequest.Method = "POST";
				webRequest.ContentType = "application/x-www-form-urlencoded";
				webRequest.Accept = "application/json";
				webRequest.Headers[HttpRequestHeader.Authorization] = basicAuth;
				webRequest.ContentLength = request.Length;
				using (StreamWriter streamWriter = new StreamWriter(webRequest.GetRequestStream()))
				{
					streamWriter.Write(request);
				}


				try
				{
					HttpWebResponse response = (HttpWebResponse)webRequest.GetResponse();
					using (StreamReader streamReader = new StreamReader(response.GetResponseStream()))
					{
						string responseData = streamReader.ReadToEnd();

						ClientCredentials refreshedCredentials = JsonConvert.DeserializeObject<ClientCredentials>(responseData);
						credentials.RefreshToken = refreshedCredentials.RefreshToken;
						credentials.AccessToken = refreshedCredentials.AccessToken;

						// Add Refresh Token to database
						StairSupplies.Database.Settings.Save(SETTING_REFRESH_TOKEN, credentials.RefreshToken);
					}
				}
				catch (WebException ex)
				{
					if (ex.Status == WebExceptionStatus.ProtocolError)
					{
						var response = ex.Response as HttpWebResponse;

						if (response != null)
						{
							using (StreamReader reader = new StreamReader(response.GetResponseStream()))
							{
								string responseText = reader.ReadToEnd();

								if (responseText != null && responseText != "")
								{
									PeakeyTools.Api.Log(PeakeyTools.Api.ApiName.quickbooks, "Could not renew Oauth refresh token. " + responseText, "EXCEPTION");
									throw new Exception("An error has occurred while retrieving oauth credentials for Quickbooks.", ex);
								}
							}
						}

					}


					PeakeyTools.Api.Log(PeakeyTools.Api.ApiName.quickbooks, "Could not renew Oauth refresh token. " + ex.Message + " " + ex.StackTrace, "EXCEPTION");
					throw new Exception("An error has occurred while retrieving oauth credentials for Quickbooks.", ex);
				}
			}
			catch (Exception ex)
			{
				PeakeyTools.Api.Log(PeakeyTools.Api.ApiName.quickbooks, "Could not renew Oauth refresh token. " + ex.Message + " " + ex.StackTrace, "EXCEPTION");
				throw new Exception("Could not renew Oauth refresh token.", ex);
			}
		}


		public static String PostRequest(String request, String jsonData)
		{
			try
			{
				String uri = String.Format("{0}{1}{2}/{3}", ApiURL, API_URI, Quickbooks.Credentials.RealmID, request);


				HttpWebRequest webRequest = (HttpWebRequest)WebRequest.Create(uri);
				webRequest.ServerCertificateValidationCallback += (sender, certificate, chain, sslPolicyErrors) => true; // Fixes 'The remote certificate is invalid according to the validation procedure.' error
				webRequest.Method = "POST";
				webRequest.ContentType = "application/json;charset=UTF-8";
				webRequest.Accept = "application/json";
				webRequest.Headers.Add(string.Format("Authorization: Bearer {0}", Quickbooks.Credentials.AccessToken));
				webRequest.ContentLength = jsonData.Length;
				using (StreamWriter streamWriter = new StreamWriter(webRequest.GetRequestStream()))
				{
					streamWriter.Write(jsonData);
				}


				try
				{
					using (HttpWebResponse webResponse = (HttpWebResponse)webRequest.GetResponse())
					{
						using (StreamReader streamReader = new StreamReader(webResponse.GetResponseStream()))
						{
							string responseData = streamReader.ReadToEnd();

							return responseData;
						}
					}
				}
				catch (WebException ex)
				{
					if (ex.Status == WebExceptionStatus.ProtocolError)
					{
						var response = ex.Response as HttpWebResponse;

						if (response != null)
						{
							using (StreamReader reader = new StreamReader(response.GetResponseStream()))
							{
								string responseText = reader.ReadToEnd();

								if (responseText != null && responseText != "")
								{
									return responseText;
								}
							}
						}

					}


					return null;
				}
			}
			catch (Exception ex)
			{
				throw new Exception("Could not post Quickbook request.", ex);
			}
		}


		public static String SubmitQuery(String query)
		{
			try
			{
				String encodedQuery = WebUtility.UrlEncode(query);
				String uri = String.Format("{0}{1}{2}/query?query={3}", ApiURL, API_URI, Quickbooks.Credentials.RealmID, encodedQuery);


				HttpWebRequest webRequest = (HttpWebRequest)WebRequest.Create(uri);
				webRequest.ServerCertificateValidationCallback += (sender, certificate, chain, sslPolicyErrors) => true; // Fixes 'The remote certificate is invalid according to the validation procedure.' error
				webRequest.Method = "GET";
				webRequest.Headers.Add(string.Format("Authorization: Bearer {0}", Quickbooks.Credentials.AccessToken));
				webRequest.Accept = "application/json";

				
				try
				{
					using (HttpWebResponse response = (HttpWebResponse)webRequest.GetResponse())
					{
						if (response.StatusCode == HttpStatusCode.Unauthorized) // 401 - Invalid/expired access token
						{
							PeakeyTools.Api.Log(PeakeyTools.Api.ApiName.quickbooks, "Quickbook Access Token is invalid/expired.", "EXCEPTION");
							throw new Exception("Quickbook Access Token is invalid/expired.");
						}
						else
						{
							using (StreamReader streamReader = new StreamReader(response.GetResponseStream()))
							{
								string responseData = streamReader.ReadToEnd();

								return responseData;
							}
						}
					}
				}
				catch (WebException ex)
				{
					throw new Exception(ex.Message, ex);
				}
			}
			catch (Exception ex)
			{
				throw new Exception("Could not submit Quickbook query.", ex);
			}
		}


		#endregion


		#region "Properties"


		public static String ClientID
		{
			get
			{
				return clientID;
			}
			set
			{
				clientID = value;
			}
		}


		public static String ClientSecret
		{
			get
			{
				return clientSecret;
			}
			set
			{
				clientSecret = value;
			}
		}


		public static String RealmID
		{
			get
			{
				return realmID;
			}
			set
			{
				realmID = value;
			}
		}


		public static String RedirectURI
		{
			get
			{
				return redirectUri;
			}
			set
			{
				redirectUri = value;
			}
		}


		public static String ApiURL
		{
			get
			{
				return apiUrl;
			}
			set
			{
				apiUrl = value;
			}
		}


		public static ClientCredentials Credentials
		{
			get
			{
				return credentials;
			}
		}


		#region "Json Properties"


		public class DiscoveryData
		{

			[JsonProperty("issuer")]
			public string Issuer { get; set; }


			[JsonProperty("authorization_endpoint")]
			public string Authorization_endpoint { get; set; }


			[JsonProperty("token_endpoint")]
			public string Token_endpoint { get; set; }


			[JsonProperty("userinfo_endpoint")]
			public string Userinfo_endpoint { get; set; }


			[JsonProperty("revocation_endpoint")]
			public string Revocation_endpoint { get; set; }


			[JsonProperty("jwks_uri")]
			public string JWKS_uri { get; set; }


			[JsonProperty("response_types_supported")]
			public List<string> Response_types_supported { get; set; }


			[JsonProperty("subject_types_supported")]
			public List<string> Subject_types_supported { get; set; }


			[JsonProperty("id_token_signing_alg_values_supported")]
			public List<string> Id_token_signing_alg_values_supported { get; set; }


			[JsonProperty("scopes_supported")]
			public List<string> Scopes_supported { get; set; }


			[JsonProperty("token_endpoint_auth_methods_supported")]
			public List<string> Token_endpoint_auth_methods_supported { get; set; }


			[JsonProperty("claims_supported")]
			public List<string> Claims_supported { get; set; }
		}


		//public class ClientCredentials
		//{
		//	[JsonProperty("expires_in")]
		//	public string Expires { get; set; }

		//	[JsonProperty("access_token")]
		//	public string AccessToken { get; set; }
		//}


		public class ClientCredentials
		{
			[JsonProperty("access_token")]
			public string AccessToken { get; set; }

			[JsonProperty("refresh_token")]
			public string RefreshToken { get; set; }

			public string Code { get; set; }

			public string RealmID { get; set; }
		}


		#endregion


		#endregion


	}
}
