--into products
INSERT INTO products (name, price, stock_quantity) VALUES
('Laptop', 999.99, 50),
('Smartphone', 499.99, 100),
('Tablet', 299.99, 75),
('Headphones', 99.99, 50),
('Smartwatch', 199.99, 30);

--into customers
INSERT INTO customers (name, email) VALUES
('Charlie Brown', 'charlie.b@example.com'),
('Diana Prince', 'diana.p@example.com'),
('Bruce Wayne', 'bruce.w@example.com'),
('Peter Parker', 'peter.p@example.com'),
('Tony Stark', 'tony.s@example.com');

--into orders
INSERT INTO orders (customer_id) VALUES
(1),
(2),
(3),
(4),
(5);

--into ordered items
INSERT INTO order_items (order_id, product_id, quantity) VALUES
(1, 1, 1),  
(2, 2, 2),  
(3, 3, 2),  
(4, 4, 1), 
(5, 5, 1),  
(3, 2, 1),  
(4, 1, 1);  
