/*
there are 27,647 rows in the SalesOrderHeaderSalesReason table. 
Which means these 27,647 are assigned to a SalesReason. However, there are 31,465 unique SalesOrderIDs in the SalesOrderHeader table. 
This is due to the fact that a SalesOrder can have zero, one, or multiple sales reasons listed. 
For Example, SalesOrderID 44044 has "Manufacturer" and "Quality" listed as reasons why the customer purchased. 
The most reasons listed for a single SalesOrderID is 3.

Using a CTE (Common Table Expression) find the number of SalesOrderIDs that have zero, one, two, and three sales reasons.

Hint
With CTE_Name as (Statement)
*/

WITH CTE_Name AS (
Select soh.SalesOrderID, COUNT(hsr.SalesOrderID) as CNT
FROM Sales.SalesOrderHeader as soh
LEFT  OUTEr JOIN Sales.SalesOrderHeaderSalesReason as hsr ON hsr.SalesOrderID = soh.SalesOrderID
LEFT OUTER JOIN Sales.SalesReason as sr on sr.SalesReasonID = hsr.SalesReasonID
GROUP BY soh.SalesOrderID
)
SELECT CNT , COUNt(CNT) as CNT_Of_SalesOrderIDs
FROm CTE_Name
GROUP BY CNT;