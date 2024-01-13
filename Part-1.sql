--PART - 1 W3-RESOURCE
--Question:-1 

select * 
from [HumanResources].[Employee]
order by JobTitle

--Question:-2 
select p.*
from [Person].[Person] AS p --Using Alias Concept-- 

--Question:-3
select p.FirstName,p.LastName,p.BusinessEntityID Employee_Id	--Using Alias Concept-- 
from [Person].[Person] AS p
order by p.LastName --DESC

--Question:- 4
/* From the following table write a query in SQL to return 
only the rows for product that have a sellstartdate that is not NULL and a productline of 'T'.
Return productid, productnumber, and name. Arranged the output in ascending order on name.*/

select ProductID,ProductNumber,Name --ProductLine,SellStartDate 
from [Production].[Product]
where ProductLine='T' AND SellStartDate IS NOT NULL		--Carefully Read Question

--Question:- 5
/*From the following table write a query in SQL to return all rows from the salesorderheader table in Adventureworks database and 
calculate the percentage of tax on the subtotal have decided.
Return salesorderid, customerid, orderdate, subtotal, percentage of tax column.Arranged the result set in ascending order on subtotal.
*/
select SalesOrderID,CustomerID,OrderDate,SubTotal,(TaxAmt*100)/SubTotal AS Tex_Percentage --,TaxAmt --Formumla
from Sales.SalesOrderHeader

--Question:-6
/*
From the following table write a query in SQL to create a list of --unique jobtitles-- in the employee table in Adventureworks database. 
Return jobtitle column and arranged the resultset in ascending order
*/

select DISTINCT(JobTitle)				--Using DISTINCT Function
from [HumanResources].[Employee]
order by JobTitle 

--Question:-7
/*From the following table write a query in SQL to calculate the total freight paid by each customer.
Return customerid and total freight. Sort the output in ascending order on customerid.
*/

select CustomerID,SUM(Freight) AS Total_Freight_Paid   --Using SUN() --Must Alis to the calculated Field.
from [Sales].[SalesOrderHeader]
group by CustomerID
order by CustomerID 

--Question:-8
/*From the following table write a query in SQL to find the average and the sum of the subtotal for every customer. 
Return customerid, average and sum of the subtotal. 
Grouped the result on customerid and salespersonid. Sort the result on customerid column in descending order.
*/

select CustomerID,SalesPersonID
	,SUM(SubTotal) AS Sub_Total
	,AVG(SubTotal) AS Avg_SubTotal
from [Sales].[SalesOrderHeader]
group by CustomerID,SalesPersonID
order by CustomerID

--Question:-9
/*From the following table write a query in SQL to retrieve total quantity of each productid which are in shelf of 'A' or 'C' or 'H'.
Filter the results for sum quantity is more than 500. Return productid and sum of the quantity. 
Sort the results according to the productid in ascending order.
*/

select ProductID
	,SUM(Quantity) AS total_Quantity
from [Production].[ProductInventory]
where Shelf IN ('A','C','H') 
group by ProductID
having SUM(Quantity)> 500
order by ProductID

--Select->From->Where->GroupBy->Having->OrderBy

--Question:-10
/*From the following table write a query in SQL to find the total quentity for a group of locationid multiplied by 10.
*/

select SUM(Quantity) AS Total_Quantity
from [Production].[ProductInventory]
group by LocationID*10

--Question:-11
/* From the following tables write a query in SQL to find the persons whose last name starts with letter 'L'. 
Return BusinessEntityID, FirstName, LastName, and PhoneNumber. Sort the result on lastname and firstname.
*/

select pe.BusinessEntityID
	,pe.FirstName
	,pe.LastName
	,ph.PhoneNumber 
from [Person].[Person] pe
JOIN [Person].[PersonPhone] ph ON pe.BusinessEntityID=ph.BusinessEntityID
where LastName LIKE 'L%'
order by FirstName

--Question:-12--      (*****)
/* From the following table write a query in SQL to find the sum of subtotal column.
Group the sum on distinct salespersonid and customerid. Rolls up the results into subtotal and running total.
Return salespersonid, customerid and sum of subtotal column i.e. sum_subtotal.
*/

select SalesPersonID
	,SUM(SubTotal) AS Sum_SubTotal
	,CustomerID
from [Sales].[SalesOrderHeader]
group by ROLLUP(SalesPersonID,CustomerID)		--ROLLUP (YOU-TUBE)--

--Question:13			(*****)
/* From the following table write a query in SQL to find the sum of the quantity of all combination of group of distinct locationid and shelf column.
Return locationid, shelf and sum of quantity as TotalQuantity.
*/

select LocationID,Shelf,SUM(Quantity) AS TotalQuantity 
from [Production].[ProductInventory]
group by LocationID,Shelf					--CUBE

--Question:-14		(*****)
/*From the following table write a query in SQL to find the sum of the quantity with subtotal for each locationid.
Group the results for all combination of distinct locationid and shelf column. Rolls up the results into subtotal and running total. 
Return locationid, shelf and sum of quantity as TotalQuantity.
*/

select LocationID,Shelf,SUM(Quantity) AS TotalQuantity
from [Production].[ProductInventory]
group by LocationID


--Question:15
/*From the following table write a query in SQL to find the total quantity for each locationid and calculate the grand-total for all locations. 
Return locationid and total quantity. Group the results on locationid.
*/

select LocationID
	,SUM(Quantity) AS Sum_TotalQuantity
from [Production].[ProductInventory]
group by GROUPING SETS(LocationID,())		--Show Grand Toatl Value At Bottom.--

---Using "Grouping Set"----

--Question:16
/*From the following table write a query in SQL to retrieve the number of employees for each City. 
Return city and number of employees. Sort the result in ascending order on city.
*/

select a.City,COUNT(a.AddressID) AS No_Of_Employee
from [Person].[BusinessEntityAddress] b
JOIN [Person].[Address] a ON b.AddressID=a.AddressID
group by a.City
order by a.City

--Question:-17
/*From the following table write a query in SQL to retrieve the total sales for each year. Return the year part of order date and total due amount.
Sort the result in ascending order on year part of order date.
*/

select YEAR(OrderDate) AS Year,SUM(TotalDue) AS Order_Amount
from [Sales].[SalesOrderHeader]
group by YEAR(OrderDate)
order by YEAR(OrderDate)

--Question:18
/* From the following table write a query in SQL to retrieve the total sales for each year.
Filter the result set for those orders where order year is on or before 2016. Return the year part of orderdate and total due amount. 
Sort the result in ascending order on year part of order date.
*/

select YEAR(OrderDate) AS Year,SUM(TotalDue) AS Order_Amount
from [Sales].[SalesOrderHeader]
group by YEAR(OrderDate)
having YEAR(OrderDate) <= 2016
order by YEAR(OrderDate)

--Question:19
/*From the following table write a query in SQL to find the contacts who are designated as a manager in various departments.
Returns ContactTypeID, name. Sort the result set in descending order.
*/

select *
from [Person].[ContactType]
where Name LIKE '%Manager'
order by ContactTypeID DESC

--Question:20
/*From the following tables write a query in SQL to make a list of contacts who are designated as 'Purchasing Manager'.
Return BusinessEntityID, LastName, and FirstName columns.
Sort the result set in ascending order of LastName, and FirstName.
*/
select * from [Person].[Person]
select * from [Person].[ContactType]
select * from [Person].[BusinessEntityContact]

select p.BusinessEntityID,p.FirstName,p.LastName,ct.Name
from  [Person].[BusinessEntityContact] bc
JOIN [Person].[ContactType] ct ON ct.ContactTypeID=bc.ContactTypeID
JOIN [Person].[Person] p  ON p.BusinessEntityID=bc.PersonID
where Name like 'Purchasing Manager'
 
--Question:21
/* From the following tables write a query in SQL to retrieve the salesperson for each PostalCode who belongs to a territory and SalesYTD is not zero. 
Return row numbers of each group of PostalCode, last name, salesytd, postalcode column.
Sort the salesytd of each postalcode group in descending order. Shorts the postalcode in ascending order.
*/

select * from [Person].[Person]
select * from [Sales].[SalesPerson]
select * from [Person].[Address]

select ROW_NUMBER() OVER(ORDER BY LastName) AS Row_Number,p.LastName,sp.SalesYTD,a.PostalCode   --ROW_NUMBER() for give Index number--
from [Sales].[SalesPerson] sp
join [Person].[Person] p ON sp.BusinessEntityID=p.BusinessEntityID
join [Person].[Address] a ON a.AddressID=p.BusinessEntityID
where sp.TerritoryID IS NOT NULL AND SalesYTD <> 0
ORDER BY PostalCode;

--Question:-22
/*From the following table write a query in SQL to count the number of contacts for combination of each type and name.
Filter the output for those who have 100 or more contacts.
Return ContactTypeID and ContactTypeName and BusinessEntityContact. 
Sort the result set in descending order on number of contacts.
*/

select * from [Person].[BusinessEntityContact]
select * from [Person].[ContactType]

select ct.Name,ct.ContactTypeID,COUNT(*) AS Number_Of_Contact
from [Person].[BusinessEntityContact] bec
JOIN [Person].[ContactType] ct ON bec.ContactTypeID=ct.ContactTypeID
group by ct.Name,ct.ContactTypeID
HAVING COUNT(*) >= 100

--Question:23
/*From the following table write a query in SQL to retrieve
the RateChangeDate, full name (first name, middle name and last name) and weekly salary (40 hours in a week) of employees.
In the output the RateChangeDate should appears in date format. Sort the output in ascending order on NameInFull.
*/

select * from HumanResources.EmployeePayHistory
select * from Person.Person

select   CONVERT(date,eh.RateChangeDate) AS From_Date
		,CONCAT(p.FirstName,',',p.MiddleName,'.',p.LastName) As Full_Name
		,(40 * eh.Rate) AS Weekly_Salary
from Person.Person p
join HumanResources.EmployeePayHistory eh ON p.BusinessEntityID=eh.BusinessEntityID
ORDER BY Full_Name

--Question:-25		(*****)
/* From the following table write a query in SQL
to find the sum, average, count, minimum, and maximum order quentity for those orders whose id are 43659 and 43664. 
Return SalesOrderID, ProductID, OrderQty, sum, average, count, max, and min order quantity.
*/

Select SalesOrderID
		,ProductID
		,OrderQty
		,COUNT(OrderQty)
		,SUM(OrderQty) AS Total_Quantity
		,MIN(OrderQty) AS Min_Qauntity
		,MAX(OrderQty) AS Max_Quantity
		,AVG(OrderQty) AS Avg_Qauntity
from Sales.SalesOrderDetail
group by SalesOrderID
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
/* From the following table write a query in SQL 
to find the sum, average, and number of order quantity for those orders whose ids are 43659 and 43664 and product id starting with '71'.
Return SalesOrderID, OrderNumber,ProductID, OrderQty, sum, average, and number of order quantity.
*/

Select SalesOrderID
		,ProductID
		,OrderQty
		--,COUNT(OrderQty)
		--,SUM(OrderQty) AS Total_Quantity
		--,MIN(OrderQty) AS Min_Qauntity
		--,MAX(OrderQty) AS Max_Quantity
		--,AVG(OrderQty) AS Avg_Qauntity
from Sales.SalesOrderDetail
where ProductID  LIKE '71%'
group by SalesOrderID,ProductID

--Question:27
/* From the following table write a query in SQL to retrieve the total cost of each salesorderID that exceeds 100000.
Return SalesOrderID, total cost.
*/

select SalesOrderID
	   ,SUM(LineTotal) AS Toatl_Cost
from Sales.SalesOrderDetail
group by SalesOrderID
having SUM(LineTotal) > 10000

--Question:28
/*From the following table write a query in SQL to retrieve products whose names start with 'Lock Washer'.
Return product ID, and name and order the result set in ascending order on product ID column.
*/

select ProductID	
		,Name
from Production.Product
where Name LIKE 'Lock Washer%'

--Question:29
/* Write a query in SQL to fetch rows from product table and order the result set on an unspecified column listprice.
Return product ID, name, and color of the product.
*/

Select ProductID
		,Name
		,Color
from Production.Product
ORDER BY ListPrice

--Question:30
/*From the following table write a query in SQL to retrieve records of employees.
Order the output on year (default ascending order) of hiredate. Return BusinessEntityID, JobTitle, and HireDate.
*/

select BusinessEntityID
	,JobTitle
	,HireDate 
from HumanResources.Employee
order by YEAR(HireDate)

--Question:31
/*From the following table write a query in SQL to retrieve those persons whose last name begins with letter 'R'. 
Return lastname, and firstname and display the result in ascending order on firstname and descending order on lastname columns.
*/

select LastName
	,FirstName
from Person.Person
where LastName LIKE 'R%'
order by FirstName ,LastName DESC

--Question:-32
/*From the following table write a query in SQL 
to ordered the BusinessEntityID column descendingly when SalariedFlag set to 'true' and BusinessEntityID in ascending order when SalariedFlag set to 'false'.
Return BusinessEntityID, SalariedFlag columns.
*/

select BusinessEntityID,SalariedFlag 
from HumanResources.Employee
order by  CASE when SalariedFlag='TRUE' Then BusinessEntityID END desc 
		 ,CASE when SalariedFlag ='FALSE' then BusinessEntityID END

--Question:33
/* From the following table write a query in SQL
to set the result in order by the column TerritoryName 
when the column CountryRegionName is equal to 'United States' and by CountryRegionName for all other rows.
*/

select BusinessEntityID,LastName,TerritoryName,CountryRegionName 
from Sales.vSalesPerson
order by CASE WHEN CountryRegionName='United States' THEN TerritoryName 
		 ELSE CountryRegionName END

--Question:34
/*From the following table write a query in SQL
to find those persons who lives in a territory and the value of salesytd except 0.
Return first name, last name,row number as 'Row Number', 'Rank', 'Dense Rank' and NTILE as 'Quartile', salesytd and postalcode. 
Order the output on postalcode column.
*/

select * from Person.Person
select * from Person.Address
select * from Sales.SalesPerson

select p.FirstName
	,p.LastName,ROW_NUMBER() OVER(ORDER BY pa.PostalCode) AS Row_Nuber
	,sp.SalesYTD
	,pa.PostalCode
from Person.Person p
JOIN  Person.Address pa ON p.BusinessEntityID=pa.AddressID
JOIN Sales.SalesPerson sp ON sp.BusinessEntityID=p.BusinessEntityID
where TerritoryID IS NOT NULL AND SalesYTD <> 0;

--Question:35
/*35. From the following table write a query in SQL
to skip the first 10 rows from the sorted result set and return all remaining rows.
*/

select * 
FROM HumanResources.Department
ORDER BY DepartmentID OFFSET 10 ROWS;

--Question:36
/*From the following table write a query in SQL
to skip the first 5 rows and return the next 5 rows from the sorted result set.
*/

select * 
FROM HumanResources.Department
ORDER BY DepartmentID OFFSET 5 ROWS
FETCH NEXT 5 ROWS ONLY;

--Question:37
/* From the following table write a query in SQL to list all the products that are Red or Blue in color. 
Return name, color and listprice.Sorts this result by the column listprice.
*/

select Name
	,Color
	,ListPrice
from Production.Product
where Color='Red' OR Color='Blue'
order by ListPrice

--Question:38
/* Create a SQL query from the SalesOrderDetail table to
retrieve the product name and any associated sales orders.
Additionally, it returns any sales orders that don't have any items mentioned in the Product table
as well as any products that have sales orders other than those that are listed there. 
Return product name, salesorderid. Sort the result set on product name column.
*/

select * from Production.Product
select * from Sales.SalesOrderDetail

select p.Name
	,sd.SalesOrderID 
from Production.Product p
FULL OUTER JOIN  Sales.SalesOrderDetail sd ON p.ProductID=sd.ProductID
order by p.Name

--Question:39
/*From the following table write a SQL query to retrieve the product name and salesorderid. 
Both ordered and unordered products are included in the result set.
*/

select p.Name
	,sd.SalesOrderID 
from Production.Product p
LEFT OUTER JOIN  Sales.SalesOrderDetail sd ON p.ProductID=sd.ProductID
order by p.Name

--Question:40
/* From the following tables write a SQL query to get all product names and sales order IDs.
Order the result set on product name column.
*/

select p.Name
	,sd.SalesOrderID 
from Production.Product p
INNER JOIN  Sales.SalesOrderDetail sd ON p.ProductID=sd.ProductID
order by p.Name

--Question:41
/*From the following tables write a SQL query to retrieve the territory name and BusinessEntityID.
The result set includes all salespeople, regardless of whether or not they are assigned a territory.
*/

select * from Sales.SalesTerritory
select * from Sales.SalesPerson

select st.Name
	,sp.BusinessEntityID 
from Sales.SalesPerson sp
LEFT JOIN Sales.SalesTerritory st ON st.TerritoryID=sp.TerritoryID

--Question:42 (*****Half Question Panding,Why Use SUBQUERY*****)
/* Write a query in SQL to find the employee's full name (firstname and lastname) and city from the following tables.
Order the result set on lastname then by firstname.
*/

select * from Person.Person
select * from HumanResources.Employee
select * from Person.Address
select * from Person.BusinessEntityAddress

select CONCAT(p.FirstName,' ',p.LastName) AS Full_Name
	,a.City
from Person.Person p
JOIN Person.Address a ON p.BusinessEntityID=a.AddressID
order by p.FirstName,p.LastName

--Question:43 (*****Panding DERIVED TABLE*****)
/*Write a SQL query to return the businessentityid,firstname and lastname columns of all persons in the person table (derived table)
with persontype is 'IN' and the last name is 'Adams'.
Sort the result set in ascending order on firstname. 
A SELECT statement after the FROM clause is a derived table.
*/

select BusinessEntityID
	,FirstName
	,LastName
	,PersonType 
from Person.Person
where PersonType LIKE 'IN%' and LastName LIKE 'Adams%'

--Question:44
/* Create a SQL query to retrieve individuals from 
the following table with a businessentityid inside 1500, a lastname starting with 'Al', and a firstname starting with 'M'.
*/

select BusinessEntityID
	,FirstName
	,LastName
from  Person.Person
where LastName LIKE 'Al%' 
	AND FirstName LIKE 'M%' 
	AND BusinessEntityID < 1500
order by BusinessEntityID

--Question:45 (***** DERIVED TABLE CONCEPT)
/*Write a SQL query to find the productid, name, and colour of the items 'Blade', 'Crown Race' and 'AWC Logo Cap' using a derived table with multiple values.
*/

select ProductID
	,Name
	,Color
from Production.Product AS DerivedProduct
where DerivedProduct.Name LIKE'Balde'

--Question:46
/*Create a SQL query to display the total number of sales orders each sales representative receives annually.
Sort the result set by SalesPersonID and then by the date component of the orderdate in ascending order.
Return the year component of the OrderDate, SalesPersonID, and SalesOrderID.
*/

select YEAR(OrderDate) SalesYear
	,SalesPersonID
	,COUNT(SalesOrderID) AS Toatal_Order
from Sales.SalesOrderHeader
group by YEAR(OrderDate) ,SalesPersonID
having SalesPersonID IS NOT NULL
order by SalesPersonID,SalesYear

--Question:47
/*From the following table write a query in SQL
to find the average number of sales orders for all the years of the sales representatives.
*/
select AVG(No_Of_Order) AS Avg_Number_Of_Sales
	FROM(	select	SalesPersonID
					,COUNT(*) AS No_Of_Order
			from Sales.SalesOrderHeader 
			where SalesPersonID IS NOT NULL
			group by SalesPersonID
		)AVG_TABLE

--Question:48
/*Write a SQL query on the following table to retrieve records with the characters green_ in the LargePhotoFileName field.
The following table's columns must all be returned.
*/

select * 
from Production.ProductPhoto
where LargePhotoFileName LIKE '%green_%'		--%_% For starting value is UNKNOWN--

--Question:49
/*Write a SQL query to retrieve 
the mailing address for any company that is outside the United States (US) and in a city whose name starts with Pa. 
Return Addressline1, Addressline2, city, postalcode, countryregioncode columns.
*/

select * from Person.Address
select * from Person.StateProvince

select a.AddressLine1
	,a.AddressLine2
	,a.City
	,a.PostalCode
	,sp.CountryRegionCode
from Person.Address a
JOIN Person.StateProvince sp ON a.StateProvinceID=sp.StateProvinceID
where CountryRegionCode <> 'US' AND a.City LIKE 'pa%'

--Question:50
/*From the following table write a query in SQL to fetch first twenty rows. Return jobtitle, hiredate.
Order the result set on hiredate column in descending order.
*/

select JobTitle
	,HireDate
from HumanResources.Employee
order by HireDate DESC
OFFSET 0 ROWS
FETCH NEXT 20 ROWS ONLY		

--Question:51
/*From the following tables write a SQL query to retrieve
the orders with orderqtys greater than 5 or unitpricediscount less than 1000, and totaldues greater than 100.
Return all the columns from the tables.
*/

select * from Sales.SalesOrderHeader
select * from Sales.SalesOrderDetail

select * 
from Sales.SalesOrderHeader so
JOIN Sales.SalesOrderDetail sd ON so.SalesOrderID=sd.SalesOrderID
WHERE so.TotalDue > 100 
	  AND (sd.OrderQty > 5 OR sd.UnitPriceDiscount < 1000)  

--Question:52
/*From the following table write a query in SQL that searches for the word 'red' in the name column.
Return name, and color columns from the table.
*/

select Name
	,Color 
from Production.Product
where name like '%Red%'

--Question:53
/* From the following table write a query in SQL to find all the products with a price of $80.99 that contain the word Mountain.
Return name, and listprice columns from the table.
*/

select Name,ListPrice
from Production.Product
where Name like '%Mountain%' AND ListPrice=80.99
--Solution is not match but answer is getting.


--Question:54
/*From the following table write a query in SQL to retrieve all the products that contain either the phrase Mountain or Road. 
Return name, and color columns.
*/

select Name,Color
from Production.Product
where Name LIKE '%Mountain%' OR Name LIKE '%Road%'

--Question:55
/*From the following table write a query in SQL to search for name which contains both the word 'Mountain' and the word 'Black'. 
Return Name and color.
*/

select Name,Color
from Production.Product
where Name LIKE '%Mountain%' AND Name LIKE '%Black%'

/*
SELECT Name,color  
FROM Production.Product  
WHERE to_tsvector(name) @@ to_tsquery('Mountain & Black');
*/

--Question:56
/* From the following table write a query in SQL to return 
all the product names with at least one word starting with the prefix chain in the Name column.
*/

select Name,Color
from Production.Product
where Name LIKE 'chain %' 

--Question:57
/*From the following table write a query in SQL to return
all category descriptions containing strings with prefixes of either chain or full.
*/

select Name,Color
from Production.Product
where Name LIKE 'chain %' OR Name LIKE 'full%'


--Question:58
/* From the following table write a SQL query to output an employee's name and email address, separated by a new line character.
*/

select CONCAT(p.FirstName,' ',p.LastName,' ',e.EmailAddress) 
from Person.Person p
JOIN Person.EmailAddress e ON p.BusinessEntityID=e.BusinessEntityID

--Question:59
/*From the following table write a SQL query to locate the position of the string "yellow" where it appears in the product name.
*/

select Name,CHARINDEX('Yellow',name) AS Match_Postion
from Production.Product
where Name like '%Yellow%'

--Question:60
/*From the following table write a query in SQL to concatenate the name, color, and productnumber columns.
*/

select CONCAT(Name,' ','Color:-' ,Color,' ','Product Number:-',ProductNumber)
from Production.Product

--Question:61
/*Write a SQL query that concatenate the columns name, productnumber, colour, and a new line character 
from the following table, each separated by a specified character.
*/

select CONCAT(Name,'@',ProductNumber,'@',Color) AS DatabaseInfo
from production.product 

--Question:62
/*From the following table write a query in SQL to return the five leftmost characters of each product name.
*/

select SUBSTRING(Name,0,4) AS Left_5_Char
from production.product 

--Question:63
/*From the following table write a query in SQL to
select the number of characters and the data in FirstName for people located in Australia.
*/

select LEN(FirstName)AS String_Lenght,FirstName,CountryRegionName
from Sales.vIndividualCustomer
where CountryRegionName='Australia'

--Question:64
/*From the following tables write a query in SQL
to return the number of characters in the column FirstName and the first and last name of contacts located in Australia.
*/

select LEN(FirstName)AS String_Lenght,LastName,sa.CountryRegionName
from Sales.vStoreWithContacts sc
JOIN Sales.vStoreWithAddresses sa  ON sc.BusinessEntityID=sa.BusinessEntityID
where CountryRegionName='Australia'

--Question:65
/* From the following table write a query in SQL to select product names that have prices between $1000.00 and $1220.00.
Return product name as Lower, Upper, and also LowerUpper.
*/

select UPPER(Name),LOWER(Name),StandardCost
from Production.Product
where StandardCost between 1000 and 1220

--Question:66
/*Write a query in SQL to remove the spaces from the beginning of a string.
*/
select '   five    space   then   the   text  'AS With_Space,TRIM('   five space then the text')AS Without_Space\

--Question:67
/*From the following table write a query in SQL to remove the substring 'HN' from the start of the column productnumber.
Filter the results to only show those productnumbers that start with "HN". 
Return original productnumber column and 'TrimmedProductnumber'.
*/

select ProductNumber,SUBSTRING(ProductNumber,3,6) AS Trim_Product_Name
from Production.Product
where ProductNumber LIKE 'HN%'

--Question:68
/* From the following table write a query in SQL 
to repeat a 0 character four times in front of a production line for production line 'T'.
*/

select Name,CONCAT('0000',ProductLine)
from Production.Product
where ProductLine='T'

--Question:69
/*From the following table write a SQL query to retrieve all contact first names with the characters inverted for people whose businessentityid is less than 6.
*/

select FirstName,REVERSE(FirstName) AS Reverse_Name
from Person.Person
where LEN(FirstName) < 6

--Question:70
/* From the following table write a query in SQL to return the eight rightmost characters of each name of the product.
Also return name, productnumber column. Sort the result set in ascending order on productnumber.
*/

select Name,ProductNumber,RIGHT(Name,8) As Right_8_Char
from Production.Product
order by ProductNumber 

--Question:71(*****)
/* Write a query in SQL to remove the spaces at the end of a string.
*/

select 'text then five spaces     after space' AS OriginalText,TRIM('text then five spaces     after space')

--Question:72
/*From the following table write a query in SQL to fetch the rows for the product name ends with the letter 'S' or 'M' or 'L'. 
Return productnumber and name.
*/

select ProductNumber,Name
from Production.Product
where RIGHT(Name,1) in ('S','M','L')


--Question:73 (*****)
/*From the following table write a query in SQL to replace null values with 'N/A' and return the names separated by commas in a single row.
*/

select * 
from Person.Person

--Question:74 (*****)
/* From the following table write a query in SQL to return the names and modified date separated by commas in a single row.
*/

select STRING_AGG(CONCAT(FirstName,' ',LastName,' ','(',ModifiedDate,')',','),' ')
from Person.Person

--SELECT STRING_AGG(CONCAT(FirstName, ' ', LastName, ' (', ModifiedDate, ')'),', ') 
--AS test FROM Person.Person;


--Question:75
/*From the following table write a query in SQL to find the email addresses of employees and groups them by city. 
Return top ten rows.
*/

select * from Person.BusinessEntityAddress
select * from Person.Address
select * from Person.EmailAddress


select City,STRING_AGG(CONVERT(nvarchar(max),CONCAT(EmailAddress,' ')),CHAR(13))
from Person.BusinessEntityAddress ba 
join Person.Address a ON ba.BusinessEntityID=a.AddressID
join Person.EmailAddress  ea On ea.BusinessEntityID=ba.BusinessEntityID
group by City

--Question:76
/*From the following table write a query in SQL to 
create a new job title called "Production Assistant" in place of "Production Supervisor".
*/

--Question:77
/*From the following table write a SQL query to retrieve all the employees whose job titles begin with "Sales".
Return firstname, middlename, lastname and jobtitle column.
*/

select * from Person.Person
select * from HumanResources.Employee

select p.FirstName,p.MiddleName,p.LastName,e.JobTitle 
from Person.Person p
JOIN HumanResources.Employee e ON p.BusinessEntityID=e.BusinessEntityID
where e.JobTitle LIKE 'Sales%'


--Question:78
/*From the following table write a query in SQL to return
the last name of people so that it is in uppercase, trimmed, and concatenated with the first name.
*/

select CONCAT(UPPER(TRIM(LastName)),',',FirstName) from Person.Person

--Question:79(*****)
/*From the following table write a query in SQL to show a resulting expression that is too small to display.
Return FirstName, LastName, Title, and SickLeaveHours. 
The SickLeaveHours will be shown as a small expression in text format.
*/

select * from Person.Person
select * from HumanResources.Employee

select p.FirstName
	,p.LastName
	,p.Title
	,CAST(e.SickLeaveHours AS char(1)) AS "Sick Leave"
from Person.Person p
JOIN HumanResources.Employee e ON p.BusinessEntityID=e.BusinessEntityID

--Question:80
/*From the following table write a query in SQL to 
retrieve the name of the products. Product, that have 33 as the first two digits of listprice.
*/

select Name,ListPrice from Production.Product
where ListPrice LIKE '33%'

--Question:81
/*From the following table write a query in SQL to 
calculate by dividing the total year-to-date sales (SalesYTD) by the commission percentage (CommissionPCT).
Return SalesYTD, CommissionPCT, and the value rounded to the nearest whole number.
*/

select SalesYTD,CommissionPct,CAST(ROUND(SalesYTD/CommissionPct,0) AS int) AS Value
from Sales.SalesPerson
where CommissionPct!=0