/*
Assume the sales team wants to reach out to folks who left a review (ProductReview). 
Is it possible to find the customers that left a review in the Person table? 
Make your best attempt at finding these customers.
Hint
The like function makes this easier
*/

-- Checking the tables and finding column names.
SELECT * FROM [Production].[ProductReview]
SELECT * FROM Person.EmailAddress
SELECT * FROM [Person].[Person]


SELECT * FROM Production.ProductReview as pr
LEFT OUTER JOIN Person.EmailAddress as email ON pr.EmailAddress = email.EmailAddress
LEFT OUTER JOIN Person.Person as p ON p.BusinessEntityID = email.BusinessEntityID
