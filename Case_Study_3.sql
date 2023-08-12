--SQL Advance Case Study
--Q: List all the states in which we have customers who have bought cellphones from 2005 till data?

--Ans: 
select b.IDCustomer,d.State, year from DIM_DATE a
join FACT_TRANSACTIONS b on a.date=b.date
join DIM_CUSTOMER c on b.IDCustomer=c.IDCustomer
join DIM_LOCATION d on b.IDLocation=d.IDLocation
where
year>=2005
order by year desc

--Q: What state in the US is buying the most 'Samsung' cell phones?

--Ans:
select a.Manufacturer_Name,d.Country,d.state from DIM_MANUFACTURER a
join DIM_MODEL b on a.IDManufacturer= b.IDManufacturer
join FACT_TRANSACTIONS c on c.IDModel= b.IDModel
join DIM_LOCATION d on c.IDLocation=d.IDLocation
where 
Manufacturer_Name='Samsung' and Country='US'


--Q: Show the number of transactions for each model per zip code per state? 

--Ans: 
select a.idmodel,b.zipcode,b.state from fact_transactions a
join dim_location b on a.idlocation=b.idlocation


--Q: Show the cheapest cellphone?

--Ans:
select top 1 model_name,min(Unit_price)Amount from dim_model
group by Unit_price,model_name


--Q: Find out the average prize for each model in the top 5 manufactures in terms in terms of sales quantity and order by average prize?

--Ans:
select top 5 a. idmodel, a.model_name,quantity, avg(unit_price)Amount from dim_model a
join fact_transactions b on a.idmodel=b.idmodel
group by unit_price,a.idmodel,model_name,quantity
order by Quantity Desc


--Q: List the names of the customers and the average amount spent in 2009, where the average is higher than 500?

--Ans:
select a.idcustomer,a.customer_name,year, avg(totalprice)Average from dim_customer a
join fact_transactions b on a.idcustomer=b.idcustomer
join dim_date c on b.date=c.date
group by a.idcustomer,a.customer_name,YEAR
having
year=2009 
order by average desc

--Q: List if there is any model that was in the top 5 in terms of quantity, simultaneously in 2008, 2009 and 2010?
	
--Ans: 
select top 5 quantity, a.idmodel,a.model_name,c.year  from dim_model a
join fact_transactions b on a.idmodel=b.idmodel
join dim_date c on b.date=c.date
where 
Year= 2008 
Union
select top 5 quantity, a.idmodel,a.model_name,c.year  from dim_model a
join fact_transactions b on a.idmodel=b.idmodel
join dim_date c on b.date=c.date
where 
Year= 2009
Union
select top 5 quantity, a.idmodel,a.model_name,c.year  from dim_model a
join fact_transactions b on a.idmodel=b.idmodel
join dim_date c on b.date=c.date
where 
Year= 2010
order by quantity desc
	
--Q: Show the manufacturer with the 2nd top sales in the year 2009 and the manufacturer with the 2nd top sales in the year of 2010?	

--Ans:
select * from dim_manufacturer a
join dim_model b on a.idmanufacturer=b.idmanufacturer
join fact_transactions c on b.idmodel=c.idmodel
join dim_date d on c.date=d.date
where
year=2009 
order by totalprice desc

select * from dim_manufacturer a
join dim_model b on a.idmanufacturer=b.idmanufacturer
join fact_transactions c on b.idmodel=c.idmodel
join dim_date d on c.date=d.date
where
year=2009
order by totalprice desc

--Q:Show the manufacturers that sold cellpones in 2010, but did not in 2009.

--Ans:
select distinct a.idmanufacturer, d.year,c.totalprice,a.manufacturer_name from dim_manufacturer a
join dim_model b on a.idmanufacturer=b.idmanufacturer 
join fact_transactions c on b.idmodel=c.idmodel
join dim_date d on c.date=d.date
where 
year=2010
except
select distinct a.idmanufacturer, d.year,c.totalprice,a.manufacturer_name from dim_manufacturer a
join dim_model b on a.idmanufacturer=b.idmanufacturer 
join fact_transactions c on b.idmodel=c.idmodel
join dim_date d on c.date=d.date
where 
year=2009



--Q: Find the top 100 customers and their average spend, average quantity by each year. Also find the percentage of change in their spend.

--Ans:
SELECT IDCUSTOMER ,YEARS , AVG_QTY , AVG_SPEDD , (( AVG_SPEDD - PREV)/PREV *100) AS PERCENTCHANGE
FROM 
      (
SELECT IDCustomer, YEARS,AVG_QTY , AVG_SPEDD ,
LAG(AVG_SPEDD,1) OVER(PARTITION BY IDCUSTOMER  ORDER BY IDCUSTOMER ASC , YEARS ASC) AS PREV
FROM 
(SELECT X.IDCustomer, AVG_SPEDD,AVG_QTY, YEARS FROM
       
	     ( SELECT TOP 10 IDCustomer, AVG(TotalPrice) AS AVG_SPEND FROM FACT_TRANSACTIONS
	      GROUP BY IDCustomer
	      ORDER BY AVG_SPEND DESC) AS X
          
	LEFT JOIN

	(SELECT IDCustomer , YEAR(DATE) AS YEARS  , AVG(TotalPrice) AS AVG_SPEDD , AVG(QUANTITY) AS AVG_QTY
	FROM FACT_TRANSACTIONS
	GROUP BY IDCustomer, YEAR(DATE)) 
AS Y
ON X.IDCustomer=Y.IDCustomer) AS F) AS C	
 
	