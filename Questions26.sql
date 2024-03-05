/*
SalesOrderHeader. The results in this question need to include one row per SalesOrderID (31,465 rows). Include the following columns:

a. SalesOrderID

b. Customer Name (include First and Last Names)

c. Person.PersonType (don't use the abbreviations, spell out each PersonType)

d. Sales Person Name (include First and Last Names). If a SalesOrderID doesn't have a Sales person then specify with 'No Sales Person'

e. OrderDate

f. Amount of Product quantity purchased

Hint:
b. Concatenate First and Last Name

c. Use case statement to specify each person type

d. Use case statement. Left Join Person.Person to SalesOrderHeader

f. OrderQty in SalesOrderDetail
*/

Select 
    soh.SalesOrderID
    ,CONCAT(cp.FirstName,' ',cp.LastName) as 'CustomerName'
    ,Case When cp.PersonType = 'IN' Then 'Inividual Customer'
	  When cp.PersonType = 'SC' Then 'Store Contact'
	  Else Null End as 'PersonType'
    ,Case When CONCAT(sp.FirstName,' ',sp.LastName) = ' ' 
	  Then 'No Sales Person'
	  Else CONCAT(sp.FirstName,' ',sp.LastName) End  as 'SalesPerson'
    ,OrderDate
    ,Sum(OrderQTY) as ProductQty
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
    ,CONCAT(sp.FirstName,' ',sp.LastName)