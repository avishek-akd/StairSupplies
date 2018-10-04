using System;
using System.Collections.Generic;
using System.IO;


namespace StairSupplies
{


	public class ConfigurationException : Exception
	{


		public ConfigurationException(string missingProperty) : base("'" + missingProperty + "' is missing from the configuration file.")
		{

		}


		public ConfigurationException(string invalidProperty, string message) : base("'" + invalidProperty + "' is configured incorrectly. " + message)
		{

		}


		public ConfigurationException(string missingProperty, Exception innerException) : base("'" + missingProperty + "' is missing from the configuration file.", innerException)
		{

		}


	}


}