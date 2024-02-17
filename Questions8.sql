/*
a. In the TransactionHistory and TransactionHistoryArchive tables a "W","S", and "P" are used as Transaction types.    
What do these abbreviations mean?

b. Union TransactionHistory and TransactionHistoryArchive

c. Find the First and Last TransactionDate in the TransactionHistory Union TransactionHistoryArchive tables. Use the union written in part b.
The current data type for TransactionDate is datetime. Convert or Cast the data type to date.

d. Find the First and Last Date for each transaction type. Use a case statement to specify the transaction types.
*/

--a
Select
	t.name as TableName
	,c.name as ColumnName
	,ep.value as Definitions
From sys.extended_properties ep
	INNER JOIN sys.tables t on t.object_id = ep.major_id
	INNER JOIN sys.columns c on c.object_id = ep.major_id
						    and c.column_id = ep.minor_id
Where t.name = 'TransactionHistory'


--b
SELECT * FROM Production.TransactionHistory
UNION
SELECT * FROM Production.TransactionHistoryArchive;


--c
SELECT MIN(CAST(TransactionDate as Date)) as MIN_Date,
		MAX(CONVERT(date,TransactionDate)) as MAX_Date
FROM (SELECT * FROM Production.TransactionHistory
UNION
SELECT * FROM Production.TransactionHistoryArchive) u;

SELECT * FROM 

--d
SELECT
CASE WHEN TransactionType ='W'
THEN 'WorkerOrder'
WHEN TransactionType = 'S'
THEN 'SalesOrder'
ELSE 'PurchaseOrder'
END as Trans_Type,
MIN(CAST(TransactionDate as date)) as First_Date,
MAX(CONVERT(date,TransactionDate)) as Last_Date
FROM(
SELECT * FROM Production.TransactionHistory
UNION 
SELECT * FROM Production.TransactionHistoryArchive) u
GROUP BY CASE WHEN TransactionType ='W'
THEN 'WorkerOrder'
WHEN TransactionType = 'S'
THEN 'SalesOrder'
ELSE 'PurchaseOrder'
END
