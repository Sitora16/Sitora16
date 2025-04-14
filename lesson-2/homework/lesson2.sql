Create table Employees(
EmpID int,
name varchar(50),
Salary decimal(10,2));

Insert into employees(
empID,
name,
salary
)values
(1,'Ali',250000),
(2,'Vali',300000),
(3,'Salim',400000),
(4,'Karim',550000),
(5,'Nodir',270000);

Update employees set salary=300000 where empID=1;
Select*from employees;

Delete Employees;
Truncate table Employees;
Drop table Employees;

Alter table Employees
Alter column name varchar(100);

Alter table Employees ADD Department varchar(100);

Alter table Employees Alter column salary float;

Create table Departments(
DepartmentID int PRIMARY key,
DepartmentName varchar(50)
);
Truncate table Employees;

Insert into Departments (DepartmentID,DepartmentName)
Select EmpID,Department from employees;

Update Employees
Set salary=6000
where EmpID=2;

Truncate table Employees;

Alter table Employees
Drop column Departments;

Exec sp_rename 'Employees','Staffmembers';

Drop table Departments;

Create table Productss(
ProductID int Primary key,
ProductName varchar (50),
Category varchar (50),
Price decimal (10,2)
);

Alter table Productss 
Add constraint chk_price_positive CHECK
(Price>0);

Alter table Product
ADD stockQuantity int Default 50;

Exec sp_rename 'Product.Category','ProductCategory','column';

Insert into Productss(ProductID,ProductName,ProductCategory,Price)
values
(1,'Laptop', 'Electronics',27000),
(2,'Phone','Electronics',23000),
(3,'Table','Furniture',25000),
(4,'Chair','Furniture',20000),
(5,'Book','Stationary',15000);

Select * into ProductsBackup from Productss;

Exec sp_rename 'Productss','Inventory';

Alter table Inventory
Alter column Price Float;

Alter table Inventory
Add ProductCode int Identity (1000,5);
