--basic data 

--1.1  Retrieve all records from the customers table, displaying all available columns.

select *
from customers

--1.2 Fetch only the customer ID, first name, and email from the customers table. 
select c.customer_id, c.first_name, c.last_name
from customers as c

--1.3  List all products that belong to the Clothing category.
select *
from products
where category ='clothing'

--1.4 Retrieve all orders where the total purchase amount is greater than $500. 
select *
from orders
where total_amount >500
order by total_amount asc

--1.5  Find all customers who joined the platform after January 1, 2023.
select *
from customers
where join_date > '2023-01-01'
order by join_date asc

--1.6  Display the top 5 most expensive products available in the database.
select  *
from products
order by price desc

--1.7 List the latest 10 orders placed, sorted by order date in descending order. 
select top (10) *
from orders
order by order_date desc

--1.8 Retrieve all orders that have a status of "Completed". 
select *
from orders
where order_status='completed'

--1.9  Find all orders that were placed between February 1, 2023, and February 28, 2023.

select *
from orders
where order_date between '2023-02-01' and '2023-02-28'

--1.10   List all products that have a price between $50 and $100.
select *
from products
where price between 50 and 100
order by price asc

--2.1 Count the total number of customers in the database.
select COUNT(customer_id)
from customers

--2.2 Find the average order amount from the orders table. 
select avg(total_amount) as avg_amt
from orders

--2.3	Retrieve the highest and lowest priced products from the product list. 
select	top (1) product_name
from products
order by price asc;select	top (1) product_name
from products
order by price desc

--2.4 Count the number of products in each category, grouping by category.
select category, COUNT(product_id)
from products
group by category

--2.5 Calculate the total revenue generated from all orders.
select  SUM(total_amount)
from orders

--2.6 Find the total number of orders placed by each customer, sorted by highest to lowest. 
select customer_id, COUNT(order_id) as total_orders
from orders
group by customer_id

--2.7 Calculate the total revenue generated for each month in 2023
select year(order_date), month(order_date), sum(total_amount)
from orders
where year(order_date) ='2023'
group by year(order_date), month(order_date)
order by month(order_date) asc

--2.8 List all customers who have placed more than 5 orders.
select customer_id, COUNT(order_id) as total_orders
from orders
group by customer_id
having count(order_id)>5

---2.9 Identify the most frequently used payment method based on the number of transactions.
select payment_method, count(payment_id)
from payments
group by payment_method

--2.10  Find the average product price for each category. 
select category, avg(price)
from products
group by category

--3.1 Retrieve all order details along with the customer’s first and last name
select o.*, c.first_name, c.last_name
from orders as o
left join customers as c
on o.customer_id=c.customer_id

--3.2 Fetch order items with product names, quantities, and subtotal values 
select o.*,p.product_name,p.stock_quantity
from [order_items m] as o
left join products as p
on o.product_id=p.product_id

--3.3 List all payment transactions along with the corresponding order details 
select o.*, p.payment_id
from orders as o
left join payments as p
on o.order_id=p.order_id

--3.4 Identify customers who have never placed an order
select c.customer_id, c.first_name, c.last_name, o.order_id
from customers as c
left join orders as o
on c.customer_id =o.customer_id
where o.order_id is null

--3.5 Find all products that have never been purchased (i.e., do not appear in any order). 
select p.*, o.order_id
from products as p
left join [order_items m] as o
on p.product_id=o.product_id
where o.order_id is null

--3.6 Retrieve customers and their total spending by summing up all their orders
select c.customer_id, c.first_name,c.last_name, sum(o.total_amount)as total_earning
from customers as c
inner join orders as o
on c.customer_id=o.customer_id
group by c.customer_id, c.customer_id, c.first_name,c.last_name
order by total_earning desc

--3.7  Get the total number of products ordered by each customer.
select c.customer_id, COUNT(order_id) as total_products
from customers as c
join orders as o
on c.customer_id =o.customer_id
group by c.customer_id

--3.8	Display all orders along with the names of the products included in each order. 
select o.*, p.product_name
from [order_items m] AS O
join products as p
on o.product_id=p.product_id

--3.9 find orders that do not have any associated payments recorded. 
select o.*, p.payment_id
from orders as o
inner join payments as p
on o.order_id =p.payment_id
where payment_id is null

--3.10  Retrieve customers along with the last date they placed an order.
select c.first_name, c.last_name, c.customer_id , max(o.order_date)
from customers as c
inner join orders as o
on c.customer_id=o.customer_id
group by c.first_name, c.last_name, c.customer_id 

--4.1 Find the most expensive product in the store using a subquery.

select *
from products
where price =(select max(price) from products)

--4.2 Retrieve the list of customers who have placed at least one order. 
select *
from customers
where customer_id in (select distinct(customer_id) from orders)

--4.3 Display orders where the total amount is greater than the average order amount
select *
from orders 
where total_amount>(select avg(total_amount) from orders)

--4.4 Find the cheapest product in each category using a correlated subquery.

--4.5 identify the customer who has placed the highest number of orders
--correct
select *
from customers
where customer_id =(select top (1)customer_id from [orders] group by customer_id
order by count(order_id) desc)



--correct
select *
from 

--4.6 fetch the second most expensive product using an alternative ranking method. 


--4.7 List all customers who have never made a payment for any order. 
select customer_id
from orders
where order_id in (select payment_id from payments where payment_id is null)


--4.8 Retrieve all products with stock levels below the average stock quantity.
select *
from products
where stock_quantity<(select AVG(stock_quantity) from products)
order by stock_quantity desc

select AVG(stock_quantity) from products


--4.9 Find customers who have spent more than $2000 in total on orders. 
select *
from orders 
where total_amount >2000

select *
from customers
where customer_id in (select customer_id 
from orders 
group by customer_id
having sum(total_amount) >2000)





