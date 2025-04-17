--3
Create table Productts(
ProductID int Primary Key,
ProductName varchar(50), 
Price decimal (10,2))

--4
Insert into Productts values 
(1, 'Laptop', 12000),
(2, 'Smartphone', 13000),
(3, 'Monitor',14000);

--5
Create table NullDemo(
Id int,
Name varchar(50) Null
)
Select * from NullDemo
Insert into NullDemo (ID) values (1)

Create table NotNulllDemo(
ID int,
Name varchar(50) Not Null
)
Insert into NotNulllDemo (ID) values(1)
Select * from NotNulllDemo

--6
Alter table Productts
Add constraint UQ_ProductName unique(productName);

--7
Select * from Productts


--8
Create table Categories(
CategoryId int primary key,
CategoryName varchar(50) unique
);

--9
Create table Test(
Id int identity(1,1),
name varchar (50)
);
--10
Bul insert Products
From 

--11
Alter table Productts
ADD Constraint FK_Products_Categories Foreign key (CategoryID) references Categories(CategoryID);

--12
Create table Students (
StudentID int primary key,
name varchar (50),
age int
);

Create table Employees(
EmpId int primary key,
Name varchar (50) unique,
PhoneNumber varchar (50) unique
);

--13
alter table Productts
Add constraint Chk_Price check (price>0); 

--14
Alter table Productts
Add Stock int not Null;

--15
Select ProductId, ProductName, isnull (price, 0) from Productts;

--17
Create table Customers(
CustId int primary key,
Name varchar (50),
Age int,
constraint Chkage Check (age>=18)
);

--18
Create table IdenDemo(
Id int identity(100,10),
Name varchar (50)
);

--19
Create table OrderDetails(
Id int Primary key,
Name varchar(50)
);

--20
select coalesce(null,null,'hi')
Select isnull (null,'Default')

--21
Create table Employees(
EmpId int primary key,
name varchar(50)
email varchar(50) unique
);

--22
Create table Departments(
deptId int primary key,
DeptName varchar (50)
);
Create table Employees(
EmpId int primary key,
EmpName varchar (50),
DeptID int,
Foreign key (DeptID) references Departments(deptID)
            on delete cascade
			On update cascade
);
