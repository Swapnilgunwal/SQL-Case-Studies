 select* from ['Nashville']

 --Q1. Get all the outcomes where the 'Landuse' is Day Care Centre.
select * from ['Nashville']
where landuse = 'DAY CARE CENTRE'

--Q2. Get all the properties where the salesprice is greater than 1 lakh.

select landuse, SalePrice from ['Nashville']
where SalePrice > 100000

--Q3. Find all the Residential condos where there are 3 baths and more than 4 bedrooms.

select landuse, FullBath, Bedrooms from ['Nashville']
where (landuse ='RESIDENTIAL CONDO' and Bedrooms = 1)
and FullBath = 3


--Q4. Get all the Quadplex , which cost more than 50 lakhs and was sold between 1930 to 1961.

select landuse, saleprice, YearBuilt  from ['Nashville']
where (landuse = 'Quadplex' and SalePrice > 500000)
and (YearBuilt between 1930 and 1961)

--Q5. Select landtype which has sale price of more than 5 crore.

select landuse, SalePrice from ['Nashville']
where SalePrice > 50000000

--Q6. Select all the landtype (Dormitory/Boarding House) which has a sale price of 2 lakhs and is in city of Urban Services District.

select landuse, saleprice, TaxDistrict from ['Nashville']
where( landuse = 'Dormitory/Boarding House' and SalePrice > 200000)
and (TaxDistrict = 'Urban Services District')

--Q7. Select the Church that was sold in 1980 and has a building value of 1 crore.

select landuse, yearbuilt, buildingvalue from ['Nashville']
where (LandUse = 'Church' and yearbuilt = 1980)
and buildingvalue > 10000000

--Q8. Get the total Sale Price of all the night clubs and also find the total night clubs.

select landuse, Saleprice from ['Nashville']
where landuse = 'Nightclub/lounge' 

--Q9. What percentage of total sale price is spend on vacant rural land.

select landuse, sum(Saleprice) from ['Nashville']
group by landuse, SalePrice
having landuse = 'vacant rural land'

--Q10. Get the sum of vacant residential land sales price which are in city of forest hill & find the average cost of it.

select landuse, sum(saleprice), avg(saleprice), TaxDistrict from ['Nashville']
group by landuse, SalePrice, SalePrice, TaxDistrict
having (LandUse = 'vacant residential land' ) and (TaxDistrict = 'CITY OF OAK HILL')

--Q11. Get the top 20 most highest priced properties with more than 4 bedrooms.

select top 20 saleprice , bedrooms, LandUse from ['Nashville']
where Bedrooms = 4
order by SalePrice desc

--Q12. Find the top 20 cheapest properties, find get the places where they are located and also tell if they are sold or vacant 
--     with having an acreage of more than 10.

select top 20 saleprice, landuse, acreage, taxdistrict from ['Nashville']
where Acreage > 10
order by SalePrice 


