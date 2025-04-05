# PostgreSQL-Ex5

# E-commerce Database README

## Introduction

This e-commerce database is designed to manage sales, inventory, and customer behavior for an online store. It includes tables for products, customers, orders, and order items, along with triggers to automate stock updates and log changes to orders.

## Database Schema

### Tables

1. **Products Table**
   - Stores product details.
   - Columns:
     - `product_id`: Unique identifier for each product.
     - `name`: Product name.
     - `price`: Product price.
     - `stock_quantity`: Current stock quantity.

2. **Customers Table**
   - Tracks customer details.
   - Columns:
     - `customer_id`: Unique identifier for each customer.
     - `name`: Customer name.
     - `email`: Customer email.

3. **Orders Table**
   - Tracks orders placed by customers.
   - Columns:
     - `order_id`: Unique identifier for each order.
     - `customer_id`: Foreign key referencing the `customer_id` in the `customers` table.
     - `order_date`: Timestamp when the order was placed.

4. **Order Items Table**
   - Tracks products in each order.
   - Columns:
     - `order_item_id`: Unique identifier for each order item.
     - `order_id`: Foreign key referencing the `order_id` in the `orders` table.
     - `product_id`: Foreign key referencing the `product_id` in the `products` table.
     - `quantity`: Number of units of the product ordered.

5. **Order Log Table**
   - Logs changes to orders (updates or deletions).
   - Columns:
     - `log_id`: Unique identifier for each log entry.
     - `order_id`: Foreign key referencing the `order_id` in the `orders` table.
     - `change_type`: Type of change (e.g., 'UPDATE', 'DELETE').
     - `change_date`: Timestamp when the change occurred.

## Triggers

1. Stock Quantity Update Trigger (update_stock_trigger):

Purpose: Automatically updates the stock quantity of a product whenever an order item is inserted.

Use Case: When a customer places an order, this trigger ensures that the stock quantity of the ordered product decreases by the quantity ordered.

Example: If a customer orders 2 units of a product, the stock quantity of that product will decrease by 2.

2. Stock Availability Check Trigger (check_stock_trigger):

Purpose: Prevents orders from being placed if there is insufficient stock.

Use Case: Before allowing an order item to be inserted, this trigger checks if there is enough stock available. If not, it raises an exception to prevent the order from being placed.

Example: If a customer tries to order 5 units of a product but only 3 units are in stock, this trigger will prevent the order from being placed.

3. Order Change Logging Triggers (log_order_update_trigger and log_order_delete_trigger):

Purpose: Logs changes to orders, including updates and deletions.

Use Case: Whenever an order is updated or deleted, these triggers insert a log entry into the order_log table to track the change.

Example: If an order's customer ID is updated, a log entry will be created indicating the change type as 'UPDATE'.

## Use Cases

- **Inserting an Order Item:** Automatically updates stock quantity and checks for sufficient stock.
- **Updating an Order:** Logs the change in the `order_log` table.
- **Deleting an Order:** Logs the deletion in the `order_log` table.

## Setup

1. Create the database schema using the provided SQL commands.
2. Insert sample data into the tables.
3. Test the triggers and queries to ensure functionality.
