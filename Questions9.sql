/*
the most recent SalesOrder transaction occurred on 2014-06-30 and the First 
Sales Order transaction occurred on 2011-05-31. 
Does the SalesOrderHeader table show a similar Order date for the first and Last Sale? Format as Date
*/

SELECT CAST(MAX(OrderDate) as date) as Last_OrderDate,
CONVERT(date,MIN(OrderDate)) as First_OrderDate
FROM [Sales].[SalesOrderHeader];