--1
select o.OrderID,c.FirstName,o.OrderDate from orders as o
join customers as c
on c.CustomerID=o.CustomerID
where o.OrderDate>'2022'

--2
Select e.name, d.DepartmentName from Employees as e
inner join Departments as d
on e.EmployeeID=d.DepartmentID
where d.DepartmentName in ('sales', 'marketing');

--3
select d.DepartmentName, max(e.Salary) from Departments as d
inner join employees as e
on d.DepartmentID=e.EmployeeID
Group by d.DepartmentName;

--4
select c.FirstName, o.OrderID, o.OrderDate from Customers as c
left join Orders as o
on c.CustomerID=o.OrderID
where o.OrderDate='2023';

--5
select c.FirstName, count(o.orderid) from Customers as c
left join orders as o
on o.CustomerID=c.CustomerID
group by c.FirstName;

--6
select p.ProductName, s.SupplierName from Products as p
left join Suppliers as s
on p.ProductID=s.SupplierID
where s.SupplierName in ('gadget supplies', 'clothing mart')


--7
select c.FirstName, max(o.OrderDate) as mostrecentorderdate from customers as c
left join Orders as o
on c.CustomerID=o.CustomerID
group by c.FirstName

--8
select c.FirstName, o.TotalAmount from orders as o
join customers as c
on o.CustomerID=c.CustomerID
where o.TotalAmount>500

--9
select p.ProductName,s.SaleDate, s.SaleAmount from Products as p
full join sales as s
on p.ProductID=s.ProductID
where year(s.SaleDate)=2022 or s.SaleAmount>400

--10
select p.ProductName, sum(s.SaleAmount) from sales as s
join products as p
on p.ProductID=s.ProductID
Group by p.ProductName

--11
select e.name, d.DepartmentName,e.Salary from Employees as e
join departments as d
on e.EmployeeID=d.DepartmentID
where d.DepartmentName='HR' and e.Salary>60000

--12
select p.ProductName, s.SaleDate, p.StockQuantity from products as p
join sales as s
on p.ProductID=s.ProductID
where year(s.saledate)=2023 and p.StockQuantity>100

--13
select e.name,d.DepartmentName,e.HireDate from employees as e
join departments as d
on e.EmployeeID=d.DepartmentID
where d.DepartmentName='sales' or year(e.hiredate)>2020

--14
select c.FirstName, o.OrderID,c.Address,o.OrderDate from customers as c
join orders as o
on c.CustomerID=o.CustomerID
where c.Country='USA' and c.Address like '[0-9]{4}';

--15
select p.ProductName,p.Category,s.SaleAmount from Products as p
join sales as s
on s.ProductID=p.ProductID
where p.Category='electronics' or
s.SaleAmount>350;

--16
select c.CategoryName,count(p.productid) as countproduct from Products as p
join Categories as c
on p.ProductID=c.CategoryID
Group by c.CategoryName;

--17
select c.FirstName, c.City,o.OrderID,o.TotalAmount from customers as c
join orders as o
on c.CustomerID=o.CustomerID
where c.City='los angeles' and o.TotalAmount>300;

--18
select e.name, d.DepartmentName from employees as e
join departments as d
on e.EmployeeID=d.DepartmentID
where d.DepartmentName in ('HR', 'Finance') or
 (LEN(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
            LOWER(e.Name),
            'a',''),
            'e',''),
            'i',''),
            'o',''),
            'u','')
        ) <= LEN(e.Name) - 4
    );select * from departments

--19
select e.name, d.DepartmentName,e.Salary from employees as e
join departments as d
on e.EmployeeID=d.DepartmentID
where d.DepartmentName in ('sales', 'marketing') and
e.Salary>60000;
