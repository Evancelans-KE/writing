--------------------------------------------------------------------------------

 -------------->   //// ABOUT THE CX-DASHBOARD ///   <------------

--------------------------------------------------------------------------------

  - Priority areas 


1. Rejections ( Gross vs Net rejections )

   a.) After pivoting the gross-rejections and filling their respective values; upload the net rejections msisdns to the database as a flat file and use the below sql commands to get the net rejected msisdns 

	   -------- 
	  select msisdn from (
	  select a.*,b.kyc_source from  rejections_31st_jan(Name of the rejected msisdns) a 
	  left outer join analytics.agg_kyc_details b
	  on a.msisdn=b.msisdn 
      where b.kyc_source ='Agile KYC') g


	  -----------


	 b.) Use the result of msisdns obtained above (in a ). Insert your vlook-up  formular on in the krej_dump and let your look up value be from the net rejections as you look against the gross-rejection dump. The result, filter the net-rejections column and remain with # N/A, copy this result to a new workbook and then pivot the results you get there based on 'status reason',,, and there you have your net rejections. Voila !!!!!


2. Activation stats

   a.) Should be prepared daily and updated daily, such that by 1st of the month, all this data is readily available for updating into the CX Dashboard.

 3. GSM Base compliance 

   a.) REC- Non, compliance Analysis
      - Use the below sql commands to get the revenues ; 

			//				SELECT count(*) subs, sum(REVENUE) revenue, bands FROM (
							SELECT TELEPHONIC_ADDRESS_ID,
							CASE when ROUND(REVENUE,0)>0 AND ROUND(REVENUE,0)<=25 THEN '1-25 Revenue'
							when ROUND(REVENUE,0)>=26 AND ROUND(REVENUE,0) <=50 THEN '26 - 50 Revenue'
							when ROUND(REVENUE,0)>=51 AND ROUND(REVENUE,0) <=100 THEN '51 - 100 Revenue'
							when ROUND(REVENUE,0)>=101 AND ROUND(REVENUE,0) <=200 THEN '101-200 Revenue'
							when ROUND(REVENUE,0)>=201 AND ROUND(REVENUE,0) <=500 THEN '201- 500 Revenue'
							when ROUND(REVENUE,0)>=501 THEN '>500'
							WHEN ROUND(REVENUE,0) IS NULL THEN 'NULL'
							when ROUND(REVENUE,0) <=0 THEN '0 TO 1 Revenue'
							ELSE 'Others' END bands , REVENUE
							FROM (
							SELECT a.*, CASE WHEN b.TELEPHONIC_ADDRESS_ID IS NULL THEN 'N' ELSE 'Y' END compliant
							FROM KYC_PREPAID a LEFT OUTER JOIN KYC_COMPLIANT b ON
							a.TELEPHONIC_ADDRESS_ID = b.TELEPHONIC_ADDRESS_ID
							) WHERE compliant='N'  AND SUBSCRIBER_INACTIVITY_DAYS <30)
							GROUP BY bands ORDER BY 3 DESC

	- For 31-60 days and 61-90 Days 
	-- Use the below commands

			    //                 SELECT BANDS, count(*) subs, sum(REVENUE) revenue FROM (
									SELECT TELEPHONIC_ADDRESS_ID, SUBSCRIBER_INACTIVITY_DAYS ,
									CASE when SUBSCRIBER_INACTIVITY_DAYS>= 31 AND SUBSCRIBER_INACTIVITY_DAYS <=60 THEN '31-60 Days'  
									WHEN SUBSCRIBER_INACTIVITY_DAYS>= 61 AND SUBSCRIBER_INACTIVITY_DAYS <=90 THEN '61-90 Days'  
									WHEN SUBSCRIBER_INACTIVITY_DAYS>= 91 AND SUBSCRIBER_INACTIVITY_DAYS <=180 THEN '91-180 Days'  
									WHEN SUBSCRIBER_INACTIVITY_DAYS>180 THEN '>180'  
									WHEN SUBSCRIBER_INACTIVITY_DAYS<=30 THEN 'REC'
									ELSE 'Others' END bands , REVENUE
									FROM (
									SELECT a.*, CASE WHEN b.TELEPHONIC_ADDRESS_ID IS NULL THEN 'N' ELSE 'Y' END compliant 
									FROM KYC_PREPAID a LEFT OUTER JOIN KYC_COMPLIANT b ON 
									a.TELEPHONIC_ADDRESS_ID = b.TELEPHONIC_ADDRESS_ID
									) WHERE compliant='N' )
									GROUP BY BANDS

 4. Airtel Money Revenues 
    a.) A file containing party/access Id (msisdns) and revenues for the particular month should be provided by Michael Otanga by 1st of the month (latest)
          * Use the following SQL commands to get the revenue bands for the various revenues;

				            select count(*)subs,rev_bands,sum(revenue) rev from (
								select party_access_id,revenue,
								case when revenue = 0 then '0'
								when revenue >=0 and revenue <= 25 then '1 - 25'
								when revenue >=26 and revenue<=50  then '26-50'
								when revenue >=51 and revenue<=100  then '51-100'
								when revenue >=101 and revenue<=200  then '101-200'
								when revenue >=201 and revenue<=500  then '201-500'
								when revenue >501 then 'Greater than 500'
								else 'null' end rev_bands from jan_am_revenues_20) a
								group by rev_bands order by 2


 5)For curing trend, use the below SQL command;

                      ///       select count(*) subs, segments from bi_segements a 
								left outer join analytics.agg_kyc_details b on a.msisdn=b.msisdn 
								where b.kyc_date >= '2020-01-01' and kyc_date <= '2020-01-27' and  kyc_source !='USSD'
								group by segments

					////////
					              select count(distinct(a.msisdn)), a.kyc_source from   non_compliant_to_compiant20201129 a
									left outer join analytics.fct_mobiquity_balances b
									on a.msisdn = b.msisdn
									--count(distinct msisdn) from analytics.fct_mobiquity_balances 
									where to_char(b.created_on,'YYYY-MM-DD') >= '2020-11-01'
									group by a.kyc_source

6. 







-----------------------------------------------------------------------------------------------

          ///////////// ABOUT THE MARKETING BANDS /////////////////

------------------------------------------------------------------------------------------------

1. Banding (For duplicate mssidns and single IDS), upload the file to the database and then use the below SQL command to get your bands. 

     a.)           select * from retailer_list a left outer join (
				   select idno, cnt , CASE WHEN cnt =1 THEN '0 to 1' 
				    WHEN cnt >=2  AND cnt <=4    THEN '2 to 4' 
					 WHEN cnt >=5  AND cnt <=7    THEN '5 to 7' 
					 WHEN cnt >=8  AND cnt <=10    THEN '8 to 10' 
					 WHEN cnt >=11  AND cnt <=15    THEN '11 to 15' 
					 WHEN cnt >=16  AND cnt <=25    THEN '16 to 25' 
					 WHEN cnt >=26  AND cnt <=35    THEN '26 to 35' 
					 WHEN cnt >35    THEN '>35' 
					ELSE 'Other'
					END  band_count
					from (
					select  "RETAILER_ID NO" idno, count(retailer) cnt  from retailer_list
					group by "RETAILER_ID NO"
					) a ) b on a."RETAILER_ID NO"=b.idno
     
     b.) Export the result data and pivot it on the following criteria, 
                 ROWS   => 'band-count'
                 VALUES => 'count of cnt'

     c.) When looking for the particular gross adds of these numbers, you can decide to use a VLOOK-UP of retailer-msisdns against the 
        banded msisdns

        or alternatively is to do a COUNTIF function of  (banded_msisdns || retailer_msisdns) in the gross adds file





-------------------------------------------------------------------------------------------------------

//////////////////////////////// DAILY DB2 RUN ///////////////////////////////////

-------------------------------------------------------------------------------------------------------


1. Get Daily updated Agile numbers from Oracle KYC-Agile. 

			 select TELEPHONIC_ADDRESS_ID, to_char(current_inserttime,'YYYY-MM-DD') 
			 KYC_DATE FROM BI_VIEW_DAILY 
			 and to_char(current_inserttime,'YYYY-MM-DD') > '2020-02-03'

 a.) Push the above result  to DB2 on AGILE-COMPLIANT Table


b.) Then trunctate table KYC_REVENUE 

     INSERT INTO KYC_REVENUE
         













-------------------------------------------------------------------------------------------------------

//////////////////////// SELECTING FROM MULTIPLE VALUES IN SAME COLUMN ///////////////////////////////

-------------------------------------------------------------------------------------------------------

1. Convert from column to text and vice versa on this website, delim.co

2. A sample command is this: SELECT count(*) FROM KYC_PREPAID WHERE TELEPHONIC_ADDRESS_ID IN (731830184,731989084,731969981,738429788,780885154,735634686,751842298,735634686,752590756,731064822,787978937,78797893) 

3. For a limited range of NOT IN, use this statement; #OR
					SELECT * FROM `users` WHERE `id` NOT IN (23,56,21, 76);


-------------------------------------------------------------------------------------------------------

//////////////////////// UNBARRED AND  ///////////////////////////////

-------------------------------------------------------------------------------------------------------

1. This table belongs to unbarred msisdns = analytics.agg_unbarred_non_kyc

2. 


-------------------------------------------------------------------------------------------------------

//////////////////////// MY JOINS  ///////////////////////////////

-------------------------------------------------------------------------------------------------------

1. Am trying to find matching records from table A and table b whilst returning all matching records 
   from both tables;

   a.) my sample query 
           ///    select a. msisdn, b.msisdn from xyzdb a 
                  left outer join on zyxdb 
                  on a.msisdn = b.msisdn 
                  where ('i can put some conditions here')
b.)  (SELECT msisdn from abcddb) MINUS (select msisdn from dcbadb)


 ----------------------------------------------------------------------------------------------------


-------------------------------------------------------------------------------------------------------

////////////////////////  VALUE SEGMENTATION  ///////////////////////////////

-------------------------------------------------------------------------------------------------------


SELECT COUNT (*), VALUE_SEGMENTATION_NAME 
FROM KYC_PREPAID 
WHERE ACTIVATION_DATE>='2019-09-01'
AND ACTIVATION_DATE<=' '
GROUP BY VALUE_SEGMENTATION_NAME



--------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------

////////////////////////  INSERT ONLY UNIQUE  VALUES .SQL ///////////////////////////////

-------------------------------------------------------------------------------------------------------


a.)  INSERT INTO Words (Word)
        SELECT @Word
         WHERE NOT EXISTS (SELECT * FROM Words WHERE Word = @Word)

b.) 


		CREATE UNIQUE NONCLUSTERED INDEX [IndexTableUniqueRows] ON [dbo].[table] 
		(
		    [Col1] ASC,
		    [Col2] ASC,

		)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = ON, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]






 

-------------------------------------------------------------------------------------------------------

////////////////////////   Ticket support link  ///////////////////////////////

-------------------------------------------------------------------------------------------------------


a.) https://airtelafrica.service-now.com/airtel?id=sc_request&table=sc_request&sys_id=fefded67db7eccdc5afdd06b68961925



-------------------------------------------------------------------------------------------------------

////////////////////////   USSD KYC-DETAILS ///////////////////////////////

-------------------------------------------------------------------------------------------------------

a.) SELECT * FROM A2346453.V_SUBSCRIBER_KYC_KE 


b.) Table partition

				SELECT * FROM (
				SELECT ACCESS_METHOD_IDENTIFIER,SUBSCRIBER_PERSONAL_ID, SUBSCRIBER_FIRST_NAME,SUBSCRIBER_LAST_NAME, CURRENT_INSERT_DATE,
				RANK () over (PARTITION BY ACCESS_METHOD_IDENTIFIER ORDER BY CURRENT_INSERT_DATE DESC) pos 
				FROM  DWH_CDR_REPOSITORY_MOBILITY_KE.V_SUBSCRIBER_KYC) vsk
				WHERE pos =1
				AND  ACCESS_METHOD_IDENTIFIER ='731179842'




-------------------------------------------------------------------------------------------------------

////////////////////////   SQL PROCEDURES ///////////////////////////////

-------------------------------------------------------------------------------------------------------

CREATE PROCEDURE My_procedure;
AS
SELECT * FROM my_table;
GO;

EXEC My_procedure





	-------------------------------------------------------------------------------------------------------

////////////////////////   R  Programming  /////////////////////////

-------------------------------------------------------------------------------------------------------


a.)  https://r4ds.had.co.nz/tibbles.html
b.)  https://www.datacamp.com/community/tutorials
c.)  http://statseducation.com/Introduction-to-R/modules/getting%20data/matrices/
d.)  https://www.extendoffice.com/documents/excel/2642-excel-best-fit-line-curve-function.html


df <- df %>%
  mutate(Name = fct_explicit_na(Name, "99"))

-----------

library(dplyr)
flights %>% group_by(carrier) %>% summarize(mean(arr_delay, na.rm=TRUE))



	-------------------------------------------------------------------------------------------------------

////////////////////////   Postgress Table  Databases; /////////////////////////

-------------------------------------------------------------------------------------------------------

a.) Airtel- Money <- 
                  AM ( select * from analytics.fct_mobiquity_balances );

            Return AM 

b.) KYC- TIMESTAMP <- 
                KYC-TSM (select * from analytics.fct_agile_kyc_emails)
   


--------------------------------------------------------------------------------------

  /////////////////// ///  AM EXISTING BASE  ///////////////////////////

  -----------------------------------------------------------------------------


-------------// SYSTEM BASE

select count (distinct msisdn) from analytics.fct_mobiquity_balances 
where to_char(last_transaction_on,'YYYY-MM-DD') >= '2019-12-01'


-------------// REC BASE

select count (distinct msisdn) from analytics.fct_mobiquity_balances 
where to_char(last_transaction_on,'YYYY-MM-DD') >= '2020-02-01'


----------------///  AM  GROSS ADDS --------------------------------------------------

SELECT count(a.msisdn) , b.kyc_source from analytics.fct_mobiquity_balances a 
left outer join analytics.agg_kyc_details b 
on a.msisdn= b.msisdn
where TO_CHAR(created_on,'YYYY-MM-DD')>= '2020-02-01' and to_char(created_on,'YYYY-MM-DD')<='2020-02-27'
group  by 
b.kyc_source


--------// System base compliance

SELECT count(a.msisdn) , b.kyc_source from feb_am_90_day_base a 
left outer join  analytics.agg_kyc_details b 
on a.msisdn= b.msisdn
group  by 
b.kyc_source

------//  REC base compliance

SELECT count(a.msisdn) , b.kyc_source from analytics.fct_mobiquity_balances a 
left outer join  analytics.agg_kyc_details b 
on a.msisdn= b.msisdn
where TO_CHAR(last_transaction_on,'YYYY-MM-DD')>= '2020-02-01' 
and to_char(last_transaction_on,'YYYY-MM-DD') <= '2020-02-28'
group  by 
b.kyc_source



-------/// AM REVENUES ----------------------------------------------- 



select count(*)subs,rev_bands,sum(revenue) rev from (
select msisdn,revenue,case when revenue =0 then '0'
when revenue >=1 and revenue <= 25 then '1 - 25'
when revenue >=26 and revenue<=50  then '26-50'
when revenue >=51 and revenue<=100  then '51-100'
when revenue >=101 and revenue<=200  then '101-200'
when revenue >=201 and revenue<=500  then '201-500'
when revenue >501 then 'Greater than 500'
else 'null' end rev_bands from sep_revenues)a
group by rev_bands order by 2


----------/// GSM REVENUES (RUN ON DB2) 


SELECT count(*) subs, sum(REVENUE) revenue, bands FROM 
(SELECT TELEPHONIC_ADDRESS_ID,
CASE when ROUND(REVENUE,0)>0 AND ROUND(REVENUE,0)<=25 THEN '1-25 Revenue'
when ROUND(REVENUE,0)>=26 AND ROUND(REVENUE,0) <=50 THEN '26 - 50 Revenue'
when ROUND(REVENUE,0)>=51 AND ROUND(REVENUE,0) <=100 THEN '51 - 100 Revenue'
when ROUND(REVENUE,0)>=101 AND ROUND(REVENUE,0) <=200 THEN '101-200 Revenue'
when ROUND(REVENUE,0)>=201 AND ROUND(REVENUE,0) <=500 THEN '201- 500 Revenue'
when ROUND(REVENUE,0)>=501 THEN '>500'
WHEN ROUND(REVENUE,0) IS NULL THEN 'NULL'
when ROUND(REVENUE,0) <=0 THEN '0 TO 1 Revenue'
ELSE 'Others' END bands , REVENUE
FROM 
(SELECT a.*, CASE WHEN b.TELEPHONIC_ADDRESS_ID IS NULL THEN 'N' ELSE 'Y' END compliant
FROM KYC_PREPAID a LEFT OUTER JOIN KYC_COMPLIANT b ON
a.TELEPHONIC_ADDRESS_ID = b.TELEPHONIC_ADDRESS_ID)
WHERE compliant='N'  AND SUBSCRIBER_INACTIVITY_DAYS <30)



-----------------------------------------------------------------------------------

   /////////////////// MATERIALIZED VIEWS /////////////////////////////////


 --------------------------------------------------------------------------------


CREATE MATERIALIZED VIEW  kyc_source_data
select a, b, c 




----------------------------------------------------------------------------------

////////////////////// SQL SERVER MANAGEMENT STUDIO //////////////////////////

-------------------------------------------------------------------------------------
       --  config.config


a.) Azure portal id = evaonyango251@gmail.com;
b.) Password  = reffer to Yahoo account ("id");
c. 


/////////////////some_ bella ciao \

  >>  https://www.hacking-tutorial.com/hacking-tutorial/remote-administration-tool-zeus-botnet-rat/#sthash.rCn4uBuC.dpbs





  ---------------------------------------------------------------------------------------------------

 ///////////////////  GSM GROSS-ADDS  ///////////////////////////////////////////////////

 ----------------------------------------------------------------------------------------------

SELECT * FROM K_REVENUE
  
INSERT
	INTO
	K_REVENUE
SELECT
	TELEPHONIC_ADDRESS_ID,
	SUM(GROSS_DECREMENT_VALUE)
FROM
	
WHERE
	MEASUREMENT_PERIOD_DATE >= '2020-10-01'
	--AND MEASUREMENT_PERIOD_DATE <= '2021-02-18'
	AND GROSS_DECREMENT_VALUE>0
GROUP BY
	TELEPHONIC_ADDRESS_ID


 
	  
              
                
TRUNCATE TABLE K_PREPAID IMMEDIATE;

SELECT COUNT(DISTINCT TELEPHONIC_ADDRESS_ID) FROM K_PREPAID;
  
INSERT
	INTO
	K_PREPAID
SELECT
	A.telephonic_ADDRESS_ID,
	SUBSCRIBER_INACTIVITY_DAYS,
	ACTIVATION_DATE,
	REVENUE,
	VALUE_SEGMENTATION_NAME,
	ZONE_NAME,
	LGA_NAME,
	SITE_NAME,
	AMI_SERVICE_PROVIDER_ID,
	REPORT_DATE,
	VALUE_SEGMENTATION_TYPE_ID
FROM
	--equivalent to daily_subscriber
(
	SELECT
		*
	FROM
		A2346453.VIEW_MOBILE_TELEPHONY_ARRANGEMENT_ke
	WHERE
		REPORT_DATE = '2021-10-06'
		AND SUBSCRIBER_INACTIVITY_DAYS <90
		AND AMI_SERVICE_PROVIDER_ID IN('440', '442')
		AND MARKET_CATEGORY_TYPE_ID IN ('500') )A
	--YU
LEFT OUTER JOIN
	--segments
 A2346453.VIEW_VALUE_SEGMENTATION_MASTER_KE B ON
	A.VALUE_SEGMENTATION_TYPE_ID = B.VALUE_SEGMENTATION_ID
LEFT OUTER JOIN A2346453.view_geography_master_ke C ON
	A.CELL_SITE_ID = C.CI_ID
	AND A.LAC_ID = C.LAC_ID
	AND C.END_DATE IS NULL
LEFT OUTER JOIN (
	SELECT
		*
	FROM
		K_REVENUE) D ON
	A.telephonic_ADDRESS_ID = D.telephonic_ADDRESS_ID
	
	
	
	

----------------------------------- * Rec Base compliance * ----------------


SELECT COUNT(DISTINCT TELEPHONIC_ADDRESS_ID) FROM KYC_PREPAID
where  TELEPHONIC_ADDRESS_ID IN ( SELECT ACCESS_METHOD_IDENTIFIER FROM A2346453.UPDATED_KYC_SND
WHERE  "SOURCE" IN ('GKYC','AGILE') UNION SELECT TELEPHONIC_ADDRESS_ID FROM AGILE_COMPLIANT
UNION SELECT mobile_number FROM GKYC_DUMP)
AND SUBSCRIBER_INACTIVITY_DAYS <30



-----------
 SELECT count(*)  FROM AGILE_COMPLIANT WHERE KYC_DATE = "2020-02-04"

SELECT *  FROM AGILE_COMPLIANT WHERE TELEPHONIC_ADDRESS_ID = '762247836'

-----------

SELECT COUNT(DISTINCT TELEPHONIC_ADDRESS_ID)REC_BASE FROM KYC_PREPAID
where SUBSCRIBER_INACTIVITY_DAYS <30

----------------------------------------------

SELECT COUNT(DISTINCT TELEPHONIC_ADDRESS_ID)SYSTEM_BASE FROM KYC_PREPAID
where SUBSCRIBER_INACTIVITY_DAYS <90

-------------
SELECT COUNT(DISTINCT TELEPHONIC_ADDRESS_ID) FROM KYC_PREPAID
where  TELEPHONIC_ADDRESS_ID IN ( SELECT ACCESS_METHOD_IDENTIFIER FROM A2346453.UPDATED_KYC_SND
WHERE  "SOURCE" IN ('GKYC','AGILE') UNION SELECT TELEPHONIC_ADDRESS_ID FROM AGILE_COMPLIANT
UNION SELECT mobile_number FROM GKYC_DUMP)



-------------
SELECT * FROM AGILE_COMPLIANT WHERE KYC_DATE = '2020-01-26' --ORDER BY KYC_DATE DESC


-----REC BASE---

	
/* system Base compliance  */

SELECT COUNT(DISTINCT TELEPHONIC_ADDRESS_ID) FROM K_PREPAID
where  TELEPHONIC_ADDRESS_ID IN (SELECT ACCESS_METHOD_IDENTIFIER FROM A2346453.UPDATED_KYC_SND
WHERE  "SOURCE" IN ('GKYC','AGILE') UNION SELECT TELEPHONIC_ADDRESS_ID FROM AGILE_COMPLIANCE 
UNION SELECT mobile_number FROM GKY_DUMP UNION SELECT MSISDN FROM C_HISTORICAL)
AND SUBSCRIBER_INACTIVITY_DAYS <90


--Rec Base compliance--

--SELECT COUNT(DISTINCT TELEPHONIC_ADDRESS_ID) FROM KYC_PREPAID
--where  TELEPHONIC_ADDRESS_ID IN ( SELECT ACCESS_METHOD_IDENTIFIER FROM A2346453.UPDATED_KYC_SND
--WHERE  "SOURCE" IN ('GKYC','AGILE') UNION SELECT TELEPHONIC_ADDRESS_ID FROM AGILE_COMPLIANT
--UNION SELECT mobile_number FROM GKYC_DUMP)
--AND SUBSCRIBER_INACTIVITY_DAYS <30

---Use this for REC compliance------

SELECT COUNT(DISTINCT TELEPHONIC_ADDRESS_ID) FROM KYC_PREPAID
where  TELEPHONIC_ADDRESS_ID IN ( SELECT ACCESS_METHOD_IDENTIFIER FROM A2346453.UPDATED_KYC_SND
WHERE  "SOURCE" IN ('GKYC','AGILE') UNION SELECT TELEPHONIC_ADDRESS_ID FROM AGILE_COMPLIANT
UNION SELECT mobile_number FROM GKYC_DUMP UNION SELECT MSISDN FROM COMPLIANT_HISTORICAL)
AND SUBSCRIBER_INACTIVITY_DAYS <30

-------------------------------------------------

 
 -----------------------------------------------------------
 

SELECT COUNT (*), SOURCE FROM  WHERE ACTIVATION_DATE>='2019-09-01'AND ACTIVATION_DATE<=' '
GROUP BY VALUE_SEGMENTATION_NAME


-----------------------* High value * -----------------------------------------------

SELECT COUNT(DISTINCT TELEPHONIC_ADDRESS_ID) FROM KYC_PREPAID
where VALUE_SEGMENTATION_NAME in ('DIAMOND','GOLD','SUPER GOLD','PLATINUM') AND
TELEPHONIC_ADDRESS_ID IN (  SELECT ACCESS_METHOD_IDENTIFIER FROM A2346453.UPDATED_KYC_SND
WHERE  "SOURCE" IN ('GKYC','AGILE') UNION SELECT TELEPHONIC_ADDRESS_ID FROM A_SUBSCRIBER_KE
UNION SELECT MSISDN FROM KYC_COMPLIANCE UNION SELECT mobile_number FROM GKYC_DUMP)


----------------------------------------------------------------------------------
SELECT COUNT(*) FROM
(SELECT TELEPHONIC_ADDRESS_ID  FROM KYC_REVENUE
UNION
SELECT TELEPHONIC_ADDRESS_ID FROM KYC_PREPAID)

----------------------------------------------------------------

SELECT * FROM

(SELECT TELEPHONIC_ADDRESS_ID  FROM KYC_REVENUE
UNION
SELECT TELEPHONIC_ADDRESS_ID, REVENUE FROM KYC_PREPAID)
--GROUP BY TELEPHONIC_ADDRESS_ID


-------------------------------------------------------------------------------------------------------

SELECT * FROM AGILE_COMPLIANT  WHERE KYC_DATE >= '2020-08-02'

SELECT * FROM A2346453.view_geography_master_ke

SELECT * FROM A2346453.VIEW_VALUE_SEGMENTATION_MASTER_KE

SELECT * FROM A2382786.V_SUBSCRIBER_REVENUE_SUMMARY_KE

SELECT * FROM A2346453.VIEW_MOBILE_TELEPHONY_ARRANGEMENT_ke

--------------------------------------------------------------------------------------------------
                    High value SYSTEM base
-------------------------------------------------------------------------------------------------

SELECT COUNT(DISTINCT TELEPHONIC_ADDRESS_ID) FROM KYC_PREPAID
where VALUE_SEGMENTATION_NAME in ('DIAMOND','GOLD','SUPER GOLD','PLATINUM') AND
TELEPHONIC_ADDRESS_ID IN (  SELECT ACCESS_METHOD_IDENTIFIER FROM A2346453.UPDATED_KYC_SND
WHERE  "SOURCE" IN ('GKYC','AGILE') UNION SELECT TELEPHONIC_ADDRESS_ID FROM AGILE_COMPLIANT
UNION SELECT MSISDN FROM COMPLIANT_HISTORICAL UNION SELECT mobile_number FROM GKYC_DUMP)
AND SUBSCRIBER_INACTIVITY_DAYS <90


-----------------------------------------------------------------------------------------------
                       High value REC base
-------------------------------------------------------------------------------------------

SELECT COUNT(DISTINCT TELEPHONIC_ADDRESS_ID) FROM KYC_PREPAID
where VALUE_SEGMENTATION_NAME in ('DIAMOND','GOLD','SUPER GOLD','PLATINUM') AND
TELEPHONIC_ADDRESS_ID IN (  SELECT ACCESS_METHOD_IDENTIFIER FROM A2346453.UPDATED_KYC_SND
WHERE  "SOURCE" IN ('GKYC','AGILE') UNION SELECT TELEPHONIC_ADDRESS_ID FROM AGILE_COMPLIANT
UNION SELECT MSISDN FROM COMPLIANT_HISTORICAL UNION SELECT mobile_number FROM GKYC_DUMP)
AND SUBSCRIBER_INACTIVITY_DAYS <30            
 
----------------------------------------------------------------------------------------------




----------------------------------------------------------------------------------------------

/////////////////////// MPESA API implementation  and important links  ///////////////////////////////////////

--------------------------------------------------------------------------------------

a.) https://packagist.org/packages/bascil/mpesa-api-php



b.) https://www.raywenderlich.com/        



----------------------------------------------------------------------------------------------------------------

///////////////////////////////// KYC DBs //////////////////////////////////////////////////

------------------------------------------------------------------------------------------------------------


a.)  SELECT FROM DWH_CDR_REPOSITORY_MOBILITY_KE.KYC_DOCUMENT_REPOSITORY kdr

b.) - SELECT * FROM MIS.KYC_DATA kd 

    - SELECT * FROM MIS.IPRS i 

c.)  SELECT * FROM  A2346453.V_POLICE_PORTAL_DATA_RECORDS_KE vpdr
    SELECT * FROM A2346453.V_POLICE_PORTAL_VOICE_SMS_RECORDS_KE 

//////////////////////// SELECT THREE TABLES ///////////////////////////////////////////////

SELECT Orders.OrderID, Customers.CustomerName, Shippers.ShipperName
FROM 
(

	
	(Orders INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID)




INNER JOIN Shippers ON Orders.ShipperID = Shippers.ShipperID);

////////////////////////////////////////////////////////////////////////
---------------------------------------------------------------------------------------------------



select a.* from analytics.agg_kyc_details a
right outer join active_july_mtd_retailers b 
on a.retailer_msisdn = b.msisdn 
where kyc_date >= '2020-06-01' and kyc_date <= '2020-06-30';


--------------------------------------------------------------------------------------------
shafi shops

select a.* from analytics.agg_kyc_details a
right outer join daily_shop_requests_d1_ga b
on a.retailer_msisdn = b.msisdn
where kyc_date >= '2020-09-01';



     V_NETWORK_SERVICE_USAGE_ANALYSIS_KE



     GRANT SELECT ON A2395648.HBB_CBD_SHOP TO USER A13211414


------------------------------------------------------------------------------------
       
     --  KUTOOLS
----------------------------------------------------------------


-- Sub FindReplace()
-- 'Updateby Extendoffice
-- Dim Rng As Range
-- Dim WorkRng As Range
-- On Error Resume Next
-- xTitleId = "KutoolsforExcel"
-- Set WorkRng = Application.Selection
-- Set WorkRng = Application.InputBox("Range", xTitleId, WorkRng.Address, Type:=8)
-- For Each Rng In WorkRng
--     If Rng.Value > 3 Then
--         Rng.Value = 0
--     End If
-- Next
-- End Sub

-----------------------------------------------------------------------------------------------

SELECT TELEPHONIC_ADDRESS_ID, LGA_NAME, SITE_NAME  FROM K_PREPAID kp
WHERE SITE_NAME LIKE '%AMUKURA%' OR SITE_NAME LIKE '%UGUNJA%' OR SITE_NAME LIKE '%ANDUNGOSI%'
OR SITE_NAME LIKE '%BUSIBWABO%' OR SITE_NAME LIKE '%NAMBALE%'  OR SITE_NAME LIKE '%ALUPE%'
OR SITE_NAME LIKE '%AMAIRO%' OR SITE_NAME LIKE '%MUNDIKA%' OR SITE_NAME LIKE '%BUSIA_TOWN_IMPROVEMENT%'
OR SITE_NAME LIKE '%BUSIA_TOWN%' OR SITE_NAME LIKE '%MATAYOS%' OR SITE_NAME LIKE '%MISORI%'
OR SITE_NAME LIKE '%BONDO_GUBA%' OR SITE_NAME LIKE '%GOBEI%' OR SITE_NAME LIKE '%RAGEGNI%'
OR SITE_NAME LIKE '%NYILIMA_KANDARIA%' OR SITE_NAME LIKE '%KANDINDI%' OR SITE_NAME LIKE '%TINGWANGI%'
OR SITE_NAME LIKE '%NDORI%' OR SITE_NAME LIKE '%LUGULU_MARACHI%' OR SITE_NAME LIKE '%RUAMBWA%'
OR SITE_NAME LIKE '%BUDALANGI%' OR SITE_NAME LIKE '%FUNYULA%' OR SITE_NAME LIKE '%SIO_PORT%'
OR SITE_NAME LIKE '%PORT_VICTORIA' OR SITE_NAME LIKE '% FUNYULA%' OR SITE_NAME LIKE '% BUTULA%'
OR SITE_NAME LIKE '%BUMALA%' OR SITE_NAME LIKE '%MURUMBA%' OR SITE_NAME LIKE '%ESHIRONYANGAH%'
OR SITE_NAME LIKE '%HIKOMARI%' OR SITE_NAME LIKE '%SHIANDA%' OR SITE_NAME LIKE '%MUMIAS_WEST%'
OR SITE_NAME LIKE '%MUMIAS_SUGAR%' OR SITE_NAME LIKE '%MALAHA%' OR SITE_NAME LIKE '%BUHURU%'
OR SITE_NAME LIKE '%LUNZA%' OR SITE_NAME LIKE '%MUMIAS_TOWN%' OR SITE_NAME LIKE '%BUKURA%'
OR SITE_NAME LIKE '%USENGE%' OR SITE_NAME LIKE '%NYANGOMA%' OR SITE_NAME LIKE '%GOT_KACHIENG%'
OR SITE_NAME LIKE '%NYAMONYE%' OR SITE_NAME LIKE '%BONDO_TTC%' OR SITE_NAME LIKE '%BONDO_TOWN%'
OR SITE_NAME LIKE '%BONDO_TECHNICAL_TRAINING_INSTITUTE%' OR SITE_NAME LIKE '%RABAR%' OR SITE_NAME LIKE '%SIAYA_TKL%'
OR SITE_NAME LIKE '%UNYOLO%' OR SITE_NAME LIKE '%HAWINGA%' OR SITE_NAME LIKE '%LUANDA%'
OR SITE_NAME LIKE '%NGIYA%' OR SITE_NAME LIKE '%WAGAI%' OR SITE_NAME LIKE '%LIHANDA_WEST_GEM%'
OR SITE_NAME LIKE '% SIAYA_EAST' OR SITE_NAME LIKE '% NDERE %' OR SITE_NAME LIKE '% YALA  %'
OR SITE_NAME LIKE '%YALA_TOWN%' OR SITE_NAME LIKE '%KHUMUSALABA%' OR SITE_NAME LIKE '%YALA_KBC_GEM_MALANGA%'
OR SITE_NAME LIKE '% UKWALA' OR SITE_NAME LIKE '% SEGA %' OR SITE_NAME LIKE '% UGUNJA%'
OR SITE_NAME LIKE '%ANYIKO%' OR SITE_NAME LIKE '%SIDINDI%' OR SITE_NAME LIKE '%KADHIENO%'
OR SITE_NAME LIKE '%KAMBIRI%' OR SITE_NAME LIKE '%BUKHAYWA%' OR SITE_NAME LIKE '%BWANGA%'
OR SITE_NAME LIKE '%MALAVA%' OR SITE_NAME LIKE '%SAMITSI%' OR SITE_NAME LIKE '%ESHISIRU_CENTRE%'
OR SITE_NAME LIKE '%SHIMANYIRO%' OR SITE_NAME LIKE '%NAMASOLI%' OR SITE_NAME LIKE '%KAKAMEGA_TOWN%'
OR SITE_NAME LIKE '%KAKAMEGA_CANNON_AWORI_STREET%' OR SITE_NAME LIKE '%KAKAMEGA_MASINDE%' OR SITE_NAME LIKE '%KAKAMEGA_SOUTH%'
OR SITE_NAME LIKE '%KHAYEGA%' OR SITE_NAME LIKE '%MUSOLI%' OR SITE_NAME LIKE '%SHINYALU%'
OR SITE_NAME LIKE '% BUTERE%' OR SITE_NAME LIKE '%KHWISERO_MARKET%' OR SITE_NAME LIKE '%MUSANDA%'
OR SITE_NAME LIKE '%BULIMBO%' OR SITE_NAME LIKE '% KAIMOSI%' OR SITE_NAME LIKE '%ISHIRU%'
OR SITE_NAME LIKE '%KANDENGE%' OR SITE_NAME LIKE '%CHAVAKALI%' OR SITE_NAME LIKE '%EBUSIRATSI%'
OR SITE_NAME LIKE '%EMUHAYA%' OR SITE_NAME LIKE '%KHWISERO%' OR SITE_NAME LIKE '%MBALE%'
OR SITE_NAME LIKE '% ABATIA%' OR SITE_NAME LIKE '%KAKAMEGA_KENFICO_ESTATE%' OR SITE_NAME LIKE '%BANJA%'
OR SITE_NAME LIKE '%TIGOI%' OR SITE_NAME LIKE '%MAJENGO%' OR SITE_NAME LIKE '%MBALE_TOWN%'
OR SITE_NAME LIKE '%MARAGOLI_HILL%';



=================================================================================================


SELECT TELEPHONIC_ADDRESS_ID, (SITE_NAME)EASTLEIGH_SHOP  FROM A13211414.REC_DEVICE_CDR_DCD
WHERE SITE_NAME LIKE '%GIKOMBA%' OR SITE_NAME LIKE '%Eastleigh%' OR SITE_NAME LIKE '%UMOJA%'
OR SITE_NAME LIKE '%BURUBURU%' OR SITE_NAME LIKE '%KOMAROCK%' OR SITE_NAME LIKE '%TENA%'
OR SITE_NAME LIKE '%JOGOO ROAD%' OR SITE_NAME LIKE '%KAHAWA WEST%'
AND ZONE_NAME IN ('NAIROBI EAST', 'NAIROBI CENTRAL')
AND REPORT_DATE>= '2020-10-18';


==============================================================================================

  2. 

---Routine Checks ,  monthly that all days are there 

-- Check if data has loaded daily 

SELECT kyc_date, count(*) FROM analytics.agg_kyc_details
WHERE kyc_date >='2020-10-01'
GROUP  BY kyc_date
ORDER BY kyc_date ;

--- Daily per KYC Source

SELECT kyc_date, kyc_source , count(*) FROM analytics.agg_kyc_details
WHERE kyc_date >='2020-10-01'
GROUP  BY kyc_date, kyc_source
ORDER BY kyc_date ;

>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>  ;;;;;;;;;**********************

  3. 

a.) Step 1 

SELECT kyc_date,ga_date, count(msisdn) FROM (
SELECT msisdn,kyc_date,ga_date,subscriber_inactivity_days FROM (
SELECT msisdn, kyc_date  FROM analytics.agg_kyc_details akd 
WHERE kyc_date='2020-11-01'
--AND msisdn ='100100261' 
)  a 
LEFT OUTER JOIN 
(
SELECT telephonic_address_id, activation_date ga_date , subscriber_inactivity_days  FROM analytics.fct_mobile_telephony_arrangement fmta 
--telephonic_address_id  ='100100261'
WHERE  activation_date >='2020-11-01'
) b 
ON a.msisdn =b.telephonic_address_id
) a GROUP BY kyc_date,ga_date


b.) Step 2 


SELECT kyc_date,ga_date, count(msisdn), is_ga FROM (
SELECT msisdn,kyc_date,ga_date,subscriber_inactivity_days, 
CASE WHEN ga_date IS NULL  THEN 'N' ELSE 'Y' END is_ga 
FROM (
SELECT msisdn, kyc_date  FROM analytics.agg_kyc_details akd 
WHERE kyc_date='2020-11-01'
--AND msisdn ='100100261' 
)  a 
LEFT OUTER JOIN 
(
SELECT telephonic_address_id, activation_date ga_date , subscriber_inactivity_days  FROM analytics.fct_mobile_telephony_arrangement fmta 
--telephonic_address_id  ='100100261'
WHERE  activation_date >='2020-11-01'
) b 
ON a.msisdn =b.telephonic_address_id
) a GROUP BY  kyc_date,ga_date,  is_ga 

-------------------------------------------------------------------------------------------------

select a.msisdn, a.retailer_msisdn, a.kyc_source, b.activation_date  from analytics.agg_kyc_details a
right outer join analytics.fct_mobile_telephony_arrangement b
on a.msisdn = b.telephonic_address_id 
where b.activation_date >= '2020-09-01' and b.activation_date <= '2020-10-31'
and a.kyc_source = 'Agile KYC';


--------------------------------------------------------------------------------------------

select msisdn,retailer_msisdn,kyc_date,kyc_source,kyc_id_type,idno, id_count,  CASE when 
                     id_count =1 THEN '0 to 1' 
				     WHEN id_count>=2  AND id_count <=4     THEN '2 to 4' 
					 WHEN id_count>=5  AND id_count <=7     THEN '5 to 7' 
					 when id_count >=8  AND id_count <=10   THEN '8 to 10' 
					 WHEN id_count >=11  AND id_count <=15  THEN '11 to 15' 
					 when id_count >=16  AND id_count <=25  THEN '16 to 25' 
					 WHEN id_count>=26  AND id_count <=35   THEN '26 to 35' 
					 WHEN id_count>35    THEN '>35' 
					ELSE 'Other'
					END  band_count from temp_idno_usage_july_2021_kyc



					create table ca_40_v2 as 
select msisdn, kyc_date,fname,lname,gender,dob,kyc_id_type,kyc_source,idno,(count)id_count,
case when 
                     count =1 THEN '0 to 1' 
				     WHEN count>=2  AND count <=4     THEN '2 to 4' 
					 WHEN count>=5  AND count <=7     THEN '5 to 7' 
					 when count >=8  AND count <=10   THEN '8 to 10' 
					 WHEN count >=11  AND count <=15  THEN '11 to 15' 
					 when count >=16  AND count <=25  THEN '16 to 25' 
					 WHEN count>=26  AND count <=35   THEN '26 to 35' 
					 WHEN count>35    THEN '>35' 
					ELSE 'Other'
					END  band_count from  ca_40_v1 


create table ca_40_v3 as 
select a.*, b.subscriber_inactivity_days  from ca_40_v2 a
left outer join analytics.fct_mobile_telephony_arrangement b 
on a.msisdn = b.telephonic_address_id
where b.report_date = '2021-10-31'

insert into  ca_40_v4  
select a.*, case when  subscriber_inactivity_days >=0  and subscriber_inactivity_days <=30  THEN '0 - 30' 
				     WHEN subscriber_inactivity_days>=31 AND subscriber_inactivity_days <=60    THEN '31 - 60' 
					 WHEN subscriber_inactivity_days>=61  AND subscriber_inactivity_days <=90    THEN '61 - 90' 
					 when subscriber_inactivity_days >=91  AND subscriber_inactivity_days <=120   THEN '91-120'   
					 WHEN subscriber_inactivity_days >121    THEN 'above 121' 
					 ELSE 'Other'
					END  inactivity_bands from ca_40_v3 as a




>>>>>>>>>>>>>>>>>....
SELECT  a.MSISDN,b.NEARBY_SHOP, b.ID_USAGE  FROM TEMP_KYC_REVENUE_MAPPINGS_23RD_V1 a
LEFT OUTER JOIN SHOP_SITES_V2 b 
ON a.SITE_NAME = b.SITE_NAME
WHERE b.NEARBY_SHOP = 'KITALE'
ORDER BY RAND() 
LIMIT 4000



SELECT count(*) FROM (
SELECT a.MSISDN, b.ZONE_NAME, b.SITE_NAME,a.DECREMENT  FROM A13211414.DECREMENT_SITE_CDRS a
LEFT OUTER JOIN A13211414.REC_DEVICE_CDR_DCD b
ON a.MSISDN = b.TELEPHONIC_ADDRESS_ID 
WHERE a.DECREMENT >=1000) 



SELECT * FROM USSD_ARPU_BANDS_V4_WITH_DECREMENT_V1 

SELECT  b.ZONE_NAME,d.COUNTY, d.SUB_COUNTY,d.WARD,d.TOWN,b.SITE_NAME,c.NEARBY_SHOP, COUNT(*) FROM USSD_TRACKER_V1 a 
LEFT OUTER JOIN A13211414.REC_DEVICE_CDR_DCD b 
ON a.MSISDN = b.TELEPHONIC_ADDRESS_ID 
LEFT OUTER JOIN SHOP_SITES_V2 c 
ON b.SITE_NAME = c.SITE_NAME 
LEFT OUTER JOIN TEMP_KYC_REVENUE_MAPPINGS_WITH_IANCTV d 
ON b.SITE_NAME = d.SITE_NAME 
WHERE b.REPORT_DATE = '2021-11-08'
GROUP BY b.ZONE_NAME,d.COUNTY, d.SUB_COUNTY,d.WARD,d.TOWN,b.SITE_NAME,c.NEARBY_SHOP

----------------------------------------------------------------------------

                   IVR link;;;;;

         http://172.23.36.99/Reports/Pages/Folder.aspx


https://us02web.zoom.us/j/86310010612?pwd=NnBxSHB5ZzBuQUhpU2xwQldhTy9idz09


https://airtelafrica.zoom.us/j/97570342225?pwd=b2hoZ1B2SS9BbXNGOFJab1p0bDZLdz09

https://kyc.ke.airtel.com:9443/kyckenya/WBLogin.aspx

https://172.23.19.50/Password_Reset/   ----Oracle mmoney

http://172.23.12.200/kyc-ke/#!/dashboard/home

https://pam.airtel.africa/PasswordVault/v10/logon/radius ==> {Toad password reset}
db2 latest pwd is
 windows Diamond#6098
 postgress BoK#25
                  
				  --3245jhdMLH*
                  ---7504G;doYET6

172.23.12.163

4145

 +254 714 756105 

 781406516

-----------------------------------------------------------------------


http://172.23.5.230:8125/superset/dashboard/14/?preselect_filters=%7B%22226%22%3A%7B%22__time_range%22%3A%22Last%20day%22%7D%7D
username: CS_portal  
Password: Airtel@132


\\172.23.5.248\CX_Audit2019\MIS

https://www.contextures.com/excelwaterfallchart.html

---------------Oracle  password reset----------------------

ip:  (172.23.115.72 and 172.23.115.73)

From:  Contact:  ashish.mankar1@wipro.com



maram.sreekanth@wipro.com
Oracle-Airtel-Africa@wipro.com

a13207658.kyc_cleanup_20211103_agile_dump 

-------------------------------------------------------------------------


=CHAR(39) & A1 & CHAR(39) & CHAR(44)

=RIGHT(A2,LEN(A2)-3)

=LEFT(A2,LEN(A2)-6)

-----------------------------------------------------------------------------------------------
https://airtelafrica.zoom.us/j/94420223974?pwd=ay9FRFVDUVZmem9mSE9pazQ3T3N1QT09



INSERT INTO OCTOBER_BABIES_A1 
SELECT  b.ACCESS_METHOD_IDENTIFIER,(b.SUBSCRIBER_PERSONAL_ID)AS IDENTIFICATION_NUMBER,b.DATE_OF_BIRTH, 
MONTH(b.DATE_OF_BIRTH) AS BIRTH_DAY_MONTH,a.SUBSCRIBER_INACTIVITY_DAYS  
FROM A2346453.VIEW_MOBILE_TELEPHONY_ARRANGEMENT_ke a
LEFT OUTER JOIN   A2382786.V_SUBSCRIBER_KYC_KE b 
ON a.TELEPHONIC_ADDRESS_ID = b.ACCESS_METHOD_IDENTIFIER 
WHERE a.REPORT_DATE = '2021-10-04'
AND MONTH(b.DATE_OF_BIRTH) = '10' 
AND b.SUBSCRIBER_PERSONAL_ID IS NOT NULL
AND MONTH(b.DATE_OF_BIRTH) IS NOT NULL
AND a.SUBSCRIBER_INACTIVITY_DAYS <90

-----------------------------------------------------------------------------------



=LEFT(D2,2)&":"&MID(D2,4,2)&":"&MID(D2,7,2)&" "&RIGHT(D2,2)