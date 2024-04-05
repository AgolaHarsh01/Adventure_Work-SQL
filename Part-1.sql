--PART - 1 W3-RESOURCE
--Question:-1 

SELECT * 
FROM [HumanResources].[Employee]
ORDER BY JobTitle

--Question:-2 
SELECT p.*
FROM [Person].[Person] AS p --Using Alias Concept-- 

--Question:-3
SELECT p.FirstName,p.LastName,p.BusinessEntityID Employee_Id	--Using Alias Concept-- 
FROM [Person].[Person] AS p
ORDER BY p.LastName --DESC

--Question:- 4
/* FROM the following table write a query in SQL to return 
only the rows for product that have a sellstartdate that is not NULL and a productline of 'T'.
Return productid, productnumber, and name. Arranged the output in ascending order on name.*/

SELECT ProductID,ProductNumber,Name --ProductLine,SellStartDate 
FROM [Production].[Product]
where ProductLine='T' AND SellStartDate IS NOT NULL		--Carefully Read Question

--Question:- 5
/*FROM the following table write a query in SQL to return all rows FROM the salesorderheader table in Adventureworks database and 
calculate the percentage of tax on the subtotal have decided.
Return salesorderid, customerid, orderdate, subtotal, percentage of tax column.Arranged the result set in ascending order on subtotal.
*/
SELECT SalesOrderID,CustomerID,OrderDate,SubTotal,(TaxAmt*100)/SubTotal AS Tex_Percentage --,TaxAmt --Formumla
FROM Sales.SalesOrderHeader

--Question:-6
/*
FROM the following table write a query in SQL to create a list of --unique jobtitles-- in the employee table in Adventureworks database. 
Return jobtitle column and arranged the resultset in ascending order
*/

SELECT DISTINCT(JobTitle)				--Using DISTINCT Function
FROM [HumanResources].[Employee]
ORDER BY JobTitle 

--Question:-7
/*FROM the following table write a query in SQL to calculate the total freight paid by each customer.
Return customerid and total freight. Sort the output in ascending order on customerid.
*/

SELECT CustomerID,SUM(Freight) AS Total_Freight_Paid   --Using SUN() --Must Alis to the calculated Field.
FROM [Sales].[SalesOrderHeader]
GROUP BY CustomerID
ORDER BY CustomerID 

--Question:-8
/*FROM the following table write a query in SQL to find the average and the sum of the subtotal for every customer. 
Return customerid, average and sum of the subtotal. 
Grouped the result on customerid and salespersonid. Sort the result on customerid column in descending order.
*/

SELECT CustomerID,SalesPersonID
	,SUM(SubTotal) AS Sub_Total
	,AVG(SubTotal) AS Avg_SubTotal
FROM [Sales].[SalesOrderHeader]
GROUP BY CustomerID,SalesPersonID
ORDER BY CustomerID

--Question:-9
/*FROM the following table write a query in SQL to retrieve total quantity of each productid which are in shelf of 'A' or 'C' or 'H'.
Filter the results for sum quantity is more than 500. Return productid and sum of the quantity. 
Sort the results according to the productid in ascending order.
*/

SELECT ProductID
	,SUM(Quantity) AS total_Quantity
FROM [Production].[ProductInventory]
where Shelf IN ('A','C','H') 
GROUP BY ProductID
having SUM(Quantity)> 500
ORDER BY ProductID

--SELECT->FROM->Where->GroupBy->Having->OrderBy

--Question:-10
/*FROM the following table write a query in SQL to find the total quentity for a group of locationid multiplied by 10.
*/

SELECT SUM(Quantity) AS Total_Quantity
FROM [Production].[ProductInventory]
GROUP BY LocationID*10

--Question:-11
/* FROM the following tables write a query in SQL to find the persons whose last name starts with letter 'L'. 
Return BusinessEntityID, FirstName, LastName, and PhoneNumber. Sort the result on lastname and firstname.
*/

SELECT pe.BusinessEntityID
	,pe.FirstName
	,pe.LastName
	,ph.PhoneNumber 
FROM [Person].[Person] pe
JOIN [Person].[PersonPhone] ph ON pe.BusinessEntityID=ph.BusinessEntityID
where LastName LIKE 'L%'
ORDER BY FirstName

--Question:-12--      (*****)
/* FROM the following table write a query in SQL to find the sum of subtotal column.
Group the sum on distinct salespersonid and customerid. Rolls up the results into subtotal and running total.
Return salespersonid, customerid and sum of subtotal column i.e. sum_subtotal.
*/

SELECT SalesPersonID
	,SUM(SubTotal) AS Sum_SubTotal
	,CustomerID
FROM [Sales].[SalesOrderHeader]
GROUP BY ROLLUP(SalesPersonID,CustomerID)		--ROLLUP (YOU-TUBE)--

--Question:13			(*****)
/* FROM the following table write a query in SQL to find the sum of the quantity of all combination of group of distinct locationid and shelf column.
Return locationid, shelf and sum of quantity as TotalQuantity.
*/

SELECT LocationID,Shelf,SUM(Quantity) AS TotalQuantity 
FROM [Production].[ProductInventory]
GROUP BY LocationID,Shelf					--CUBE

--Question:-14		(*****)
/*FROM the following table write a query in SQL to find the sum of the quantity with subtotal for each locationid.
Group the results for all combination of distinct locationid and shelf column. Rolls up the results into subtotal and running total. 
Return locationid, shelf and sum of quantity as TotalQuantity.
*/

SELECT LocationID,Shelf,SUM(Quantity) AS TotalQuantity
FROM [Production].[ProductInventory]
GROUP BY LocationID


--Question:15
/*FROM the following table write a query in SQL to find the total quantity for each locationid and calculate the grand-total for all locations. 
Return locationid and total quantity. Group the results on locationid.
*/

SELECT LocationID
	,SUM(Quantity) AS Sum_TotalQuantity
FROM [Production].[ProductInventory]
GROUP BY GROUPING SETS(LocationID,())		--Show Grand Toatl Value At Bottom.--

---Using "Grouping Set"----

--Question:16
/*FROM the following table write a query in SQL to retrieve the number of employees for each City. 
Return city and number of employees. Sort the result in ascending order on city.
*/

SELECT a.City,COUNT(a.AddressID) AS No_Of_Employee
FROM [Person].[BusinessEntityAddress] b
JOIN [Person].[Address] a ON b.AddressID=a.AddressID
GROUP BY a.City
ORDER BY a.City

--Question:-17
/*FROM the following table write a query in SQL to retrieve the total sales for each year. Return the year part of order date and total due amount.
Sort the result in ascending order on year part of order date.
*/

SELECT YEAR(OrderDate) AS Year,SUM(TotalDue) AS Order_Amount
FROM [Sales].[SalesOrderHeader]
GROUP BY YEAR(OrderDate)
ORDER BY YEAR(OrderDate)

--Question:18
/* FROM the following table write a query in SQL to retrieve the total sales for each year.
Filter the result set for those orders where order year is on or before 2016. Return the year part of orderdate and total due amount. 
Sort the result in ascending order on year part of order date.
*/

SELECT YEAR(OrderDate) AS Year,SUM(TotalDue) AS Order_Amount
FROM [Sales].[SalesOrderHeader]
GROUP BY YEAR(OrderDate)
having YEAR(OrderDate) <= 2016
ORDER BY YEAR(OrderDate)

--Question:19
/*FROM the following table write a query in SQL to find the contacts who are designated as a manager in various departments.
Returns ContactTypeID, name. Sort the result set in descending order.
*/

SELECT *
FROM [Person].[ContactType]
where Name LIKE '%Manager'
ORDER BY ContactTypeID DESC

--Question:20
/*FROM the following tables write a query in SQL to make a list of contacts who are designated as 'Purchasing Manager'.
Return BusinessEntityID, LastName, and FirstName columns.
Sort the result set in ascending order of LastName, and FirstName.
*/
SELECT * FROM [Person].[Person]
SELECT * FROM [Person].[ContactType]
SELECT * FROM [Person].[BusinessEntityContact]

SELECT p.BusinessEntityID,p.FirstName,p.LastName,ct.Name
FROM  [Person].[BusinessEntityContact] bc
JOIN [Person].[ContactType] ct ON ct.ContactTypeID=bc.ContactTypeID
JOIN [Person].[Person] p  ON p.BusinessEntityID=bc.PersonID
where Name like 'Purchasing Manager'
 
--Question:21
/* FROM the following tables write a query in SQL to retrieve the salesperson for each PostalCode who belongs to a territory and SalesYTD is not zero. 
Return row numbers of each group of PostalCode, last name, salesytd, postalcode column.
Sort the salesytd of each postalcode group in descending order. Shorts the postalcode in ascending order.
*/

SELECT * FROM [Person].[Person]
SELECT * FROM [Sales].[SalesPerson]
SELECT * FROM [Person].[Address]

SELECT ROW_NUMBER() OVER(ORDER BY LastName) AS Row_Number,p.LastName,sp.SalesYTD,a.PostalCode   --ROW_NUMBER() for give Index number--
FROM [Sales].[SalesPerson] sp
join [Person].[Person] p ON sp.BusinessEntityID=p.BusinessEntityID
join [Person].[Address] a ON a.AddressID=p.BusinessEntityID
where sp.TerritoryID IS NOT NULL AND SalesYTD <> 0
ORDER BY PostalCode;

--Question:-22
/*FROM the following table write a query in SQL to count the number of contacts for combination of each type and name.
Filter the output for those who have 100 or more contacts.
Return ContactTypeID and ContactTypeName and BusinessEntityContact. 
Sort the result set in descending order on number of contacts.
*/

SELECT * FROM [Person].[BusinessEntityContact]
SELECT * FROM [Person].[ContactType]

SELECT ct.Name,ct.ContactTypeID,COUNT(*) AS Number_Of_Contact
FROM [Person].[BusinessEntityContact] bec
JOIN [Person].[ContactType] ct ON bec.ContactTypeID=ct.ContactTypeID
GROUP BY ct.Name,ct.ContactTypeID
HAVING COUNT(*) >= 100

--Question:23
/*FROM the following table write a query in SQL to retrieve
the RateChangeDate, full name (first name, middle name and last name) and weekly salary (40 hours in a week) of employees.
In the output the RateChangeDate should appears in date format. Sort the output in ascending order on NameInFull.
*/

SELECT * FROM HumanResources.EmployeePayHistory
SELECT * FROM Person.Person

SELECT   CONVERT(date,eh.RateChangeDate) AS FROM_Date
		,CONCAT(p.FirstName,',',p.MiddleName,'.',p.LastName) As Full_Name
		,(40 * eh.Rate) AS Weekly_Salary
FROM Person.Person p
join HumanResources.EmployeePayHistory eh ON p.BusinessEntityID=eh.BusinessEntityID
ORDER BY Full_Name

--Question:-25		(*****)
/* FROM the following table write a query in SQL
to find the sum, average, count, minimum, and maximum order quentity for those orders whose id are 43659 and 43664. 
Return SalesOrderID, ProductID, OrderQty, sum, average, count, max, and min order quantity.
*/

SELECT SalesOrderID
		,ProductID
		,OrderQty
		,COUNT(OrderQty)
		,SUM(OrderQty) AS Total_Quantity
		,MIN(OrderQty) AS Min_Qauntity
		,MAX(OrderQty) AS Max_Quantity
		,AVG(OrderQty) AS Avg_Qauntity
FROM Sales.SalesOrderDetail
GROUP BY SalesOrderID
having  SalesOrderID=43659


SELECT SalesOrderID, ProductID, OrderQty
    ,SUM(OrderQty) OVER win AS "Total Quantity"
    ,AVG(OrderQty) OVER win AS "Avg Quantity"
    ,COUNT(OrderQty) OVER win AS "No of Orders"
    ,MIN(OrderQty) OVER win AS "Min Quantity"
    ,MAX(OrderQty) OVER win AS "Max Quantity"
FROM Sales.SalesOrderDetail
WHERE SalesOrderID IN(43659,43664)
WINDOW win AS (PARTITION BY SalesOrderID);

--Question:26
/* FROM the following table write a query in SQL 
to find the sum, average, and number of order quantity for those orders whose ids are 43659 and 43664 and product id starting with '71'.
Return SalesOrderID, OrderNumber,ProductID, OrderQty, sum, average, and number of order quantity.
*/

SELECT SalesOrderID
		,ProductID
		,OrderQty
		--,COUNT(OrderQty)
		--,SUM(OrderQty) AS Total_Quantity
		--,MIN(OrderQty) AS Min_Qauntity
		--,MAX(OrderQty) AS Max_Quantity
		--,AVG(OrderQty) AS Avg_Qauntity
FROM Sales.SalesOrderDetail
where ProductID  LIKE '71%'
GROUP BY SalesOrderID,ProductID

--Question:27
/* FROM the following table write a query in SQL to retrieve the total cost of each salesorderID that exceeds 100000.
Return SalesOrderID, total cost.
*/

SELECT SalesOrderID
	   ,SUM(LineTotal) AS Toatl_Cost
FROM Sales.SalesOrderDetail
GROUP BY SalesOrderID
having SUM(LineTotal) > 10000

--Question:28
/*FROM the following table write a query in SQL to retrieve products whose names start with 'Lock Washer'.
Return product ID, and name and order the result set in ascending order on product ID column.
*/

SELECT ProductID	
		,Name
FROM Production.Product
where Name LIKE 'Lock Washer%'

--Question:29
/* Write a query in SQL to fetch rows FROM product table and order the result set on an unspecified column listprice.
Return product ID, name, and color of the product.
*/

SELECT ProductID
		,Name
		,Color
FROM Production.Product
ORDER BY ListPrice

--Question:30
/*FROM the following table write a query in SQL to retrieve records of employees.
Order the output on year (default ascending order) of hiredate. Return BusinessEntityID, JobTitle, and HireDate.
*/

SELECT BusinessEntityID
	,JobTitle
	,HireDate 
FROM HumanResources.Employee
ORDER BY YEAR(HireDate)

--Question:31
/*FROM the following table write a query in SQL to retrieve those persons whose last name begins with letter 'R'. 
Return lastname, and firstname and display the result in ascending order on firstname and descending order on lastname columns.
*/

SELECT LastName
	,FirstName
FROM Person.Person
where LastName LIKE 'R%'
ORDER BY FirstName ,LastName DESC

--Question:-32
/*FROM the following table write a query in SQL 
to ordered the BusinessEntityID column descendingly when SalariedFlag set to 'true' and BusinessEntityID in ascending order when SalariedFlag set to 'false'.
Return BusinessEntityID, SalariedFlag columns.
*/

SELECT BusinessEntityID,SalariedFlag 
FROM HumanResources.Employee
ORDER BY  CASE when SalariedFlag='TRUE' Then BusinessEntityID END desc 
		 ,CASE when SalariedFlag ='FALSE' then BusinessEntityID END

--Question:33
/* FROM the following table write a query in SQL
to set the result in ORDER BY the column TerritoryName 
when the column CountryRegionName is equal to 'United States' and by CountryRegionName for all other rows.
*/

SELECT BusinessEntityID,LastName,TerritoryName,CountryRegionName 
FROM Sales.vSalesPerson
ORDER BY CASE WHEN CountryRegionName='United States' THEN TerritoryName 
		 ELSE CountryRegionName END

--Question:34
/*FROM the following table write a query in SQL
to find those persons who lives in a territory and the value of salesytd except 0.
Return first name, last name,row number as 'Row Number', 'Rank', 'Dense Rank' and NTILE as 'Quartile', salesytd and postalcode. 
Order the output on postalcode column.
*/

SELECT * FROM Person.Person
SELECT * FROM Person.Address
SELECT * FROM Sales.SalesPerson

SELECT p.FirstName
	,p.LastName,ROW_NUMBER() OVER(ORDER BY pa.PostalCode) AS Row_Nuber
	,sp.SalesYTD
	,pa.PostalCode
FROM Person.Person p
JOIN  Person.Address pa ON p.BusinessEntityID=pa.AddressID
JOIN Sales.SalesPerson sp ON sp.BusinessEntityID=p.BusinessEntityID
where TerritoryID IS NOT NULL AND SalesYTD <> 0;

--Question:35
/*35. FROM the following table write a query in SQL
to skip the first 10 rows FROM the sorted result set and return all remaining rows.
*/

SELECT * 
FROM HumanResources.Department
ORDER BY DepartmentID OFFSET 10 ROWS;

--Question:36
/*FROM the following table write a query in SQL
to skip the first 5 rows and return the next 5 rows FROM the sorted result set.
*/

SELECT * 
FROM HumanResources.Department
ORDER BY DepartmentID OFFSET 5 ROWS
FETCH NEXT 5 ROWS ONLY;

--Question:37
/* FROM the following table write a query in SQL to list all the products that are Red or Blue in color. 
Return name, color and listprice.Sorts this result by the column listprice.
*/

SELECT Name
	,Color
	,ListPrice
FROM Production.Product
where Color='Red' OR Color='Blue'
ORDER BY ListPrice

--Question:38
/* Create a SQL query FROM the SalesOrderDetail table to
retrieve the product name and any associated sales orders.
Additionally, it returns any sales orders that don't have any items mentioned in the Product table
as well as any products that have sales orders other than those that are listed there. 
Return product name, salesorderid. Sort the result set on product name column.
*/

SELECT * FROM Production.Product
SELECT * FROM Sales.SalesOrderDetail

SELECT p.Name
	,sd.SalesOrderID 
FROM Production.Product p
FULL OUTER JOIN  Sales.SalesOrderDetail sd ON p.ProductID=sd.ProductID
ORDER BY p.Name

--Question:39
/*FROM the following table write a SQL query to retrieve the product name and salesorderid. 
Both ordered and unordered products are included in the result set.
*/

SELECT p.Name
	,sd.SalesOrderID 
FROM Production.Product p
LEFT OUTER JOIN  Sales.SalesOrderDetail sd ON p.ProductID=sd.ProductID
ORDER BY p.Name

--Question:40
/* FROM the following tables write a SQL query to get all product names and sales order IDs.
Order the result set on product name column.
*/

SELECT p.Name
	,sd.SalesOrderID 
FROM Production.Product p
INNER JOIN  Sales.SalesOrderDetail sd ON p.ProductID=sd.ProductID
ORDER BY p.Name

--Question:41
/*FROM the following tables write a SQL query to retrieve the territory name and BusinessEntityID.
The result set includes all salespeople, regardless of whether or not they are assigned a territory.
*/

SELECT * FROM Sales.SalesTerritory
SELECT * FROM Sales.SalesPerson

SELECT st.Name
	,sp.BusinessEntityID 
FROM Sales.SalesPerson sp
LEFT JOIN Sales.SalesTerritory st ON st.TerritoryID=sp.TerritoryID

--Question:42 (*****Half Question Panding,Why Use SUBQUERY*****)
/* Write a query in SQL to find the employee's full name (firstname and lastname) and city FROM the following tables.
Order the result set on lastname then by firstname.
*/

SELECT * FROM Person.Person
SELECT * FROM HumanResources.Employee
SELECT * FROM Person.Address
SELECT * FROM Person.BusinessEntityAddress

SELECT CONCAT(p.FirstName,' ',p.LastName) AS Full_Name
	,a.City
FROM Person.Person p
JOIN Person.Address a ON p.BusinessEntityID=a.AddressID
ORDER BY p.FirstName,p.LastName

--Question:43 (*****Panding DERIVED TABLE*****)
/*Write a SQL query to return the businessentityid,firstname and lastname columns of all persons in the person table (derived table)
with persontype is 'IN' and the last name is 'Adams'.
Sort the result set in ascending order on firstname. 
A SELECT statement after the FROM clause is a derived table.
*/

SELECT BusinessEntityID
	,FirstName
	,LastName
	,PersonType 
FROM Person.Person
where PersonType LIKE 'IN%' and LastName LIKE 'Adams%'

--Question:44
/* Create a SQL query to retrieve individuals FROM 
the following table with a businessentityid inside 1500, a lastname starting with 'Al', and a firstname starting with 'M'.
*/

SELECT BusinessEntityID
	,FirstName
	,LastName
FROM  Person.Person
where LastName LIKE 'Al%' 
	AND FirstName LIKE 'M%' 
	AND BusinessEntityID < 1500
ORDER BY BusinessEntityID

--Question:45 (***** DERIVED TABLE CONCEPT)
/*Write a SQL query to find the productid, name, and colour of the items 'Blade', 'Crown Race' and 'AWC Logo Cap' using a derived table with multiple values.
*/

SELECT ProductID
	,Name
	,Color
FROM Production.Product AS DerivedProduct
where DerivedProduct.Name LIKE'Balde'

--Question:46
/*Create a SQL query to display the total number of sales orders each sales representative receives annually.
Sort the result set by SalesPersonID and then by the date component of the orderdate in ascending order.
Return the year component of the OrderDate, SalesPersonID, and SalesOrderID.
*/

SELECT YEAR(OrderDate) SalesYear
	,SalesPersonID
	,COUNT(SalesOrderID) AS Toatal_Order
FROM Sales.SalesOrderHeader
GROUP BY YEAR(OrderDate) ,SalesPersonID
having SalesPersonID IS NOT NULL
ORDER BY SalesPersonID,SalesYear

--Question:47
/*FROM the following table write a query in SQL
to find the average number of sales orders for all the years of the sales representatives.
*/
SELECT AVG(No_Of_Order) AS Avg_Number_Of_Sales
	FROM(	SELECT	SalesPersonID
					,COUNT(*) AS No_Of_Order
			FROM Sales.SalesOrderHeader 
			where SalesPersonID IS NOT NULL
			GROUP BY SalesPersonID
		)AVG_TABLE

--Question:48
/*Write a SQL query on the following table to retrieve records with the characters green_ in the LargePhotoFileName field.
The following table's columns must all be returned.
*/

SELECT * 
FROM Production.ProductPhoto
where LargePhotoFileName LIKE '%green_%'		--%_% For starting value is UNKNOWN--

--Question:49
/*Write a SQL query to retrieve 
the mailing address for any company that is outside the United States (US) and in a city whose name starts with Pa. 
Return Addressline1, Addressline2, city, postalcode, countryregioncode columns.
*/

SELECT * FROM Person.Address
SELECT * FROM Person.StateProvince

SELECT a.AddressLine1
	,a.AddressLine2
	,a.City
	,a.PostalCode
	,sp.CountryRegionCode
FROM Person.Address a
JOIN Person.StateProvince sp ON a.StateProvinceID=sp.StateProvinceID
where CountryRegionCode <> 'US' AND a.City LIKE 'pa%'

--Question:50
/*FROM the following table write a query in SQL to fetch first twenty rows. Return jobtitle, hiredate.
Order the result set on hiredate column in descending order.
*/

SELECT JobTitle
	,HireDate
FROM HumanResources.Employee
ORDER BY HireDate DESC
OFFSET 0 ROWS
FETCH NEXT 20 ROWS ONLY		

--Question:51
/*FROM the following tables write a SQL query to retrieve
the orders with orderqtys greater than 5 or unitpricediscount less than 1000, and totaldues greater than 100.
Return all the columns FROM the tables.
*/

SELECT * FROM Sales.SalesOrderHeader
SELECT * FROM Sales.SalesOrderDetail

SELECT * 
FROM Sales.SalesOrderHeader so
JOIN Sales.SalesOrderDetail sd ON so.SalesOrderID=sd.SalesOrderID
WHERE so.TotalDue > 100 
	  AND (sd.OrderQty > 5 OR sd.UnitPriceDiscount < 1000)  

--Question:52
/*FROM the following table write a query in SQL that searches for the word 'red' in the name column.
Return name, and color columns FROM the table.
*/

SELECT Name
	,Color 
FROM Production.Product
where name like '%Red%'

--Question:53
/* FROM the following table write a query in SQL to find all the products with a price of $80.99 that contain the word Mountain.
Return name, and listprice columns FROM the table.
*/

SELECT Name,ListPrice
FROM Production.Product
where Name like '%Mountain%' AND ListPrice=80.99
--Solution is not match but answer is getting.


--Question:54
/*FROM the following table write a query in SQL to retrieve all the products that contain either the phrase Mountain or Road. 
Return name, and color columns.
*/

SELECT Name,Color
FROM Production.Product
where Name LIKE '%Mountain%' OR Name LIKE '%Road%'

--Question:55
/*FROM the following table write a query in SQL to search for name which contains both the word 'Mountain' and the word 'Black'. 
Return Name and color.
*/

SELECT Name,Color
FROM Production.Product
where Name LIKE '%Mountain%' AND Name LIKE '%Black%'

/*
SELECT Name,color  
FROM Production.Product  
WHERE to_tsvector(name) @@ to_tsquery('Mountain & Black');
*/

--Question:56
/* FROM the following table write a query in SQL to return 
all the product names with at least one word starting with the prefix chain in the Name column.
*/

SELECT Name,Color
FROM Production.Product
where Name LIKE 'chain %' 

--Question:57
/*FROM the following table write a query in SQL to return
all category descriptions containing strings with prefixes of either chain or full.
*/

SELECT Name,Color
FROM Production.Product
where Name LIKE 'chain %' OR Name LIKE 'full%'


--Question:58
/* FROM the following table write a SQL query to output an employee's name and email address, separated by a new line character.
*/

SELECT CONCAT(p.FirstName,' ',p.LastName,' ',e.EmailAddress) 
FROM Person.Person p
JOIN Person.EmailAddress e ON p.BusinessEntityID=e.BusinessEntityID

--Question:59
/*FROM the following table write a SQL query to locate the position of the string "yellow" where it appears in the product name.
*/

SELECT Name,CHARINDEX('Yellow',name) AS Match_Postion
FROM Production.Product
where Name like '%Yellow%'

--Question:60
/*FROM the following table write a query in SQL to concatenate the name, color, and productnumber columns.
*/

SELECT CONCAT(Name,' ','Color:-' ,Color,' ','Product Number:-',ProductNumber)
FROM Production.Product

--Question:61
/*Write a SQL query that concatenate the columns name, productnumber, colour, and a new line character 
FROM the following table, each separated by a specified character.
*/

SELECT CONCAT(Name,'@',ProductNumber,'@',Color) AS DatabaseInfo
FROM production.product 

--Question:62
/*FROM the following table write a query in SQL to return the five leftmost characters of each product name.
*/

SELECT SUBSTRING(Name,0,4) AS Left_5_Char
FROM production.product 

--Question:63
/*FROM the following table write a query in SQL to
SELECT the number of characters and the data in FirstName for people located in Australia.
*/

SELECT LEN(FirstName)AS String_Lenght,FirstName,CountryRegionName
FROM Sales.vIndividualCustomer
where CountryRegionName='Australia'

--Question:64
/*FROM the following tables write a query in SQL
to return the number of characters in the column FirstName and the first and last name of contacts located in Australia.
*/

SELECT LEN(FirstName)AS String_Lenght,LastName,sa.CountryRegionName
FROM Sales.vStoreWithContacts sc
JOIN Sales.vStoreWithAddresses sa  ON sc.BusinessEntityID=sa.BusinessEntityID
where CountryRegionName='Australia'

--Question:65
/* FROM the following table write a query in SQL to SELECT product names that have prices between $1000.00 and $1220.00.
Return product name as Lower, Upper, and also LowerUpper.
*/

SELECT UPPER(Name),LOWER(Name),StandardCost
FROM Production.Product
where StandardCost between 1000 and 1220

--Question:66
/*Write a query in SQL to remove the spaces FROM the beginning of a string.
*/
SELECT '   five    space   then   the   text  'AS With_Space,TRIM('   five space then the text')AS Without_Space\

--Question:67
/*FROM the following table write a query in SQL to remove the substring 'HN' FROM the start of the column productnumber.
Filter the results to only show those productnumbers that start with "HN". 
Return original productnumber column and 'TrimmedProductnumber'.
*/

SELECT ProductNumber,SUBSTRING(ProductNumber,3,6) AS Trim_Product_Name
FROM Production.Product
where ProductNumber LIKE 'HN%'

--Question:68
/* FROM the following table write a query in SQL 
to repeat a 0 character four times in front of a production line for production line 'T'.
*/

SELECT Name,CONCAT('0000',ProductLine)
FROM Production.Product
where ProductLine='T'

--Question:69
/*FROM the following table write a SQL query to retrieve all contact first names with the characters inverted for people whose businessentityid is less than 6.
*/

SELECT FirstName,REVERSE(FirstName) AS Reverse_Name
FROM Person.Person
where LEN(FirstName) < 6

--Question:70
/* FROM the following table write a query in SQL to return the eight rightmost characters of each name of the product.
Also return name, productnumber column. Sort the result set in ascending order on productnumber.
*/

SELECT Name,ProductNumber,RIGHT(Name,8) As Right_8_Char
FROM Production.Product
ORDER BY ProductNumber 

--Question:71(*****)
/* Write a query in SQL to remove the spaces at the end of a string.
*/

SELECT 'text then five spaces     after space' AS OriginalText,TRIM('text then five spaces     after space')

--Question:72
/*FROM the following table write a query in SQL to fetch the rows for the product name ends with the letter 'S' or 'M' or 'L'. 
Return productnumber and name.
*/

SELECT ProductNumber,Name
FROM Production.Product
where RIGHT(Name,1) in ('S','M','L')


--Question:73 (*****)
/*FROM the following table write a query in SQL to replace null values with 'N/A' and return the names separated by commas in a single row.
*/

SELECT * 
FROM Person.Person

--Question:74 (*****)
/* FROM the following table write a query in SQL to return the names and modified date separated by commas in a single row.
*/

SELECT STRING_AGG(CONCAT(FirstName,' ',LastName,' ','(',ModifiedDate,')',','),' ')
FROM Person.Person

--SELECT STRING_AGG(CONCAT(FirstName, ' ', LastName, ' (', ModifiedDate, ')'),', ') 
--AS test FROM Person.Person;


--Question:75
/*FROM the following table write a query in SQL to find the email addresses of employees and groups them by city. 
Return top ten rows.
*/

SELECT * FROM Person.BusinessEntityAddress
SELECT * FROM Person.Address
SELECT * FROM Person.EmailAddress


SELECT City,STRING_AGG(CONVERT(nvarchar(max),CONCAT(EmailAddress,' ')),CHAR(13))
FROM Person.BusinessEntityAddress ba 
join Person.Address a ON ba.BusinessEntityID=a.AddressID
join Person.EmailAddress  ea On ea.BusinessEntityID=ba.BusinessEntityID
GROUP BY City

--Question:76
/*FROM the following table write a query in SQL to 
create a new job title called "Production Assistant" in place of "Production Supervisor".
*/

--Question:77
/*FROM the following table write a SQL query to retrieve all the employees whose job titles begin with "Sales".
Return firstname, middlename, lastname and jobtitle column.
*/

SELECT * FROM Person.Person
SELECT * FROM HumanResources.Employee

SELECT p.FirstName,p.MiddleName,p.LastName,e.JobTitle 
FROM Person.Person p
JOIN HumanResources.Employee e ON p.BusinessEntityID=e.BusinessEntityID
where e.JobTitle LIKE 'Sales%'


--Question:78
/*FROM the following table write a query in SQL to return
the last name of people so that it is in uppercase, trimmed, and concatenated with the first name.
*/

SELECT CONCAT(UPPER(TRIM(LastName)),',',FirstName) FROM Person.Person

--Question:79(*****)
/*FROM the following table write a query in SQL to show a resulting expression that is too small to display.
Return FirstName, LastName, Title, and SickLeaveHours. 
The SickLeaveHours will be shown as a small expression in text format.
*/

SELECT * FROM Person.Person
SELECT * FROM HumanResources.Employee

SELECT p.FirstName
	,p.LastName
	,p.Title
	,CAST(e.SickLeaveHours AS char(1)) AS "Sick Leave"
FROM Person.Person p
JOIN HumanResources.Employee e ON p.BusinessEntityID=e.BusinessEntityID

--Question:80
/*FROM the following table write a query in SQL to 
retrieve the name of the products. Product, that have 33 as the first two digits of listprice.
*/

SELECT Name,ListPrice FROM Production.Product
where ListPrice LIKE '33%'

--Question:81
/*FROM the following table write a query in SQL to 
calculate by dividing the total year-to-date sales (SalesYTD) by the commission percentage (CommissionPCT).
Return SalesYTD, CommissionPCT, and the value rounded to the nearest whole number.
*/

SELECT SalesYTD,CommissionPct
	,CAST(ROUND(SalesYTD/CommissionPct,0) AS int) AS Value
FROM Sales.SalesPerson
where CommissionPct!=0

--Question:82
/* FROM the following table write a query in SQL to find those persons that have a 2 in the first digit of their SalesYTD.
Convert the SalesYTD column to an int type, and then to a char(20) type.
Return FirstName, LastName, SalesYTD, and BusinessEntityID.
*/

SELECT p.FirstName
	,p.LastName
	,sp.SalesYTD
	,p.BusinessEntityID
FROM Person.Person p
JOIN Sales.SalesPerson sp ON p.BusinessEntityID=sp.BusinessEntityID
Where CAST(CAST(sp.SalesYTD As INT) AS char(20)) LIKE '2%'

--Question:83
/*FROM the following table write a query in SQL to convert the Name column to a char(16) column.
Convert those rows if the name starts with 'Long-Sleeve Logo Jersey'. Return name of the product and listprice.
*/

SELECT CAST(Name As char(16)) AS Name
	,ListPrice
FROM Production.Product
where Name LIKE 'Long-Sleeve Logo Jersey%'


--Question:84
/*
FROM the following table write a SQL query to determine the discount price for the salesorderid 46672.
Calculate only those orders with discounts of more than.02 percent. 
Return productid, UnitPrice, UnitPriceDiscount, and DiscountPrice (UnitPrice*UnitPriceDiscount ).
*/

SELECT ProductID
	,UnitPrice
	,UnitPriceDiscount
	,UnitPrice*UnitPriceDiscount AS DiscountPrice
FROM Sales.SalesOrderDetail
where SalesOrderID='46672' AND UnitPriceDiscount > .02

--Question:85
/*
FROM the following table write a query in SQL to calculate the average vacation hours,
and the sum of sick leave hours, that the vice presidents have used.
*/

SELECT AVG(VacationHours) AS Avg_Vaction_Hours
	,SUM(SickLeaveHours) AS Total_Sick_leave_Hours
FROM HumanResources.Employee
where JobTitle LIKE 'Vice President%'

--Question:86
/*
FROM the following table write a query in SQL to calculate the average bonus received and the sum of year-to-date sales for each territory. 
Return territoryid, Average bonus, and YTD sales.
*/

SELECT TerritoryID
	,AVG(Bonus) As AVg_Bonus
	,SUM(SalesYTD) AS Sum_of_Sales
FROM Sales.SalesPerson
GROUP BY terr


--Question:87
/*
 FROM the following table write a query in SQL to return the average list price of products.
 Consider the calculation only on unique values.
*/

SELECT ROUND(AVG(ListPrice),3) AS Avg_List_price
FROM Production.Product

--Question:88
/*
From the following table write a query in SQL to return a moving average of yearly sales for each territory.
Return BusinessEntityID, TerritoryID, SalesYear, SalesYTD, average SalesYTD as MovingAvg, and total SalesYTD as CumulativeTotal.
*/

select BusinessEntityID
	,TerritoryID
	,YEAR(ModifiedDate) AS SalesYear  
	,SalesYTD
	,AVG(SalesYTD) OVER(partition by TerritoryID) AS MovingAvg  
from Sales.SalesPerson
--where TerritoryID IS NULL

--Question:90
/*
From the following table write a query in SQL to return the number of different titles that employees can hold.
*/

select COUNT(DISTINCT(JobTitle)) AS Number_of_Jobtitles
from HumanResources.Employee

--Question:91
/*
 From the following table write a query in SQL to return the number of different titles that employees can hold.
*/

select COUNT(*) AS Number_of_Employee
from HumanResources.Employee

--Question:92
/*
From the following table write a query in SQL to find the average bonus for the salespersons who achieved the sales quota above 25000. 
Return number of salespersons, and average bonus.
*/

select AVG(Bonus) AS AVG_Bonus 
	,COUNT(BusinessEntityID) AS count
from Sales.SalesPerson
where SalesQuota > 25000


--Question:93
/*
 From the following tables wirte a query in SQL to return aggregated values for each department.
 Return name, minimum salary, maximum salary, average salary, and number of employees in each department.
*/
select * from HumanResources.Department
select * from HumanResources.EmployeePayHistory
select * from HumanResources.EmployeeDepartmentHistory

select d.Name
	,d.DepartmentID
	,MIN(ep.Rate) AS Min_Salary
	,MAX(ep.Rate) AS Max_Salary
	,avg(ep.Rate) AS avg_Salary 
	,COUNT(ep.BusinessEntityID) AS Number_of_employee
from HumanResources.Department d
JOIN HumanResources.EmployeeDepartmentHistory ed ON ed.DepartmentID=ed.DepartmentID 
JOIN HumanResources.EmployeePayHistory ep ON ep.BusinessEntityID= ed.BusinessEntityID
group by d.DepartmentID,d.Name


--Question:94
/*
From the following tables write a SQL query to return the departments of a company that each have more than 15 employees.
*/

select JobTitle
	,COUNT(BusinessEntityID) AS No_of_Employee
from HumanResources.Employee
group by JobTitle
HAVING COUNT(BusinessEntityID) > 15

--Question:95
/*
From the following table write a query in SQL to find the number of products that ordered in each of the specified sales orders.
*/

select SalesOrderID
	,COUNT(ProductID) AS productcount
from  Sales.SalesOrderDetail
group by SalesOrderID
--having SalesOrderID='43661'

--Question:96
/*
From the following table write a query in SQL to compute the 
statistical variance of the sales quota values for each quarter in a calendar year for a sales person. 
Return year, quarter, salesquota and variance of salesquota.
*/

select QuotaDate AS Year
	,DATEPART(QUARTER,QuotaDate) Quarter_
	,SalesQuota AS SalesQuota 
	,var(SalesQuota) OVER(order by DATEPART(QUARTER,QuotaDate)) AS Variance
from  sales.salespersonquotahistory
--where  BusinessEntityID=2 and DATEPART(QUARTER,QuotaDate)=2012
order by Quarter_ 

--Question:97
/*
From the following table write a query in SQL to populate the variance of all unique values as well as all values,
including any duplicates values of SalesQuota column.
*/
