/*
Ken Sánchez, the CEO of AdventureWorks, has recently changed his email address.

a. What is Ken's current email address?

b. Update his email address to 'Ken.Sánchez@adventure-works.com'

Hint:
Join Person.Person to Person.EmailAddress
*/

--a
SELECT p.FirstName , p.LastName,e.EmailAddress FROM Person.person as p
INNER JOIN Person.EmailAddress as e
ON p.BusinessEntityID = e.BusinessEntityID
WHERE p.BusinessEntityID = 1

--b
UPDATE Person.EmailAddress
SET EmailAddress = 'Ken.Sánchez@adventure-works.com'
WHERE BusinessEntityID = 1
