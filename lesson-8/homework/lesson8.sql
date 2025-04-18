--1
Select category,count(*) from Products
Group by category;

--2
Select category, avg(price) from Products
Group by Category;

--3
Select * from Customers
Where city like 'L%';

--4
Select * from Products
where Productname like '%er';

--5
Select * from Customers
Where Country like '%a'; 

--6
Select max(price) from Products;

--7
Select ProductName, StockQuantity, 
IIF (StockQuantity<30, 'LowStock', 'Sufficient') from Products;

--8
Select country, count(*) from Customers
Group by country;

--9
Select min(quantity),max(quantity) from Orders;

--10
Select CustomerID from Orders
where year(OrderDate)=2023
Except
Select CustomerID from Invoices
Where year(InvoiceDate)=2023;

--11
Select ProductName from Product
Union ALl
Select ProductName from Products_Discounted;

--12
Select ProductName from Product
Union 
Select ProductName from Products_Discounted;

--13
Select avg(OrderDate) from Orders;

--14
Select ProductName,
Case
When price<100 then 'Low'
When Price Between 100 and 500 then 'Mid'
When Price>500 then 'High'
from Products;


--15
Select Distinct City from Customers
Order by City asc;

--16
Select ProductID, sum(saleamount) from Sales;

--17
Select ProductName from Products
where ProductName like '%oo%';

--18
Select ProductID from Products
intersect
Select ProductID from Products_Discounted;

--19
Select CustomerID, sum(TotalAmount) from Invoices
Group by CustomerID
Order by TotalAmount desc 
limit 3;

--20
Select ProductId, ProductName from Products
Except
Select ProductID,ProductName From Products_Discounted;

--21
Select p.product_name,
       Count (s.sale_id) from Products p
Join sales son p.product_id=s.product_id
Group by p. product_name;

--22
Select ProductID, sum(Quantity) from Orders
Group by ProductID
Order by Quantity desc
limit 5;
