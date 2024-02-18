/*
The first and most recent OrderDate in the SalesOrderHeader table matches the Sales Order Dates in the transactionHistory table.
a. Find the other tables and dates that should match the WorkOrder and PurchaseOrder Dates. Format these dates as a date in the YYYY-MM-DD format.
b. Do the dates match? Why/Why not?
Hint
Use Purchasing.PurchaseOrderHeader and Production.Workorder
*/

Select 
	Status
	,Convert(date,Min(OrderDate)) as FirstDate --matches the pending status
	,Convert(date,Max(OrderDate)) as LastDate
from Purchasing.PurchaseOrderHeader
Group by Status

Select 
	Convert(date,Min(DueDate)) as FirstDate
	,Convert(date,Max(DueDate)) as LastDate
	,Convert(date,Min(StartDate)) as FirstStartDate --matches TransactionHistory
	,Convert(date,Max(StartDate)) as LastStartDate 
	,Convert(date,Min(EndDate)) as FirstEndDate
	,Convert(date,Max(EndDate)) as LastEndDate
from Production.WorkOrder