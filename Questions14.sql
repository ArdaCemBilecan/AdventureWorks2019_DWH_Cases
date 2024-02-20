/*
In general Gross Revenue is calculated by taking the Amount of Sales/Revenue without removing the expenses to sell that item. 
Which also means that in general Net Revenue is the Amount of Sales/Revenue after the expenses have been subtracted.

Which product has the best margins? (Highest Net Revenue)
Hint
List Price and Standard Cost in Production.Product
*/

-- If Margins Column's format is a Text cuz of the FORMAT. So for sorting create new column and no use format and use it forr sorting.
SELECT Name,
FORMAT(ListPrice,'C0') as ListPrice,
FORMAT(StandardCost,'C0') as StandardCost,
FORMAT((ListPrice - StandardCost),'C0') as Margins,
(ListPrice - StandardCost) as SORT
FROM Production.Product 
ORDER BY SORT DESC