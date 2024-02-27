/*
Using a 
Select Into Statement put this table into a Temporary Table. Name the table '#Temp1'

b. Run this statement:

Select * 
From #Temp1
Where BusinessEntityID in ('288','286')
Notice that these two Employees have worked for AdventureWorks for 10 months; however, the YearsEmployed says "1." 
The DateDiff Function I used in our statement above does simple math:(2014 - 2013 = 1). Update the YearsEmployed to "0" for these two Employees.

c. Using the Temp table, how many employees have worked for AdventureWorks over 5 years and 6 months?

d. Create a YearsEmployed Grouping like below:

Employed Less Than 1 Year

Employed 1-3 Years

Employed 4-6

Employed Over 6 Years

Show a count of Employees in each group

e. Show the average VacationHours and SickLeaveHours by the YearsEmployed Group. Which Group has the highest average Vacation and SickLeave Hours?

*/


--a
Select 
	Rank() Over (Order by Hiredate asc) as 'Seniority'
	,DATEDIFF(Day,HireDate,'2014-03-03') as 'DaysEmployed'
	,DATEDIFF(Month,HireDate,'2014-03-03') as 'MonthsEmployed'
	,DATEDIFF(Year,HireDate,'2014-03-03') as 'YearsEmployed'
	,* 
Into #Temp1
From HumanResources.Employee
SELECT * FROM #Temp1

--b
Update #Temp1
Set YearsEmployed = 0 
Where BusinessEntityID in ('288','286') 
 
Select * From #Temp1
Where BusinessEntityID in ('288','286')

--c
SELECT * FROM #Temp1
WHERE MonthsEmployed > 66

--d
Select  
	Case When YearsEmployed = 0 Then 'EmployedLessThan1Year'
		  When YearsEmployed between 1 and 2 Then 'Employed1-2Years'
		  When YearsEmployed between 3 and 4 Then 'Employed3-4Years'
		  When YearsEmployed between 5 and 6 Then 'Employed5-6Years'
		  Else 'EmployedOver6years' 
		  End YearsEmployedGroup
	,Count(*) as EmpCNT
	,AVG(YearsEmployed) as Sort
From #Temp1
Group by 
	Case When YearsEmployed = 0 Then 'EmployedLessThan1Year'
		  When YearsEmployed between 1 and 2 Then 'Employed1-2Years'
		  When YearsEmployed between 3 and 4 Then 'Employed3-4Years'
		  When YearsEmployed between 5 and 6 Then 'Employed5-6Years'
		  Else 'EmployedOver6years' 
		  End
Order by 3 desc

--d
SELECT * FROM #Temp1

SELECT AVG(SickLeaveHours) as AVG_SickLeaveHours , AVG(VacationHours) as AVG_VacationHours,YearsEmployed
from #Temp1
GROUP BY YearsEmployed

SELECT *,AVG(SickLeaveHours) OVER(PARTITION BY YearsEmployed) as AVG_SickLeaveHours 
, AVG(VacationHours) OVER(PARTITION BY YearsEmployed) as AVG_VacationHours
FROM #Temp1