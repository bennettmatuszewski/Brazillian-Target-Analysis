--Beginner queries
-- List all distinct payment types used in the payments table.
select distinct payment_type from payments

-- Count how many orders each order_status has in the orders table.
select order_status, count(*) as order_count from orders group by order_status

-- Find the top 5 cities with the most customers.
select customer_city, count(*) as customer_count from customers group by customer_city order by customer_count desc limit 5

-- Count the number of sellers in each state.
select seller_state, count(*) from sellers group by seller_state order by count desc

-- Get the total number of payments made via credit_card.
select count(payment_type) from payments where payment_type = 'credit_card'

-- Intermediate queries
-- Find the average freight_value for each seller.
select seller_id, avg(freight_value) from sellers join order_items using (seller_id) group by seller_id order by avg desc

-- Get all customers who placed more than 3 orders.
select customer_id, count(*) as order_count from orders group by customer_id having count(*) > 3

-- Calculate the total payment_value for each order.
select payment_id, sum(payment_value) from payments group by payment_id order by sum desc

-- List all products with more than 3 photos and a weight greater than 1000g.
select product_id, product_photos_qty, product_weight_g from products where product_photos_qty > 3 and product_weight_g > 1000

-- Find the number of orders that were delivered late
select order_id, order_estimated_delivery_date, order_delivered_customer_date from orders where order_estimated_delivery_date < order_delivered_customer_date

-- Advanced queries
--Find the top 3 sellers by total revenue (sum of price in order_items).
select seller_id, sum(price) from sellers join order_items using (seller_id) group by seller_id order by sum desc limit 3

-- Determine the customer who spent the most money overall.
select customer_id, sum(payment_value) from customers join orders using (customer_id) join payments using (order_id) group by customer_id order by sum desc limit 1

-- Find sellers who have shipped to more than 5 distinct cities.
select seller_id, count(DISTINCT customers.customer_city) from sellers join order_items using (seller_id) join orders using (order_id) join customers using (customer_id) group by seller_id having count(distinct customers.customer_city) > 5 order by count desc 

-- Find the average delivery time (in days) for each product category.
select product_category_name, AVG(AGE(orders.order_estimated_delivery_date, orders.order_purchase_timestamp)) from products join order_items using (product_id) join orders using (order_id) group by product_category_name order by avg desc

-- List orders with multiple payment types (e.g., split across credit_card and voucher).
select order_id from payments group by order_id having count(distinct payment_type) > 1
