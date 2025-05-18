--1
DROP TABLE IF EXISTS #RegionSales;
GO
CREATE TABLE #RegionSales (
  Region      VARCHAR(100),
  Distributor VARCHAR(100),
  Sales       INTEGER NOT NULL,
  PRIMARY KEY (Region, Distributor)
);
GO
INSERT INTO #RegionSales (Region, Distributor, Sales) VALUES
('North','ACE',10), ('South','ACE',67), ('East','ACE',54),
('North','ACME',65), ('South','ACME',9), ('East','ACME',1), ('West','ACME',7),
('North','Direct Parts',8), ('South','Direct Parts',7), ('West','Direct Parts',12);

select * from #RegionSales
;with allcombinations as(
select distinct r.region, d.distributor 
from
(select distinct region from #RegionSales) as r
cross join
(select distinct distributor from #RegionSales) as d)
select ac.Region, ac.Distributor, isnull(rs.sales,0)from allcombinations as ac
left join #RegionSales as rs
on ac.Region=rs.Region and ac.Distributor=rs.Distributor
order by ac.Distributor,ac.Region

--2
CREATE TABLE Employee (id INT, name VARCHAR(255), department VARCHAR(255), managerId INT);
TRUNCATE TABLE Employee;
INSERT INTO Employee VALUES
(101, 'John', 'A', NULL), (102, 'Dan', 'A', 101), (103, 'James', 'A', 101),
(104, 'Amy', 'A', 101), (105, 'Anne', 'A', 101), (106, 'Ron', 'B', 101);

select managerId,count(*) as drepc from Employee
Group by managerId
having count(*)>=5;

--3
CREATE TABLE Products (product_id INT, product_name VARCHAR(40), product_category VARCHAR(40));
CREATE TABLE Orders (product_id INT, order_date DATE, unit INT);
TRUNCATE TABLE Products;
INSERT INTO Products VALUES
(1, 'Leetcode Solutions', 'Book'),
(2, 'Jewels of Stringology', 'Book'),
(3, 'HP', 'Laptop'), (4, 'Lenovo', 'Laptop'), (5, 'Leetcode Kit', 'T-shirt');
TRUNCATE TABLE Orders;
INSERT INTO Orders VALUES
(1,'2020-02-05',60),(1,'2020-02-10',70),
(2,'2020-01-18',30),(2,'2020-02-11',80),
(3,'2020-02-17',2),(3,'2020-02-24',3),
(4,'2020-03-01',20),(4,'2020-03-04',30),(4,'2020-03-04',60),
(5,'2020-02-25',50),(5,'2020-02-27',50),(5,'2020-03-01',50);

select p.product_name, sum(o.unit) as unit from Products as p
join orders as o
on p.product_id=o.product_id
where o.order_date>+'2020-02-01' and o.order_date<'2020-03-01'
Group by p.product_name
having sum(o.unit)>=100

--4
DROP TABLE IF EXISTS Orders;
CREATE TABLE Orders (
  OrderID    INTEGER PRIMARY KEY,
  CustomerID INTEGER NOT NULL,
  [Count]    MONEY NOT NULL,
  Vendor     VARCHAR(100) NOT NULL
);
INSERT INTO Orders VALUES
(1,1001,12,'Direct Parts'), (2,1001,54,'Direct Parts'), (3,1001,32,'ACME'),
(4,2002,7,'ACME'), (5,2002,16,'ACME'), (6,2002,5,'Direct Parts');

select o.CustomerID, o.OrderID,count(*) as totalorder from Orders as o
Group by o.CustomerID,o.OrderID
having count(*)=(
       select max(count(*))
	   from Orders
	   where CustomerID=o.CustomerID
	   Group by OrderID);
	   select * from Orders



--5
DECLARE @Check_Prime INT = 91;
DECLARE @i INT = 2;
DECLARE @IsPrime BIT = 1; 

IF @Check_Prime <= 1
BEGIN
    SET @IsPrime = 0;
END
ELSE
BEGIN
    WHILE @i * @i <= @Check_Prime
    BEGIN
        IF @Check_Prime % @i = 0
        BEGIN
            SET @IsPrime = 0;
            BREAK;
        END
        SET @i = @i + 1;
    END
END

IF @IsPrime = 1
    PRINT 'This number is prime';
ELSE
    PRINT 'This number is not prime';

--6
CREATE TABLE Device(
  Device_id INT,
  Locations VARCHAR(25)
);
INSERT INTO Device VALUES
(12,'Bangalore'), (12,'Bangalore'), (12,'Bangalore'), (12,'Bangalore'),
(12,'Hosur'), (12,'Hosur'),
(13,'Hyderabad'), (13,'Hyderabad'), (13,'Secunderabad'),
(13,'Secunderabad'), (13,'Secunderabad');


WITH LocationCounts AS (
    SELECT 
        Device_id,
        Locations,
        COUNT(*) AS SignalCount
    FROM Device
    GROUP BY Device_id, Locations
),
MaxLocation AS (
    SELECT 
        lc.Device_id,
        lc.Locations AS max_signal_location
    FROM LocationCounts lc
    JOIN (
        SELECT 
            Device_id,
            MAX(SignalCount) AS MaxSignal
        FROM LocationCounts
        GROUP BY Device_id
    ) max_lc
    ON lc.Device_id = max_lc.Device_id AND lc.SignalCount = max_lc.MaxSignal
),
DeviceStats AS (
    SELECT 
        Device_id,
        COUNT(*) AS no_of_signals,
        COUNT(DISTINCT Locations) AS no_of_location
    FROM Device
    GROUP BY Device_id
)
SELECT 
    ds.Device_id,
    ds.no_of_location,
    ml.max_signal_location,
    ds.no_of_signals
FROM DeviceStats ds
JOIN MaxLocation ml ON ds.Device_id = ml.Device_id
ORDER BY ds.Device_id;


--7
CREATE TABLE Employee (
  EmpID INT,
  EmpName VARCHAR(30),
  Salary FLOAT,
  DeptID INT
);
INSERT INTO Employee VALUES
(1001,'Mark',60000,2), (1002,'Antony',40000,2), (1003,'Andrew',15000,1),
(1004,'Peter',35000,1), (1005,'John',55000,1), (1006,'Albert',25000,3), (1007,'Donald',35000,3);


select EmpID,EmpName,Salary from Employee as e
where salary>(select avg(salary) from Employee where DeptID=e.DeptID);


--8
CREATE TABLE WinningNumbers (Number INT);
INSERT INTO WinningNumbers VALUES (25), (45), (78);
CREATE TABLE Tickets (TicketID VARCHAR(20), Number INT);
INSERT INTO Tickets VALUES
('A23423', 25), ('A23423', 45), ('A23423', 78),
('B35643', 25), ('B35643', 45), ('B35643', 98),
('C98787', 67), ('C98787', 86), ('C98787', 91);

--9
CREATE TABLE Spending (
  User_id INT,
  Spend_date DATE,
  Platform VARCHAR(10),
  Amount INT
);
INSERT INTO Spending VALUES
(1,'2019-07-01','Mobile',100),
(1,'2019-07-01','Desktop',100),
(2,'2019-07-01','Mobile',100),
(2,'2019-07-02','Mobile',100),
(3,'2019-07-01','Desktop',100),
(3,'2019-07-02','Desktop',100);

;select User_id,Spend_date,
       sum(case when platform='Mobile' then amount else 0 end),
	   sum(case when platform='Desktop' then amount else 0 end)from spending
Group by user_id,spend_date

--10
DROP TABLE IF EXISTS Grouped;
CREATE TABLE Grouped
(
  Product  VARCHAR(100) PRIMARY KEY,
  Quantity INTEGER NOT NULL
);
INSERT INTO Grouped (Product, Quantity) VALUES
('Pencil', 3), ('Eraser', 4), ('Notebook', 2);

;with numbers as(
select 1 as n
union all
select n+1 from numbers where n<100),

expanded as(
select g.Product, 1 as quantity from Grouped as g
join numbers as n
on n.n<=g.Quantity)
select * from expanded 
order by Product
