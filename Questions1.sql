USE [AdventureWorks2019];

/*
a. How many employees exist in the Database?
b. How many of these employees are active employees?
c. Write a Query Job Titles equal the 'SP' Person type
d. How many of these employees are sales people?
Hint:
Use the HumanResources.Employee Table and the Person.Person Table
*/

--a
Select 
	Count(*) as EmpCNT
	,Count(Distinct BusinessEntityID) as EmpCNT2
	,Count(Distinct NationalIDNumber) as EmpCNT3
From HumanResources.Employee

--b   If CurrentFlag is 1 then it's active person
SELECT CurrentFlag ,COUNT(*) as Num_of_Active_Person
FROM HumanResources.Employee
GROUP BY CurrentFlag;


--c
Select 
	Distinct JobTitle as CNT
	From HumanResources.Employee e
	INNER JOIN Person.Person p on p.BusinessEntityID = e.BusinessEntityID
Where PersonType = 'SP'


--d
SELECT JobTitle,COUNT(Distinct e.BusinessEntityID) as Num_Of_SP_PersonType FROM HumanResources.Employee as e
INNER JOIN Person.person as p 
ON e.BusinessEntityID = p.BusinessEntityID
WHERE PersonType = 'SP'
GROUP BY JobTitle;