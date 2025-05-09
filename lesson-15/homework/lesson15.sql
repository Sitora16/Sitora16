--1
select * from employees
where salary=(select min(salary) from employees);

--2
select * from products
where price>(select avg(price) from products);

--3
select e.id,e.name from employees as e
join departments as d
on d.id=e.department_id
where d.department_name='sales';

--4
select c.CustomerID, c.FirstName from Customers as c
left join orders as o
on c.CustomerID=o.OrderID
where o.OrderID is null


--5
select * from products
where price=(select max(price) from products) 

--6
select * from Employees as e
where DepartmentID=(select top 1 DepartmentID from Employees
                    Group by DepartmentID
					order by avg(salary) desc 
					);

--7
select * from employees as e
where e.salary>(select avg(salary) from employees
                where department_id=e.department_id);

--8
select * from Students
where grade=(select max(grade) from Students);

--9
select * from products as p
where price=(select max(price) from products 
where category_id=p.category_id 
and price<
           (select max(price) from products
		    where category_id=p.category_id))
and price<
           (select max(price) from products
		    where category_id=p.category_id);

--10
select * from employees as e
where e.salary>(select avg(salary) from employees) and
e.salary<(select max(salary) from employees
where department_id=e.department_id);

