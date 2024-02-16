/* 
a. Sum the LineTotal in SalesOrderDetail. Format as currency

b. Sum the LineTotal in SalesOrderDetail by the MakeFlag in the product table. Use a case statement to specify manufactured vs. purchased. Format as currency.

c. Add a count of distinct SalesOrderIDs

d. What is the average LineTotal per SalesOrderID?
Hint
Join Production.Product to Sales.SalesOrderDetail using the ProductID
*/

--a. 
Select 
	Format(Sum(linetotal),'C0') as LineTotal
From Sales.SalesOrderDetail

--b. 
Select 
	Case When p.MakeFlag = 1 Then 'Manufactured'
		 Else 'Purchased' End as MakeFlag
	,Format(Sum(linetotal),'C0') as LineTotal
From Sales.SalesOrderDetail sod
	Inner Join Production.Product p on p.ProductID = sod.ProductID
Group by MakeFlag


--c. 
Select 
	Case When p.MakeFlag = 1 Then 'Manufactured'
		 Else 'Purchased' End as MakeFlag
	,Format(Sum(linetotal),'C0') as LineTotal
	,Format(Count(Distinct sod.SalesOrderID),'N0') as SalesOrderID_CNT
From Sales.SalesOrderDetail sod
	Inner Join Production.Product p on p.ProductID = sod.ProductID
Group by MakeFlag


--d. 
Select 
	Case When p.MakeFlag = 1 Then 'Manufactured'
		 Else 'Purchased' End as MakeFlag
	,Format(Sum(linetotal),'C0') as LineTotal
	,Format(Count(Distinct sod.SalesOrderID),'N0') as SalesOrderID_CNT
	,Format(Sum(linetotal)/Count(Distinct sod.SalesOrderID),'C0') as AvgLineTotal
From Sales.SalesOrderDetail sod
	Inner Join Production.Product p on p.ProductID = sod.ProductID
Group by MakeFlag