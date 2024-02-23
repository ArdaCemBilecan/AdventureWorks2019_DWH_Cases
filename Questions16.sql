/*
a. Using Sales.SalesReason pull a distinct list of every sales reason.
b. Add a count of SalesOrderID's to the sales reason.
c. Which Sales Reason is most common?
*/

--a
SELECT DISTINCT * FROM Sales.SalesReason

--b
Select 
	sr.Name as Reason
	,Format(Count(sohsr.SalesOrderID),'#,#') as CNT
From Sales.SalesOrderHeaderSalesReason sohsr
	Inner Join Sales.SalesReason sr
		on sr.SalesReasonID = sohsr.SalesReasonID
Group by 
	sr.Name

--c
Select 
	sr.Name as Reason
	,Count(sohsr.SalesOrderID) as Sort
	,Format(Count(sohsr.SalesOrderID),'#,#') as CNT
From Sales.SalesOrderHeaderSalesReason sohsr
	Inner Join Sales.SalesReason sr
		on sr.SalesReasonID = sohsr.SalesReasonID
Group by 
	sr.Name 
Order by 2 desc
