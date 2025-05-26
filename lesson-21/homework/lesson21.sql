--1
select SaleID, ProductName,ROW_NUMBER()over(order by SaleDate) as rownum 
from ProductSales

--2
select ProductName, 
       sum(quantity) as totalquantity,
	   DENSE_RANK()over(order by sum( quantity)desc) as rnk
from ProductSales
Group by ProductName

--3
SELECT *
FROM (
    SELECT 
        CustomerID,
        SaleID,
        SaleAmount,
        ROW_NUMBER() OVER (PARTITION BY CustomerID ORDER BY SaleAmount DESC) AS rn
    FROM ProductSales
) AS ranked_sales
WHERE rn = 1;


--4
select SaleID, ProductName,
       lead(saleamount)over(order by saledate) as leadsale 
from ProductSales

--5
select SaleID, ProductName,
       lag(saleamount)over(order by saledate) as prevsale 
from ProductSales

--6
select * from
           (select SaleID, ProductName, saleamount,
       lag(saleamount)over(order by saledate) as prevsale 
from ProductSales)as lagsale
where SaleAmount>prevsale



--7
select ProductName, saledate, lag(SaleAmount)over(partition by productname order by saledate)as lagpro
from ProductSales

--8

SELECT 
    ProductName,
    SaleDate,
    SaleAmount,
    LEAD(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS NextSaleAmount,
    (LEAD(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) - SaleAmount) * 100.0 / NULLIF(SaleAmount, 0) AS PercentChange
FROM 
    ProductSales;

--9
SELECT 
    SaleID,
    saledate,
    saleamount,
    LAG(saleamount) OVER (PARTITION BY saleid ORDER BY saledate) AS previous_sale_amount,
    CASE 
        WHEN LAG(saleamount) OVER (PARTITION BY saleid ORDER BY saledate) IS NOT NULL 
             AND LAG(saleamount) OVER (PARTITION BY saleid ORDER BY saledate) != 0 
        THEN saleamount * 1.0 / LAG(saleamount) OVER (PARTITION BY saleid ORDER BY saledate)
        ELSE NULL
    END AS sale_ratio
FROM ProductSales;

--10
select ProductName, first_value(saleamount)over(partition by productname order by saledate)-diffAmount as lagpro
from ProductSales

--11
select productname, saleamount, saledate from (select ProductName, saleamount, saledate, lag(SaleAmount)over(partition by productname order by saledate) as previoussale
from ProductSales) as sub
where SaleAmount>previoussale

--12
SELECT 
    ProductName,
    SaleDate,
    SaleAmount,
    SUM(SaleAmount) OVER (
        PARTITION BY ProductName
        ORDER BY SaleDate
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS ClosingBalance
FROM ProductSales;

--13
select ProductName,avg(saleamount)over(partition by productname order by saledate 
       rows between 2 preceding and current row ) as movingsale
from ProductSales

--14
SELECT 
    ProductName,
    SaleDate,
    SaleAmount,
    AVG(SaleAmount) OVER () AS AvgSaleAmount,
    SaleAmount - AVG(SaleAmount) OVER () AS DifferenceFromAvg
FROM ProductSales;

--15
with cte as(
select EmployeeID,Name,Department, rank()over(order by salary) as salaryrank
from Employees1)
select * FROM cte
WHERE SalaryRank IN (
    SELECT SalaryRank
    FROM cte
    GROUP BY SalaryRank
    HAVING COUNT(*) > 1);

--16
select EmployeeID,name,Department,Salary from(select EmployeeID,name,Department,Salary, rank()over(order by salary)as ranksalary
from Employees1) as ranked
where ranksalary<=2

--17
select employeeid,name,department,salary from(select EmployeeID,name, Department,Salary, RANK()over(order by salary)as ranksalary
from Employees1 ) as ranked
where ranksalary=1;

--18
SELECT 
    EmployeeID,
    Name,
    Department,
    Salary,
    SUM(Salary) OVER (
        PARTITION BY Department
        ORDER BY EmployeeID
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS RunningTotal
FROM Employees1;

--19
select EmployeeID,name, Department, sum(salary)over(partition by department) as sumsalary
from Employees1

--20
select EmployeeID,name, Department, avg(salary)over(partition by department) as sumsalary
from Employees1

--21
SELECT
    EmployeeID,
    Name,
    Department,
    Salary,
    AVG(Salary) OVER (PARTITION BY Department) AS AvgDepartmentSalary,
    Salary - AVG(Salary) OVER (PARTITION BY Department) AS SalaryDifference
FROM Employees1;

--22
SELECT
    EmployeeID,
    Name,
    Department,
    Salary,
    AVG(Salary) OVER (
        ORDER BY EmployeeID
        ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
    ) AS MovingAvgSalary
FROM Employees1;

--23
SELECT 
    SUM(Salary) AS SumLast3Salaries
FROM (
    SELECT TOP 3 Salary
    FROM Employees1
    ORDER BY HireDate DESC
) AS LastThree;
