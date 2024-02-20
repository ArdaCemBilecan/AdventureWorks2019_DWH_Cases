/*
In this question use SalesOrderID '69411' to determine answer.
a. In the SalesOrderHeader what is the difference between "SubTotal" and "TotalDue"?
b. Which one of these matches the "LineTotal" in the SalesOrderDetail?
c. How is TotalDue calculated in SalesOrderHeader?
d. How is LineTotal calculated in SalesOrderDetail?

Hint:
Use SalesOrderDetail to join Product and SalesOrderHeader
*/

--a
SELECT SUM(SubTotal) as Sum_ST , SUM(TotalDue) as Sum_TD , (SUM(SubTotal) - SUM(TotalDue)) as Variance 
FROM [Sales].[SalesOrderHeader] WHERE SalesOrderID = '69411';


--b
SELECT soh.SalesOrderID,SUM(SubTotal) as Sum_ST , SUM(TotalDue) as Sum_TD , (SUM(SubTotal) - SUM(TotalDue)) as Variance ,SUM(LineTotal) as Sum_LT
FROM [Sales].[SalesOrderHeader] as soh 
INNER JOIN Sales.SalesOrderDetail as sod ON soh.SalesOrderID = sod.SalesOrderID
WHERE soh.SalesOrderID = '69411'
GROUP BY soh.SalesOrderID

--c 
SELECT SalesOrderID,SubTotal,TaxAmt,Freight,(SubTotal + TaxAmt + Freight) as Manually_TotalDue,TotalDue
FROM Sales.SalesOrderHeader


--d 
SELECT SalesOrderID,OrderQty,UnitPrice,UnitPriceDiscount,CONVERT(float,LineTotal),
CASE WHEN UnitPriceDiscount <> 0
THEN CONVERT(float,(OrderQty * UnitPrice))
ELSE CONVERT(float,(OrderQty * UnitPrice) - (OrderQty * UnitPrice*UnitPriceDiscount))
END as Manually_LineTotal
FROM Sales.SalesOrderDetail;