--1 
Select top 5 * from Employees
Order by salary desc;

--2
Select distinct ProductName from Products;

--3
Select * from Products 
where Price >100;

--4
Select FirstName from Customers
WHERE Firstname Like 'A%';

--5
Select * from Products
Order by Price Asc;

--6
Select * from Employees
where Salary>=60000 and DepartmentName='HR'; 

--7
Select FirstName,Isnull(email,'noemail@example.com') From Employees;

--8
Select * from Products
Where Price Between 50 and 100;

--9
Select DISTINCT category, productName from Products;

--10
Select DISTINCT category, productName from Products
Order by Productname desc;

--11
Select top 10 productName
From Products
Order by Price desc;

--12
Select coalesce (FirstName, Lastname) from Employees;

--13
Select distinct category, price from Products;

--14
Select * from Employees
Where (age between 30 and 40) or Department='Marketing';

--15
Select * from Employees
Order by salary desc
offset 10 rows fetch next 10 rows only;

--16
Select * from Products
where price<=1000 and stockquantity>50
order by stockquantity asc;

--17
Select * from Products
where ProductName like '%e%';

--18
Select * from Employees
where DepartmentName in('HR','IT','Finance');

--19
Select * from Customers
order by city asc, PostalCode desc;

--20
Select top (10)*
From Products
order by StockQuantity;

--21
Select FirstName+' '+ LastName from Employees;

--22
Select distinct category ,ProductName,Price from Products
Where Price>50;

--23
Select * from Products
where price<(select avg(price)*0.1from products);

--24
Select * from Employees
Where age<30 and DepartmentName in ('HR','IT');

--25
Select * from Customers
Where email like '%@gmail.com';

--26
Select * from Employees
where salary>all(
      Select Salary from Employees
	  Where DepartmentName='sales'
);

--27
Select * from Orders
where OrderDate between cast(GetDate()-180 as date) and cast(Getdate()as date);
