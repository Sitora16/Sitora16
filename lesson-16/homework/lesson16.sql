;with numbers(n) as(
select 1 as n
union all
select n+1
from Numbers1
where n<1000)
select * from Numbers1

--2
select e.EmployeeID,e.FirstName,s.salesamount  from Employees as e
join(select EmployeeID,sum(salesamount) as total 
     from sales
     Group by EmployeeID )  as s
on e.employeeid=s.employeeid

--3
with cte as(
select salary from Employees)  select avg(salary)from cte 


--4
select p.ProductID,p.ProductName,maxsales.maxsale from Products as p
join (select ProductID, max(salesamount) as maxsale from sales
      Group by ProductID) as maxsales
on p.ProductID=maxsales.ProductID;

--5
with numbers1 as (
select 1 as n
union all
select n*2
from numbers1
where n*2 < 1000000)
select * from Numbers1

--6
;WITH SalesCountCTE AS (
    SELECT 
        EmployeeID,
        COUNT(*) AS SalesCount
    FROM Sales
    GROUP BY EmployeeID
)
SELECT 
    e.EmployeeID,
    e.FirstName
FROM Employees e
JOIN SalesCountCTE s ON e.EmployeeID = s.EmployeeID
WHERE s.SalesCount > 5;

--7
with cte as (
select productid,sum(SalesAmount) as totalsale from sales
                 Group by ProductID)
select p.ProductID, p.ProductName, c.totalsale from Products as p
join cte as c 
on p.ProductID=c.ProductID
where c.totalsale>500

--8
with avgsalary as(
select avg(Salary) as avgsal from Employees)
select e.EmployeeID,e.FirstName,e.Salary from Employees as e
join avgsalary as a
on e.Salary=a.avgsal;

--medium
--1


select top 5 e.EmpID,e.EmpName, s.ordercount from Employee as e
join(select EmployeeID, count(*) as ordercount from Sales 
     Group by EmployeeID) as s
on s.EmployeeID=e.EmpID
order by s.ordercount desc;

--2
select p.product_id, p.product_name,p.product_category, s.saleamount from products as p
join( select ProductID,sum(SalesAmount) as saleamount from sales 
      Group by ProductID) as s
on s.ProductID=p.product_id
order by product_name;

--3
CREATE FUNCTION dbo.GetFactorial (@n INT)
RETURNS BIGINT
AS
BEGIN
    DECLARE @result BIGINT = 1;
    DECLARE @i INT = 1;

    WHILE @i <= @n
    BEGIN
        SET @result = @result * @i;
        SET @i = @i + 1;
    END

    RETURN @result;
END;
GO
SELECT 
    Number,
    dbo.GetFactorial(Number) AS Factorial
FROM 
    Numbers1;

--4
 WITH SplitCTE AS (
    SELECT 
        String,
        1 AS Position,
        SUBSTRING(String, 1, 1) AS Character
    FROM 
        Example

    UNION ALL

    SELECT 
        e.String,
        c.Position + 1,
        SUBSTRING(e.String, c.Position + 1, 1) AS Character
    FROM 
        SplitCTE c
        JOIN Example e ON c.String = e.String
    WHERE 
        c.Position + 1 <= LEN(e.String)
)
SELECT 
    String,
    Position,
    Character
FROM 
    SplitCTE
ORDER BY 
    String, Position
OPTION (MAXRECURSION 0); 

--5
select * from Sales

;WITH OySavdolari AS (
    SELECT
        CAST(DATEFROMPARTS(YEAR(saledate), MONTH(saledate), 1) AS DATE) AS oy,
        SUM(SaleAmount) AS jami_savdo
    FROM Sales
    GROUP BY YEAR(saledate), MONTH(saledate)
),

SavdoFarqi AS (
    SELECT
        oy,
        jami_savdo,
        LAG(jami_savdo) OVER (ORDER BY oy) AS oldingi_oy_savdosi
    FROM OySavdolari
)
SELECT
    oy,
    jami_savdo,
    oldingi_oy_savdosi,
    jami_savdo - ISNULL(oldingi_oy_savdosi, 0) AS savdo_farqi
FROM SavdoFarqi
ORDER BY oy;


--6
select e.name, qs.datepart, qs.totalsales from (select SaleID, datepart(quarter, SaleDate) as quarter, sum(s.SalesAmount) as totalsales from sales as s
Group by saleid,datepart(quarter, s.SaleDate)
having sum(saleamount)>45000) as qs
Join employees as e
on e.employeeid=qs.saleid

--1


WITH FibonacciCTE (n, fib1, fib2) AS
(
    SELECT 0, 0, 1  
    UNION ALL
    SELECT n + 1, fib2, fib1 + fib2
    FROM FibonacciCTE
    WHERE n < 10
)
SELECT n, fib1 AS FibonacciNumber
FROM FibonacciCTE
ORDER BY n;

--2
SELECT str
FROM Strings
WHERE LEN(str) > 1
  AND str NOT LIKE '%[^' + LEFT(str, 1) + ']%';

  --3
  DECLARE @n INT = 5;

;WITH Numbers AS (
    SELECT 1 AS num
    UNION ALL
    SELECT num + 1
    FROM Numbers
    WHERE num + 1 <= @n
),
Result AS (
    SELECT 
        num,
        CAST('' AS VARCHAR(MAX)) AS seq
    FROM (SELECT 1 AS dummy) a
    WHERE 1 = 0

    UNION ALL

    SELECT 
        n.num,
        (
            SELECT STRING_AGG(CAST(x.num AS VARCHAR(10)), '')
            FROM Numbers x
            WHERE x.num <= n.num
        ) AS seq
    FROM Numbers n
)
SELECT seq FROM Result
WHERE seq IS NOT NULL
OPTION (MAXRECURSION 0);


--4
select e.employeeid, s.totalsale from employeesss as e 
join( 
    select EmployeeID,SaleDate,sum(SalesAmount) as totalsale from Sales as s
    WHERE saledate >= DATEADD(MONTH, -6, GETDATE())
	Group by s.employeeid) as ss
on e.employeeid=ss.EmployeeID
where ss.totalsale=(select max(sub.totalsale)
                    from Saless
					where SaleDate>=DATEADD(MONTH, -6, GETDATE())
					Group by EmployeeID) as sub);

--5
WITH NumberSplit AS (
    SELECT 
        ID,
        value AS NumberStr
    FROM RemoveDuplicateIntsFromNames
    CROSS APPLY STRING_SPLIT(Name, ' ')
    WHERE ISNUMERIC(value) = 1
),
Filtered AS (
    SELECT 
        ID,
        NumberStr,
        COUNT(*) OVER (PARTITION BY ID, NumberStr) AS Occurrences
    FROM NumberSplit
),
FinalNumbers AS (
    SELECT DISTINCT 
        ID,
        NumberStr
    FROM Filtered
    WHERE Occurrences > 1 AND LEN(NumberStr) > 1
)
SELECT 
    r.ID,
    r.Name,
    STUFF((
        SELECT ' ' + f.NumberStr
        FROM FinalNumbers f
        WHERE f.ID = r.ID
        FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'), 1, 1, '') AS CleanedNumbers
FROM RemoveDuplicateIntsFromNames r;


