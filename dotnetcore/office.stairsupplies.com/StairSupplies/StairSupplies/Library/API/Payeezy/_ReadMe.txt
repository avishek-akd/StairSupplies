/api/payeezy/payment?dollarAmount=1.66&cardNumber=4111111111111111&expirationDate=1218&cardHoldersName=John%20Doe&orderID=127761&securityCode=123

Credit Cards to Test:
https://support.payeezy.com/hc/en-us/articles/204504235-Using-Test-Credit-Card-Numbers

Reference Guide:
https://support.payeezy.com/hc/en-us/articles/206601408-First-Data-Payeezy-Gateway-Web-Service-API-Reference-Guide
(AVS: '4 Request Properties')

Responses:
https://support.payeezy.com/hc/en-us/articles/203730509-First-Data-Payeezy-Gateway-Bank-Response-Codes
https://support.payeezy.com/hc/en-us/articles/203730499-eCommerce-Response-Codes-ETG-e4-Transaction-Gateway-Codes-

Transaction Types:
https://support.payeezy.com/hc/en-us/articles/115003604894-Transaction-Types-Available
https://support.payeezy.com/hc/en-us/articles/206601408-First-Data-Payeezy-Gateway-Web-Service-API-Reference-Guide

Payeezy demo:
https://demo.globalgatewaye4.firstdata.com/

Invalid Transaction Tag Error:
https://support.payeezy.com/hc/en-us/articles/204504145-I-received-the-transaction-response-Invalid-Transaction-Tag-What-does-this-mean-

Tagged Purchase / Refund:
https://support.payeezy.com/hc/en-us/articles/203731349-Level-II-and-Level-III-Functionality-in-RPM
(Must support level 2 data and level 3 data under Terminals)

Recharging previous transaction:
"There is no specific transaction type via API to support what the functionality you’re referring to.  It is possible with tokenization.  

The basic process flow is below.
•	You submit a $0 pre-authorization using the POST token method (developer APIs), a $0 authorization through API, or a hosted payment page with the credit card details.
•	Our response contains the assigned Transarmor Token number in place of the credit card number
•	You store the token on an external server/database
•	You then submit a purchase transaction with the Token number, card expiration, cardholder name, and credit card type based on the frequency you set in your coding""

Transarmor Token:
https://developer.payeezy.com/content/enable-transarmor-demo-account-0
https://support.payeezy.com/hc/en-us/articles/203731209-Using-TransArmor-Tokens-on-Self-Service-DEMO-for-Testing