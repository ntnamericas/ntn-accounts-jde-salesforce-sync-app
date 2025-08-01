%dw 2.0
output application/java
---  
"Select  
ABAN8 AS SHIPTONUM, ABALPH AS SHIPTONAME,
ABAN81 AS BILLTONUM1, ABAN82 AS BILLTONUM2, ABAN83 AS BILLTONUM3,(SELECT ABALPH FROM CRPDTA.F0101 X WHERE T1.ABAN81 = X.ABAN8) AS BILLTONAME, ABYEARSTAR as ABYEARSTAR,
ABDUNS AS DUNSNUMBER, ABNOE AS ABNOE, ABGROWTHR as ABGROWTHR, ABALKY as ABALKY, ABEFTB AS ABEFTB,ABAC08 AS ABAC08, ABAC01 AS ABAC01, TRIM(AICMGR) AS AICMGR, TRIM(AICPGP) as AICPGP, 
TRIM(AIDAOJ) AS AIDAOJ, TRIM(AIDLC) as AIDLC, TRIM(AIAC06) AS AIAC06, TRIM(AIAC05) AS AIAC05,TRIM(AIACL) as AIACL, TRIM(AIDB) AS AIDB, TRIM(AIARPY) AS AIARPY,
TRIM(AIHOLD) AS AIHOLD, TRIM(AIINMG) AS AIINMG, TRIM(AITSTA) AS AITSTA, TRIM(AITRAR) as AITRAR,
ABAN86 AS PARENTNUM, (SELECT ABALPH FROM CRPDTA.F0101 X WHERE T1.ABAN86 = X.ABAN8) AS PARENTNAME,
TRIM(ABAC01) AS NBCAMKT, (SELECT DRDL01 FROM CRPCTL.F0005 WHERE DRSY = '01' AND DRRT = '01' AND TRIM(DRKY) = TRIM(T1.ABAC01)) AS NBCAMKTNAME, --ADDED NBCA MARKET
TRIM(ABAC08) AS NBCAMKTDES, (SELECT DRDL01 FROM CRPCTL.F0005 WHERE DRSY = '01' AND DRRT = '08' AND TRIM(DRKY) = TRIM(T1.ABAC08)) AS NBCAMKTDESNAME,
--( SELECT max(ALEFTB) FROM CRPDTA.f0116 WHERE TRIM(ALAN8)=TRIM(T1.ABAN8) ) AS EFFDATE, //THIS WAS AN ISSUE WITH JOIN, FIXED ON LINE 89 BELOW
--(SELECT DRDL01 FROM CRPCTL.F0005 WHERE DRSY = '01' AND DRRT = '01' AND ROWNUM = 1) AS NBCAMARKETDRKY, --NOT NEEDED. CAN USE NBCAMKT AND NBCAMKTNAME. THIS JUST PULLS FIRST LINE WHICH WOULD BE WRONG
--(SELECT DRDL01 FROM CRPCTL.F0005 WHERE DRSY = '01' AND DRRT = '08' AND ROWNUM = 1) AS NBCAMKTDESDRKY, --NOT NEEDED. CAN USE NBCAMKTDES AND NBCAMKTDESNAME. THIS JUST PULLS FIRST LINE WHICH WOULD BE WRONG LINE 13 & 14 WERE FLIPPED ANYWAY
--(SELECT DRKY FROM CRPCTL.F0005 WHERE DRSY = '01' AND DRRT = '08' AND ROWNUM = 1) AS NBCAMKTDESDRDL01, --NOT NEEDED. CAN USE NBCAMKTDES AND NBCAMKTDESNAME. THIS JUST PULLS FIRST LINE WHICH WOULD BE WRONG LINE 13 & 14 WERE FLIPPED ANYWAY
TRIM(AIASN) AS NTNADVPRICE, (SELECT DRDL01 FROM CRPCTL.F0005 WHERE DRSY = '40' AND DRRT = 'AS' AND TRIM(DRKY) = TRIM(T2.AIASN)) AS NTNADVPRCGRPNAME,
TRIM(ABSIC) AS SIC, (SELECT DRDL01 FROM CRPCTL.F0005 WHERE DRSY = '01' AND DRRT = 'SC' AND TRIM(DRKY) = TRIM(T1.ABSIC)) AS SICNAME,
TRIM(ABAC03) AS CTYPE, (SELECT DRDL01 FROM CRPCTL.F0005 WHERE DRSY = '01' AND DRRT = '03' AND TRIM(DRKY) = TRIM(T1.ABAC03)) AS CTYPENAME,
TRIM(ABAC10) AS CUSTGROUP, (SELECT DRDL01 FROM CRPCTL.F0005 WHERE DRSY = '01' AND DRRT = '10' AND TRIM(DRKY) = TRIM(T1.ABAC10)) AS CUSTGROUPNAME,
TRIM(ABAC12) AS GLOBALMKT, (SELECT DRDL01 FROM CRPCTL.F0005 WHERE DRSY = '01' AND DRRT = '12' AND TRIM(DRKY) = TRIM(T1.ABAC12)) AS GLOBALMKTNAME,
TRIM(ABAC02) AS REG, (SELECT DRDL01 FROM CRPCTL.F0005 WHERE DRSY = '01' AND DRRT = '02' AND TRIM(DRKY) = TRIM(T1.ABAC02)) AS REGNAME,
TRIM(ABAC04) AS REP, (SELECT DRDL01 FROM CRPCTL.F0005 WHERE DRSY = '01' AND DRRT = '04' AND TRIM(DRKY) = TRIM(T1.ABAC04)) AS REPNAME,
(SELECT WWMLNM FROM CRPDTA.F0111 X WHERE T1.ABAN8 = X.WWAN8 AND WWIDLN = 0 AND ROWNUM = 1) AS MAILNAME,
(SELECT EAEMAL FROM CRPDTA.F0111, CRPDTA.F01151 WHERE EAAN8 = WWAN8 AND WWIDLN = 0 AND EAIDLN = 0 AND EAETP = 'I' AND WWAN8 = T1.ABAN8 AND ROWNUM = 1 AND ROWNUM = 1) AS WEBSITE,
(SELECT EAEMAL FROM CRPDTA.F0111, CRPDTA.F01151 WHERE EAAN8 = WWAN8 AND WWIDLN = 0 AND EAIDLN = 0 AND EAETP = 'E' AND WWAN8 = T1.ABAN8 AND ROWNUM = 1 AND ROWNUM = 1) AS EMAIL,
TRIM(AICRCD) AS CURRCODE,
TRIM(AITRAR) AS PAYCODE, (SELECT PNPTD FROM CRPDTA.F0014 WHERE PNPTC = T2.AITRAR) AS PAYNAME,
(SELECT CONCAT(TRIM(WPAR1),CONCAT('-', TRIM(WPPH1))) FROM CRPDTA.F0115 WHERE WPAN8 = T1.ABAN8 AND WPPHTP = '   '  AND WPIDLN = 0 AND WPRCK7 = 1 AND ROWNUM = 1) AS SHIPPHONE,
(SELECT CONCAT(TRIM(WPAR1),CONCAT('-', TRIM(WPPH1))) FROM CRPDTA.F0115 WHERE WPAN8 = T1.ABAN8 AND WPPHTP = 'FAX '  AND WPIDLN = 0 AND ROWNUM = 1) AS SHIPFAX,
(SELECT CONCAT(TRIM(WPAR1),CONCAT('-', TRIM(WPPH1))) FROM CRPDTA.F0115 WHERE WPAN8 = T1.ABAN81 AND WPPHTP = '   '  AND WPIDLN = 0 AND WPRCK7 = 1 AND ROWNUM = 1) AS BILLPHONE,
(SELECT CONCAT(TRIM(WPAR1),CONCAT('-', TRIM(WPPH1))) FROM CRPDTA.F0115 WHERE WPAN8 = T1.ABAN81 AND WPPHTP = 'FAX '  AND WPIDLN = 0 AND ROWNUM = 1) AS BILLFAX,
(SELECT ALADD1 FROM CRPDTA.F0116 AL1 WHERE T1.ABAN81 = ALAN8 AND AL1.aleftb = (select max(w.aleftb) from crpdta.f0116 w where w.alan8 = AL1.alan8)) AS BILLADD1,
(SELECT ALADD2 FROM CRPDTA.F0116 AL1 WHERE T1.ABAN81 = ALAN8 AND AL1.aleftb = (select max(w.aleftb) from crpdta.f0116 w where w.alan8 = AL1.alan8)) AS BILLADD2,
(SELECT ALADD3 FROM CRPDTA.F0116 AL1 WHERE T1.ABAN81 = ALAN8 AND AL1.aleftb = (select max(w.aleftb) from crpdta.f0116 w where w.alan8 = AL1.alan8)) AS BILLADD3,
(SELECT ALADD4 FROM CRPDTA.F0116 AL1 WHERE T1.ABAN81 = ALAN8 AND AL1.aleftb = (select max(w.aleftb) from crpdta.f0116 w where w.alan8 = AL1.alan8)) AS BILLADD4,
(SELECT ALCTY1 FROM CRPDTA.F0116 AL1 WHERE T1.ABAN81 = ALAN8 AND AL1.aleftb = (select max(w.aleftb) from crpdta.f0116 w where w.alan8 = AL1.alan8)) AS BILLCTY1,
(SELECT ALADDS FROM CRPDTA.F0116 AL1 WHERE T1.ABAN81 = ALAN8 AND AL1.aleftb = (select max(w.aleftb) from crpdta.f0116 w where w.alan8 = AL1.alan8)) AS BILLADDS,
(SELECT ALADDZ FROM CRPDTA.F0116 AL1 WHERE T1.ABAN81 = ALAN8 AND AL1.aleftb = (select max(w.aleftb) from crpdta.f0116 w where w.alan8 = AL1.alan8)) AS BILLADDZ,
(SELECT ALCTR FROM CRPDTA.F0116 AL1 WHERE T1.ABAN81 = ALAN8 AND AL1.aleftb = (select max(w.aleftb) from crpdta.f0116 w where w.alan8 = AL1.alan8)) AS BILLCTR,
(SELECT DRDL01 FROM CRPCTL.F0005 WHERE TRIM(DRSY) = '00' AND TRIM(DRRT) = 'CN' AND SUBSTR(DRKY,8,3) = (SELECT (ALCTR) FROM CRPDTA.F0116 AL1 WHERE T1.ABAN81 = ALAN8 
AND AL1.aleftb = (select max(w.aleftb) from crpdta.f0116 w where w.alan8 = AL1.alan8))) AS CTRBILL,
(SELECT ALADD1 FROM CRPDTA.F0116 AL1 WHERE T1.ABAN8 = ALAN8 AND AL1.aleftb = (select max(w.aleftb) from crpdta.f0116 w where w.alan8 = AL1.alan8)) AS SHIPADD1,
(SELECT ALADD2 FROM CRPDTA.F0116 AL1 WHERE T1.ABAN8 = ALAN8 AND AL1.aleftb = (select max(w.aleftb) from crpdta.f0116 w where w.alan8 = AL1.alan8)) AS SHIPADD2,
(SELECT ALADD3 FROM CRPDTA.F0116 AL1 WHERE T1.ABAN8 = ALAN8 AND AL1.aleftb = (select max(w.aleftb) from crpdta.f0116 w where w.alan8 = AL1.alan8)) AS SHIPADD3,
(SELECT ALADD4 FROM CRPDTA.F0116 AL1 WHERE T1.ABAN8 = ALAN8 AND AL1.aleftb = (select max(w.aleftb) from crpdta.f0116 w where w.alan8 = AL1.alan8)) AS SHIPADD4,
(SELECT ALCTY1 FROM CRPDTA.F0116 AL1 WHERE T1.ABAN8 = ALAN8 AND AL1.aleftb = (select max(w.aleftb) from crpdta.f0116 w where w.alan8 = AL1.alan8)) AS SHIPCTY1,
(SELECT ALADDS FROM CRPDTA.F0116 AL1 WHERE T1.ABAN8 = ALAN8 AND AL1.aleftb = (select max(w.aleftb) from crpdta.f0116 w where w.alan8 = AL1.alan8)) AS SHIPADDS,
(SELECT ALADDZ FROM CRPDTA.F0116 AL1 WHERE T1.ABAN8 = ALAN8 AND AL1.aleftb = (select max(w.aleftb) from crpdta.f0116 w where w.alan8 = AL1.alan8)) AS SHIPADDZ,
(SELECT ALCTR FROM CRPDTA.F0116 AL1 WHERE T1.ABAN81 = ALAN8 AND AL1.aleftb = (select max(w.aleftb) from crpdta.f0116 w where w.alan8 = AL1.alan8)) AS SHIPCTR,
(SELECT DRDL01 FROM CRPCTL.F0005 WHERE TRIM(DRSY) = '00' AND TRIM(DRRT) = 'CN' AND SUBSTR(DRKY,8,3) = (SELECT (ALCTR) FROM CRPDTA.F0116 AL1 WHERE T1.ABAN8 = ALAN8 
AND AL1.aleftb = (select max(w.aleftb) from crpdta.f0116 w where w.alan8 = AL1.alan8))) AS CTRSHIP,
(SELECT AXDC FROM CRPDTA.F4780 WHERE AXAN8 = ABAN8 AND TRIM(AXXRTS) = 'SF') AS SHIPTOID,
--(SELECT AXDC FROM CRPDTA.F4780 t1 WHERE AXAN8 IN (select ABAN81 from CRPDTA.F0101 WHERE trim(ABAN8) != trim(ABAN81) AND TRIM(t1.AXXRTS) = 'SF' AND ROWNUM = 1)) AS BILLTOID,
(SELECT AXDC FROM CRPDTA.F4780 WHERE AXAN8 = ABAN81 and aban8 <> aban81 AND TRIM(AXXRTS) = 'SF') AS BILLTOID,
--(SELECT AXDC FROM CRPDTA.F4780 t2 WHERE AXAN8 IN (select ABAN86 from CRPDTA.F0101 WHERE trim(ABAN8) != trim(ABAN86) AND TRIM(t2.AXXRTS) = 'SF' AND ROWNUM = 1)) AS PARENTID,
(SELECT AXDC FROM CRPDTA.F4780 WHERE AXAN8 = ABAN86  and aban8 <> aban86 AND TRIM(AXXRTS) = 'SF') AS PARENTID,
TRIM(AIBADT) AS BILLTYPE, (SELECT DRDL01 FROM CRPCTL.F0005 WHERE DRSY = 'H42' AND DRRT = 'BA' AND TRIM(DRKY) = TRIM(T2.AIBADT)) AS BILLTYPENAME,
TRIM(AICMGR) AS CREDITMGR, (SELECT DRDL01 FROM CRPCTL.F0005 WHERE DRSY = '01' AND DRRT = 'CR' AND TRIM(DRKY) = TRIM(T2.AICMGR)) AS CRMGRNAME,
TRIM(AICPGP) AS CUSTPRICEGRP, (SELECT DRDL01 FROM CRPCTL.F0005 WHERE DRSY = '40' AND DRRT = 'PC' AND TRIM(DRKY) = TRIM(T2.AICPGP)) AS CUSTPRICENAME,
TRIM(AIDB) AS DB, (SELECT DRDL01 FROM CRPCTL.F0005 WHERE DRSY = '01' AND DRRT = 'DB' AND TRIM(DRKY) = TRIM(T2.AIDB)) AS DNBNAME,
TRIM(AITSTA) AS TEMPCRMSG, (SELECT DRDL01 FROM CRPCTL.F0005 WHERE DRSY = '00' AND DRRT = 'CM' AND TRIM(DRKY) = TRIM(T2.AITSTA)) AS TEMPCRNAME,
TRIM(AIINMG) AS PRINTMSG, (SELECT DRDL01 FROM CRPCTL.F0005 WHERE DRSY = '40' AND DRRT = 'PM' AND TRIM(DRKY) = TRIM(T2.AIINMG)) AS PRINTMSGNAME,
TRIM(AIHOLD) AS HOLD, (SELECT DRDL01 FROM CRPCTL.F0005 WHERE DRSY = '42' AND DRRT = 'HC' AND TRIM(DRKY) = TRIM(T2.AIHOLD)) AS HOLDNAME,
(SELECT AXEXRA FROM CRPDTA.F4780 WHERE AXAN8 = ABAN8 AND TRIM(AXXRTS) = 'SF') AS BRNCHCODE,
(SELECT CUALPH3 FROM CRPDTA.F57DOLCU WHERE TRIM(CUALPH) = 'NBCC' AND TRIM(CUDEPT) = 'Rep' AND TRIM(CUAC04) = TRIM(T1.ABAC04)) AS REPID,
(SELECT CUALPH3 FROM CRPDTA.F57DOLCU WHERE TRIM(CUALPH) = 'NBCC' AND TRIM(CUDEPT) = 'Coordinator' AND TRIM(CUAC06) = TRIM(T1.ABAC05)) AS CSRID,
TRIM(AIAC05) AS ENGINEER, (SELECT DRDL01 FROM CRPCTL.F0005 WHERE DRSY = '01' AND DRRT = '06' AND TRIM(DRKY) = TRIM(T2.AIAC05)) AS ENGNAME,
(SELECT CUALPH3 FROM CRPDTA.F57DOLCU WHERE TRIM(CUALPH) = 'NBCC' AND TRIM(CUDEPT) = 'Engineering' AND TRIM(CUAC36) = TRIM(T2.AIAC05)) AS ENGID,
TRIM(AIAC06) AS MKTREP, (SELECT DRDL01 FROM CRPCTL.F0005 WHERE DRSY = '01' AND DRRT = '06' AND TRIM(DRKY) = TRIM(T2.AIAC06)) AS MKTNAME,
TRIM(ABAC05) AS CSR, (SELECT DRDL01 FROM CRPCTL.F0005 WHERE DRSY = '01' AND DRRT = '05' AND TRIM(DRKY) = TRIM(T1.ABAC05)) AS CSRNAME,
TRIM(ABAT1) AS SEARCHTYPE, (SELECT DRDL01 FROM CRPCTL.F0005 WHERE DRSY = '01' AND DRRT = 'ST' AND TRIM(DRKY) = TRIM(T1.ABAT1)) AS SEARCHTYPENAME,
(SELECT CUALPH3 FROM CRPDTA.F57DOLCU WHERE TRIM(CUALPH) = 'NBCC' AND TRIM(CUDEPT) = 'Mkt' AND TRIM(CUAC30) = TRIM(T2.AIAC06)) AS MKTID

FROM CRPDTA.F0101 T1            
LEFT OUTER JOIN CRPDTA.F03012 T2
  ON ABAN8 = AIAN8       
LEFT OUTER JOIN CRPDTA.F0116  T3
  ON ABAN8 = ALAN8       
where (t1.ABAT1 IN ('C','EU','EUX','CX','N') AND TRIM(t1.ABSIC) = 'NBCC')
AND
( 
    (t1.ABUPMJ >= $(vars.previousJobRun.date) and t1.ABUPMT >= $(vars.previousJobRun.time)) OR
    ((t2.AIUPMJ >= $(vars.previousJobRun.date) and t2.AIUPMT >= $(vars.previousJobRun.time)) AND (t2.AIPID <> 'B03B0131')) OR
    (t3.ALUPMJ >= $(vars.previousJobRun.date)  AND t3.ALUPMT >= $(vars.previousJobRun.time)) 
)

 --AND t1.ABAN8 IN(30059, 30038)
 AND t3.aleftb = (select max(w.aleftb) from crpdta.f0116 w where w.alan8 = t3.alan8)
ORDER BY ABAN8 DESC"