using System;


namespace StairSupplies
{
	public partial class Payments
    {
        public partial class Transactions
        {
            public partial class Payeezy
            {


                public class Item
                {


                    #region Declerations


                    private Int32 paymentTransactionID = 0;
					private Int32 paymentTransactionReferenceID = 0;


                    private String exactID = "";
                    private Double dollarAmount = 0.00;
                    private String transactionTag = "";
                    private String authorizationNum = "";
                    private String cardHoldersName = "";
                    private String exactResponseCode = "";
                    private String exactMessage = "";
                    private String bankResponseCode = "";
                    private String bankMessage = "";
                    private String sequenceNo = "";
                    private String retrievalRefNo = "";
                    private String cardType = "";
                    private String transactionType = "";
                    private String expiryDate = "";
                    private String transarmorToken = "";


					private Boolean approved = false;


                    #endregion


                    #region Methods


                    public Boolean Save()
                    {
                        try
                        {
                            return StairSupplies.Database.PaymentTransactions_Payeezy.Save(this);
                        }
                        catch (Exception ex)
                        {
							PeakeyTools.Api.Log(PeakeyTools.Api.ApiName.payeezy, "Could not Save Payment_Transactions_Payeezy item.", ex, "EXCEPTION");
							throw new Exception("Could not Save Payment_Transactions_Payeezy item.", ex);
                        }
                    }


                    #endregion


                    #region Properties


                    public Int32 PaymentTransactionID
                    {
                        get
                        {
                            return paymentTransactionID;
                        }
                        set
                        {
                            paymentTransactionID = value;
                        }
                    }


					public Int32 PaymentTransactionReferenceID
					{
						get
						{
							return paymentTransactionReferenceID;
						}
						set
						{
							paymentTransactionReferenceID = value;
						}
					}


					public String ExactID
                    {
                        get
                        {
                            return exactID;
                        }
                        set
                        {
                            exactID = value;
                        }
                    }


                    public Double DollarAmount
                    {
                        get
                        {
                            return dollarAmount;
                        }
                        set
                        {
                            dollarAmount = value;
                        }
                    }


                    public String TransactionTag
                    {
                        get
                        {
                            return transactionTag;
                        }
                        set
                        {
                            transactionTag = value;
                        }
                    }


                    public String AuthorizationNum
                    {
                        get
                        {
                            return authorizationNum;
                        }
                        set
                        {
                            authorizationNum = value;
                        }
                    }


                    public String CardHoldersName
                    {
                        get
                        {
                            return cardHoldersName;
                        }
                        set
                        {
                            cardHoldersName = value;
                        }
                    }


                    public String ExactResponseCode
                    {
                        get
                        {
                            return exactResponseCode;
                        }
                        set
                        {
                            exactResponseCode = value;
                        }
                    }


                    public String ExactMessage
                    {
                        get
                        {
                            return exactMessage;
                        }
                        set
                        {
                            exactMessage = value;
                        }
                    }


                    public String BankResponseCode
                    {
                        get
                        {
                            return bankResponseCode;
                        }
                        set
                        {
                            bankResponseCode = value;
                        }
                    }


                    public String BankMessage
                    {
                        get
                        {
                            return bankMessage;
                        }
                        set
                        {
                            bankMessage = value;
                        }
                    }


                    public String SequenceNo
                    {
                        get
                        {
                            return sequenceNo;
                        }
                        set
                        {
                            sequenceNo = value;
                        }
                    }


                    public String RetrievalRefNo
                    {
                        get
                        {
                            return retrievalRefNo;
                        }
                        set
                        {
                            retrievalRefNo = value;
                        }
                    }


                    public String CardType
                    {
                        get
                        {
                            return cardType;
                        }
                        set
                        {
                            cardType = value;
                        }
                    }


                    public String TransactionType
                    {
                        get
                        {
                            return transactionType;
                        }
                        set
                        {
                            transactionType = value;
                        }
                    }


                    public String ExpiryDate
                    {
                        get
                        {
                            return expiryDate;
                        }
                        set
                        {
                            expiryDate = value;
                        }
                    }


                    public String TransarmorToken
                    {
                        get
                        {
                            return transarmorToken;
                        }
                        set
                        {
                            transarmorToken = value;
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
}