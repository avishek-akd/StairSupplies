namespace StairSupplies.API
{
	partial class Payeezy
	{


        public class Exceptions
        {


            public class NoAnswerException : Payeezy.Exception
            {
                public NoAnswerException(string message) : base(message) { }
            }


            public class PreviouslyProcessedTransactionException : Payeezy.Exception
            {
                public PreviouslyProcessedTransactionException(string message) : base(message) { }
            }


            public class InvalidCreditCardNumberException : Payeezy.Exception
            {
                public InvalidCreditCardNumberException(string message) : base(message) { }
            }


            public class BadAmountNonnumericAmountException : Payeezy.Exception
            {
                public BadAmountNonnumericAmountException(string message) : base(message) { }
            }


            public class ZeroAmountException : Payeezy.Exception
            {
                public ZeroAmountException(string message) : base(message) { }
            }


            public class OtherErrorException : Payeezy.Exception
            {
                public OtherErrorException(string message) : base(message) { }
            }


            public class BadTotalAuthAmountException : Payeezy.Exception
            {
                public BadTotalAuthAmountException(string message) : base(message) { }
            }


            public class InvalidSKUNumberException : Payeezy.Exception
            {
                public InvalidSKUNumberException(string message) : base(message) { }
            }


            public class InvalidCreditPlanException : Payeezy.Exception
            {
                public InvalidCreditPlanException(string message) : base(message) { }
            }


            public class InvalidStoreNumberException : Payeezy.Exception
            {
                public InvalidStoreNumberException(string message) : base(message) { }
            }


            public class InvalidFieldDataException : Payeezy.Exception
            {
                public InvalidFieldDataException(string message) : base(message) { }
            }


            public class MissingCompanionDataException : Payeezy.Exception
            {
                public MissingCompanionDataException(string message) : base(message) { }
            }


            public class DoesNotMatchMOPException : Payeezy.Exception
            {
                public DoesNotMatchMOPException(string message) : base(message) { }
            }


            public class DuplicateOrderNumberException : Payeezy.Exception
            {
                public DuplicateOrderNumberException(string message) : base(message) { }
            }


            public class InvalidCurrencyException : Payeezy.Exception
            {
                public InvalidCurrencyException(string message) : base(message) { }
            }


            public class IllegalActionException : Payeezy.Exception
            {
                public IllegalActionException(string message) : base(message) { }
            }


            public class InvalidPurchaseException : Payeezy.Exception
            {
                public InvalidPurchaseException(string message) : base(message) { }
            }


            public class InvalidEncryptionFormatException : Payeezy.Exception
            {
                public InvalidEncryptionFormatException(string message) : base(message) { }
            }


            public class MissingOrInvalidSecurePaymentDataException : Payeezy.Exception
            {
                public MissingOrInvalidSecurePaymentDataException(string message) : base(message) { }
            }


        }


	}
}