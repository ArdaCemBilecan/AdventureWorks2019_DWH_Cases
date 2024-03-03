/*
a. Limit the results in question 22 to only show the top 25 customers in  each region. There are 10 regions so you should have 250 rows.
b. What is the average TotalDue per Region? Leave the top 25 filter
*/

--a
SELECT * FROM(
Select 
	distinct st.Name as RegionName
	,Concat(p.FirstName,' ',p.LastName) as CustomerName
	,Format(Sum(TotalDue),'C0') as TotalDue
	,ROW_NUMBER() Over(Partition by st.Name Order by Sum(TotalDue) desc) as RowNum
From Sales.SalesTerritory st
	Inner Join Sales.SalesOrderHeader soh on soh.TerritoryID = st.TerritoryID
	Inner Join Sales.Customer c on c.CustomerID = soh.CustomerID
	Inner Join Person.Person p on p.BusinessEntityID = c.PersonID
Group by 
	st.Name
	,Concat(p.FirstName,' ',p.LastName)
	) a
WHERE RowNum <= 25

--b
WITH TOTALDUE as (
Select 
	distinct st.Name as RegionName
	,Concat(p.FirstName,' ',p.LastName) as CustomerName
	,CAST(Sum(TotalDue) as float) as TotalDue
	,ROW_NUMBER() Over(Partition by st.Name Order by Sum(TotalDue) desc) as RowNum
From Sales.SalesTerritory st
	Inner Join Sales.SalesOrderHeader soh on soh.TerritoryID = st.TerritoryID
	Inner Join Sales.Customer c on c.CustomerID = soh.CustomerID
	Inner Join Person.Person p on p.BusinessEntityID = c.PersonID
Group by 
	st.Name
	,Concat(p.FirstName,' ',p.LastName)
)
SELECT RegionName,FORMAT(AVG(TotalDue),'C0') as AVG_TotalDue_Region FROM TOTALDUE
GROUP BY RegionName


