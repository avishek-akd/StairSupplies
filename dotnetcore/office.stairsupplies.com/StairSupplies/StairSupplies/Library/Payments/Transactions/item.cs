using System;


namespace StairSupplies
{
	public partial class Payments
	{
		public partial class Transactions
		{


			public class Item
			{


				#region Declerations


				private Int32 orderID = 0;
				private Int32 orderVersionID = 0;
				private Int32 employeeID = 0;
				private String processedDate = DateTime.MinValue.ToString("yyyy-MM-dd HH:mm:ss");


				private Boolean approved = false;


				#endregion


				#region Methods


				public Boolean Save()
				{
					try
					{
						return StairSupplies.Database.PaymentTransactions.Save(this);
					}
					catch (Exception ex)
					{
						PeakeyTools.Api.Log(PeakeyTools.Api.ApiName.payeezy, "Could not Save payment transaction item.", ex, "EXCEPTION");
						throw new Exception("Could not Save payment transaction item.", ex);
					}
				}


				#endregion


				#region Properties


				public Int32 OrderID
				{
					get
					{
						return orderID;
					}
					set
					{
						orderID = value;
					}
				}


				public Int32 OrderVersionID
				{
					get
					{
						return orderVersionID;
					}
					set
					{
						orderVersionID = value;
					}
				}


				public Int32 EmployeeID
				{
					get
					{
						return employeeID;
					}
					set
					{
						employeeID = value;
					}
				}


				public String ProcessedDate
				{
					get
					{
						return processedDate;
					}
					set
					{
						processedDate = value;
					}
				}


				public Boolean Approved
				{
					get
					{
						return approved;
					}
					set
					{
						approved = value;
					}
				}


				#endregion


			}


		}
	}
}