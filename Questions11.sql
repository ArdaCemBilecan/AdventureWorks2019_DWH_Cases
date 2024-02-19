/*
AdventureWorks works with customers, employees and business partners all over the globe.
The accounting department needs to be sure they are up-to-date on Country and State tax rates.

a. Pull a list of every country and state in the database.
b. Includes tax rates.
c. There are 181 rows when looking at countries and states, but once you add tax rates the number of rows increases to 184. Why is this?
d. Which location has the highest tax rate?

Hint:
a. Start by using the StateProvince table
b. Use a left join when joining SalesTaxRate to StateProvince
c. Find the countries/states that have more than 1 tax rate
*/


--a You can check the columns name in this code
SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'StateProvince';
SELECT CountryRegionCode,StateProvinceCode, s.Name FROM Person.StateProvince as s
ORDER BY 1,2,3

--b Just wanna see Tax Rate you can use this code. But Let's write it a bit complex
SELECT * FROM [Sales].[SalesTaxRate]

SELECT sp.StateProvinceID,StateProvinceCode,CountryRegionCode,TaxType,TaxRate from 
Person.StateProvince as sp
LEFT OUTER JOIN Sales.SalesTaxRate as st
ON sp.StateProvinceID = st.StateProvinceID;

--c
Select * from Sales.SalesTaxRate	
	Where StateProvinceID in (
		Select 
			sp.StateProvinceID
		From Person.StateProvince sp
		  Inner Join Person.CountryRegion cr on cr.CountryRegionCode = sp.CountryRegionCode
		  Left Join Sales.SalesTaxRate tr on tr.StateProvinceID = sp.StateProvinceID
		Group by sp.StateProvinceID
		Having count(*) > 1)

--d. 
Select 
	cr.Name as 'Country'
	,sp.Name as 'State'
	,tr.TaxRate
From Person.StateProvince sp
	Inner Join Person.CountryRegion cr on cr.CountryRegionCode = sp.CountryRegionCode
	Left Join Sales.SalesTaxRate tr on tr.StateProvinceID = sp.StateProvinceID
Order by 3 desc


