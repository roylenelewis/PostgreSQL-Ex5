1) --Updating Stock Quantity Trigger --

-- Insert a new order item
INSERT INTO order_items (order_id, product_id, quantity)
VALUES (1, 1, 2);  -- Assuming product_id 1 is a Laptop

-- Check the updated stock quantity
SELECT stock_quantity FROM products WHERE product_id = 1;

2) --Preventing Orders with Insufficient Stock Trigger--

-- Attempt to insert an order item with insufficient stock
INSERT INTO order_items (order_id, product_id, quantity)
VALUES (1, 1, 100);  -- Assuming there are less than 100 Laptops in stock

-- This should raise an exception due to insufficient stock


3) --Logging Changes to Orders Triggers--

-- Update an existing order
UPDATE orders
SET customer_id = 2
WHERE order_id = 1;

-- Check the log
SELECT * FROM order_log;

-- Delete an existing order
DELETE FROM orders
WHERE order_id = 1;

-- Check the log again
SELECT * FROM order_log;


--COMBINING ALL--


-- Insert a new order
INSERT INTO orders (customer_id) VALUES (1);

-- Insert a new order item
INSERT INTO order_items (order_id, product_id, quantity)
VALUES (1, 1, 2);  -- Assuming product_id 1 is a Laptop

-- Check the updated stock quantity
SELECT stock_quantity FROM products WHERE product_id = 1;

-- Attempt to insert an order item with insufficient stock
BEGIN;
INSERT INTO order_items (order_id, product_id, quantity)
VALUES (1, 1, 100);  -- This should raise an exception due to insufficient stock
ROLLBACK;  -- Rollback to prevent transaction failure

-- Update an existing order
UPDATE orders
SET customer_id = 2
WHERE order_id = 1;

-- Check the log
SELECT * FROM order_log;

-- Delete an existing order
DELETE FROM orders
WHERE order_id = 1;

-- Check the log again
SELECT * FROM order_log;
