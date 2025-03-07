	%dw 2.0
	import * from dw::core::Strings 
	output application/json

	// Function to convert Julian date to standard date format
	fun julianToStandard(julianDate : Number) = do {
		var myDate = if (sizeOf(julianDate splitBy '') > 5) {
			date : leftPad(julianDate, 6, 0),
			day : leftPad(julianDate, 6, 0)[3 to -1],
			year : 1900 + leftPad(julianDate, 6, 0)[0 to 2]
		}
		else if (!isEmpty(julianDate) and !(julianDate ~= 0) and sizeOf(julianDate splitBy '') > 4) {
			date : julianDate,
			day : julianDate[2 to -1],
			year : 1900 + julianDate[0 to 1]
		}
		else if (!isEmpty(julianDate) and !(julianDate ~= 0) and sizeOf(julianDate splitBy '') > 3) {
			date : julianDate,
			day : julianDate[1 to -1],
			year : 1900 + (julianDate[0] default 0)
		}
		else if (!isEmpty(julianDate) and !(julianDate ~= 0) and sizeOf(julianDate splitBy '') >= 1) {
			date : julianDate,
			day : julianDate[0 to -1],
			year : 1900
		}
		else 0
	  ---
	  if (myDate ~= 0)
		0
	  else
		((("0101" ++ myDate.year) as Date {format: "ddMMyyyy"}) + ("P$(myDate.day - 1)D" as Period)) as Date {format: "yyyy-MM-dd"}
	}

	fun concatKeyValue(DRKY, DRDL01, pvalue) =
	  (if (!isEmpty(DRKY))
	  [trim(DRKY),trim(DRDL01)] filter (!isEmpty($)) joinBy  "-"
	  else
		pvalue)
	---
	payload map (item, index) -> (do {
var recordType = if (trim(item.SIC) ~= "NBCC" and trim(item.SEARCHTYPE) ~= "C")
		  {
			"RecordTypeId": "012f4000000MFV5AAO",
			"Is_Account_Activated__c": true,
			"Status__c": 'Active',
			"Type": 'Customer',
			"Address_Type__c": 'C-Customer',
			"Integration_Complete__c": true
		  }
		else if (trim(item.SIC) ~= "NBCC" and trim(item.SEARCHTYPE) ~= "CX")
		  {
			"RecordTypeId": "012f4000000MFV5AAO",
			"Is_Account_Activated__c": false,
			"Status__c": 'Inactive',
			"Type": 'Customer',
			"Address_Type__c": 'CX-Inactive Customer',
			"Integration_Complete__c": true
		  }
		else if (trim(item.SIC) ~= "NBCC" and trim(item.SEARCHTYPE) ~= "EU")
		  {
			"RecordTypeId": "012f4000000d9wxAAA",
			"Is_Account_Activated__c": true,
			"Status__c": 'Active',
			"Type": 'End User',
			"Address_Type__c": 'EU-End User',
			"Integration_Complete__c": true
		  }
		else if (trim(item.SIC) ~= "NBCC" and trim(item.SEARCHTYPE) ~= "EUX")
		  {
			"RecordTypeId": "012f4000000d9wxAAA",
			"Is_Account_Activated__c": false,
			"Status__c": 'Inactive',
			"Type": 'End User',
			"Address_Type__c": 'EUX-Inactive End User',
			"Integration_Complete__c": true      }
		else
		  null
		---
		{
		  "X1st_Address_Number__c": (( item.BILLTONUM1 as Number ) + 90000000) default 0,
		  "X2nd_Address_Number__c": ((item.BILLTONUM2 as Number )+ 90000000)  default 0,  
		  "X3rd_Party_Billing__c": ((item.BILLTONUM3 as Number) + 90000000)  default 0,
		 "Name": trim(item.BILLTONAME),
		  "AccountNumber": ((item.SHIPTONUM as Number) + 90000000) default 0,
		  "RecordType": recordType."RecordTypeId", 
          "Status__c": recordType."Status__c",
          "Is_Account_Activated__c": recordType."Is_Account_Activated__c",
          "Type": recordType."Type",
          "Integration_Complete__c": recordType."Integration_Complete__c",
		  "Address_Type__c": concatKeyValue(item.SEARCHTYPE, item.SEARCHTYPENAME, trim(item.SEARCHTYPE)), //this needs to be mapped to search type
		  "Alpha_Name__c": trim(item.SHIPTONAME),
		  "Bill_To_Number__c": ((item.BILLTONUM1 as Number) + 90000000) default 0,
		  "Customer_Service_Coordinator_Code__c": concatKeyValue(item.CSR, item.CSRNAME, trim(item.ABAC05)),
		  "DunsNumber": trim(item.DUNSNUMBER),
		  "Effective_Date__c": julianToStandard(trim(item.EFFDATE)) default "",
		  "NumberOfEmployees": item.ABNOE default 0,
		  "Growth_Rate__c": item.ABGROWTHR default 0,
		  "JDE_AddressNumber__c": ((item.SHIPTONUM as Number) + 90000000),
		  "Long_Address_Number__c": trim(item.ABALKY) default "",
		  "NBCA_Market__c": concatKeyValue(item.NBCAMARKETDRKY, item.NBCAMKTNAME, trim(item.NBCAMKT)),
		  "NBCA_MKT_DES__c": concatKeyValue(trim(item.NBCAMKTDESDRKY), trim(item.NBCAMKTDESDRDL01), trim(item.ABAC08)),
          "NTN_ADV_PRC_GRP__c": concatKeyValue(trim(item.NTNADVPRCGRPNAME),trim(item.NTNADVPRCGRPNAME),""),
		  "NTN_Company_Name__c": trim(item.SIC),
		  "NTN_Cust_Type__c": concatKeyValue(trim(item.CTYPE), trim(item.CTYPENAME), trim(item.ABAC08)),
		  "NTN_Customer_Group__c": concatKeyValue(item.CUSTGROUP, item.CUSTGROUPNAME, trim(item.ABAC10)),
		  "NTN_Global_Market__c": concatKeyValue(item.GLOBALMKT, item.GLOBALMKTNAME, trim(item.ABAC12)),
		  "NTN_Market_Code__c": concatKeyValue(item.NBCAMKTDESDRKY, item.NBCAMKTDESDRDL01, trim(item.ABAC08)),
		  "Region__c": concatKeyValue(item.REG, item.REGNAME, trim(item.ABAC02)),
		  "Rep_Code__c": concatKeyValue(item.REP, item.REPNAME, trim(item.ABAC04)),
		  "Sic": trim(item.SIC),
		  "SicDesc": trim(item.SICNAME),
		  "YearStarted": trim(item.ABYEARSTAR) default "",
		  "Mailing_Name__c": trim(item.MAILNAME),
		  "Bill_To_Fax__c": item.BILLFAX,
		  "Bill_To_Phone__c":item.BILLPHONE,

		  "Fax": item.SHIPFAX,
		  "Phone": item.SHIPPHONE,
		  "Website": trim(item.WEBSITE),
		  "BillingAddress": {
			"BillingStreet": trim([
			  trim(item.BILLADD1) ++ " \n " default "",
			  trim(item.BILLADD2) ++ " \n " default "",
			  trim(item.BILLADD3) ++ " \n " default "",
			  trim(item.BILLADD4)
			] filter (!isEmpty($)) joinBy ""),
			"BillingCity": trim(item.BILLCTY1),
			"BillingStateCode": trim(item.BILLADDS),
			"BillingPostalCode": trim(item.BILLADDZ),
//CASE --> FOR BILLING COUNTRY CODE
//WHEN (TRIM(TO_CHAR(ALCTR)) IS NOT NULL OR TRIM(TO_CHAR(ALCTR)) != '') THEN TRIM(TO_CHAR(ALCTR))
//WHEN (TRIM(TO_CHAR(ALCTR)) IS NULL OR TRIM(TO_CHAR(ALCTR)) = '') AND TRIM(TO_CHAR(ABSIC)) = 'NBCC'
//THEN 'CA'	ELSE 'US'
      "BillingCountryCode": 
  if (!isEmpty(trim(item.CTRBILL))) upper(substring(trim(item.CTRBILL), 0, 2)) 
  else if (isEmpty(trim(item.CTRBILL)) and !isEmpty(item.SIC) and trim(item.SIC) == 'NBCC') 'CA' 
    else 'US',
		  },
		  "ShippingAddress": {
			"ShippingStreet": trim([
			  trim(item.SHIPADD1)  ++ " \n " default "",
			  trim(item.SHIPADD2) ++ " \n " default "",
			  trim(item.SHIPADD3) ++ " \n " default "",
			  trim(item.SHIPADD4)
			] filter (!isEmpty($)) joinBy ""),
			"ShippingCity": trim(item.SHIPCTY1),
			"ShippingStateCode": trim(item.SHIPADDS),
			"ShippingPostalCode": trim(item.SHIPADDZ),
//CASE --> FOR SHIPPING COUNTRY CODE
//WHEN (TRIM(TO_CHAR(ALCTR)) IS NOT NULL OR TRIM(TO_CHAR(ALCTR)) != '') THEN TRIM(TO_CHAR(ALCTR))
//WHEN (TRIM(TO_CHAR(ALCTR)) IS NULL OR TRIM(TO_CHAR(ALCTR)) = '') AND TRIM(TO_CHAR(ABSIC)) = 'NBCC'
//THEN 'CA'	ELSE 'US'
      "ShippingCountryCode": 
  if (!isEmpty(trim(item.CTRSHIP))) upper(substring(trim(item.CTRSHIP), 0, 2)) 
  else if (isEmpty(trim(item.CTRSHIP)) and !isEmpty(item.SIC) and trim(item.SIC) == 'NBCC') 'CA' 
    else 'US',
		  },
		  "Parent": trim(item.PARENTID),
		  "Parent_Number__c": ((trim(item.PARENTNUM) as Number) + 90000000),
		  "CurrencyIsoCode": item.CURRCODE,
		  "Billing_Address_Type__c" : concatKeyValue(trim(item.BILLTYPENAME), trim(item.BILLTYPENAME), "" ),
		  "Credit_Limit__c": 
			if (!isEmpty(item.AIACL))
			  trim(item.AIACL)
			else
			  "",
		  "Credit_Manager__c": concatKeyValue(item.CREDITMGR, item.CRMGRNAME, trim(item.AICMGR)),
		  "Customer_Price_Group_40PC__c": concatKeyValue(item.CUSTPRICEGRP, item.CUSTPRICENAME, trim(item.AICPGP)),
		  "Date_Account_Opened__c":  // Convert date to julian format,
			if (!isEmpty(item.AIDAOJ))
			  julianToStandard(trim(item.AIDAOJ))
			else
			  "",
		  "Date_Of_Last_Credit_Review__c":  // Convert date to julian format,
			if (!isEmpty(item.AIDLC))
			  julianToStandard(trim(item.AIDLC))
			else
			  "",
		  "Dun_Bradstreet_Rating__c": concatKeyValue(item.DB, item.DNBNAME, trim(item.AIDB)),
		  "Factor_Special_Payee__c": 
			if (!isEmpty(item.AIARPY))
			  trim(item.AIARPY)
			else
			  "",
		  "Hold_Orders_Code__c":  concatKeyValue(item.HOLD, item.HOLDNAME, trim(item.AIHOLD)),
		
		  "Payment_Terms_A_R__c": concatKeyValue(item.PAYCODE, item.PAYNAME, trim(item.AITRAR)),
		  "Print_Message__c": concatKeyValue(item.PRINTMSG, item.PRINTMSGNAME, trim(item.AIINMG)),
		  "Temporary_Credit_Message__c": concatKeyValue(item.TEMPCRMSG, item.TEMPCRNAME, trim(item.AITSTA)),
		  "Branch_Code__c": trim(item.BRNCHCODE),
		  "Owner": trim(item.REPID),
		  "Account_Coordinator__c": trim(item.CSRID),
		  "Engineer__c": concatKeyValue(item.ENGINEER, item.ENGNAME, trim(item.AIAC05)),
      "MKT_REP__c": concatKeyValue(item.MKTREP, item.MKTNAME, trim(item.AIAC06)),
      "Account_Engineer__c": trim(item.ENGID),
		  "Account_Marketing_Rep__c": trim(item.MKTID),
		  "Bill_To_Account__c": trim(item.BILLTOID),
		  "NTN_Company_Number__c": 
			if (trim(item.SIC) ~= "NBCC")
			  "00010"
			else
			  "00001"
		}
	  })