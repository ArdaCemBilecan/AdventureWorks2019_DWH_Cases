/*
"Mountain-100 Silver" and the "Mountain-100 Black" bicycles have the highest margins...
meaning the ListPrice to StandardCost ratio is higher than any other product.

a. Within the Production.Product table find a identifier that groups the 8 "Mountain-100" bicycles (4 Silver and 4 Black).

b. How many special offers have been applied to these 8 bicycles? When did the special offer start? 
When did the special offer end? What was the special offer?

c. Based on the most recent special offer start date is the product actually discontinued? Is the product still sold?

d. When was the last date the product was sold to an actual customer?

Hint
Use SpecialOfferProduct to join SpecialOffer and Product
*/

--a
SELECT * FROM Production.Product WHERE Name LIKE '%Mountain-100%'

--b We leanrt ProductModelID was 19 but I wanna write this code dynamic.
Select so.StartDate,so.EndDate,so.Type,so.Category,so.Description,so.DiscountPct,Count(Distinct p.name) as CNT
From Production.Product p
	Inner Join Sales.SpecialOfferProduct sop on sop.ProductID = p.ProductID
	Inner Join Sales.SpecialOffer so on so.SpecialOfferID = sop.SpecialOfferID
Where ProductModelID IN (SELECT ProductModelID FROM Production.Product WHERE Name LIKE '%Mountain-100%')
Group by 
	so.StartDate
	,so.EndDate
	,so.Type
	,so.Category
	,so.Description
	,so.DiscountPct

--c
Select  SellStartDate,SellEndDate,DiscontinuedDate
From Production.Product
Where ProductModelID IN (SELECT ProductModelID FROM Production.Product WHERE Name LIKE '%Mountain-100%')



--d For take date, use join with SalesOrderDetails and SalesOrderHeader
Select Min(OrderDate) as FirstDate,Max(OrderDate) as MostRecentDate
From Sales.SalesOrderHeader soh
	Inner Join Sales.SalesOrderDetail sod on sod.SalesOrderID = soh.SalesOrderID
	Inner Join Production.Product p on p.ProductID = sod.ProductID
Where ProductModelID = '19'