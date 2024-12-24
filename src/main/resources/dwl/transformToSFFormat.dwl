%dw 2.0
output application/java 
---
payload map (record) -> {
 "X1st_Address_Number__c": record.X1st_Address_Number__c default "" ,
 "X2nd_Address_Number__c": record.X2nd_Address_Number__c default "",
 "X3rd_Party_Billing__c": record.X3rd_Party_Billing__c default "" ,
 "Name": record.Name default "",
 "AccountNumber": record.AccountNumber as String default "",
 "RecordTypeId": record.RecordType.RecordTypeId default "",
 "Address_Type__c": record.RecordType.Address_Type__c default "",
 "Alpha_Name__c": record.Alpha_Name__c default "",
 "Bill_To_Number__c": record.Bill_To_Number__c default "",
 "Customer_Service_Coordinator_Code__c": record.Customer_Service_Coordinator_Code__c default "",
 "Duns_Number__c": record.DunsNumber default "",
  "Effective_Date__c": if (record.Effective_Date__c == 0) "" else record.Effective_Date__c as Date ,
 "NumberOfEmployees": record.NumberOfEmployees default "",
 "Growth_Rate__c": record.Growth_Rate__c default "" ,
 "JDE_AddressNumber__c": record.JDE_AddressNumber__c default "",
 "Long_Address_Number__c": record.Long_Address_Number__c  default "",
 "NBCA_Market__c": record.NBCA_Market__c default "",
 "NBCA_MKT_DES__c": record.NBCA_MKT_DES__c default "",
 "NTN_ADV_PRC_GRP__c": record.NTN_ADV_PRC_GRP__c default "",
 "NTN_Company_Name__c": record.NTN_Company_Name__c default "",
 "NTN_Cust_Type__c": record.NTN_Cust_Type__c default "",
 "NTN_Customer_Group__c": record.NTN_Customer_Group__c default "",
 "NTN_Global_Market__c": record.NTN_Global_Market__c default "",
 "NTN_Market_Code__c": record.NTN_Market_Code__c default "" ,
 "Region__c": record.Region__c default "",
 "Rep_Code__c": record.Rep_Code__c default "",
 "Sic": record.Sic default "",
 "SicDesc": record.SicDesc default "",
 "Status__c": record.RecordType.Status__c,
 "Type": record.RecordType."Type" default "" ,
 "Year_Started__c": record.Year_Started__c default "",
 "Mailing_Name__c":record.Mailing_Name__c default "",
 "Bill_To_Fax__c": record.Bill_To_Fax__c default "" ,
 "Bill_To_Phone__c": record.Bill_To_Phone__c default "",
 "Fax": record.Fax default "",
 "Phone": record.Phone default "",
 "Website": record.Website default "",
 "Parent_Number__c": record.Parent_Number__c default "",
 "CurrencyIsoCode": record.CurrencyIsoCode default "",
 "Credit_Limit__c": record.Credit_Limit__c default "",
 "Credit_Manager__c": record.Credit_Manager__c default "",
 "Customer_Price_Group_40PC__c": record.Customer_Price_Group_40PC__c default "",
  "Date_Account_Opened__c": record.Date_Account_Opened__c as Date default "",
 "Date_Of_Last_Credit_Review__c": record.Date_Of_Last_Credit_Review__c as Date  default "",
 "Dun_Bradstreet_Rating__c": record.Dun_Bradstreet_Rating__c default "",
 "Factor_Special_Payee__c": record.Factor_Special_Payee__c default "",
 "Hold_Orders_Code__c": record.Hold_Orders_Code__c default "",
 "Payment_Terms_A_R__c": record.Payment_Terms_A_R__c default "",
 "Print_Message__c": record.Print_Message__c default "",
 "Temporary_Credit_Message__c": record.Temporary_Credit_Message__c default "",
 "Branch_Code__c": record.Branch_Code__c default "",
 "OwnerId": record.Owner default "",
 "Account_Coordinator__c": record.Account_Coordinator__c default "",
 "Engineer__c": record.Engineer__c default "",
 "Bill_To_Account__c": record.Bill_To_Account__c default "",
 "Account_Engineer__c": record.Account_Engineer__c default "",
 "Integration_Complete__c": record.RecordType.Integration_Complete__c  ,
 "Is_Account_Activated__c": record.RecordType.Is_Account_Activated__c ,
 "Account_Marketing_Rep__c": record.Account_Marketing_Rep__c default "",
 "MKT_REP__c": record.MKT_REP__c default "",
 "NTN_Company_Number__c": record.NTN_Company_Number__c default "",
 "ShippingStreet" : record.ShippingAddress.ShippingStreet default "",
 "ShippingCity" : record.ShippingAddress.ShippingCity default "",
 "ShippingCountryCode" : record.ShippingAddress.ShippingCountryCode default "",
 "ShippingPostalCode"  : record.ShippingAddress.ShippingPostalCode default "",
 "ShippingStateCode": record.ShippingAddress.ShippingStateCode default "" ,
 "BillingStreet":  record.BillingAddress.BillingStreet default "" ,
 "BillingCity":  record.BillingAddress.BillingCity default "" ,
 "BillingStateCode": record.BillingAddress.BillingStateCode default "" ,
 "BillingPostalCode" : record.BillingAddress.BillingPostalCode default "" ,
 "BillingCountryCode" : record.BillingAddress.BillingCountryCode default ""
}