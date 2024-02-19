/*
The Marketing Department has never ran ads in the United Kingdom and would like you pull a list of every individual customer (PersonType = IN) by country.
a. How many individual (retail) customers exist in the person table?
b. Show this breakdown by country
c. What percent of total customers reside in each country. For Example,  
if there are 1000 total customers and 200 live in the United States then 20% of the customers live in the United States. 


Hint
b. Be sure the total retail customers found in part a doesn't change  as you join tables.
c. Multiple ways to do this. Try using an Inner Query
*/

--a
SELECT COUNT(PersonType),PersonType as CPT FROM [Person].[Person]
GROUP BY PersonType

--b
SELECT cr.Name as Country_Name , count(p.BusinessEntityID) as Sort , Format(count(p.BusinessEntityID),'N0') as CNT from Person.Person p
	Inner Join Person.BusinessEntityAddress bea on bea.BusinessEntityID = p.BusinessEntityID
	Inner Join Person.Address a on a.AddressID = bea.AddressID
	Inner Join Person.StateProvince sp on sp.StateProvinceID = a.StateProvinceID
	Inner Join Person.CountryRegion cr on cr.CountryRegionCode = sp.CountryRegionCode
WHERE PersonType = 'IN'
GROUP By cr.Name
ORDER BY 2 desc

--c
SELECT cr.Name as Country_Name , count(p.BusinessEntityID) as Sort ,
FORMAT(
CAST(
COUNT(p.BusinessEntityID) as float) / (SELECT COUNT(*) FROM Person.Person WHERE PersonType = 'IN') ,'P') as Percentage_Country
from Person.Person p
	Inner Join Person.BusinessEntityAddress bea on bea.BusinessEntityID = p.BusinessEntityID
	Inner Join Person.Address a on a.AddressID = bea.AddressID
	Inner Join Person.StateProvince sp on sp.StateProvinceID = a.StateProvinceID
	Inner Join Person.CountryRegion cr on cr.CountryRegionCode = sp.CountryRegionCode
WHERE PersonType = 'IN'
GROUP By cr.Name
ORDER BY 2 desc


-- For the Calculating total of the Total Retail Customers we can use DECLARE statement for more readable.
DECLARE @TotalRetailCustomers as FLOAT = (SELECT COUNT(*) FROM Person.Person WHERE PersonType = 'IN')
SELECT cr.Name as Country_Name , count(p.BusinessEntityID) as Sort ,
FORMAT(
CAST(
COUNT(p.BusinessEntityID) as float) / @TotalRetailCustomers ,'P') as Percentage_Country
from Person.Person p
	Inner Join Person.BusinessEntityAddress bea on bea.BusinessEntityID = p.BusinessEntityID
	Inner Join Person.Address a on a.AddressID = bea.AddressID
	Inner Join Person.StateProvince sp on sp.StateProvinceID = a.StateProvinceID
	Inner Join Person.CountryRegion cr on cr.CountryRegionCode = sp.CountryRegionCode
WHERE PersonType = 'IN'
GROUP By cr.Name
ORDER BY 2 desc

