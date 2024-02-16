/*
a. How many products are sold by AdventureWorks?
b. How many of these products are actively being sold by AdventureWorks?
c. How many of these active products are made in house vs. purchased?
Hint:
Use the Product table be sure to review each column
*/

--a
SELECT count(*) as Number_Of_Solded FROM Production.Product
WHERE FinishedGoodsFlag = 1;

--b
Select 
	Count(*) as NUMof_Active_Solded_Production
From Production.Product
Where FinishedGoodsFlag = 1
	and SellEndDate is null

--c
Select 
	Count(*) as ProductCNT
	,Count(Case When MakeFlag = 0
				Then ProductID
				Else null End) as PurchasedProduct
	,Count(Case When MakeFlag = 1
				Then ProductID
				Else null End) as MadeInHouse
From Production.Product
Where FinishedGoodsFlag = 1
	and SellEndDate is null;
