--1. 

select ProductName,S.SupplierName from Products as P
cross join Suppliers as S

select ProductName as Name,S.SupplierName from Suppliers as S
cross join Products as P

--2
select d.DepartmentName,e.EmployeeID from departments as d
cross join Employees as e 

--3
select S.SupplierName,P.ProductName from products as P
inner join suppliers as S
on p.SupplierID=S.SupplierID

--4
select c.Firstname, o.orderid from Customers as c
inner join Orders as o
on c.CustomerID=o.orderid;


--5
Select s.Name, c.CourseName from students as s
cross join courses as c

--6
Select p.productname, o.productid from Products as p
inner join orders as o
on o.productid=p.ProductID

--7
Select d.DepartmentName, e.EmployeeID from departments as d
inner join employees as e
on d.DepartmentID=e.EmployeeID

--8
select s.name, c.courseid from Students as s
inner join Enrollments as e
on s.StudentID=c.courseid

--9
Select o.OrderID, p.PaymentID from orders as o
inner join payments as p
on o.OrderID=p.OrderID

--10
select o.orderid,p.productname from orders as o
inner join products as p
on o.productid=p.productid
where p.Price<100


--Medium
--11
select E.Name,D.DepartmentName from Employees as E
inner join Departments as D on E.DepartmentID!=D.DepartmentID


--12
Select o.orderid, p.productname from orders as o
inner join products as p
on o.productid=p.ProductID
where totalamount>stockquantity

--13
select c.firstname, s.ProductID from customers as c
inner join sales as s
on c.customerid=s.customerid
where s.SaleAmount>=500

--14
select e.StudentID, c.CourseName from courses as c
inner join enrollments e
on c.CourseID=e.CourseID

--15
select p.productname, s.suppliername from products as p
inner join suppliers as s
on p.productid=s.supplierid
where s.SupplierName='tech'

--16
select o.orderid, p.PaymentID from orders as o
inner join payments as p
on o.orderid=p.orderid
where p.amount<o.TotalAmount

--17
select emp.employeeid, emp.firstname, emp.departmentname, emp.salary, mng.employeeid, mng.firstname, mng.departmentname, mng.salary from employees as emp
inner join employees as mng
on emp.managerid=mng.employeeid
where emp.salary>mng.salary

--18
select p.productname, c.CategoryName from products as p
inner join categories as c
on p.Category=c.CategoryID
where c.categoryname in ('Electronics','Furniture')

--19
Select s.saleid, s.productid, c.FirstName, c.Country from sales as s
inner join customers as c
on s.customerid=c.customerid
where c.Country='USA'


--20
Select o.orderid, c.FirstName, o.TotalAmount from orders as o
inner join customers as c
on o.customerid=c.customerid
where c.country='germany' and o.TotalAmount>100

--21
Select emp.employeeid, emp.firstname, dept.employeeid as managerid, dept.firstname from Employees as emp
inner join Employees as dept
on emp.employeeid=dept.EmployeeID
and emp.DepartmentID<>dept.DepartmentID;

--22
select p.PaymentID,
       p.amount as pa, 
	   o.quantity,
	   pr.price (o.quantiy * p.price) as ea from payments as p
inner join orders as o
on p.orderid=o.orderid
inner join products as pr 
on o.productid=pr.productid
where p.amount<>(o.quantity*pr.price);


select * from payments
select * from orders
select * from products

--23
select s.studentid, s.name from students as s
left join enrollments as e
on s.StudentID=e.studentid
where e.StudentID is null;

--24
select Mng.EmployeeID as MngID,
	Mng.Name as MngName,
	Mng.Salary as MngSalary,
	Emp.EmployeeID as EmpID,
	Emp.Name as EmpName,
	Emp.Salary as EmpSalary
	from Employees as Mng
inner join Employees as Emp on Mng.EmployeeID=Emp.ManagerID
where Mng.Salary<=Emp.Salary
order by 1

--25
select distinct c.customerid, c.firstname from customers as c 
join orders as o
on c.customerid=o.customerid
left join payments as p 
on o.OrderID=p.OrderID
where p.PaymentID is null;
select * from payments
select * from customers

