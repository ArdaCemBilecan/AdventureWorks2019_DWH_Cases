/*
a. Using the RANK function rank the employees in the Employee table by the hiredate. Label the column as 'Seniority'

b. Assuming Today is March 3, 2014, add 3 columns for the number of days, months, and years the employee has been employed.

Hint:
Rank() Over (Order by ColumnName asc/desc)
*/

--a
Select Rank() Over (Order by Hiredate asc) as 'Seniority',* 
From HumanResources.Employee

--b
Declare @CurrentDate date = '2014-03-03'
Select 
	Rank() Over(Order by Hiredate asc) as 'Seniority'
	,DATEDIFF(Day,HireDate,@CurrentDate) as 'DaysEmployed'
	,DATEDIFF(Month,HireDate,@CurrentDate) as 'MonthsEmployed'
	,DATEDIFF(Year,HireDate,@CurrentDate) as 'YearsEmployed'
	,* 
from HumanResources.Employee