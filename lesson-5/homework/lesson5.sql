--1
Select ProductName as Name from Products;

--2
Select * from Customers as Client;

--3
Select ProductName from Products
Union 
Select ProductName from Products_Discounted;

--4
Select * from Products
Intersect
Select * from Products_Discounted;

--5
Select distinct CustomerName, Country from Customers;

--6
Select *,case when Price>1000 then 'High'
              when Price<=1000 then 'Low' end as Pricecolumn
from Products;

--7
Select StockQuantity, iif (Stock>100, 'yes', 'No') from Products_Discounted;

--8
Select ProductName from Products
Union
Select ProductName from OutOfStock;

--9
Select * from Products
Except
Select * from Products_Discounted;

--10
Select ProductName, iif(Price>1000, 'Expensive', 'Affordable') as PriceCategory from Products;

--11
Select * from Employees
where age<25 or salary>60000;

--12
Update Employees
set salary=salary*1.1
where departmentName='HR' or EmployeeID=5;

--13
Select ProductName from Products
Intersect
Select ProductName from Products_Discounted;

--14
Select SaleAmount, case when SaleAmount>500 then 'Top Tier'
               when SaleAmount between 200 and 500 then 'Mid tier' else 'Low Tier' end 
			   from Sales

--15
Select CustomerID from Orders
Except
Select CustomerID from Invoices;

--16
Select CustomerID, Quantity,
       case when Quantity=1 then '3% between 1'
	        when Quantity=3 then '5%' else '7%'
			end as DiscountPercentage
			from Orders;
