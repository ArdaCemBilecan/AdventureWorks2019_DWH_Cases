/*
Due to an increase in shipping cost you've been asked to pull a few figures related to the freight column in

Sales.SalesOrderHeader

a. How much has AdventureWorks spent on freight in totality?

b. Show how much has been spent on freight by year (ShipDate)

c. Add the average freight per SalesOrderID

d. Add a Cumulative/Running Total sum
*/

--a 
SELECT FORMAT(SUM(freight),'C1') as Total_Freight FROM Sales.SalesOrderHeader

--b
SELECT LEFT(FORMAT(ShipDate,'yyyyMMdd'),4),FORMAT(SUM(freight),'C1') as Total_Freight FROM Sales.SalesOrderHeader
GROUP BY LEFT(FORMAT(ShipDate,'yyyyMMdd'),4)

--c 
SELECT SalesOrderId , AVG(freight) as AVG_Freight_bySalesOrderID from Sales.SalesOrderHeader
Group By SalesOrderID


--d
Select 
	ShipYear
	,Format(TotalFreight,'C0') as TotalFreight
	,Format(AvgFreight,'C0') as AvgFreight
	,Format(Sum(TotalFreight) Over (Order by ShipYear),'C0') as RunningTotal
From(
	Select 
		Year(ShipDate) as ShipYear
		,Sum(Freight) as TotalFreight
		,Avg(Freight) as AvgFreight 
	From Sales.SalesOrderHeader
	Group by 
		Year(ShipDate))a