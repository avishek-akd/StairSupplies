using System;
using System.IO;
using System.Net;
using System.Security.Cryptography;
using System.Text;


namespace StairSupplies.API
{


	public partial class Payeezy
	{


		#region Declerations


		private static String gatewayID = "";
		private static String gatewayPassword = "";
		private static String keyID = "";
		private static String hmacKey = "";
		private static String apiUrl = "";

		private const String requestURI = "/transaction/v27";
		private const String requestMethod = "POST";


		#endregion


		#region Methods


		public static String Submit(StringBuilder stringBuilder)
		{
			try
			{
				ASCIIEncoding encoder = new ASCIIEncoding();
				SHA1CryptoServiceProvider sha1Crypto = new SHA1CryptoServiceProvider();
				HMAC hmacSHA1;
				byte[] xmlByte;
				byte[] hmacData;
				String xmlString = "";
				String hash = "";
				String hashedContent = "";
				String type = "";
				String time = "";
				String hashData = "";
				String base64Hash = "";
				String url = "";


				xmlString = stringBuilder.ToString();
				xmlByte = encoder.GetBytes(xmlString);
				hash = BitConverter.ToString(sha1Crypto.ComputeHash(xmlByte)).Replace("-", "");
				hashedContent = hash.ToLower();
				type = "application/xml";
				time = DateTime.UtcNow.ToString("yyyy-MM-ddTHH:mm:ssZ");
				hashData = StairSupplies.API.Payeezy.REQUEST_METHOD + "\n" + type + "\n" + hashedContent + "\n" + time + "\n" + StairSupplies.API.Payeezy.REQUEST_URI;
				hmacSHA1 = new HMACSHA1(Encoding.UTF8.GetBytes(StairSupplies.API.Payeezy.HmacKey));
				hmacData = hmacSHA1.ComputeHash(Encoding.UTF8.GetBytes(hashData));
				base64Hash = Convert.ToBase64String(hmacData);
				url = StairSupplies.API.Payeezy.ApiURL + StairSupplies.API.Payeezy.REQUEST_URI;


				HttpWebRequest webRequest = (HttpWebRequest)WebRequest.Create(url);
				webRequest.Method = "POST";
				webRequest.ContentType = type;
				webRequest.Accept = "*/*";
				webRequest.Headers.Add("x-gge4-date", time);
				webRequest.Headers.Add("x-gge4-content-sha1", hashedContent);
				webRequest.Headers.Add("Authorization", "GGE4_API " + StairSupplies.API.Payeezy.KeyID + ":" + base64Hash);
				webRequest.ContentLength = xmlString.Length;
				using (StreamWriter streamWriter = new StreamWriter(webRequest.GetRequestStream()))
				{
					streamWriter.Write(xmlString);
				}


				try
				{
					using (HttpWebResponse webResponse = (HttpWebResponse)webRequest.GetResponse())
					{
						using (StreamReader responseStream = new StreamReader(webResponse.GetResponseStream()))
						{
							return responseStream.ReadToEnd();
						}
					}
				}
				catch (WebException ex) // Ecommerce exceptions get caught here --- "Bad Request (22) - Invalid Credit Card Number"
				{
					using (StreamReader responseStream = new StreamReader(ex.Response.GetResponseStream()))
					{
						string response = responseStream.ReadToEnd();

						PeakeyTools.Api.Log(PeakeyTools.Api.ApiName.payeezy, "An error was received from the Payeezy API. [Response]: " + response, ex, "FAILURE");
						throw new Exception(response);
					}
				}
			}
			catch (Exception ex)
			{
				PeakeyTools.Api.Log(PeakeyTools.Api.ApiName.payeezy, "Could not submit Payeezy API request.", ex, "EXCEPTION");
				throw new Exception(ex.Message);
			}
		}


		#endregion


		#region Properties


		public static String GatewayID
		{
			get
			{
				return gatewayID;
			}
			set
			{
				gatewayID = value;
			}
		}


		public static String GatewayPassword
		{
			get
			{
				return gatewayPassword;
			}
			set
			{
				gatewayPassword = value;
			}
		}


		public static String KeyID
		{
			get
			{
				return keyID;
			}
			set
			{
				keyID = value;
			}
		}


		public static String HmacKey
		{
			get
			{
				return hmacKey;
			}
			set
			{
				hmacKey = value;
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


		public static String REQUEST_URI
		{
			get
			{
				return requestURI;
			}
		}


		public static String REQUEST_METHOD
		{
			get
			{
				return requestMethod;
			}
		}


		#endregion


	}


}