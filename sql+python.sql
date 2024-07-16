--find top 10 highest revenue generating products 
select product_id,sum(sale_price) as sales
from df_orders
group by product_id
order by sales desc
LIMIT 10;


-- find top 5 highest selling products in each region 
with cte as(
select region , product_id, sum(sale_price) as sales
from df_orders
group by region, product_id)
	select * from (
select * 
, row_number() over(partition by region order by sales desc) as rn 
from cte) A
where rn<=5


--find month over month growth comparison for 2022 and 2023 sales eg : jan 2022 vs jan 2023
select year(order_date),month(order_date),
sum (sale_price) as sales
from df_orders
group by year(order_date), month(order_date)
