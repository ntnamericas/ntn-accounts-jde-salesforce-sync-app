%dw 2.0
output application/java
---  
"WITH 
-- Subquery for vars.DRDL01
DRDL01_ST AS (
    SELECT DRKY, DRDL01 
    FROM TESTCTL.F0005 
    WHERE trim(DRSY) = '01' AND trim(DRRT) = 'ST' 
),
-- Subquery for vars.coordinatorCode
coordinatorCode AS (
    SELECT DRKY, DRDL01 
    FROM TESTCTL.F0005 
    WHERE trim(DRSY) = '01' AND trim(DRRT) = '06' 
),
-- Subquery for vars.NBCAMarket
NBCAMarket AS (
    SELECT DRKY, DRDL01 
    FROM TESTCTL.F0005 
    WHERE trim(DRSY) = '01' AND trim(DRRT) = '01' 
),
-- Subquery for vars.NBCAMKTDES
NBCAMKTDES AS (
    SELECT DRKY, DRDL01 
    FROM TESTCTL.F0005 
    WHERE trim(DRSY) = '01' AND trim(DRRT) = '08' 
),
-- Subquery for vars.ntnCustType
ntnCustType AS (
    SELECT DRKY, DRDL01 
    FROM TESTCTL.F0005 
    WHERE trim(DRSY) = '01' AND trim(DRRT) = '03' 
),
-- Subquery for vars.NTNCustomerGroup
NTNCustomerGroup AS (
    SELECT DRKY, DRDL01 
    FROM TESTCTL.F0005 
    WHERE trim(DRSY) = '01' AND trim(DRRT) = '10' 
),
-- Subquery for vars.NTNGlobalMarket
NTNGlobalMarket AS (
    SELECT DRKY, DRDL01 
    FROM TESTCTL.F0005 
    WHERE trim(DRSY) = '01' AND trim(DRRT) = '12' 
),

-- Subquery for vars.NTNADVPRCGRP
NTNADVPRCGRP AS (
	select DRDL01,DRKY
	FROM TESTCTL.F0005
	where trim(DRSY) = '40' AND trim(DRRT) = 'AS'
),

-- Subquery for vars.Region
Region AS (
    SELECT DRKY, DRDL01 
    FROM TESTCTL.F0005 
    WHERE trim(DRSY) = '01' AND trim(DRRT) = '02' 
),
-- Subquery for vars.RepCode
RepCode AS (
    SELECT DRKY, DRDL01 
    FROM TESTCTL.F0005 
    WHERE trim(DRSY) = '01' AND trim(DRRT) = '04' 
),
-- Subquery for vars.SicDesc
SicDesc AS (
    SELECT DRKY, DRDL01 
    FROM TESTCTL.F0005 
    WHERE trim(DRSY) = '01' AND trim(DRRT) = 'SC'
),
-- Subquery for vars.MailingName
MailingName AS (
    SELECT WWAN8, WWMLNM 
    FROM testdta.F0111 
    WHERE  WWIDLN = '0'
),
-- Subquery for vars.accountEngineer
accountEngineer AS (
    SELECT CUALPH3, CUAC36 
    FROM testdta.F57DOLCU 
    WHERE  trim(CUDEPT) = 'Engineering'
),
-- Subquery for vars.accountMarketingRep
accountMarketingRep AS (
    SELECT CUALPH3, CUAC32 
    FROM testdta.F57DOLCU 
    WHERE trim(CUDEPT) = 'Mkt'
),
-- Subquery for vars.MKTREP
MKTREP AS (
    SELECT DRDL01, DRKY 
    FROM TESTCTL.F0005 
    WHERE trim(DRSY) = '01' AND trim(DRRT) = '05'
),
-- Subquery for vars.billAccount
billAccount AS (
    SELECT AXDC,AXAN8 
    FROM testdta.F4780 
    WHERE trim(AXXRTS) = 'SF'
),
-- Subquery for vars.billFax
billFax AS (
    SELECT f0.WPAR1, f0.WPPH1, f0.WPPHTP, f0.WPAN8, f0.WPUPMT, f0.WPUPMJ 
    FROM testdta.F0115 f0
    WHERE  trim(f0.WPPHTP) = 'FAX' and (f0.WPUPMJ >= $(vars.jobRun.date) AND f0.WPUPMT >= $(vars.previousJobRun.time))
),
-- Subquery for vars.billPhone
billPhone AS (
    SELECT f0.WPAR1, f0.WPPH1, f0.WPPHTP, f0.WPAN8, f0.WPUPMT, f0.WPUPMJ
    FROM testdta.F0115 f0
    WHERE trim(f0.WPPHTP) = 'BLANK' and (f0.WPUPMJ >= $(vars.jobRun.date) AND f0.WPUPMT >= $(vars.previousJobRun.time))
),
-- Subquery for vars.billFaxABAN8
billFaxABAN8 AS (
    SELECT f0.WPAR1, f0.WPPH1, f0.WPPHTP, f0.WPAN8, f0.WPUPMT, f0.WPUPMJ
    FROM testdta.F0115 f0
    WHERE trim(f0.WPPHTP) = 'BLANK' and (f0.WPUPMJ >= $(vars.jobRun.date) AND f0.WPUPMT >= $(vars.previousJobRun.time))
),
-- Subquery for vars.phone
phone AS (
    SELECT f0.WPAR1, f0.WPPH1, f0.WPAN8, f0.WPUPMT, f0.WPUPMJ
    FROM testdta.F0115 f0
    WHERE trim(f0.WPPHTP) = 'BLANK' and (f0.WPUPMJ >= $(vars.jobRun.date) AND f0.WPUPMT >= $(vars.previousJobRun.time))
),
-- Subquery for vars.Website
Website AS (
    SELECT EA.EAEMAL, EA.EAAN8, WW.WWAN8
	FROM testdta.F01151 EA
	JOIN testdta.F0111 WW ON EA.EAAN8 = WW.WWAN8
	WHERE WW.WWIDLN = '0'
	  AND EA.EAIDLN = '0'
	  AND EA.EAETP = 'I'
),
-- Subquery for vars.Website
--Website AS (
--    SELECT EA.EAEMAL, EA.EAAN8
--	FROM testdta.F01151 EA
--	JOIN testdta.F0111 WW ON EA.EAAN8 = WW.WWAN8
--	WHERE WW.WWAN8 IN ('')
--	  AND WW.WWIDLN = '0'
--	  AND EA.EAIDLN = '0'
--	  AND EA.EAETP = 'I'
--),
-- Subquery for vars.billingAddress
billingAddress AS (
	SELECT AL1.ALAN8, AL1.ALEFTB, AL1.ALADD1, AL1.ALADD2, AL1.ALADD3, AL1.ALADD4, AL1.ALCTY1, AL1.ALADDS, AL1.ALADDZ, AL1.ALCTR, AL1.ALUPMJ, AL1.ALUPMT
	FROM testdta.F0116 AL1
	WHERE AL1.ALAN8 in (select f1.ABAN81 from testdta.F0101 f1 where f1.ABUPMJ >= $(vars.jobRun.date) and f1.ABUPMT >= $(vars.previousJobRun.time) AND f1.ABAT1 IN ('C','EU','EUX','CX','N') AND TRIM(f1.ABSIC) = 'NBCC') and (AL1.ALUPMJ >= $(vars.jobRun.date) AND AL1.ALUPMT >= $(vars.previousJobRun.time))
),
-- Subquery for vars.billingCountryCode
billingCountryCode AS (
	SELECT DRDL02, DRKY
	FROM TESTCTL.F0005
	WHERE trim(DRSY) = '77' AND trim(DRRT) = 'CN'
),
-- Subquery for vars.shippingCountryCode
shippingCountryCode AS (
	SELECT DRDL02, DRKY
	FROM TESTCTL.F0005
	WHERE trim(DRSY) = '77' AND trim(DRRT) = 'CN'
),
-- Subquery for vars.ShippingAddress
ShippingAddress AS (
	SELECT AL1.*
	FROM testdta.F0116 AL1
	WHERE AL1.ALAN8 in (select f1.ABAN8 from testdta.F0101 f1 where f1.ABUPMJ >= $(vars.jobRun.date) and f1.ABUPMT >= $(vars.previousJobRun.time) AND f1.ABAT1 IN ('C','EU','EUX','CX','N') AND TRIM(f1.ABSIC) = 'NBCC') and (AL1.ALUPMJ >= $(vars.jobRun.date) AND AL1.ALUPMT >= $(vars.previousJobRun.time))
),
-- Subquery for vars.Parent
Parent AS (
	SELECT AXDC, AXAN8
	FROM testdta.F4780
	WHERE trim(AXXRTS) = 'SF'
),
-- Subquery for vars.CurrencyIsoCode
CurrencyIsoCode AS (
	SELECT f3.AICRCD,f3.AIAN8
	FROM testdta.F03012 f3
	WHERE f3.AIAN8 in (select f1.ABAN8 from testdta.F0101 f1 where f1.ABUPMJ >= $(vars.jobRun.date) and f1.ABUPMT >= $(vars.previousJobRun.time) AND f1.ABAT1 IN ('C','EU','EUX','CX','N') AND TRIM(f1.ABSIC) = 'NBCC') and (f3.AIUPMJ >= $(vars.jobRun.date) AND f3.AIUPMT >= $(vars.previousJobRun.time))
),
-- Subquery for vars.F03012table
F03012table AS (
    select f2.ABAN8,f3.AIAN8,f3.AIASN,f3.AIBADT,f3.AIACL,f3.AICMGR,f3.AICPGP,f3.AIDAOJ,f3.AIDLC,f3.AIARPY,f3.AIHOLD,f3.AITRAR,f3.AIINMG,f3.AITSTA,f3.AIAC06,f3.AIAC05,f3.AIDB, f3.AIUPMJ, f3.AIUPMT 
	FROM testdta.F0101 f2
	LEFT OUTER JOIN testdta.F03012 f3
	ON trim(f2.ABAN8) = trim(f3.AIAN8) 
	WHERE trim(f3.AIAN8)  in (select f1.ABAN8 from testdta.F0101 f1 where trim(f1.ABAT1) IN ('C','EU','EUX','CX','N') AND TRIM(f1.ABSIC) = 'NBCC')
	--f1.ABUPMJ >= $(vars.jobRun.date) and f1.ABUPMT >= $(vars.previousJobRun.time) AND  and (f2.ABUPMJ >= $(vars.jobRun.date) and f2.ABUPMT >= $(vars.previousJobRun.time)) and (f3.AIUPMJ >= $(vars.jobRun.date) AND f3.AIUPMT >= $(vars.previousJobRun.time))

),



-- Subquery for vars.billingAddressType
billingAddressType AS (
	select DRDL01,DRKY
	FROM TESTCTL.F0005
	where trim(DRSY) = 'H42' AND trim(DRRT) = 'BA'
),
-- Subquery for vars.CreditManager
CreditManager AS (
	select DRDL01,DRKY
	FROM TESTCTL.F0005
	where trim(DRSY) = '01' AND trim(DRRT) = 'CR'
),
-- Subquery for vars.customerPriceGroup
customerPriceGroup AS (
	select DRDL01,DRKY
	FROM TESTCTL.F0005
	where trim(DRSY) = '40' AND trim(DRRT) = 'PC'
),
-- Subquery for vars.dunBradstreet
dunBradstreet AS (
	select DRDL01,DRKY
	FROM TESTCTL.F0005
	where trim(DRSY) = '01' AND trim(DRRT) = 'DB'
),
-- Subquery for vars.HoldOrders
HoldOrders AS (
    select DRDL01, DRKY
    from TESTCTL.F0005
    where trim(DRSY) = '42' AND trim(DRRT) = 'HC'
),
-- Subquery for vars.Payment
Payment AS (
    select PNPTD, PNPTC
    from testdta.F0014
),
-- Subquery for vars.printMessage
printMessage AS (
    select DRDL01, DRKY
    from TESTCTL.F0005
    where trim(DRSY) = '40' AND trim(DRRT) = 'PM'
),
-- Subquery for vars.temporaryCreditMessage
temporaryCreditMessage AS (
    select DRDL01, DRKY
    from TESTCTL.F0005
    where trim(DRSY) = '00' AND trim(DRRT) = 'CM'
),
-- Subquery for vars.branchCode
branchCode AS (
    select AXEXRA, AXAN8
    from testdta.F4780
    where AXAN8 in (select f1.ABAN8 from testdta.F0101 f1 where f1.ABUPMJ >= $(vars.jobRun.date) and f1.ABUPMT >= $(vars.previousJobRun.time) AND f1.ABAT1 IN ('C','EU','EUX','CX','N') AND TRIM(f1.ABSIC) = 'NBCC')
),

-- Subquery for vars.Owner
Owner AS (
    select CUALPH3, CUAC04, CUDEPT
    from testdta.F57DOLCU
    where trim(CUDEPT) = 'Rep'
),
-- Subquery for vars.accountCoordinator
accountCoordinator AS (
    select CUALPH3, CUAC06
    from testdta.F57DOLCU
    where trim(CUDEPT) = 'Coordinator'
),
-- Subquery for vars.Engineer
Engineer AS (
    select DRDL01, DRKY
    from TESTCTL.F0005
    where trim(DRSY) = '01' AND trim(DRRT) = '06'
)




-- Add more subqueries as needed
SELECT 
    t1.*, 
    t2.DRDL01 AS DRDL01_ST, 
    t3.DRDL01 AS coordinatorCodeDRDL01, 
    t3.DRKY AS coordinatorCodeDRKY,
    t4.DRDL01 AS NBCAMarketDRDL01, 
    t4.DRKY AS NBCAMarketDRKY, 
    t5.DRDL01 AS NBCAMKTDESDRDL01, 
    t5.DRKY AS NBCAMKTDESDRKY, 
    t6.DRDL01 AS ntnCustTypeDRDL01, 
    t6.DRKY AS ntnCustTypeDRKY,
    t7.DRDL01 AS NTNCustomerGroupDRDL01, 
    t7.DRKY AS NTNCustomerGroupDRKY,
    t8.DRDL01 AS NTNGlobalMarketDRDL01, 
    t8.DRKY AS NTNGlobalMarketDRKY, 
    t9.DRDL01 AS RegionDRDL01,
    t9.DRKY AS RegionDRKY, 
    t10.DRDL01 AS RepCodeDRDL01, 
    t10.DRKY AS RepCodeDRKY, 
    t11.DRDL01 AS SicDesc, 
    t12.WWMLNM AS MailingName,
    t13.CUALPH3 AS accountEngineer,
    t14.CUALPH3 AS accountMarketingRep,
    t15.DRDL01 AS MKTREPDRDL01,
    t15.DRKY AS MKTREPDRKY,
    t16.AXDC AS billAccount,
	t17.WPAR1 AS billFaxWPAR1,
	t17.WPPH1 AS billFaxWPPH1,
	t17.WPPHTP AS billFaxWPPHTP,
	t17.WPAN8 AS billFaxWPAN8,
	t18.WPAR1 AS billPhoneWPAR1,
	t18.WPPH1 AS billPhoneWPPH1,
	t18.WPPHTP AS billPhoneWPPHTP,
	t19.WPAR1 AS billFaxABAN8WPAR1,
	t19.WPPH1 AS billFaxABAN8WPPH1,
	t19.WPPHTP AS billFaxABAN8WPPHTP,
	t19.WPAN8 AS billFaxABAN8WPAN8,
	t20.WPAR1 AS phoneWPAR1,
	t20.WPPH1 AS phoneWPPH1,
	t20.WPAN8 AS phoneWPAN8,
	t21.EAEMAL AS WebsiteEAEMAL,
	t21.EAAN8 AS WebsiteEAAN8,
	t22.ALAN8 AS billingAddressALAN8,
	t22.ALEFTB AS billingAddressALEFTB,
	t22.ALADD1 AS billingAddressALADD1,
	t22.ALADD2 AS billingAddressALADD2,
	t22.ALADD3 AS billingAddressALADD3,
	t22.ALADD4 AS billingAddressALADD4,
	t22.ALCTY1 AS billingAddressALCTY1,
	t22.ALADDS AS billingAddressALADDS,
	t22.ALADDZ AS billingAddressALADDZ,
	t22.ALCTR AS billingAddressALCTR,
	t23.DRDL02 AS billingCountryCodeDRDL02,
     	CASE 
		WHEN (TRIM(TO_CHAR(t24.ALCTR)) IS NOT NULL OR TRIM(TO_CHAR(t24.ALCTR)) != '') THEN TRIM(TO_CHAR(t24.ALCTR))
    	WHEN (TRIM(TO_CHAR(t24.ALCTR)) IS NULL OR TRIM(TO_CHAR(t24.ALCTR)) = '') AND TRIM(TO_CHAR(t1.ABSIC)) = 'NBCC' THEN 'CA'
    	ELSE 'US'
	END AS billingCountryCodeValue,
	t23.DRKY AS billingCountryCodeDRKY,
	-- need to add respective fields
	t24.ALEFTB AS ShippingAddressALEFTB,
	t24.ALAN8 AS ShippingAddressALAN8,
    t24.ALADD1 AS ShippingAddressALADD1,
    t24.ALADD2 AS ShippingAddressALADD2,
    t24.ALADD3 AS ShippingAddressALADD3,
    t24.ALADD4 AS ShippingAddressALADD4,
    t24.ALCTY1 AS ShippingAddressALCTY1,
    t24.ALADDS AS ShippingAddressALADDS,
    t24.ALADDZ AS ShippingAddressALADDZ,

	t25.AXDC AS ParentAXDC,
	t25.AXAN8 AS ParentAXAN8,
	t26.AICRCD AS CurrencyIsoCodeAICRCD,
	t27.ABAN8 AS F03012tableABAN8,
	t27.AIASN AS F03012tableAIASN,
	t27.AIBADT AS F03012tableAIBADT,
	t27.AIACL AS F03012tableAIACL,
	t27.AICMGR AS F03012tableAICMGR,
	t27.AICPGP AS F03012tableAICPGP,
	t27.AIDAOJ AS F03012tableAIDAOJ,
	t27.AIDLC AS F03012tableAIDLC,
	t27.AIARPY AS F03012tableAIARPY,
	t27.AIHOLD AS F03012tableAIHOLD,
	t27.AITRAR AS F03012tableAITRAR,
	t27.AIINMG AS F03012tableAIINMG,
	t27.AITSTA AS F03012tableAITSTA,
	t27.AIAC06 AS F03012tableAIAC06,
	t27.AIAC05 AS F03012tableAIAC05,
	t27.AIDB AS F03012tableAIDB,
	t28.DRDL01 AS billingAddressTypeDRDL01,
	t28.DRKY AS billingAddressTypeDRKY,
	t29.DRDL01 AS CreditManagerDRDL01,
	t29.DRKY AS CreditManagerDRKY,
	t30.DRDL01 AS customerPriceGroupDRDL01,
	t30.DRKY AS customerPriceGroupDRKY,
	t31.DRDL01 AS dunBradstreetDRDL01,
	t31.DRKY AS dunBradstreetDRKY,
	t32.DRDL01 AS HoldOrdersDRDL01,
	t32.DRKY AS HoldOrdersDRKY,
	t33.PNPTD AS PaymentPNPTD,
	t33.PNPTC AS PaymentPNPTC,
	t34.DRDL01 AS printMessageDRDL01,
	t34.DRKY AS printMessageDRKY,
	t35.DRDL01 AS temporaryCreditMessageDRDL01,
	t35.DRKY AS temporaryCreditMessageDRKY,
	t36.AXEXRA AS branchCodeAXEXRA,
	t36.AXAN8 AS branchCodeAXAN8,
	t37.CUALPH3 AS OwnerCUALPH3,
	t37.CUAC04 AS OwnerCUAC04,
	t37.CUDEPT AS OwnerCUDEPT,
	t38.CUALPH3 AS accountCoordinatorCUALPH3,
	t38.CUAC06 AS accountCoordinatorCUAC06,
	t39.DRDL01 AS EngineerDRDL01,
	t39.DRKY AS EngineerDRKY,
    t40.DRDL02 AS shippingCountryCodeDRDL02,
     	CASE 
		WHEN (TRIM(TO_CHAR(t24.ALCTR)) IS NOT NULL OR TRIM(TO_CHAR(t24.ALCTR)) != '') THEN TRIM(TO_CHAR(t24.ALCTR))
    	WHEN (TRIM(TO_CHAR(t24.ALCTR)) IS NULL OR TRIM(TO_CHAR(t24.ALCTR)) = '') AND TRIM(TO_CHAR(t1.ABSIC)) = 'NBCC' THEN 'CA'
    	ELSE 'US' 
	END AS shippingCountryCodeValue,
	t40.DRKY AS shippingCountryCodeDRKY,
    t41.DRDL01 AS NTNADVPRCGRPDRDL01,
    t41.DRKY AS NTNADVPRCGRPDRKY
FROM 
    testdta.F0101 t1
LEFT JOIN DRDL01_ST t2 ON trim(t1.ABAT1) = trim(t2.DRKY)
LEFT JOIN coordinatorCode t3 ON trim(t1.ABAC05) = trim(t3.DRKY)
LEFT JOIN NBCAMarket t4 ON trim(t1.ABAC01) = trim(t4.DRKY)
LEFT JOIN NBCAMKTDES t5 ON trim(t1.ABAC08) = trim(t5.DRKY)
LEFT JOIN ntnCustType t6 ON trim(t1.ABAC03) = trim(t6.DRKY)
LEFT JOIN NTNCustomerGroup t7 ON trim(t1.ABAC10) = trim(t7.DRKY)
LEFT JOIN NTNGlobalMarket t8 ON trim(t1.ABAC12) = trim(t8.DRKY)
LEFT JOIN Region t9 ON trim(t1.ABAC02) = trim(t9.DRKY)
LEFT JOIN RepCode t10 ON trim(t1.ABAC04) = trim(t10.DRKY)
LEFT JOIN SicDesc t11 ON trim(t1.ABSIC) = trim(t11.DRKY)
LEFT JOIN MailingName t12 ON trim(t1.ABAN8) = trim(t12.WWAN8)
LEFT JOIN F03012table t27 ON trim(t1.ABAN8) = trim(t27.AIAN8)
LEFT JOIN accountEngineer t13 ON TRIM(t13.CUAC36) = trim(t27.AIAC06)
LEFT JOIN accountMarketingRep t14 ON TRIM(t14.CUAC32) = trim(t27.AIAC05)
LEFT JOIN MKTREP t15 ON  TRIM(t15.DRKY) = trim(t27.AIAC05)
LEFT JOIN billAccount t16 ON trim(t1.ABAN81) = trim(t16.AXAN8)
LEFT JOIN billFax t17 ON trim(t1.ABAN81) = trim(t17.WPAN8)
LEFT JOIN billPhone t18 ON trim(t1.ABAN81) = trim(t18.WPAN8)
LEFT JOIN billFaxABAN8 t19 ON  trim(t1.ABAN8) = trim(t19.WPAN8)
LEFT JOIN phone t20 ON trim(t1.ABAN8) = trim(t20.WPAN8)
LEFT JOIN Website t21 ON trim(t1.ABAN8) = trim(t21.EAAN8) and trim(t1.ABAN8) = trim(t21.WWAN8)
LEFT JOIN billingAddress t22 ON trim(t1.ABAN81) = trim(t22.ALAN8)
LEFT JOIN billingCountryCode t23 ON trim(t22.ALCTR) = trim(t23.DRKY)
LEFT JOIN ShippingAddress t24 ON trim(t1.ABAN8) = trim(t24.ALAN8)
LEFT JOIN shippingCountryCode t40 ON trim(t24.ALCTR) = trim(t40.DRKY)
LEFT JOIN Parent t25 ON trim(t1.ABAN86) = trim(t25.AXAN8)
LEFT JOIN CurrencyIsoCode t26 ON trim(t1.ABAN8) = trim(t26.AIAN8)
-- we can optimize these below two joins
LEFT JOIN billingAddressType t28 ON trim(t27.AIBADT) = trim(t28.DRKY)
LEFT JOIN CreditManager t29 ON trim(t27.AICMGR) = trim(t29.DRKY)
LEFT JOIN customerPriceGroup t30 ON trim(t27.AICPGP) = trim(t30.DRKY)
LEFT JOIN dunBradstreet t31 ON trim(t27.AIDB) = trim(t31.DRKY)
LEFT JOIN HoldOrders t32 ON trim(t27.AIHOLD) = trim(t32.DRKY)
LEFT JOIN Payment t33 ON trim(t27.AITRAR) = trim(t33.PNPTC)
LEFT JOIN printMessage t34 ON trim(t27.AIINMG) = trim(t34.DRKY)
LEFT JOIN temporaryCreditMessage t35 ON trim(t27.AITSTA) = trim(t35.DRKY)
LEFT JOIN branchCode t36 ON trim(t1.ABAN8) = trim(t36.AXAN8)
LEFT JOIN Owner t37 ON trim(t1.ABAC04) = trim(t37.CUAC04)
LEFT JOIN accountCoordinator t38 ON trim(t1.ABAC05) = trim(t38.CUAC06)
LEFT JOIN Engineer t39 ON trim(t27.AIAC06) = trim(t39.DRKY)
LEFT JOIN NTNADVPRCGRP t41 ON trim(t27.AIASN) = trim(t41.DRKY)
where ((t1.ABUPMJ >= $(vars.jobRun.date) and t1.ABUPMT >= $(vars.previousJobRun.time)) OR (t27.AIUPMJ >= $(vars.jobRun.date) AND t27.AIUPMT >= $(vars.previousJobRun.time)) OR (t22.ALUPMJ >= $(vars.jobRun.date) AND t22.ALUPMT >= $(vars.previousJobRun.time)) OR (t24.ALUPMJ >= $(vars.jobRun.date)AND t24.ALUPMT >= $(vars.previousJobRun.time)) OR (t17.WPUPMJ >= $(vars.jobRun.date) AND t17.WPUPMT >= $(vars.previousJobRun.time)) OR (t18.WPUPMJ >= $(vars.jobRun.date)AND t18.WPUPMT >= $(vars.previousJobRun.time)) OR (t19.WPUPMJ >= $(vars.jobRun.date) AND t19.WPUPMT >= $(vars.previousJobRun.time)) OR (t20.WPUPMJ >= $(vars.jobRun.date) AND t20.WPUPMT >= $(vars.previousJobRun.time))) AND t1.ABAT1 IN ('C','EU','EUX','CX','N') AND TRIM(t1.ABSIC) = 'NBCC'"