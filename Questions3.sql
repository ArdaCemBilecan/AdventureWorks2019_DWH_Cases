USE [AdventureWorks2019];
/*
Question 13
a. What is the job title for John Evans
b. What department does John Evans work in?
Hint:
Use EmployeeDepartmentHistory to join Employee and Department
*/

--a
Select JobTitle , FirstName,LastName from Person.Person as p
INNER JOIN HumanResources.Employee as e
ON p.BusinessEntityID = e.BusinessEntityID
WHERE FirstName='John' AND LastName ='Evans';

--b
WITH DEPARTMENT AS (
    SELECT his.BusinessEntityID,his.DepartmentID,dep.Name
    FROM HumanResources.EmployeeDepartmentHistory AS his
    LEFT JOIN HumanResources.Department AS dep
    ON his.DepartmentID = dep.DepartmentID
)
SELECT p.BusinessEntityID,p.FirstName,p.LastName,dep.DepartmentID,dep.Name from PERSON.PERSON as p
INNER JOIN DEPARTMENT as dep
ON p.BusinessEntityID = dep.BusinessEntityID
WHERE p.FirstName = 'John' AND p.LastName = 'Evans'; 
