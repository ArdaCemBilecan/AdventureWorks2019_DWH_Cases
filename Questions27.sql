/*
The column is currently null. We want the comment in SalesOrderHeader to say:

"[CustomerName] is a(n) [PersonType] and purchased

[OrderQty] Product(s) from [SalesPersonName] on [OrderDate]."

a. Using the column elements From Question 41 build a CTE (common table expression) that includes two columns - SalesOrderID and Comment. Here is an example for Customer (BusinessEntityID) 49123:

"Michael Allen is a(n) Store Contact and purchased

72 Product(s) from Jillian Carson on 12/31/2012"

b. Update SalesOrderHeader.Comment using the CTE from part a. Remember there are 31,465 unique SalesOrderID's.
*/

With CTE as(
	Select 
		soh.SalesOrderID
		,(CONCAT(cp.FirstName,' ',cp.LastName) 
			+ ' is a(n) ' 
			+ Case When cp.PersonType = 'IN' Then 'Inividual Customer'
				   When cp.PersonType = 'SC' Then 'Store Contact'
				   Else Null End 
			+ ' and purchased ' 
			+ Cast(Sum(OrderQTY) as varchar) 
			+ ' Product(s) from ' 
			+ Case When CONCAT(sp.FirstName,' ',sp.LastName) = ' ' 
				   Then 'No Sales Person'
				   Else CONCAT(sp.FirstName,' ',sp.LastName) End 
			+ ' on ' 
			+ Convert(varchar, OrderDate,101)) as Comment
	From Sales.SalesOrderHeader soh
		Inner Join Sales.SalesOrderDetail sod on soh.SalesOrderID = sod.SalesOrderID
		Inner Join Sales.Customer c on c.CustomerID = soh.CustomerID
		Inner Join Person.Person cp on cp.BusinessEntityID = c.PersonID
		Left Join Person.Person sp on sp.BusinessEntityID = soh.SalesPersonID
	Group by 
		soh.SalesOrderID
		,CONCAT(cp.FirstName,' ',cp.LastName)
		,cp.PersonType
		,OrderDate
		,CONCAT(sp.FirstName,' ',sp.LastName))
--b.
Update Sales.SalesOrderHeader
Set Comment = CTE.Comment
From Sales.SalesOrderHeader soh
	Inner Join CTE on CTE.SalesOrderID = soh.SalesOrderID 
 
Update Sales.SalesOrderHeader
Set Comment = null