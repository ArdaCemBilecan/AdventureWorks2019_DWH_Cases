/*
a. Which Purchasing vendors have the highest credit rating?
b. Using a case statement replace the 1 and 0 in Vendor.PreferredVendorStatus to "Preferred" vs "Not Preferred."  
How many vendors are considered Preferred?

c. For Active Vendors only, do Preferred vendors have a High or lower average credit rating?
d. How many vendors are active and Not Preferred?

Hint
a. use the Vendor table
c. Cast CreditRating as a decimal
*/
--a
SELECT BusinessEntityID,Name,AccountNumber,CreditRating FROM Purchasing.Vendor
WHERE CreditRating = (SELECT MAX(CreditRating) as Max_Credit FROM Purchasing.Vendor);

--b
SELECT	
CASE WHEN PreferredVendorStatus = 1
THEN 'Preferred'
ELSE 'Not Preffered'
END as PreferredVendorStatus,
COUNT(PreferredVendorStatus) AS Nummber_Of_Preferred
from [Purchasing].[Vendor]
WHERE PreferredVendorStatus = 1
GROUP BY PreferredVendorStatus;


--c Using ActiveFlag columns
Select 
	Case when PreferredVendorStatus = '1' Then 'Preferred'
		 Else 'Not Preferred' End as PreferredStatus
	,Avg(Cast(CreditRating as decimal)) as AvgRating
From Purchasing.Vendor
Where ActiveFlag = 1
Group by 
	Case when PreferredVendorStatus = '1' Then 'Preferred'
		 Else 'Not Preferred' End

--d
WITH Pref_NotPref AS (
SELECT
CASE WHEN PreferredVendorStatus = 1
THEN 'Preferred'
ELSE 'Not Preferred'
END as PreferredVendorStatus,
BusinessEntityID , ActiveFlag
FROM Purchasing.Vendor
)
SELECT PreferredVendorStatus,ActiveFlag,COUNT(*) as Active_Not_Pref FROM Pref_NotPref
WHERE PreferredVendorStatus='Not Preferred' AND ActiveFlag = 1
GROUP BY PreferredVendorStatus,ActiveFlag