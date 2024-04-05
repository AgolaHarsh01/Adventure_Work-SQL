--Question:-101
/*
 From the following table write a query in SQL to calculate the salary percentile for each employee within a given department.
 Return department, last name, rate, cumulative distribution and percent rank of rate.
 Order the result set by ascending on department and descending on rate.
*/

Select dh.Department
	,dh.LastName
	,ep.Rate
	,PERCENT_RANK() OVER(partition by department Order by rate) AS pctrank
	,CUME_DIST() OVER(partition by department Order by rate) AS cumedist
from HumanResources.EmployeePayHistory ep
JOIN HumanResources.vemployeedepartmenthistory dh ON ep.BusinessEntityID=dh.BusinessEntityID

--Question:-102
/*
From the following table write a query in SQL to return
the name of the product that is the least expensive in a given product category. 
Return name, list price and the first value i.e. LeastExpensive of the product.
*/

select Name
	,ListPrice
	,FIRST_VALUE(Name) over(order by ListPrice ASC) AS LeastExpensive
from production.Product
WHERE ProductSubcategoryID = 37