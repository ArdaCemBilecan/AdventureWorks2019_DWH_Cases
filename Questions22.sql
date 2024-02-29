/*
AdventureWorks leadership has asked you to put together a report. Follow the steps below to build the report.

a. Pull a distinct list of every region. Use the SalesTerritory as the region.

b. Add the Sum(TotalDue) to the list of regions

c. Add each customer name. Concatenate First and Last Names

d. Using ROW_NUMBER and a partition rank each customer by region. For example, Australia is a region and we want to rank each customer by the Sum(TotalDue). 
*/

--a
SELECT distinct name FROM Sales.SalesTerritory

--b
Select 
	distinct st.Name as RegionName
	,Format(Sum(TotalDue),'C0') as TotalDue
From Sales.SalesTerritory st
	Inner Join Sales.SalesOrderHeader soh on soh.TerritoryID = st.TerritoryID
Group by st.Name

--c
Select 
	distinct st.Name as RegionName
	,Concat(p.FirstName,' ',p.LastName) as CustomerName
	,Format(Sum(TotalDue),'C0') as TotalDue
From Sales.SalesTerritory st
	Inner Join Sales.SalesOrderHeader soh on soh.TerritoryID = st.TerritoryID
	Inner Join Sales.Customer c on c.CustomerID = soh.CustomerID
	Inner Join Person.Person p on p.BusinessEntityID = c.PersonID
Group by 
	st.Name
	,Concat(p.FirstName,' ',p.LastName)

--d
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