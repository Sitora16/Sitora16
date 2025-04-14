
Select * from Productss
Select min(price) from Productss

Select max(salary) from Employees 

Select * from Customers
Select count(*) from Customers

Select * from Products
Select (count(distinct category)) from Products

Select * from Sales
Select sum(saleamount) from Sales
where ProductID=7;

Select * from Employees
Select avg(age) from Employees

Select DepartmentName,count(EmployeeID) from Employees 
Group by DepartmentName 

Select * from Products
Select category,min(price),max(price)
from Products
Group by Category;

Select * from Sales
Select customerID, sum(salesamount) from Sales
Group by CustomerID;

Select * from Employees
Select departmentName, count (*) from Employees
Group by departmentName
having count (*)>5;

Select *from Sales
Select ProductID, Sum(saleAmount),Avg(SaleAmount) from sales
Group by ProductID;

Select count(employeeID) from employees
Where departmentName='HR'

Select * from Employees
Select DepartmentName, max(salary),min(salary) from employees
Group by Departmentname;

Select DepartmentName,avg(salary) from Employees
Group by departmentName;

Select DepartmentName, avg(salary),count(employeeID) from employees
Group by DepartmentName;

Select Category, avg(price) from Products
Group by category
having avg(price)>400;

Select SaleDate, sum(SaleAmount) from Sales
Group by SaleDate;

Select CustomerID, Count(*) from Customers
group by CustomerID
Having count(*)>=3;

Select DepartmentName, sum(salary) from Employees
Group by DepartmentName
Having sum(salary)>500000;

Select Category, avg(StockQuantity) from products
Group by Category
having avg(StockQuantity)>200;

Select CustomerID,sum(saleAmount) from sales
group by customerID
Having sum(saleAmount)>1500;

Select DepartmentName, sum(salary), avg(salary) from Employees
Group by DepartmentName
having avg(salary)>65000;

Select * from Orders
select CustomerID, max(orderID), min(OrderID) from Orders
Group by CustomerID
Having min(OrderID) <50;

select saleDate, sum(SaleAmount),count(distinct ProductID) from Sales
Group by SaleDate
having count(distinct ProductID)>8;

Select year, min(Quantity), max(Quantity) from Orders
Group by Year;
