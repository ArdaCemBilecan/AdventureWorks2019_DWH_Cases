/*
Assume today is August 15, 2014.
a. Calculate the age for every current employee. What is the age of the oldest employee?
b. What is the average age by Organization level? Show answer with a single decimal
c. Use the ceiling function to round up
d. Use the floor function to round down

Hint:
use the DATEDIFF Function
*/

--a In this question I wanna see BusinessEntityID,Emplooye's Full Name , BirthDate , Age 
SELECT e.BusinessEntityID,CONCAT(p.FirstName,' ',P.LastName) as FullName,e.BirthDate,DATEDIFF(YEAR,BirthDate,'2014/08/15') as Age
FROM HumanResources.Employee as e
INNER JOIN Person.Person as p
ON e.BusinessEntityID = p.BusinessEntityID
ORDER BY Age DESC

--b 
Select OrganizationLevel,
Format(Avg(cast(DATEDIFF(Year,BirthDate,'2014-08-15') as decimal)),'N2') as Age
From HumanResources.Employee
Group by OrganizationLevel
Order by 2 desc


--c 
Select OrganizationLevel,
Format(Avg(cast(DATEDIFF(Year,BirthDate,'2014-08-15') as decimal)),'N2') as Age_Avg,
Ceiling(Avg(cast(DATEDIFF(Year,BirthDate,'2014-08-15') as decimal))) as Age_Ceiling
From HumanResources.Employee
Group by OrganizationLevel
Order by 2 desc

--d 
Select OrganizationLevel,
Format(Avg(cast(DATEDIFF(Year,BirthDate,'2014-08-15') as decimal)),'N2') as Age_Avg,
Ceiling(Avg(cast(DATEDIFF(Year,BirthDate,'2014-08-15') as decimal))) as Age_Ceiling,
FLOOR(AVG(CAST(DATEDIFF(Year,BirthDate,'2014-08-15') as decimal))) as Age_Floor
From HumanResources.Employee
Group by OrganizationLevel
Order by 2 desc
