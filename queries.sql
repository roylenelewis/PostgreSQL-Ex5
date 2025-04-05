
select * from products
  
select * from customers
  
select *from orders
  
select * from order_items
  
-- Get all orders by a specific customer
SELECT * FROM orders WHERE customer_id = 1;

SELECT * FROM orders WHERE customer_id = 2;

-- list of products with low stock
SELECT * FROM products WHERE stock_quantity < 20;

SELECT * FROM products WHERE stock_quantity < 60;

-- revenue of each product
SELECT p.name, SUM(oi.quantity * p.price) AS total_revenue
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.name;

-- most popular product
SELECT p.name, SUM(oi.quantity) AS total_quantity
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.name
ORDER BY total_quantity DESC
LIMIT 1;

-- total number of orders placed by each customer
SELECT c.name, COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.name;

-- Calculate the revenue generated by each product category
SELECT 
    CASE 
        WHEN p.name LIKE '%Laptop%' THEN 'Laptops'
        WHEN p.name LIKE '%Smartphone%' THEN 'Smartphones'
        WHEN p.name LIKE '%Tablet%' THEN 'Tablets'
        WHEN p.name LIKE '%Headphones%' THEN 'Headphones'
        WHEN p.name LIKE '%Smartwatch%' THEN 'Smartwatches'
        ELSE 'Other'
    END AS product_category,
    SUM(oi.quantity * p.price) AS total_revenue
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY product_category;

--  most frequent buyer 
SELECT c.name, COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.name
ORDER BY total_orders DESC
LIMIT 1;

-- List all orders with their corresponding customer names
SELECT o.order_id, c.name AS customer_name, o.order_date
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id;

-- Calculate the average price of products sold
SELECT AVG(p.price) AS average_product_price
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id;

-- Find products that have been ordered more than once
SELECT p.name, SUM(oi.quantity) AS total_quantity_ordered
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.name
HAVING COUNT(DISTINCT oi.order_id) > 1;

-- Get the total revenue for each month
SELECT EXTRACT(MONTH FROM o.order_date) AS order_month,
       SUM(oi.quantity * p.price) AS total_revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY order_month;

-- List customers who have not placed any orders
SELECT c.name
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- Calculate the total stock value of all products
SELECT SUM(p.stock_quantity * p.price) AS total_stock_value
FROM products p;
