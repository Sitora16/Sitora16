--1
Select e.firstname, e.salary, d.DepartmentName from Employees as e
inner join Departments as d
on e.EmployeeID=d.DepartmentID
where e.Salary>50000

--2
Select c.FirstName, c.LastName, o.OrderDate from customers as c
inner join orders as o
on c.CustomerID=o.CustomerID
where year (o.OrderDate)=2023;

--3
Select e.firstname, d.DepartmentName from Employees as e
left join departments as d
on e.EmployeeID=d.DepartmentID

--4
select p.ProductName, s.SupplierName from products as p
left join suppliers as s
on p.ProductID=s.SupplierID

--5
select o.OrderID,o.OrderDate,p.PaymentDate,p.Amount from orders as o
full join payments as p
on o.OrderID=p.OrderID

--6
select e.firstname as employeename, m.lastname as managername from employees as e
left join employees as m
on e.employeeid=m.employeeid

--7
select s.name from students as s
inner join enrollments as e
on s.StudentID=e.StudentID
inner join courses as c
on e.CourseID=c.CourseID
where c.coursename='math 101'

--8
Select c.FirstName, c.LastName, sum(o.quantity) from customers as c
Join Orders as o
on c.customerid=o.customerid
Group by c.firstname, c.lastname
having sum(o.quantity)>3;


--9
Select e.EmployeeID, e.firstname, d.DepartmentName from Employees as e
inner join departments as d
on e.employeeid=d.DepartmentID
where d.DepartmentName='Human Resources'

--10
select d.departmentname, count(e.employeeid) from employees as e
inner join Departmentss as d
on e.EmployeeID=d.DepartmentID
group by d.DepartmentName
having count(e.employeeid)>5;
select * from Departmentss

--11
select p.ProductID, p.ProductName from products as p
left join sales as s
on p.ProductID=s.ProductID
where s.SaleID is null;

--12
select c.firstname, c.lastname, count(o.orderid) from Customers	as c
inner join orders as o
on c.CustomerID=o.CustomerID
group by c.FirstName,c.LastName;

--13
select e.Name, d.DepartmentName from employees as e
inner join Departmentss as d
on e.EmployeeID=d.DepartmentID;

--14
select e1.Name as emp1,
       e2.Name as emp2 from Employees as e1
join Employees as e2
on e1.ManagerID=e2.ManagerID 
where e1.EmployeeID<e2.EmployeeID;

--15
select o.OrderID,o.OrderDate, c.FirstName from orders as o
inner join customers as c
on o.CustomerID=c.CustomerID
where year (o.OrderDate)=2022;

--16
select e.Name, e.Salary, d.DepartmentName from Employees as e
inner join Departmentss as d
on e.DepartmentID=d.DepartmentID
where d.DepartmentName='sales' and e.Salary>60000;

--17
select o.OrderID, o.OrderDate, p.PaymentDate,p.Amount from Orders as o
inner join payments as p
on o.OrderID=p.OrderID

--18
select p.ProductID,p.ProductName from Products as p
left join Orders as o
on p.ProductID=o.ProductID
where o.ProductId is null;

--19
select e.name, e.salary from Employees as e
where e.Salary>(
     select avg(salary)
	 from Employees
	 where departmentid=e.DepartmentID)

--20
select o.OrderID, o.OrderDate from orders as o
left join payments as p
on o.OrderID=p.OrderID
where p.PaymentID is null and o.OrderDate<'2020-01-01';


--21
select p.ProductID,p.ProductName from Products as p
left join categories as c
on p.ProductID=c.CategoryID
where c.CategoryID is null;

--22
select e1.Name as employee1,
       e2.name as employee2,
	   e1.managerid,
	   e1.salary
	   from Employees as e1
Join Employees as e2
on e1.managerid=e2.managerid and
       e1.employeeid<e2.employeeid
where e1.salary>60000 and e2.salary>60000;

--23
select e.Name, d.departmentname from Employees as e
inner join Departmentss as d
on e.EmployeeID=d.DepartmentID
where d.DepartmentName like 'M%';

--24
select s.SaleID,p.ProductName,s.SaleAmount from Products as p
inner join sales as s
on s.ProductID=s.ProductID
where s.SaleAmount>500

--25
select s.StudentID, s.Name from Students as s
where s.StudentID not in(
      select e.studentid from Enrollments as e
	  join courses as c 
	  on e.CourseID=e.CourseID
	  where c.CourseName='Math 101');

--26
select o.OrderID, o.OrderDate,p.PaymentID from Orders as o
left join payments as p
on o.OrderID=p.OrderID
where p.PaymentID is null;

--27
select p.ProductID, p.ProductName,c.CategoryName from Products as p
inner join Categories as c
on p.ProductID=c.CategoryID
where c.CategoryName in ('electronics', 'furniture');
