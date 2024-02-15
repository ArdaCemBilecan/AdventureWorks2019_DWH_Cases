/*
Question 12:
a. What is the name of the CEO? Concatenate first and last name.
b. When did this person(CEO) start working for AdventureWorks
c. Who reports to the CEO? Includes their names and title
Hint:
Join HumanResources.Employee to Person.Person
*/

--a Chief Executive Officer(CEO)
SELECT CONCAT(FirstName+' ',LastName) as CEO_FullName from HumanResources.Employee as e
INNER JOIN Person.person as p
ON e.BusinessEntityID = p.BusinessEntityID
WHERE JobTitle = 'Chief Executive Officer';

--b We got Hired Date Column.
SELECT HireDate FROM HumanResources.Employee
WHERE JobTitle = 'Chief Executive Officer';

--c It means Where OrganizasionLevel = 1
SELECT CONCAT(FirstName,' ',LastName) as FullName,JobTitle from HumanResources.Employee as e
INNER JOIN Person.person as p
ON e.BusinessEntityID = p.BusinessEntityID
WHERE OrganizationLevel = '1';