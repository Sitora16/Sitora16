--Task 1
Select 
    customer_id,
	customer_name,
	total_amount,
	sum(total_amount) over (partition  by customer_name order by order_date  ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as RunningTotal
from sales_data




--Task 2

Select product_category,count(distinct sale_id) as SaleCouunt from sales_data
group by product_category


--Task 3
Select product_category,max(total_amount) as MaxTotal from sales_data
 group by product_category

 --Task 4
 Select product_category,min(unit_price) as MaxTotal from sales_data
 group by product_category
 
 

 --Task 5
 Select customer_id,
        customer_name,
		product_category,
		total_amount,
		AVG(total_amount) over(order by order_date ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) as MovingAvg
                 from  sales_data
 
  --Task 6
 Select distinct 
        region,
		sum(total_amount) over(partition by region ) as SumRegion 
                 from  sales_data
 

  --Task 7
 Select  customer_id,
                 customer_name,  
                 sum(total_amount) AS total_purchase,
                 DENSE_RANK() over (order by  sum(total_amount) desc ) as RankCustomer
                 from  sales_data
				 group by customer_id, customer_name
            
			
  --Task 8

  Select total_amount as CurrentAmount,
         LEAD(total_amount) over(order by order_date) as NextSaleAmount,
		 (total_amount-LEAD(total_amount) over(order by order_date)) as DiffSaleAmount
  from sales_data


  --Task 9

 ;with cte as (Select  product_category,
          product_name,unit_price,
		  dense_rank() over (partition by product_category order by unit_price desc) as Price 
  from sales_data)
  select * from cte 
  where Price<=3

  --Task 10

  Select region,
        order_date,
		total_amount,
		sum(total_amount) over (partition by region order by order_date   
		ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW ) as SumAmount from  sales_data
  order by region,order_date



 --Task 11


 SELECT
    product_category,
    order_date,
    total_amount,
    SUM(total_amount) OVER (
        PARTITION BY product_category
        ORDER BY order_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS cumulative_revenue
FROM
    sales_data
ORDER BY
    product_category, order_date;

 --Task 12
 CREATE TABLE numbers (
    ID INT
);

INSERT INTO numbers (ID) VALUES
(1),
(2),
(3),
(4),
(5);


Select id,sum(id) over(order by id) as SumPreValues from numbers


 --Task 13
 CREATE TABLE OneColumn (
    Value SMALLINT
);
INSERT INTO OneColumn VALUES (10), (20), (30), (40), (100);

Select Value,Sum(Value) over (order by Value  ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) as Sum_of_Previous  from OneColumn




 --Task 14


 CREATE TABLE Row_Nums (
    Id INT,
    Vals VARCHAR(10)
);
INSERT INTO Row_Nums VALUES
(101,'a'), (102,'b'), (102,'c'), (103,'f'), (103,'e'), (103,'q'), (104,'r'), (105,'p');

;with cte as (Select id,Vals,row_number() over(  partition by id order by Vals) as row_number_in_group ,
2 * DENSE_RANK() OVER (ORDER BY Id) - 1 AS start_odd_number
from Row_Nums)

Select id,Vals,(start_odd_number + row_number_in_group -1 ) AS RowNumber from cte


 --Task 15
 Select customer_id, 
        customer_name,
		count(distinct product_category) AS num_categories
from sales_data
group by  customer_id, 
        customer_name		
Having count(distinct product_category)>1


 --Task 16

;with Sumcte as (Select customer_id,
	   region,
	   sum(total_amount)  as customer_spending
from sales_data
group by customer_id,
	   region ),


Avgcte as (Select customer_id,
       region,
	   avg(total_amount) AS avg_spending 
from sales_data
group by customer_id,
	   region)

Select s.customer_id,s.region,s.customer_spending,a.avg_spending from Sumcte as S
join Avgcte as A
on s.customer_id=a.customer_id
where s.customer_spending>a.avg_spending




 --Task 17

;with customer_spending as ( 
Select customer_id,
       customer_name,
       region, 
	   SUM(total_amount) AS total_spent from sales_data
 group by  customer_id,customer_name,region,total_amount)

 Select customer_id,
        customer_name,
        region,
		total_spent,
		 dense_rank() over (partition by region order by total_spent desc) as RankRegion
		from customer_spending
