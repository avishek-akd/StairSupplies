using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;


namespace StairSupplies.API
{
	public partial class Quickbooks
	{
		public partial class DataTypes
		{


			public class AccountingTypes
			{


				public Double Total { get; set; }

				public string Title { get; set; }


			}


			public class Customer
			{


				public Int32 ID { get; set; }
				public Int32 TermID { get; set; }

				public string GivenName { get; set; }
				public string FamilyName { get; set; }
				public string DisplayName { get; set; }
				public string PrimaryPhone { get; set; }
				public string PrimaryEmailAddr { get; set; }
				public string TermName { get; set; }


			}


			public class Error
			{


				public string Message { get; set; }
				public string Detail { get; set; }
				public string Code { get; set; }


			}


			public class Invoice
			{


				public Int32 ID { get; set; }
				public Int32 SyncToken { get; set; }

				public string DocNumber { get; set; }
				public string OfficeID { get; set; }
				public string SalesRep { get; set; }


			}


			public class Item
			{


				public Int32 ID { get; set; }

				public string Name { get; set; }


			}


			public class Preferences
			{


				public struct CustomField
				{
					public Int32 ID { get; set; }

					public string Name { get; set; }
					public string Type { get; set; }
					public string StringValue { get; set; }
				}


			}


			public class Term
			{


				public Boolean Active { get; set; }

				public Int32 ID { get; set; }

				public string Name { get; set; }


			}


			public class Transaction
			{


				public Int32 ID { get; set; }
				public Int32 OrderID { get; set; }

				public string OfficeID { get; set; } // orderID-transactionID
				public string DocNumber { get; set; } // orderID
				public string Date { get; set; }
				public string SalesEmployeeFirstName { get; set; }


			}


		}
	}
}
